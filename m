From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 04 Dec 2007 10:40:20 +0100
Message-ID: <47552084.3070601@viscovery.net>
References: <20071022063222.GS14735@spearce.org>	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>	<7vmytycykt.fsf@gitster.siamese.dyndns.org>	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 10:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzUGl-0005DV-OG
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 10:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXLDJk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 04:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXLDJk1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 04:40:27 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2228 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXLDJk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 04:40:27 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IzUFa-00013A-Ro; Tue, 04 Dec 2007 10:39:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 22E4F4E4; Tue,  4 Dec 2007 10:40:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67032>

Junio C Hamano schrieb:
> * sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
>  + refactor fetch's ref matching to use refname_match()
>  + push: use same rules as git-rev-parse to resolve refspecs
>  + add refname_match()
>  + push: support pushing HEAD to real branch name
> 
> The last one changes the semantics to somewhat less safe:
> 
>     * We did not allow fetching outside refs/ (except HEAD), but now we
>       allow any random string.
> 
>     * We used to restrict fetching names that do not begin with refs/ to
>       heads, tags and remotes, but now the code grabs anything underneath
>       refs/.
> 
> which could invite mistakes by letting typos slip through, but I won't
> be a good judge, as I probably "fetch" much less often than other people
> do and these may be non issues in the real-world usecases.  It could be
> that I am worried too much needlessly.  If anybody who is following
> 'next' has been bitten by the change, please speak up.  Otherwise this
> will go in soon.

Forks on repo.or.cz use the namespace refs/forkee that lists everything that 
the forkee has below refs/. So this change might indeed be annoying. (But 
I'm not using next, so I can't tell, yet.)

> Incidentally, if we do not install dashed form of built-ins anywhere
> (which is not this series is about --- this is just moving them out of
> user's PATH), "git help -a" will stop showing them.  I am not enthused
> about removing the hardlinks to built-ins to begin with, but people who
> want such a change need to first modify help.c:list_commands() to pick
> up builtins without having git-foo hardlinks in gitexecdir.  This may
> need to happen anyway as mingw fallouts, though ;-).

Heh. 'git help -a' currently shows nothing. But it has nothing to do with 
hardlinks. It's because the test for the executable bit fails :-(

BTW, we do use hardlinks on Windows; even the MsysGit installer creates them 
(as long as the filesystem is NTFS). So, the fallout you are 
expecting/hoping for will not be in the first round of MinGW port patches. ;)

-- Hannes
