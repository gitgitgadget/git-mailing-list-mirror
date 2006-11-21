X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: make HTML links out of http/https URLs in changelogs
Date: Tue, 21 Nov 2006 23:28:17 +0100
Organization: At home
Message-ID: <ejvuf4$4v4$1@sea.gmane.org>
References: <4563777C.4050108@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 22:27:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 52
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32047>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gme5L-0000D8-05 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031254AbWKUW1U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031245AbWKUW1U
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:27:20 -0500
Received: from main.gmane.org ([80.91.229.2]:41670 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031255AbWKUW1T (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:27:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gme56-000091-IC for git@vger.kernel.org; Tue, 21 Nov 2006 23:27:09 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 23:27:08 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 23:27:08 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kir Kolyshkin wrote:

> It is a common practice to put links to bugzillas, mailing lists, etc. 
> in git log entries. The fact that gitweb doesn't make HTML links out of 
> that URLs makes following those URLs inconvenient. This patch fixes that 
> problem, trying to address cases when URL is enclosed in round or square 
> brackets.

Preliminary committags support was sent as an RFC patch on git mailing list
once. Hyperlinking plain text http, https, ftp, ftps links etc. is a special
case of committag. That wha is implemented now, namely hyperlinking
commitsha to commit view is also special case of comittag.

And I plan to implement it, only later. But you are welcome to do it
instead.

gitweb-xmms2 http://git.xmms.se/?p=gitweb-xmms2.git has xmms2 related
committags support (links to xmms2 Mantis bugtracker from BUG(n) and
FEATURE(n))
 
> Slightly tested on http://git.openvz.org/. Applicable to git-1.4.4.
> 
> Signed-off-by: Kir Kolyshkin <kir@openvz.org>
> ---
>  gitweb/gitweb.perl |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- git-1.4.4/gitweb/gitweb.perl      2006-11-15 08:22:27.000000000 +0100
> +++ git-1.4.4-my/gitweb/gitweb.perl   2006-11-21 22:49:14.000000000 +0100
> @@ -828,6 +828,8 @@

Could you please send patches created by git tools, namely git-format-patch,
or if you really need to send GNU diff patches, use -p option? It really
helps in patch review.

>                       $line =~ s/$hash_text/$link/;
>               }
>       }
> +     # make HTML links out of http(s) URLs
> +     $line =~ s/(http[s]?:\/\/[^[:space:]\]\)]+)/<a href="\1">\1<\/a>/g;
>       return $line;
>  }

Wont work correctly if commit message has sha1 of commit in it; it would be
changed to 
 <a href="$my_uri?p=$project;a=commit;h=$hash_text" class="text">$hash_text</a>
then the code you added will add hyperlink in place of href value (!).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

