From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 08:15:51 +0100
Message-ID: <568E10A7.5050606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:23:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH4uU-0004eK-6z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 08:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbcAGHW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 02:22:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46642 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbcAGHWz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 02:22:55 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2016 02:22:55 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 08F4B2099E
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 02:15:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 07 Jan 2016 02:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=BB4
	S9H7C9mAQHFPegPKRM6bKu9c=; b=i1IGDyolwPINu+2eToiWk16RDJ55XrqzvK2
	C1rhOydEtfzo4tX4VvSd8jmJw4EN+SRVL91eoqZ/u/YY7EXum2+3XZsQHhN/9M1A
	rkUmzLDbmw8PgW0cDmOOHzToHVAwMQeUwX90fOStUhUT/py//1fOc/OVR7OHH5FZ
	Lse2ajtE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=BB4S9H7C9mAQHFPegPKRM6bKu9c=; b=dYM2O
	pXsEMRQjHul8P9wqkI9aJcgdEPfkI1n0pJlzBoZXR8u02upQI6BwBBWlN9tqlMip
	uHYmG/4vWm8mhkkz3lUr/D4JfNPrcQVPoIC7iM2inMduAq8BpUKoTWBcsuZFzanM
	8eSMZHIV2nIzB/lxh9XP68FKVpRO9WYfOpma0o=
X-Sasl-enc: jmh5Jpo46tOtV+cdwHAB68HrC9aGeoVs4FB5NMgfwKO/ 1452150952
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9E2B5C016D5
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 02:15:52 -0500 (EST)
X-Mozilla-News-Host: news://news.gmane.org:119
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283469>

Hi there,

sorry I can't dig deeper now, but the worktree code from next seems to
get confused now as soon as you cd to a subdir of a worktree (other tha=
n
the main worktree) and use an alias:

git help ss
`git ss' is aliased to `status -s -b'
[mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git status -s -b
## exam
[mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git ss
fatal: internal error: work tree has already been set
Current worktree: /home/mjg/Teaching/LUK
New worktree: /home/mjg/Teaching/LUK/Biomath-WS15

This is inside the subdir "Biomath-WS15" of the worktree residing in
".../LUK".

It wasn't like that last year ;)

Something about setting GIT_DIR and the like in the environment must
have changed (for aliases), badly interacting with the worktree code.

Michael
