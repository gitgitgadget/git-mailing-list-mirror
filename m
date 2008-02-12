From: Frans Pop <elendil@planet.nl>
Subject: [BUG] git bisect should not expand file globs in log
Date: Tue, 12 Feb 2008 20:23:28 +0100
Message-ID: <200802122023.28879.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 20:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP0zu-0006Ep-6A
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 20:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYBLTju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 14:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYBLTju
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 14:39:50 -0500
Received: from hpsmtp-eml12.KPNXCHANGE.COM ([213.75.38.112]:37013 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbYBLTjt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 14:39:49 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 14:39:49 EST
Received: from cpsmtp-eml105.kpnxchange.com ([213.75.84.105]) by hpsmtp-eml12.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Feb 2008 20:23:31 +0100
Received: from faramir.fjphome.nl ([84.85.147.182]) by cpsmtp-eml105.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Feb 2008 20:23:31 +0100
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-OriginalArrivalTime: 12 Feb 2008 19:23:31.0439 (UTC) FILETIME=[C0AC77F0:01C86DAC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73684>

Hi,

During a git bisect session I ended up with the following in the
.git/BISECT_LOG:

# bad: [38a382ae5dd4f4d04e3046816b0a41836094e538] Kobject: convert 
arch/alpha arch/arm arch/avr32 arch/blackfin arch/cris arch/frv arch/h8300 
arch/ia64 arch/m32r arch/m68k arch/m68knommu arch/mips arch/parisc 
arch/powerpc arch/ppc arch/s390 arch/sh arch/sh64 arch/sparc arch/sparc64 
arch/um arch/v850 arch/x86 arch/x86_64 arch/xtensa from 
kobject_unregister() to kobject_put()
git-bisect bad 38a382ae5dd4f4d04e3046816b0a41836094e538

>From the following command you can see shat happened: the 'arch/*' from the 
commit log was expanded in the comment line in the bisect log file.

$ git bisect bad
38a382ae5dd4f4d04e3046816b0a41836094e538 is first bad commit
commit 38a382ae5dd4f4d04e3046816b0a41836094e538
Author: Greg Kroah-Hartman <gregkh@suse.de>
Date:   Thu Dec 20 08:13:05 2007 -0800

    Kobject: convert arch/* from kobject_unregister() to kobject_put()

git version: 1.5.4 (current Debian unstable)

Cheers,
FJP
