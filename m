From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Is this a git-bisect bug?
Date: Sat, 21 Feb 2009 19:25:53 +0200
Message-ID: <87skm7em72.fsf@iki.fi>
References: <gnpccl$l69$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LavdO-0001Fn-SR
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbZBURZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZBURZ6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:25:58 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:47393 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbZBURZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:25:57 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B89055C446A; Sat, 21 Feb 2009 19:25:54 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Lavbt-0001GC-IC; Sat, 21 Feb 2009 19:25:53 +0200
In-Reply-To: <gnpccl$l69$1@ger.gmane.org> (walt's message of "Sat\, 21 Feb 2009 09\:07\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110968>

On 2009-02-21 09:07 (-0800), walt wrote:

> I'm using the current git.git to bisect a bug in Linus.git.
>
> I got this far and then ran into trouble:
> good 2.6.29-rc5-00094-gc951aa6
> bad  2.6.29-rc5-00112-g3501033
>
> A glance at git log will show that those two commits were
> both from Feb 17 with only one other commit between them.
>
> So, why does this happen?:
>
> $git bisect start 3501033 c951aa6
> Bisecting: 8 revisions left to test after this
> be716615fe596ee117292dc615e95f707fb67fd1] x86, vm86: fix preemption bug

Someone will probably give real explanation but non-linear development
is part of it:

$ git log --graph --pretty=oneline --abbrev-commit c951aa6..3501033

*   3501033 Merge branch 'x86-fixes-for-linus' of git:// [...]
|\  
| * be71661 x86, vm86: fix preemption bug
| * e49590b x86, olpc: fix model detection without OFW
| * b13e246 x86, hpet: fix for LS21 + HPET = boot hang
| * 7ad9de6 x86: CPA avoid repeated lazy mmu flush
| * 34b0900 x86: warn if arch_flush_lazy_mmu_cpu is called in [...]
| * d85cf93 x86/paravirt: make arch_flush_lazy_mmu/cpu disable [...]
| * be03d9e x86, pat: fix warn_on_once() while mapping 0-1MB range [...]
| * 4f06b04 x86/cpa: make sure cpa is safe to call in lazy mmu mode
| * 9f339e7 x86, ptrace, mm: fix double-free on race
*   8ce9a75 Merge branch 'core-fixes-for-linus' of git:// [...]
|\  
| * 9af8814 iommu: fix Intel IOMMU write-buffer flushing
| * 2fff78c futex: fix reference leak
* b30b774 Merge branch 'merge' of git://git.kernel.org/pub/scm/ [...]
* 26456dc powerpc/vsx: Fix VSX alignment handler for regs 32-63
* 0047656 powerpc/ps3: Move ps3_mm_add_memory to device_initcall
* 06eccea powerpc/mm: Fix numa reserve bootmem page selection
* fbc78b0 powerpc/mm: Fix _PAGE_CHG_MASK to protect _PAGE_SPECIAL
