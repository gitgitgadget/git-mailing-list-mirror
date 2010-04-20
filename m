From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [bug] git svn clone failing with invalid diff stream
Date: Tue, 20 Apr 2010 18:12:15 +0200
Message-ID: <4BCDD25F.4030406@drmicha.warpmail.net>
References: <m2q971f65791004192348zab4adf13p93a6a4c1d60f9c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 18:15:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4G6k-0006Ss-Pm
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 18:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0DTQPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 12:15:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59869 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753318Ab0DTQPT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 12:15:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 922E3EB3DC;
	Tue, 20 Apr 2010 12:15:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 20 Apr 2010 12:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hNmT0rOF/AAec76+5V7O8NUdjsA=; b=B26zqcc+g4hEXFW/0nG2LVWJrBZxmYYIPRi4vwLunmcqTH5ECSoXcZILrCN6FRHY8nyxekgxsrtFO0zyCqI4MXSbQl9VC3zvbkPkt7XV8KRpB5Ku05B4FH58xk43RsSjvmvs+QMIiGNRKKDlkfsfgpRt+9vu6ubQTqD08znESzM=
X-Sasl-enc: wbIVtN6tAqCRS/Sz2ESgKFab0o91B4mdHjhr5WTxbrze 1271780118
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F0E674DA7F;
	Tue, 20 Apr 2010 12:15:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <m2q971f65791004192348zab4adf13p93a6a4c1d60f9c16@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145386>

Anand Kumria venit, vidit, dixit 20.04.2010 08:48:
> Hi,
> 
> Using both git 1.7.0.4 and 1.5.6.5 I am unable to clone the Subversion
> respository for Serendipity.
> 
> URL: svn://svn.berlios.de/serendipity
> 
> It fails consistently on r1341 with:
> 
> (1.5.6.5): Svndiff data contains invalid instruction: Invalid diff
> stream: [tgt] insn 335 starts beyond the target view position at
> /usr/bin/git-svn line 3856
> 
> and
> 
> (1.7.0.4): Svndiff data contains invalid instruction: Invalid diff
> stream: [tgt] insn 335 starts beyond the target view position at
> /usr/lib/git-core/git-svn line 5047
> 
> On, seemingly UTF-8 encoded data. Any ideas / pointers would be appreciated.

That message actually comes from the underlying svn diff itself. To me
it looks like a problem with the underlying fsfs on the server:

http://www.szakmeister.net/fsfsverify/

hg convert runs into the same problem, btw.

It would be worthwhile to try svnsync and clone the synced repo, but it
seems berlios does not support the necessary replay command. Time to
talk to them!

Michael
