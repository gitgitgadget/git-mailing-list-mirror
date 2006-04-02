From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 10:35:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 19:36:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ6Un-0005g2-F8
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 19:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWDBRgD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWDBRgD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 13:36:03 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29356 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932374AbWDBRgB
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 13:36:01 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C8303> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 2 Apr 2006 10:35:57 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18273>

On Sun, 2 Apr 2006, Junio C Hamano wrote:

> $ git diff-tree -p 52e8a6^2 52d8a6 -- git-fetch.sh
>
> shows a change that trivially is redundant, like this:
>
>    diff --git a/git-fetch.sh b/git-fetch.sh
>    index b4325d9..de4f011 100755
>    --- a/git-fetch.sh
>    +++ b/git-fetch.sh
>    @@ -320,7 +320,7 @@ fetch_main () {
>         ( : subshell because we muck with IFS
>           IFS="    $LF"
>           (
>    -         git-fetch-pack $exec $keep "$remo...
>    +         git-fetch-pack $exec $keep --thin...
>           ) |
>           while read sha1 remote_name
>           do
>    @@ -367,21 +367,26 @@ fetch_main "$reflist"
>
>     # automated tag following
>     case "$no_tags$tags" in
>    -'')
>    -       taglist=$(IFS=" " &&
>    -       git-ls-remote $upload_pack --tags "$remote" |
>    ...
>    -       done)
>    +'')
>    +       case "$reflist" in
>    +       *:refs/*)
>    ...
>
> Notice the first '-' and '+' lines of second hunk are identical?
>
> There is another interesting thing.  This is running diff
> between 52e8a6^2 and 52d8a6 blobs, but if I change them slightly
> so that the first hunk is not different, then this anomaly
> disappears.

Could you send me the two files that creates the above diff?


- Davide
