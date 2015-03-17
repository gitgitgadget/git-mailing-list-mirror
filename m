From: Ryan Lortie <desrt@desrt.ca>
Subject: git submodule: update=!command
Date: Tue, 17 Mar 2015 15:28:57 -0400
Message-ID: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 20:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxAm-0001a4-Li
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 20:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbbCQT3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 15:29:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45915 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753242AbbCQT26 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 15:28:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id ED9392099E
	for <git@vger.kernel.org>; Tue, 17 Mar 2015 15:28:55 -0400 (EDT)
Received: from web1 ([10.202.2.211])
  by compute4.internal (MEProxy); Tue, 17 Mar 2015 15:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=desrt.ca; h=
	message-id:x-sasl-enc:from:to:cc:mime-version
	:content-transfer-encoding:content-type:subject:date; s=mesmtp;
	 bh=FPCyWK/iT6D0ldnJ/R5sXoRxd2I=; b=i6qyMjjUlMbkrowVv/eAyyaniIbP
	HdpN7BhbrY+abZowhKZDHlJzkl43xXo5IKvOXgB9GVG4h+Oy5fFZT4Dk0rpSg+cq
	cyTPIXxy5X2q+jVRueEsZXeTKaQCzgQxNAOzRtn6bx82CnFbgvE96E9Zv/vLFGvi
	CC67o70bvyjLSDo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to:cc
	:mime-version:content-transfer-encoding:content-type:subject
	:date; s=smtpout; bh=FPCyWK/iT6D0ldnJ/R5sXoRxd2I=; b=sysxLTGxdmv
	+BuhVcc5NQsxUECYiidHk69PQdEUvObNRIQoeNFBN4PgHytRd9bsOaLakvDHMLxy
	inXlL0pSusiuFpz4nsaVfNB8JYsf88GPsvWtiKcbWe/rNI2Dvyx7fQ67iPDP7phM
	MHj2T4M13LMkFtIb4bsiOkWUmyf9O4Qo=
Received: by web1.nyi.internal (Postfix, from userid 99)
	id BB02DAF3342; Tue, 17 Mar 2015 15:28:57 -0400 (EDT)
X-Sasl-Enc: IHurpUcxovbUd1BjCO30LSMC/vQVUA8rmo60PXd7Upmo 1426620537
X-Mailer: MessagingEngine.com Webmail Interface - ajax-15db86eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265655>

karaj,

'man git-submodule' contains mention (in one place) that:

    Setting the key submodule.$name.update to !command
    will cause command to be run.

This is not documented in 'man gitmodules' (which documents the other
possible values for the 'update' key) nor in 'man git-config' which also
mentions the 'update' key (but refers readers to the two other pages).

This feature is scary.  The idea that arbitrary code could be executed
on my machine when I run innocent-looking git commands, based on the
content of the .gitmodules file is enough to  give pause to anybody.

Fortunately, it seems that (for now?) this is not really the case.  'git
submodule init' will copy the values of the 'update' key from
.gitmodules to your local git config, but only if they are one of
"none", "checkout", "merge" or "rebase".

So, I guess I'm asking two things.

The first is a question about git's basic policy with respect to things
like this.  I hope that it's safe to assume that running 'git' commands
on repositories downloaded from potentially-hostile places will never
result in the authors of those repositories being able to run code on my
machine.

If that is true then, the second request would be to spell this out more
explicitly in the relevant documentation.  I'm happy to write a patch to
do that, if it is deemed appropriate.

Thanks in advance.

Cheers
