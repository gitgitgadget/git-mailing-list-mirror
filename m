From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG] send-email: alias expansion broken
Date: Fri, 14 Oct 2011 14:29:27 +0200
Message-ID: <4E982B27.8050807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Cord Seele <cowose@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 14:30:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REgtp-0003ba-0r
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 14:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772Ab1JNM3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 08:29:31 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33004 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932180Ab1JNM33 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 08:29:29 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9812420A9A;
	Fri, 14 Oct 2011 08:29:29 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 Oct 2011 08:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=x
	BZRzyW/HaKuTlz+INvbOCblocE=; b=eh6qY8jY2iGwcNocfmSM795csS92ZAlMp
	9OTQ7JafN9hk+HF/sAIguV/Obi+OXzzis0bkl9iJu/ker4uOgbdIHHZOSdTdgCEc
	8S9dZ9WlQwKf33lledlqP2GyRQabjaAHiI1k+inC2jNaVz9IzQMbdDOZ06dQhcjV
	fg46oaINCs=
X-Sasl-enc: Q4vPd5n0aVCxpXdgZcEH5k70CufnKRIJzWa3EdJojEai 1318595369
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1BBFF404A7E;
	Fri, 14 Oct 2011 08:29:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183567>

cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)

broke the expansion of aliases for me:

./git-send-email --cc=junio  --dry-run
0001-t7800-avoid-arithmetic-expansion-notation.patch
0001-t7800-avoid-arithmetic-expansion-notation.patch
Who should the emails appear to be from? [Michael J Gruber
<git@drmicha.warpmail.net>]
Emails will be sent from: Michael J Gruber <git@drmicha.warpmail.net>
Dry-OK. Log says:
Sendmail: /home/mjg/bin/msmtp-fastmail-git -i git@vger.kernel.org junio
git@drmicha.warpmail.net
From: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
Cc: junio
...

Happens with both "--cc junio" and "--cc=junio".

Reverting cec5dae brings my aliases back. Relevant config:

git config --get-regexp sendemail.alias\*
sendemail.aliasesfile /home/mjg/git/gitauthors
sendemail.aliasfiletype mutt

Can I please have alias expansion back?

No, I don't know what cec5dae tries to achieve, and I lack the perl fu
to fix it.

Michael
