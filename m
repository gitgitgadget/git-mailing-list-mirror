From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: more fancy ignoring of files ('if' in .gitignore?)
Date: Tue, 27 Oct 2009 10:56:02 +0100
Message-ID: <4AE6C3B2.9050601@drmicha.warpmail.net>
References: <200910271030.54571.schubert.seb@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schubert <schubert.seb@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2imk-0004Z5-Um
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 10:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZJ0J4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 05:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZJ0J4D
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 05:56:03 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41296 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533AbZJ0J4C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 05:56:02 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 87440BD5ED;
	Tue, 27 Oct 2009 05:56:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 27 Oct 2009 05:56:06 -0400
X-Sasl-enc: zf66xz8GmoKToEUGnFAtzn4uT/OdhTjzH2Cnpk3FjvPF 1256637366
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D751D162C6;
	Tue, 27 Oct 2009 05:56:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091027 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <200910271030.54571.schubert.seb@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131319>

Sebastian Schubert venit, vidit, dixit 27.10.2009 10:30:
> Hi,
> 
> I would like to ignore files if certain other files are present. In my 
> special case, I want to ignore foo.pdf and foo.eps if foo.fig is 
> present (both pdf and eps are generated on the fly but don't belong 
> into repository). In general, I do NOT want to ignore pdf or eps. There 
> are a lot of foos so I would like to have a general solution.
> 
> Is this possible?

No.

You can script around it by making e.g. your build process (which
generated pdf/eps from fig) add a specific foo.pdf etc to .gitignore.

In fact, at the the time you add a fig to your repo you should add (&
commit) corresponding lines to .gitignore. This is the common approach.

Alternatively, you can update your ignore with

rm -f .gitignore;find . -name \*.fig | while read i;do echo -e
${i%fig}pdf "\n" ${i%fig}eps >>.gitignore;done

if you have no other ignore patterns in there. (This is q&d, adjust if
you have spaces in file names or such.)

Michael
