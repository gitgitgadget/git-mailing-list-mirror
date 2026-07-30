Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20E3F54C5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403186; cv=none; b=Wh9ghjiOibXhB/Ekmu0evI2W2sZIyQ771vZGAJJJ40cfwm4NAeRUtvB7rnYK9fuinL/+SqO4XMEb7Sdp3jgYiL6FFeasJWwmu10qUsWQYKx3iWi1N7QSLG8uAR8IRd3G+rkfH7erfjictSU2VtJqy/4Nus2CLs5fbr3p+R5SWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403186; c=relaxed/simple;
	bh=67V3WXRFDFhJfMB2tBRGE6tNePIak36ec6k/0KO5Ymk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSU8mjhWBTf5OpqrP5B/F6B5s54yiN2hPg5m8YMaOxpRM8oo+5LuOgax9j2TV9newb0AxotnHmHCAY4VRvUrqKgmlEF1s0cYuzKACmmdS0wYjESZ0dsbLgmZSWWWJxZOTUdLFq5IIwEXQWbOyEh6kHd4Eq4Sp1kK1Gy5wKLNyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oRABCvfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoSAu1r+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oRABCvfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoSAu1r+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E3BC61D00125;
	Thu, 30 Jul 2026 05:19:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 05:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403183;
	 x=1785489583; bh=O7f15Ts2O8N2gHo9x59jPskd9V4Z4bm7Jv6Mu5LCL0Y=; b=
	oRABCvfZcztagJF48HJr/Vt7vUb/3e6Xua+Yq59KXRkjQianPqiPN+fdotg9pyfr
	zRokuXQOP2Mf7mmveqacqlPsxi71z9kuqldUldqUFCsLvKjoucatVm1nvIh/9Sfv
	JfSxDnZOb/kn3I6RjTFxGHeMPtYJbIaH94119ILRgr2e4cmVeIyad9t0JNyL/XWo
	YwpLDofDxXR8OI59ishCyZeZNWmR4d9xubRIQFO9SYijTThYXFBX9ZuGMBdg/BEo
	AV26Aib/Dvc79xWzjuLUZMTjyjqDPT4kx9YnFsNdYylpyN9uSthmEbaWZ1DjYsMa
	K6Yn3DW0G16irOeBgiMkuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403183; x=
	1785489583; bh=O7f15Ts2O8N2gHo9x59jPskd9V4Z4bm7Jv6Mu5LCL0Y=; b=U
	oSAu1r+NR/je6tNZOIQ7FPzttJva/6sjXGGV01ATancv/u6MQvCLeoG0G6FO6R5o
	WItriULiZOrPMRLairPYIKkWehnvcyHNFNQrObQxxBBTKlH6YkSFrOoGJkwYQnjz
	VAEZE5EcISJBnsZ4zicZwIbLD7MWAR5tN3sSbWQxKlpWum60SjkNZyMMo6KOFKVc
	6v8mf99RQVwn/k2NXx7EsllbtN0U4RMqVQ6vFDge4v9DG1K+SMkjPpMNn2REXVjc
	zuwJR4LZzkPghVV9zckSaAuO/GkBepfELTjATXssOLmbMU1locyKf2YSyoZb0sTy
	2CjWx8nugoHaxkD5GoUaQ==
X-ME-Sender: <xms:Lxdrap6PqmB5c6o9DNyrhuJE9GPTTdbnBRuysRgYOHZtQJcLnlXMipw>
    <xme:Lxdral8VuF3_HnTqJlAyUPhO4rGvjhj0yVIKbn9FvTGLRejm3D9adT_B-bFGLD_DL
    d9ura6NYAwfITc1-y214FgHm5482wA8vtRVl3DXLAbtWC3VR56bvA>
X-ME-Received: <xmr:LxdramoxtfO8pjZQskyylR6-eMt1_op-HA7tcmY62fUB3PP1-ujGS27cf3h9r6EWb0ijXkcmVnBFNq4uQd3h3PG3znTt89yN-_b-NNsg6ld-ctHzE0zH9GM>
X-ME-Proxy-Cause: dmFkZTEQRaEnp20JHpkZN84W0Q6WHP48FXgPbfDynCccs1aRUH7OTcWv14/9sQKcd3mlNw
    cNwb/n+9BQBBGue2hk8pje/LcGgLUW27pJUGEKVe4HF1dVfkZGOdX9ynw3XapXdoE/Aazt
    igSQlf9AzI8Wf7moh0eWcCkc7o1tplhOgXEX9VazN6RbSvEzsHM61maQEBnNB/6olueJb7
    1465y6Br3pCDzlfMELcHsNzFjCqNxPUCGBiVMsMrGOoRJXHJfVf2kJjGdep5Nc0wMPTIEm
    bYl2FFqIRqrq2iLm4PJtQhzdHasuyxV8J8l8WydIceVVYxQD485lKvS/iMIosI/5SG1QqC
    eSEn8D9H7gJibxg/p0VyxZL+fFfVYx8/5/11/tqfxnZTywRE89oQPAgRefQuWiwN1+d7iM
    eUlFTqdwho8PmJiObPiP7kcwbB0agcsCQ5cEqo8JBrdpGhvs+UKKdOVbfycV3GgcFcB+WD
    Vhly7/m3tZwnEODbfzJ2iTHfICxL8byYPbipHnRbndZdGCDTuAxIzVXqrcaZ+fZYUmH9uW
    9t/NLaRIEmesMWQu1q+dTW1dSnfEh1YXscP585lkCQoicwLoIbDMYFxS7/OVQ7gvGLtKPy
    z7CQPoRMSY58DlEsEYjfqlyK38a1Ko0v8hXP1aEu58BS/tFzPNx5bULEsFjg
X-ME-Proxy: <xmx:LxdraupjLH0TA_XYOY6G-EUTsRU31ZWUcEKuQlLVoJI9JHBbd7nAcg>
    <xmx:Lxdrah1VoV3s3q-rRSta70jxgjm-N3bvr_l340clezwe_RA4GNKQOg>
    <xmx:LxdrakFJnU0A3Zzh38LNa7TMwbrQB9PNPpDhy5Q4U6KLJKI-CpFZRQ>
    <xmx:LxdrakHnd8QWR5oinNQ7-ENrTX9nRxYT7xX65qXoTl7nc2SBYx6G0w>
    <xmx:LxdraqX09K4q94mp0bi7Ij4pAAVrJbRgYoGcHYFkLH1qQR1oj-tVvKVn>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:19:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/11] =?UTF-8?q?doc:=20interpret-trailers:=20use=20?= =?UTF-8?q?=E2=80=9Cmetadata=E2=80=9D=20in=20Name=20as=20well?=
Date: Thu, 30 Jul 2026 11:18:16 +0200
Message-ID: <V4_metadata_Name_section.ae5@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We now since the previous commit introduce the format as “trailer
metadata”. We can replace “structured information” with “metadata”
in the “Name” section to be consistent.

While “structured information” does emphasize that the data is not
loosely structured, we also say that this command adds to or parses
this format. I don’t think that we need to emphasize that it is
structured since clearly there is some structure there.

Both “metadata” and “structured information” can convey the same
information. But “metadata” is shorter and easier to deploy since
it’s just one word.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Msg: s/trailers metadata/trailer metadata/ (knock-on effect from
      change in the prevoius commit)
    
    ---
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index c8950d3babc..5e776f0059a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - Add or parse structured information in commit messages
+git-interpret-trailers - Add or parse metadata in commit messages
 
 SYNOPSIS
 --------
-- 
2.54.0.22.g9e26862b904

