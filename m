From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/BUG?] git show with tree/commit
Date: Tue, 12 Apr 2016 17:33:33 +0200
Message-ID: <570D154D.6090006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0Jx-0005lE-HV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 17:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbcDLPdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 11:33:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56059 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965045AbcDLPdg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 11:33:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3179620EB1
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 11:33:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 12 Apr 2016 11:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=nyL
	U4mWYPQart+nEwSrhv569B8Q=; b=EQAYeqyc6qvxZlV6J4FQwK4FVQfpG/EXaFz
	lJKzeJVeSFwjyPqgRDFI7fKXJrHJWtuE2oSduogGYrfigMYNgvUpiAaWBGxQGCUP
	533M+/wagyZ5sNCxHUqkSBnSwpwaKxl0W6y33Bf+66ugDVjb8LRowHXipicGOzHT
	wb4chez4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=nyLU4mWYPQart+nEwSrhv569B8Q=; b=m6wE/
	ROZ+pCrX3MG2Uhs3htxh7MjuDe9mCZX6by2tbayrwYI3Dyq85DJpmg5eeS54jyF4
	K30URjNGq8Rf7wi/m2UbPyChAukeFlN0Cqv2jQRRKp3+t7NfTOSPIRWx8U3/j/RX
	5cOe9GeV7pu3Cj+qO+RtJltO6eyDedHazXRwYo=
X-Sasl-enc: MMn2KrRx4p02SfHEzKOyXtn1OP4lNdImNkyGRXJHf1Tx 1460475214
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id BDEAEC00018
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 11:33:34 -0400 (EDT)
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291268>

With current next, using any commit sha1:

$ git cat-file -p cab2cdadfda8e8e8631026443b11d3ed6e7ba517
tree 04050d37b1676ba8da277be1902513049b45413a
parent b673b5e7d121021f77768c736cd9f98d7b3b3967
parent 7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355
...

$ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:

.gitattributes
.gitignore
.mailmap
...

$ git show 04050d37b1676ba8da277be1902513049b45413a:
tree 04050d37b1676ba8da277be1902513049b45413a

.gitattributes
.gitignore
.mailmap
...

While it's clear to me what's going on, I'm wondering whether it's a
good idea that "git show" says "tree" in front of the unresolved
treeish, whether it's a tree, a commit or something else. I think it's
pretty confusing. Alternatives would be:

tree <resolved tree id> # here: 040...
treeish <treeish>	# here: "treeish cab2c..."
tree <treeish>^{tree} 	# here: "tree cab2c^{tree}"

Cheers
Michael
