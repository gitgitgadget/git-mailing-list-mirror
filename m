From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: STG, problem with pop/push of alternative versions of a patch
Date: Sat, 15 Sep 2007 13:42:31 -0400
Message-ID: <9e4733910709151042p7c681e25o386be2ca2719daa9@mail.gmail.com>
References: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
	 <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
	 <9e4733910709150725k73bec66bw753c4b3c01244cff@mail.gmail.com>
	 <b0943d9e0709151031m70b9d03bw4068805e697e97f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbfF-0002o1-CC
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXIORmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbXIORmg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:42:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:22165 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXIORmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:42:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1380161wah
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uBNJuHFnvS4H7OjEzCuos1oFtUG7LlYicFPu5Z+2Zls=;
        b=jjsr2TLEaJ6k2vo9aRRZyY6QdGPDBKC5SLNkWbfqZbW9vD28jloXZDUBRdVuc3XPUE5VHOHo5Yh96/WEdMx5XJB4IIErMv+FLUePL1Y//jhDJSyfIqyghmYywtv5/filjltq6IRt579WIEsWAsJyFDwDCbCp+SSLG7DDOgfAPF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DToHUrek/930w+FY7N8OxtX58oAg3W+Er5JkoWmlElMmIDdy2Csae+P9UpC2FeMkh+IuISLgQ9BRMwCgJPadHOwCG9ho52xpYzu8rT3Y7E9hVzbbEpio/gbrlkTzAd4Kq11G+4HMER6eAWcyOURkPiEAAoRp2ST1fHpz4MZNiL4=
Received: by 10.114.126.1 with SMTP id y1mr498845wac.1189878151531;
        Sat, 15 Sep 2007 10:42:31 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sat, 15 Sep 2007 10:42:31 -0700 (PDT)
In-Reply-To: <b0943d9e0709151031m70b9d03bw4068805e697e97f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58268>

On 9/15/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 9/15/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > I trying to test two different versions of a patch that add files.
> > > > These patches create a new directory and add several files. When I pop
> > > > a version of the patch the directory and files and not getting
> > > > removed. This causes an error when I push the alternative version of
> > > > the patch.
> > >
> > > This shouldn't happen AFAICT (at least for the files, as GIT doesn't
> > > care much about directories). What GIT/StGIT version are you using?
> > > StGIT simply calls GIT to do the HEAD switch.
> >
> > I have played around with some more. It is more complicated than the
> > simple case I described.  Earlier I noticed a message about applying a
> > patch that was empty that shouldn't have been. I checked and the patch
> > is indeed empty. The empty patch probably caused the files to be left.
> > I had been using hide/unide and reordering with on the patch and had
> > encountered a couple errors in stg. I'll try and track down the
> > sequence that caused the contents of the patch to be lost.
>
> BTW, you can run 'stg log <patch>' to see how the patch was changed.
> It even has a -g option to invoke gitk and see each change.
>
> One way a patch could become empty is if the changes it makes are
> already in the repository (in another patch or merged upstream).

I was not happy when my patch disappeared. Luckily I had exported it a
little while earlier.

This error may have messed up my state and I didn't detect it until
later. 0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
is the patch that went missing.


---------- Forwarded message ----------
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sep 13, 2007 4:08 PM
Subject: Stg AssertionError in sink command
To: Git Mailing List <git@vger.kernel.org>, catalin.marinas@gmail.com


Using current git source for Stg

Patch 008 was hidden and I used unhide to bring it back. But the
hide/unhide process moved it to the top of the stack. I need to sink
it back down to where it came from. Shouldn't hide/unhide preserve the
patch position in the stack?

jonsmirl@terra:~/mpc5200b$ stg series
+ 0001-powerpc-exports-rheap-symbol-to-modules.patch
+ 0002-powerpc-Changes-the-config-mechanism-for-rheap.patch
+ 0003-powerpc-ppc32-Update-mpc52xx_psc-structure-with-B-r.patch
+ 0004-powerpc-BestComm-core-support-for-Freescale-MPC5200.patch
+ 0005-powerpc-BestcComm-ATA-task-support.patch
+ 0006-powerpc-BestcComm-FEC-task-support.patch
> 0007-powerpc-BestcComm-GenBD-task-support.patch
- domen-fec
- 0009-sound-Add-support-for-Freescale-MPC5200-AC97-interf.patch
- 0010-powerpc-In-rheap.c-move-the-EXPORT_SYMBOL-and-use.patch
- 0011-powerpc-BestComm-move-the-EXPORT_SYMBOL-and-use-th.patch
- 0012-powerpc-BestComm-ATA-task-move-the-EXPORT_SYMBOL-a.patch
- 0013-powerpc-BestComm-FEC-task-move-the-EXPORT_SYMBOL-a.patch
- 0014-powerpc-BestComm-GenBD-task-move-the-EXPORT_SYMBOL.patch
- 0015-powerpc-BestComm-Replace-global-variable-bcom-by-b.patch
- 0016-powerpc-Make-the-BestComm-driver-a-standard-of_plat.patch
- 0017-powerpc-Fix-typo-in-BestComm-ATA-task-support-code.patch
- 0018-powerpc-BestComm-ATA-task-microcode-insert-copyri.patch
- 0019-powerpc-BestComm-FEC-task-microcode-insert-copyri.patch
- 0020-powerpc-BestComm-GenBD-task-microcode-insert-copy.patch
- 0021-powerpc-Fix-errors-in-bcom-bcom_eng-renaming.patch
- Makefile
- pcm030_bsp_powerpc
- fs_jffs2_use_memcpy_fromio
- gpio_frame
- ppc_gpio
- GPIO-adaption
- mpc52xx_restart
- pcm_dts_eth_phys
- 0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
jonsmirl@terra:~/mpc5200b$ stg sink -t domen-fec
0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
Checking for changes in the working directory ... done
Traceback (most recent call last):
  File "/usr/local/bin/stg", line 43, in <module>
    main()
  File "/usr/local/lib/python2.5/site-packages/stgit/main.py", line 284, in main
    command.func(parser, options, args)
  File "/usr/local/lib/python2.5/site-packages/stgit/commands/sink.py",
line 58, in func
    crt_series.pop_patch(options.to or oldapplied[0])
  File "/usr/local/lib/python2.5/site-packages/stgit/stack.py", line
1129, in pop_patch
    assert(name in applied)
AssertionError
jonsmirl@terra:~/mpc5200b$



-- 
Jon Smirl
jonsmirl@gmail.com
