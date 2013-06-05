From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Git server, chroot, git gc --auto and "uname: not found"
Date: Wed, 05 Jun 2013 18:37:28 +0200
Message-ID: <vpqip1sfr93.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 18:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkGiQ-000645-2m
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 18:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab3FEQhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 12:37:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37203 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755288Ab3FEQhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 12:37:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r55GbRoY014271
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Jun 2013 18:37:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UkGiG-0002DT-SK; Wed, 05 Jun 2013 18:37:28 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Jun 2013 18:37:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r55GbRoY014271
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371055048.11826@WFGOD+sT/pj0UK88t9MSog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226458>

Hi,

I'm having issues with a Git hosting in a chroot (based on fusion
forge). The problem is that receive-pack triggers a "git gc --auto",
which itself triggers a "git repack", which is a shell-script.

The shell script needs basic commands [1], which are not available within the
chroot.

Is there a clean solution to this problem?

I guess the right solution is "send a patch that ports git-repack.sh to
C" (I thought we already had the server-side in C only, but just
discovered it isn't the case), but I wont have time for that (not soon
at least).

Thanks,

[1] uname, used in git-sh-setup, and then /bin/rm /usr/bin/find /bin/sed
/usr/bin/tr /bin/mkdir /bin/chmod and /bin/mv according to strace.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
