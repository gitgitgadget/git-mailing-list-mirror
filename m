Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30F4248B1
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235906; cv=none; b=fjP+QUqvIm37f3OCQsV33S5RdUjDoGo//AB+j8bAXv46bA1hzbjhJ3HQluoAwTGdG6O9eKmpvR5Pdulv+iBIo+f7Q9T7vGEU3wUCtsD+00mjGL9sCCUGklcxZ5j3Zy3xscwtJ3wFGbBGews0C5rsfAdjYvLLeHSoEfE1q7T/wjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235906; c=relaxed/simple;
	bh=h125oOCJqojDzkjbDFRzLTL+dONVdqyMktUdS3pkMPA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FZ8cdOdWDgE0IrDVdOvP6BVXhi2mU++58vN8uVwrTHICP+fO8SuEX5mu1UIFGqH9/CrP3aDS/O7miKfakRLAfUtOYSQN1CBhhYpO6DexkvUhc4v04pwX8g3CokgKYSqIqIS1x3EkIDo+W9/rZXJLzmi6wv5I24gys8+JBB0d7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Q4xT0xV8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q4xT0xV8"
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8XMQ4bRzzMlHb;
	Tue, 28 Jul 2026 12:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785235890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h125oOCJqojDzkjbDFRzLTL+dONVdqyMktUdS3pkMPA=;
	b=Q4xT0xV8mLEU+EWbpV6OLbPq2nJ7L7EnW4rHWmBczQUUJHDXtN1TNsHRKrIOMNXueY9pOY
	Uzt+kwT4I3/iMxGsNvJvt/jLxdOKlx6YjdXR1M+czkVdfPdHCJN3c1bNJE7I/g5/X2bDLy
	BA1UiA4gRd7+dOP00hJuxFJPpgAZpCv2eVYmsFbUofaO7YcsgfauXrRhIm2oejJdoXSOm9
	meQ77esByNUaINQ2ue6tBRkul5Vce7n74g2i+ibaagTT1fCGj1vPYmXVyN7stJL6VGY19V
	qNC1uAkbvjMWPzAxRqHdd2YitGzbJwaiTfZ71yDfQ4CH6kN7hRhDGL4Q4rd0fQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/3] urlmatch: normalize ssh and ftp default ports
From: =?utf-8?Q?Fabian_Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
In-Reply-To: <DE62DFBE-ED4C-4EF5-8F4D-FAAB3519F86A@gmail.com>
Date: Tue, 28 Jul 2026 12:51:18 +0200
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32323233-CE82-421A-94D2-5902C4382F8D@mailbox.org>
References: <20260724004011.41795-2-fpottbaecker+git@mailbox.org>
 <DE62DFBE-ED4C-4EF5-8F4D-FAAB3519F86A@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
X-MBO-RS-ID: 30f03e12bc973d2054d
X-MBO-RS-META: 3cubyfadaat34eomqj6tff5ezox54gjw

> On 24. Jul 2026, at 13:35, Ben Knoble <ben.knoble@gmail.com> wrote:
>=20
> Just offhand, not commenting on the rest of the series : the comments =
look wrong for ftp, ssh to me.

Right, I messed up the continuation indent here (I wanted to make it in =
line with the rest of the file).
Lined up for a v2, but it is minor so I would await further comments for =
now (see =
https://gitlab.com/fpottbaecker/git/-/compare/config_url_scp_syntax_v1..co=
nfig_url_scp_syntax).

Also, since I noticed this as a convenience thing gitgitgadget does:

Fetch-It-Via: git fetch https://gitlab.com/fpottbaecker/git.git =
config_url_scp_syntax_v1=
