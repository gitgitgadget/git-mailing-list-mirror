From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: What happens when the repository is bigger than gc.autopacklimit
 * pack.packSizeLimit?
Date: Fri, 29 Aug 2014 11:38:00 -0400
Message-ID: <201408291538.s7TFc0DU001156@hobgoblin.ariadne.com>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com> <20140827194746.GE7561@peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 17:44:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNOLc-0006PJ-9N
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 17:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaH2PoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 11:44:11 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:47943
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752650AbaH2PoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 11:44:09 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2014 11:44:09 EDT
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id ke8p1o0020vyq2s53fe1p1; Fri, 29 Aug 2014 15:38:01 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id kfe01o00y1KKtkw3Rfe1MY; Fri, 29 Aug 2014 15:38:01 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s7TFc0K9001157;
	Fri, 29 Aug 2014 11:38:00 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s7TFc0DU001156;
	Fri, 29 Aug 2014 11:38:00 -0400
In-reply-to: <20140827194746.GE7561@peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409326681;
	bh=pyy5KQNFvHtOqDe/bPkHb2BXK3gTjOhVNXTx1VXvSUI=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=TRaa3ksjCPZU6jwrfy+yof6htxt4DdLya5EkrZZhsdf4L1nLXby+rToXEfJAdC1Ij
	 N6+gjLLr5HGYoEITioE3AHGs8xQOUgF8woHIFVTOu367AaPQ8vyo1HQhk4SuhHNbC1
	 TK5GAStsknLq2LdmZ0Unt3T7Chiy3/Wk6P4cmsF7HKaMFXJQ9Q0cO74aXdm23ICziK
	 Sp33EQ2ZG76ocPJBgIpVhi56t1ROHSOJ+qhE7Q920krnWXvSPDk2qxE3Qxkse/yJhc
	 8H70gm7VlzV+gG8UU0UYfaj18igqrpGm6DLnPLS/8+iEU4AGyeCDpgcbMa5uapoF8y
	 4umtr0pGufTmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256149>

> From: Jeff King <peff@peff.net>

> why are you setting the packsize limit to 99m in the first place?

I want to copy the Git repository to box.com as a backup measure, and
my account on box.com limits files to 100 MB.

> There are more delta opportunities

In this repository, only the smallest files are text files; the bulk
of the files are executable binaries.  So I've set
core.bigFileThreshold to 10k to stop Git from attempting
delta-compression of the binaries.  That makes the repository slightly
larger, but it dramatically speeds the repacking process.

Dale
