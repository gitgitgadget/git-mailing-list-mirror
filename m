From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 00:43:47 +0200
Message-ID: <17596.4771.377000.843941@lapjr.intranet.kiel.bmiag.de>
References: <20060706055729.GA12512@admingilde.org>
	<87k66p8jee.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<87fyh1ncm0.fsf@mid.deneb.enyo.de>
	<f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	<20060716223607.GA6023@steel.home>
	<87d5c4ajlu.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
	<f36b08ee0607171332k1da1ef77j352b31c78039d06c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 18 00:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2boz-0005vL-Ot
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGQWoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWGQWoI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 18:44:08 -0400
Received: from bilbo.bmiag.de ([62.154.210.131]:29714 "HELO bilbo.bmiag.de")
	by vger.kernel.org with SMTP id S1751221AbWGQWoF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 18:44:05 -0400
Received: (qmail 29173 invoked by uid 106); 17 Jul 2006 22:44:03 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdlN9qfq; Tue Jul 18 00:44:03 2006
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id B79DD3BB4E
	for <git@vger.kernel.org>; Tue, 18 Jul 2006 00:44:02 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05930-04 for <git@vger.kernel.org>;
	Tue, 18 Jul 2006 00:43:54 +0200 (CEST)
Received: from bmiag.de (elros.intranet.kiel.bmiag.de [10.132.1.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with SMTP id 5BC2C3AF51
	for <git@vger.kernel.org>; Tue, 18 Jul 2006 00:43:54 +0200 (CEST)
Received: (qmail 8598 invoked by uid 5002); 17 Jul 2006 22:43:53 -0000
Received: from dialin5.galadriel.bmiag.de (HELO LAPJR) (192.168.251.5)
  by elros.intranet.kiel.bmiag.de with SMTP; 17 Jul 2006 22:43:53 -0000
To: "Yakov Lerner" <iler.ml@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)git@vger.kernel.org
								     ^-missing end of address
In-Reply-To: <f36b08ee0607171332k1da1ef77j352b31c78039d06c@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23987>

Yakov Lerner writes:
 > On me, it failed me on git-apply with more than 1 patches on
 > the commandline.
 > 
 > git-apply with 1 patch on the commandline passed, with two, failed.
 > 
 > git-apply with two patches on commandline is the simplest
 > testcase that exposes this problem, AFAIK.

In that case tests 4109 and 4110 should fail, shouldn't they? They
succed for me on NTFS (and fail on other FS). But anyway, I did some
quick performance check and the NO_MMAP code path seems to be as fast
as the mmap one (even much faster in some cases). So the combination
of windows' memory management and git mmap usage doesn't seem so hot
(especially considering the fact that git runs about twice as fast on
FAT32 for me).

  jr
