X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 03 Nov 2006 21:53:58 +0100
Organization: At home
Message-ID: <eiga89$ho$1@sea.gmane.org>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net> <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 20:54:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 60
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30884>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg639-00081U-1j for gcvg-git@gmane.org; Fri, 03 Nov
 2006 21:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932135AbWKCUx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 15:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWKCUx7
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 15:53:59 -0500
Received: from main.gmane.org ([80.91.229.2]:8339 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932135AbWKCUx6 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 15:53:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gg62q-0007xv-IF for git@vger.kernel.org; Fri, 03 Nov 2006 21:53:44 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 21:53:44 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006
 21:53:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:

> --- Junio C Hamano <junkio@cox.net> wrote:

>> One thing we talked about but nobody stepped up to code [*1*] is
>> to give "git-format-patch --stdin" that reads list of commits,
>> and runs "git-diff-tree --pretty --stat --summary -p $commit".
>> With that, we could do something like:
>> 
>>      git rev-list linus..orinoco | git format-patch --stdin
> 
> That'd be swell to have.
> 
>> Your "git-format-patch --single $commit" is a shorthand for a
>> degenerated special case of that pattern.
> 
> Yes, except that I'd have to paste the sha-1 into the terminal
> rather than on the command line.  This again proves that the current
> git-format-patch <sha-1> to mean "<sha-1>..HEAD" is horribly broken.

First, you could have behavior you wanted by using additional option
--single, i.e. git-format-patch --single <sha-1> would mean
git-format-patch <sha-1>^..<sha-1>

But I agree that it is somewhat counter-intuitive that for all
other commands which use revision list <sha-1> means lineage
of <sha-1> while for git-format-patch it means <sha-1>..HEAD
... and we have <sha-1>.. shortcut (two characters more) to mean
the same.
 
Another command with non-obvious UI is git-format-branch, which
is not CLI equivalent of gitk/qgit (doesn't accept revision range
for example).

>> You cannot do patch-id based filtering with this form, but I see
>> that "single" is often wanted on the list and #git, and people
>> who want it do not care about patch-id based filtering at all.
> 
> The reason it is wanted is because it is _intuitive_.  This is
> what engineers (of different backgrounds) tend to intuitively think
> and assume given git's structure and the nature and meaning of
> what an <sha-1> is in git, only to be surprised later when that
> assumption is completely broken by git-format-patch.

Intuiveness is in the eye of beholder :-)

>> And I do not think it is that "they do not realize how much they
>> would be missing without patch-id filtering", in this case.  So
>> the above command line would probably be Ok.
> 
> I do not think they'd be missing _anything_.  After all,
> "git-format-patch <sha-1>..HEAD" is also intuitive.

And we have <sha-1>.. shortcut. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

