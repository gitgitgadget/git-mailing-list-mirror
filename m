From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: STG, problem with pop/push of alternative versions of a patch
Date: Fri, 14 Sep 2007 23:49:26 -0400
Message-ID: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 05:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWOez-0003un-2U
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 05:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbXIODt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 23:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXIODt2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 23:49:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:34659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbXIODt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 23:49:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1193435wah
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 20:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=9yGTXSQWZWG+V65mJPsgTiPc2Bx1i9UW1EG8qC8B80A=;
        b=NIVlq4nkIiPyD0yObm31rsKhlG6ZRZbI6qnISlH7X/dCNIdjgwSKnpgy1ObzeO5fUWAe6uHGRPzVVB60ispBBFD/HwUPmYhYWYPPxvF28soHJuW5MZ85lcMhg3zBDYrcFX9SDmQRbSgDz4ljzFhQFE802rldf8GmuQGEsf/cUDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ab0RVFVORgda4CejOO8Vjthlxx2YnQo/SSEVlCooy6MpAI6z/uOf00ggOYRiNTatR+49gsILlTbesp0CC0UXdWcsJfzTrFqwgf/ZUo6gHj3wGBuWbtSKXH1GWy3KgfLoKXp/iYkOTb/DUBF5MAzmJrXQ3VTAFcEuBoRJAUB4jqM=
Received: by 10.114.154.1 with SMTP id b1mr1190106wae.1189828166824;
        Fri, 14 Sep 2007 20:49:26 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 14 Sep 2007 20:49:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58218>

I trying to test two different versions of a patch that add files.
These patches create a new directory and add several files. When I pop
a version of the patch the directory and files and not getting
removed. This causes an error when I push the alternative version of
the patch.

jonsmirl@terra:~/mpc5200b$ stg series
+ 0001-powerpc-exports-rheap-symbol-to-modules.patch
+ 0002-powerpc-Changes-the-config-mechanism-for-rheap.patch
+ 0003-powerpc-ppc32-Update-mpc52xx_psc-structure-with-B-r.patch
+ 0004-powerpc-BestComm-core-support-for-Freescale-MPC5200.patch
+ 0005-powerpc-BestcComm-ATA-task-support.patch
+ 0006-powerpc-BestcComm-FEC-task-support.patch
+ 0007-powerpc-BestcComm-GenBD-task-support.patch
+ ignore-uImage
+ 0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
+ 0009-sound-Add-support-for-Freescale-MPC5200-AC97-interf.patch
+ 0010-powerpc-In-rheap.c-move-the-EXPORT_SYMBOL-and-use.patch
+ 0011-powerpc-BestComm-move-the-EXPORT_SYMBOL-and-use-th.patch
+ 0012-powerpc-BestComm-ATA-task-move-the-EXPORT_SYMBOL-a.patch
+ 0013-powerpc-BestComm-FEC-task-move-the-EXPORT_SYMBOL-a.patch
+ 0014-powerpc-BestComm-GenBD-task-move-the-EXPORT_SYMBOL.patch
+ 0015-powerpc-BestComm-Replace-global-variable-bcom-by-b.patch
+ 0016-powerpc-Make-the-BestComm-driver-a-standard-of_plat.patch
+ 0017-powerpc-Fix-typo-in-BestComm-ATA-task-support-code.patch
+ 0018-powerpc-BestComm-ATA-task-microcode-insert-copyri.patch
+ 0019-powerpc-BestComm-FEC-task-microcode-insert-copyri.patch
+ 0020-powerpc-BestComm-GenBD-task-microcode-insert-copy.patch
+ 0021-powerpc-Fix-errors-in-bcom-bcom_eng-renaming.patch
+ Makefile
+ pcm030_bsp_powerpc
+ fs_jffs2_use_memcpy_fromio
+ gpio_frame
+ ppc_gpio
+ GPIO-adaption
+ mpc52xx_restart
> pcm_dts_eth_phys
- domen-fec
jonsmirl@terra:~/mpc5200b$ stg pop
0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch..
Checking for changes in the working directory ... done
Popping patches "pcm_dts_eth_phys" -
"0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch" ...
done
Now at patch "ignore-uImage"
jonsmirl@terra:~/mpc5200b$ stg series
+ 0001-powerpc-exports-rheap-symbol-to-modules.patch
+ 0002-powerpc-Changes-the-config-mechanism-for-rheap.patch
+ 0003-powerpc-ppc32-Update-mpc52xx_psc-structure-with-B-r.patch
+ 0004-powerpc-BestComm-core-support-for-Freescale-MPC5200.patch
+ 0005-powerpc-BestcComm-ATA-task-support.patch
+ 0006-powerpc-BestcComm-FEC-task-support.patch
+ 0007-powerpc-BestcComm-GenBD-task-support.patch
> ignore-uImage
- 0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
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
- domen-fec
jonsmirl@terra:~/mpc5200b$ stg push domen-fec
Checking for changes in the working directory ... done
Pushing patch "domen-fec" ... error: drivers/net/fec_mpc52xx/Kconfig:
already exists in working directory
error: drivers/net/fec_mpc52xx/Makefile: already exists in working directory
error: drivers/net/fec_mpc52xx/fec.c: already exists in working directory
error: drivers/net/fec_mpc52xx/fec.h: already exists in working directory
error: drivers/net/fec_mpc52xx/fec_phy.c: already exists in working directory
fatal: Untracked working tree file 'drivers/net/fec_mpc52xx/Kconfig'
would be overwritten by merge.

  Error: The merge failed during "push".
         Use "refresh" after fixing the conflicts or revert the
operation with "push --undo".
stg push: git-merge-recursive failed with code 128
jonsmirl@terra:~/mpc5200b$ stg push --undo
Undoing push of "domen-fec" ... done
Now at patch "ignore-uImage"
jonsmirl@terra:~/mpc5200b$ stg status
? drivers/net/fec_mpc52xx/
jonsmirl@terra:~/mpc5200b$


-- 
Jon Smirl
jonsmirl@gmail.com
