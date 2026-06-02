Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E809378D74
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401575; cv=none; b=eAah4eMOa3/BdCuAqyijWFPozWbyWq/6r24pE51xKeWkhmI6m9DjGuxo7tOjWpJCH3JZpw7Knrm5GpOEKOuDosT0ak6LW4B7N+Gjm8J4nxqk6IpufxtGnvU0SjjcQ2JJlzji8DkAlxV/rX2k5KsBiIW7cnqKrAXVDF1KzvdkWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401575; c=relaxed/simple;
	bh=oD3EnB303qIA0UrXj/mKkwuxUZg9BrxZn3o9w1JO6mg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQRC265/V8slsyYktHBOy9XcZhd3uwHHeXtdGKadC4O4hHDW/bQyypaPlwK/19xpznNpuffv9+QhQOoRiis0xIXnb3Ff1bFnkTi3KVXiZj5Gk6XE4IoxZCRgNesWw2AtZYLY7bdFeJoAC3bazNYIZNMNgjg6mET1B8sZ774w+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPqAZpn8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpG8Fr0N; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPqAZpn8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpG8Fr0N"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 23F721D00085;
	Tue,  2 Jun 2026 07:59:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 07:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780401570; x=1780487970; bh=vBwy3fFt6+
	VeIbTzeyfRhyLeRgBDDo4qD1MRNmV27us=; b=RPqAZpn8GTWFGfn9Sw44uLnQ8Q
	wuxaly1u+nzt0nL3yiT3z9kAYjSBhVORFDEm1ogowGHj4HJxNNr6hwq1osvIcTs6
	luiYLcaemBikJr/MyByTF0vmVJAZS41LJnvaniF2Vle8qr79A7g/llzipRvZe0A+
	PKhRqNaNqNfkq4Duy1LDaE5jrjDSUOfonPEX06pdZMr/SPe8lyG+G0pj3cGEFOkj
	sSZoUha1/qbEl/3TN7Al1/ir+fhlOyZF4uEbTbiu3qEzNzDlgeD/pFNdctD6dyfa
	sP+GuTlK5EtiFuciwgpiLbRs4pf4iF5bZ8W874qDHZwJHrXQYlqu8wxCLFnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780401570; x=1780487970; bh=vBwy3fFt6+VeIbTzeyfRhyLeRgBD
	Do4qD1MRNmV27us=; b=NpG8Fr0NSA+nbnJAatMO+r3WA70TnRYsM0UJM+4vmPyR
	4ChTQD1g/VOK/+h+o0ulvP8zZN2/rQrSSpDnuC0QeZfR3OspxXNMPSBbhxmyHbxm
	VCZGzjEpbtSP7h6/zzVuK/Rf9fnT/yLJ0gNszIPA0Na7qcSyu5UlE6rpzgfirasX
	i9q16FofVtKrOohKBQU6wjuYLa98DE8GmcXUlhBb8E+P/p2X3GoKC04etCGjs8Oo
	+AIJjefkIBBPNkit0exiaEUTnrMASN9JR7ehTOH68T3uSVZAIDyXfQvhUXAfK7y7
	fXuo2gh9X9a7+3mgBx8xc/CA/dGdabsN83eusihdhw==
X-ME-Sender: <xms:osUeaqBB4YsZVG4EQ8heeScpWP6-Y-KoonEsrFr9NJACCcG6ttLZ3A>
    <xme:osUeaqhQ8gf0mXqMeqTsBzwyKkgolAMH3uD9UNNh__6VPVY-XHrxpvyRUTZSIRCW0
    LCRX1PyaChs6C4QUZsX2_ZY5OTlzCqBx-LZMw2GGWCzl1ib4o2EyQ>
X-ME-Received: <xmr:osUearM9zFXWfY2A8cTc7Xn4RR5PB0kq_0CAqIiSnmMi923VZG-TiLNcXaCvZSuvEAwvDwhUMkT4N8DXKKYuSdap9wbL4qRvlC4yHAFX3g>
X-ME-Proxy-Cause: dmFkZTGpEpaKOCWZHasi0qv2XLlfi00gp/3BtWa35Pw7Hj7zRKMtU5tb34L/3AykllMZnI
    0tUHsKleYoVfweGTpz+n6N0CsiZsCScFuckv+zu60iR8egrQrRAF1Parup7HePdVON6Pnu
    fkTxYowli78AXQ8ej63iuobKK+GJLsy6bTdMfyko+7pr3xLv1H4PFTbAyBiMOoe2MQOfEX
    MACvuqDs+FpMD0VllQOQjwXbraOwnCmmV0VGmnA1OkLJsWVr86ljg6VNlH2l7mHiWgh6OE
    SJwxn5T+i/+d9Moy6xpsGQQI1bi8Lp3h7AFjVkrXFqNWLTdV6qp0Dd31eQ/pTY2RUByqNw
    85gfFZutJ/yRKltUYopxA6wNON9B+dtRkZg/iPjT32h0a+I/zju5Fspo6q8jYnUpGvuQbq
    pKNIASwOaFlzh4Z3AN1z9dm5mJZk2gcxnpAOKdkBYmerZPmEPXKOvxwVap2nbiQnOljpJx
    iI68OIXL+B/OQV81WhxpDmKhqyGnwkxVgdD33yIne8sMIQJtmaovGFZLJJAuMwbv/lejF+
    gRFEkQZpU7DU2KbKma/td2nv95j3M8lK5RxZViB0Ryctk2Xff8MSfakbq1K+58uaUTyh1f
    N3PUkvFrpdxOsHmC5+cwx7pV57oifPvu4GDvLjEDtE/+rTLD7K/huiypHcyw
X-ME-Proxy: <xmx:osUeaj5gQ0rY-sxtqjJh43KTXs-r_5A4alLWEDCtwUmEUJqgsKQKZQ>
    <xmx:osUeah0sFo5qfUHdti5SnaJ_cUyMJzn78WiXtSLoti4y0Z8akVCmhw>
    <xmx:osUeasbBZtnfO826wrNVAR2ZorqIBxP-xbw7bWo6Rn6QcBLOF94Cgg>
    <xmx:osUeahAY9RSKKZtROSJpu7GKFBh0lUuUVWUJJxL9MkkIH0bL9FUPQQ>
    <xmx:osUeatafF71KuRt2cYj09_-6P1IwUB9daYzCLGi4NJ2fPtp-RFRFDtvr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 07:59:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82b1f985 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 11:59:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Documentation: recommend the use of b4
Date: Tue, 02 Jun 2026 13:59:08 +0200
Message-Id: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzFHmoC/yXM0QpAMBTG8VfRubaaWSOvIhc2B4dCO0gt7264/
 NX/+wIwekKGKgng8SSmdYnI0gTc2C4DCuqiQUllpJFKbDMLq0WeOadkV/SlthDjzWNP13dUN7/
 5sBO6/V3DfT9TcCrDagAAAA==
X-Change-ID: 20260602-pks-b4-31cc20d7f84b
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series wires up b4 in Git and recommends the use
thereof via "MyFirstContribution", as discussed in [1].

Thanks!

Patrick

[1]: <xmqqik81xpqx.fsf@gitster.g>

---
Patrick Steinhardt (2):
      b4: introduce configuration for the Git project
      Documentation/MyFirstContribution: recommend the use of b4

 .b4-config                             |  3 ++
 .b4-cover-template                     | 11 +++++
 Documentation/MyFirstContribution.adoc | 81 ++++++++++++++++++++++++++++++++--
 Documentation/SubmittingPatches        |  6 ++-
 4 files changed, 96 insertions(+), 5 deletions(-)


---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260602-pks-b4-31cc20d7f84b

