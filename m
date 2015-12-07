From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: rebase has no --verify-signatures
Date: Mon, 7 Dec 2015 15:00:15 +0100
Message-ID: <20151207140015.GA14956@netblarch.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 14:53:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5wE9-0007Vb-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 14:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbbLGNxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 08:53:04 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33202 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbbLGNxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 08:53:02 -0500
Received: by wmec201 with SMTP id c201so166486247wme.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=J8jiQWE7VMWvaOYVOtBiho/sVAO/OgwMy3Xc1vU2yLg=;
        b=DB6EJVA83QrjayV2YNvdh037gcqekGhou4FtfnWB/bw3aG2FMJIvsIuRbVslsx5eeo
         cwUY87G786Q+0SUbzJ2uSCX5zVqF4I8Y+BtzEuY65Vj2o15GLjQU3CO9wmOgro09Q74z
         wQWm1HTYVVoilkG4Oewp5E6d5rfsorlH808AlXD5YdpnZ4ZtbbCjSQqSDSqRmpzmxJw9
         QgDk4v7YvYtCpC3w/6Wdj55lo0uwkfjUZ1bRDms/p1bX4jwlo5+rdg/SPjRfMleIdQS5
         b/Kk7sIflHpMXHhufA7/hfTAFBPNnRhFGbEfs/ORW7QGpiL3AeKLCa8QqmZZzTTmlFKI
         /Vug==
X-Received: by 10.195.13.135 with SMTP id ey7mr32457290wjd.25.1449496380843;
        Mon, 07 Dec 2015 05:53:00 -0800 (PST)
Received: from netblarch.tu-darmstadt.de (s5067.dyn.hrz.tu-darmstadt.de. [130.83.220.43])
        by smtp.gmail.com with ESMTPSA id c4sm25357844wjs.36.2015.12.07.05.52.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 05:53:00 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282094>

Hi,

The git merge command has a --verify-signatures flag, which, when set, checks that the commits to be merged have trusted GPG signatures. git pull also knows this flag and forwards it to the merge command.

However, doing a git pull --rebase --verify-signatures silently ignores it, since rebase has no --verify-signatures flag.

Is there any technical reason why rebase should not have a --verify-signatures flag? I have written a patch to git-rebase--am which enables it to do such a check. If there is no reason not to include it I'd add documentation and a test and submit it.

Otherwise I think git pull should warn, or even die with an error, if both --rebase and --verify-signatures are passed.

Regards,
Alexander Hirsch
