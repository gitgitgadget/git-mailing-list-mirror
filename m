X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk with arguments fails on OSX
Date: Wed, 29 Nov 2006 12:48:30 -0800
Message-ID: <7vejrmou75.fsf@assigned-by-dhcp.cox.net>
References: <864psixpj6.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0611291609370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<86vekyw9ue.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 20:48:58 +0000 (UTC)
Cc: git@vger.kernel.org, merlyn@stonehenge.com (Randal L. Schwartz)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86vekyw9ue.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "29 Nov 2006 07:28:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32668>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWMP-0001l4-Uy for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967665AbWK2Usv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967668AbWK2Usv
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:48:51 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43953 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S967665AbWK2Usu
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:48:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129204842.XSZX18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 29
 Nov 2006 15:48:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id skog1V00D1kojtg0000000; Wed, 29 Nov 2006
 15:48:40 -0500
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> Johannes> Hi,
> Johannes> On Wed, 29 Nov 2006, Randal L. Schwartz wrote:
>
>>> 
>>> Using the native "wish", gitk fails on OSX 10.4 if given any arguments.
>>> For example, the failure for "gitk --all" is:
>>> 
>>> localhost.local:~/MIRROR/git-GIT % gitk --all
>>> Error in startup script: unknown option "-state"
>>> while executing
>
> Johannes> Known problem:
>
> Johannes> http://thread.gmane.org/gmane.comp.version-control.git/31266/focus=31266
>
> The fix works for me.  How about mainlining it?

The changes look sane to me.

Paul?  I prefer to be fed gitk changes through you, if you don't
mind.

> From: Randal L. Schwartz <merlyn@localhost.local>
> Date: Wed, 29 Nov 2006 07:20:04 -0800
> Subject: [PATCH] patch from mailing list
>
> ---
>  gitk |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/gitk b/gitk
> index ab383b3..d9df0a3 100755
> --- a/gitk
> +++ b/gitk
> @@ -1632,8 +1632,8 @@ proc showview {n} {
>  
>      set curview $n
>      set selectedview $n
> -    .bar.view entryconf 2 -state [expr {$n == 0? "disabled": "normal"}]
> -    .bar.view entryconf 3 -state [expr {$n == 0? "disabled": "normal"}]
> +    .bar.view entryconf "Edit*" -state [expr {$n == 0? "disabled": "normal"}]
> +    .bar.view entryconf "Delete*" -state [expr {$n == 0? "disabled": "normal"}]
>  
>      if {![info exists viewdata($n)]} {
>         set pending_select $selid
> @@ -6305,8 +6305,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
>      set viewargs(1) $revtreeargs
>      set viewperm(1) 0
>      addviewmenu 1
> -    .bar.view entryconf 2 -state normal
> -    .bar.view entryconf 3 -state normal
> +    .bar.view entryconf "Edit*" -state normal
> +    .bar.view entryconf "Delete*" -state normal
>  }
>  
>  if {[info exists permviews]} {
> -- 
> 1.4.4.1.gf927
>
>
>
> -- 
> Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
> <merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
> Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
> See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
