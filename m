From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: a few remaining issues...
Date: Fri, 5 Jan 2007 17:54:49 +0100
Message-ID: <17822.33497.895000.694542@lapjr.intranet.kiel.bmiag.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 17:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2sLa-0004tH-7h
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 17:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbXAEQzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 11:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbXAEQzK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 11:55:10 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:36663 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161149AbXAEQzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 11:55:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 20E1C3AF1F;
	Fri,  5 Jan 2007 17:54:59 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13104-10; Fri, 5 Jan 2007 17:54:58 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id C189D3AF1D;
	Fri,  5 Jan 2007 17:54:57 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id D69573ADC8;
	Fri,  5 Jan 2007 17:54:56 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03823-02; Fri, 5 Jan 2007 17:54:52 +0100 (CET)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id CF0593ADC6;
	Fri,  5 Jan 2007 17:54:51 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36007>

Junio C Hamano writes:
 > * Handling paths that are unknown to the index.
 > 
 > I sent out patches tonight to teach "git reset <tree> -- <path>"
 > to restore the absense of path in the index from the tree
 > tonight.  There was another one recently brought up on the list:
 > "git commit -- <path>" for path that is no longer known to the
 > index.  While jumping the index is a practice I particularly do
 > not want to encourage by extending git to support it, we already
 > have support for most of the cases, so I think it makes sense to
 > do this for consistency.  I haven't thought about the necessary
 > changes yet, so people can beat me if they want to.  My vague
 > idea is to check HEAD to see if <path> exists and if so refrain
 > from complaining.

This looks like a job for your para-walk topic. For this git-commit
case we just need a

  git-ls --no-workdir --error-unmatch HEAD -- <pattern>...

to replace git-ls-files. To my untrained eyes it looks like this is
mostly there (AFAICS it doesn't do pattern matching and the
--error-unmatch thingy).
