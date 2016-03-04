From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 0/2] Test trash dir sanitizing
Date: Fri,  4 Mar 2016 11:53:48 +0100
Message-ID: <cover.1457088499.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 11:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abnMt-0006pZ-M7
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 11:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbcCDKxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 05:53:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47691 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835AbcCDKxw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 05:53:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AC46121AB9
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 05:53:51 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 04 Mar 2016 05:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=yQ8smf+d8tLyzRahnmqfad51cRA=; b=VoiawM07imhe4oRljwldCj6ceR1K
	6p1/OcJ5ULb44d4VM4WgBh/MJZ+kuAD04lU/u7ZKBC/J/8QhPpzpQ/4WSN+KX2i3
	ofFD1BNLnfhsLcEH02hRlmzFwMILZ4ofB7LwunzqSe7yK+5Vs0YG59ad/+qu5XO2
	YGlvzL/f9zSRg3Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=yQ8smf+d8tLyzRahnmqfad51cR
	A=; b=H/qGriaWi2Ed61uoCb2kBOD5XxRWHuFoFU67w8ildJDBvM/pBhuu+5F/R3
	5XBymITCCGq9q10r+CUf5GRZslMQ9TQ24zKNK4wsEL0T8ohPHmq/sWCcBvwzDP+y
	wlEYQxZgW08TinaVtG1eERjrEvb9FmZ6JB58B+pXbUz9QhWPw=
X-Sasl-enc: JbDIj2smPvrnIqRt8mjd/xSDTTiDpnGIdUHeUsiZ5w52 1457088831
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4A8F16801BC;
	Fri,  4 Mar 2016 05:53:51 -0500 (EST)
X-Mailer: git-send-email 2.8.0.rc0.181.g163d81c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288243>

I encountered a Heisenbug[*] where t5510 would leave its trash directory without
cleanup, though not reproducibly so. This mini series cleans up two spots which
may or may not be related, but should be goog cleanup anyways.

[*] Running tests with prove -j4.

Michael J Gruber (2):
  test-lib: quote TRASH_DIRECTORY
  t5510: do not leave changed cwd

 t/t5510-fetch.sh | 10 ++++++----
 t/test-lib.sh    |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.8.0.rc0.181.g163d81c
