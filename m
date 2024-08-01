Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C352183CA1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508702; cv=none; b=Y/C++mdBzS7tuDqbLM/k1n/V5ZW1WqcC8EFOq93gd50anfxi11C4zf7icNqYrH4wZaKT0XpI41MpyNpdsEnc4labspzn9jzj670dyjAM446K8WWcjQrxbz6rGTR9ZhDE0Fen4+opQ4UAzh9RI9yGfAPbt8NdnTaEpB/W0sOvlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508702; c=relaxed/simple;
	bh=yHS9K62Nug1YbfKBYBS4yeyS8Yo8q+FJcoQJ4xeyV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz1tBQB5kHcdBJqMjDITAovDxE9r8aTNFqqWz6RThjf6dmmxgp8lN8Qc7+h82ouUlJBUjSm7HM09W7t+MVq3KwoDY42P5M2A8oaaRlyJGemjEIP5SGQvZqOX32LpHXfQuspf01UR/RMsFHWmleCKQ3zYT0YvtyuY2DP2Km4cW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f8Fecv8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqqNp4kv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f8Fecv8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqqNp4kv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 48555114AAF5;
	Thu,  1 Aug 2024 06:38:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 06:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508700; x=1722595100; bh=WRRGVyXesf
	+M5j2PC7ycoWJkg5Y7DN9FbUpWcjEr5vM=; b=f8Fecv8M0kZHvBECMb0AwraErY
	QEsm3j6yTG5gwnC1MigducqqOUAyCXVyUwR5pSEZqdgbOk/Cah4rplFrxbDDf33n
	H1zSGpBYaAOdPm0W0W/4Jru8fQ+IPWRuJSCegaaZtNaZnjnX9ZsPjS4xoE2+Maml
	6NZeXRd8Bqavhd0FMDcV2WcmDLoFU7lTq2SQXEkGCPYBNOv3lYD5ATcOskSnPNV1
	05dUZ3Oazf/8fq364rAPA+8fPx+ovSDcXiwmRmWWY1cvX5Qp+L8Q1gHrYKgFcDfJ
	OjDcMPGbsYfYkSyUB4KLsDyaMiR8Su52zkInR6p0jbaDHO29rGv6dYKkBtnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508700; x=1722595100; bh=WRRGVyXesf+M5j2PC7ycoWJkg5Y7
	DN9FbUpWcjEr5vM=; b=XqqNp4kv5tOlhjcpN+/vXo0bT1usmy+ow9onwH/zncRA
	inkpfzAf6ZtMeOVU2NvyyyTxmhXUPKiZGPCbKpbYclEkRi/eHmnE3CgzaPiazwvx
	JrAyzwY+AgwvjeEmd5/MMy14tlQCRxyIRKkVFPvNcW/qZPFlop8xS2VDtd0WGFFh
	YyQ4SCTrpbnVyK5Xb+JXkn0MpJE3AEM8eyPvSPkak8e0jy6rOxUZyVJFJfWC4wYB
	eKs4fBe7HBV07nfAoMsMU4vXkHHZW9SIwxZMiavxOofwyZT+eqFu+Zbv/Nz4sihL
	utGWukoj97R9GZKCyQcxGw8ez9RsTuGSEbOelqkJ0A==
X-ME-Sender: <xms:nGWrZivJyRL73b1wsPF8PRfqFKDgXkfHKo5Y770rDFmFwV3DWiKqzw>
    <xme:nGWrZndlQVBGl7oRGHr0JxNqAr315jNB0UgwBKxlnOLk5wOUUT17CiBKHlVJFA9EJ
    hKWFaa5E2He0NcFwA>
X-ME-Received: <xmr:nGWrZtx1FaCuKaTA2759Pytt75OiPLkWB6_pOSnagw0LBJLQEwHrkAg_J4zptDuw8CD2LWlQJD044sl6EAwrKDUzSeYI9wjfzcvPByx9sLqik8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:nGWrZtNCuiTWOdrrnrP5LiwGPESgCt4lEEuVlwSArZfTBr3UlZe8-w>
    <xmx:nGWrZi_KH8xY79cDqawT3jw8JZz6bQ2d5GqtaH6rhYS3HYy2fK6wwA>
    <xmx:nGWrZlXsaR_YD8P8_7EeQcv41MPZ-6NjzLYK08fm-olzXzRzsoltuA>
    <xmx:nGWrZrePZ5EOaJlXN0lO9zKcuWT22iuFDOVMfI1GYqTJVlt55_Hnfw>
    <xmx:nGWrZpmrsR1v7JwdTkZ14OyNQWrEE2w-7nnbV3c4OZC9_KcmqqpYR7Rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3ab3f222 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:36:46 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 02/24] builtin/log: fix leaking branch name when creating
 cover letters
Message-ID: <73a16fff43ee36f497f3ea7377a68babd3b9d392.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2WIgbpXe0z8Y0YRd"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--2WIgbpXe0z8Y0YRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `make_cover_letter()` without a branch name, we try to
derive the branch name by calling `find_branch_name()`. But while this
function returns an allocated string, we never free the result and thus
have a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c         | 4 +++-
 t/t3206-range-diff.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4d4b60caa7..a73a767606 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1434,6 +1434,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	int need_8bit_cte =3D 0;
 	struct pretty_print_context pp =3D {0};
 	struct commit *head =3D list[0];
+	char *to_free =3D NULL;
=20
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
@@ -1455,7 +1456,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	}
=20
 	if (!branch_name)
-		branch_name =3D find_branch_name(rev);
+		branch_name =3D to_free =3D find_branch_name(rev);
=20
 	pp.fmt =3D CMIT_FMT_EMAIL;
 	pp.date_mode.type =3D DATE_RFC2822;
@@ -1466,6 +1467,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
=20
+	free(to_free);
 	free(pp.after_subject);
 	strbuf_release(&sb);
=20
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index a767c3520e..973e20254b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -5,6 +5,7 @@ test_description=3D'range-diff tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Note that because of the range-diff's heuristics, test_commit does more
--=20
2.46.0.dirty


--2WIgbpXe0z8Y0YRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZZcACgkQVbJhu7ck
PpTThw/9ETyeP90wF2QWCv56DKBdH2VKD2RCs/T9dgH9wpgXI5U2m/Topdl2Zc9i
6u20vyGeYNnyxSvRzpWKPr2aOF2kDoLJNU75YjoDyDYZAc2KjfNdzHHGg5griWo7
bxWnaY59ybZsYjoDkOoldXt8BgaYUtkEM4znZ+FSaFNy9aiKbNrB4LQNZHg84vSY
oRN5aT083CpnMl33jL/HgQKmFd/Ca+5nVM/bGIpM9oRpflh703ja/1dlf/H9RiGF
lBKYoMXwRwIAgdK7KjQGePOF7voplNLLXu7xSzi/1wcR+PSzQdfpuVPJ/GZ9k1Sx
IS0Ipz9iIykspO5T2R8Blj2AHiQqJwH6Hg9t88/3R4fJ4kzkzH/V3U9s+oKbY8YW
bxKTH3eln5dj7Uu0NwHLl1xyQlA0O0C1kNmsfKLpBeypL6TEi+f3Cw6SA8FtAZXW
6jqkaS0Vjnhw8kuUkAdOXrDRm81AHxWEsbhv6c+fcCs2vNVMJYffTDxxUNvNRe/v
nDERyUnuoOM6Qnsx95M9bPiHvfLyFZOEJlSawH4SGuaod+9Y5OtMNiM9vRNN+NbR
gyZ3N+FafI+2JWr7TfNvUmv+ccMU3M0IwQzJmzrIES0+yJN1GW9cSNAqvvq7l92F
SWQmCpzqa2c+ec1clZz5lXwP1l49/7PU7U+cmCkb6EttFZA54mc=
=8Z1K
-----END PGP SIGNATURE-----

--2WIgbpXe0z8Y0YRd--
