From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFE: "git bisect reverse"
Date: Thu, 28 May 2009 14:54:02 -0700
Message-ID: <4A1F07FA.6040008@zytor.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 	<4A1E00F1.4030709@zytor.com> <efe2b6d70905281407x56bb788aq3dba4b27eb91d7a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 28 23:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9nYZ-0006hV-Gp
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbZE1VyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZE1VyX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:54:23 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55206 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZE1VyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:54:23 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n4SLs4Hs006771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2009 14:54:10 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <efe2b6d70905281407x56bb788aq3dba4b27eb91d7a6@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9402/Thu May 28 13:16:58 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120239>

Ealdwulf Wuffinga wrote:
> 
> It would fit a lot better into this algorithm to have some model of
> the probability that a commit will cause a skip. It doesn't actually
> have to be a very good one, because if it's poor it will only make the
> search slightly less efficient, not affect the reliability of the
> final result.
> 

How about simply modelling it linearly, with 100% probability for known
skip point, 0% for a known good/bad point, and a linear gradient in
between?  It's probably a good enough model.  In practice, it will
vastly overestimate the probability of a skip, so if a linear model
turns out to be too conservative, I would probably just try to model it
as a higher-order power function.

	-hpa
