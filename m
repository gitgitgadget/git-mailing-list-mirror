From: Jonathon Mah <me@JonathonMah.com>
Subject: RFC: Renaming "git rebase --onto"
Date: Mon, 30 Mar 2015 13:49:34 -0700
Message-ID: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 22:49:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycgd5-0006q0-S2
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 22:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbbC3Uth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 16:49:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45676 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbC3Utg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 16:49:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DC87E20856
	for <git@vger.kernel.org>; Mon, 30 Mar 2015 16:49:32 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 30 Mar 2015 16:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=JonathonMah.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=A0V
	GMotvPv/aBOcMbcWuojUbNm0=; b=qJzfHu3QR2DeZ3iH1xlS98ShLAfFWFbpOVa
	o3YBrEVk9K5CzJdireoCv5YP+ITujzKve1SSg3ceKrjZteI4EAUXznl1fkLmkmnB
	Ar/wSw/RCpjg2IWEEPtwAFVUs/LIG4dC6XBX6vFpyCSzdsA6GeI6Y7DETx94U63q
	CgZsDpW0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=A0VGMotvPv/aBOcMbcWuojUbNm0=; b=t/s3E
	Y0tw5MoFPEhnpD3QtgNafZkxevucn3sCLH7kNUUigbDTTL3Fd+41Gu87Vh3qo5Hu
	QGWrfqrp7NhCsgmZpOTzyGObsxnRFiKII43dABE4x8JCQKtxm8kx5dfTnkuUw/J9
	znQxsinGc8DpW9EKawajceqL2+fLIxDJVKzDnY=
X-Sasl-enc: U+msGegauiSIgQx2xqyEMlrr8g+eflrfoVS2vcgSXwbm 1427748575
Received: from [10.1.10.53] (unknown [50.250.236.46])
	by mail.messagingengine.com (Postfix) with ESMTPA id 81E6AC00013;
	Mon, 30 Mar 2015 16:49:35 -0400 (EDT)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266474>

During a few years of discussing git operations with colleagues, I=E2=80=
=99ve found the =E2=80=9Cgit rebase --onto=E2=80=9D operation particula=
rly ambiguous. The reason is that I always describe a rebase operation =
as =E2=80=9Conto=E2=80=9D something else (because of the English phrase=
 =E2=80=9CA is based on B=E2=80=9D). For example:=20

$ git rebase new-base  # =E2=80=9CRebase HEAD onto new-base (from merge=
-base of HEAD and new-base)"
$ git rebase new-base my-branch  # =E2=80=9CRebase my-branch onto new-b=
ase (from merge-base of my-branch and new-base)=E2=80=9D

Personally, I understand =E2=80=9Cgit-rebase --onto new-base old-base=E2=
=80=9D as meaning =E2=80=9Crebase from old-base to new-base=E2=80=9D. S=
ome prepositions that might make this clearer:

$ git rebase --from old-base new-base  # =E2=80=9CRebase HEAD onto new-=
base, from old-base"
$ git rebase --after old-base new-base  # =E2=80=9CRebase commits on HE=
AD after old-base HEAD onto new-base"
$ git rebase --excluding old-base new-base  # =E2=80=9CRebase HEAD onto=
 new-base, excluding commit old-base (and its parents)"

In all cases this would change the order of the arguments compared to -=
-onto, making it more consistent with the  no-option rebase.

What do others think? Is my view of =E2=80=9Conto=E2=80=9D common or un=
usual?



Jonathon Mah
me@JonathonMah.com
