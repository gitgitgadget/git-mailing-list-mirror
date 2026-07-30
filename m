Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9D3C0A08
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403260; cv=none; b=JdfMRvQ7IwFveXrPsrpu7JrZO2tMftHugPJ9CZ0NZcXf/y1BLzgQmpsLBkkt7gi9guhJ5zjQn18OxEtGFRdynjhWlo/F+LHDvifJuGf+yNJgq/FAa7wC0M/lhqZSg/QfTLO2kfyiTXsn81TX0a/0nM29GvGlzGE69lGY/gRqIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403260; c=relaxed/simple;
	bh=ZVvRWSFLkCOvbjBFPdl8ErtlpNfEpeDnFYMRFFma+qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPh1P7Us9UxVSgapFicoLofCNJ0lHFv9gpekMW2yyIcwqNy7VRGnNtB9qOKlbUti4lPIZW4RQ5Q7xdMr9CsETUH6JoApFJWHUMEvCeMR4sur0CBvKaRnr2KiRZQwCvkCY9YI0HLsQU0XFb43gccHi15XZKGH9qx5gD9OMEaXQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L4eGxJiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myqinwHm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L4eGxJiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myqinwHm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D0807A01C8;
	Thu, 30 Jul 2026 05:20:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 30 Jul 2026 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403258;
	 x=1785489658; bh=g95CV+b6TgiXhzUmZbFP81/c8WX2kKWmyPL0aZHO9Ug=; b=
	L4eGxJiy2prM6dQPyWLjQovw/T57n0ADme01nSHSAIhO4aQLXfpaF9o8hSm9AgoW
	FBb77QBtIAI0UM2fixNKj4AjnoyMi+Rx/c0IHt1gPwHTaBRfc1lxuDN/T33y1thv
	wzgb3NDbyjGEwLjgBXWL3H+G6potr96pr8FPJFgjpeYhPIYAmeLsAVmmpDZ4a2oL
	QREQ3PD26th9IwA9sP/G6yhA7UGQ+KpO9k0ii+3aKjcHsDso/4XBscXalqVdzmIN
	tzeObjcxWlcYv5XHU3RuSw+j/WUsViXEJwvXuKCqnSu00+nEAzFWVAB0hILukhJr
	e+YrJdchTnOpBWPjfa2u8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403258; x=
	1785489658; bh=g95CV+b6TgiXhzUmZbFP81/c8WX2kKWmyPL0aZHO9Ug=; b=m
	yqinwHm/nH93l6aUwdRKun3BtDhxAvTNBfpxw9OgR7IqM9oOR36mgSmPDci9rU/R
	a8oVi2IK7Dsbb2Akc5Lwym+0M1pprNcnokAqk4MGgx6/NOMT0eE3+/A3Y+348eTR
	ICIXmsKAH+P5KNZlo/aYP52MH1iFF8oA3I85FfkoVVfATI//OZnVROPp3cvyfa7b
	PaTxcnn1odLF+Y6nQCx2TJCy2gpkoMSxW4GqBvK6sJ2H4PksyP4zFLAlfO1QsoAw
	4mHec7M23+m/usoDeL2bmPWdg/9qVzPguYy1OKgBFYbooL5qE2j23iPygqtr5VCW
	hCVZlzKIiZ89KbrBD8hfQ==
X-ME-Sender: <xms:ehdrauj0lWD155Cz1H3Yct-fYo2I2FN-MPVwNcpbio37M63OzmdAQhU>
    <xme:ehdrauGxKl5Sw4f0cKgq1fEwk4U39a5NfbR7_Ph0jJ3eMCWjw8a16WkSxsoxko8Jw
    pKj2bMjCDpmJGT7SnrlTmNDsi7PmSkcabyOoaMDMjQXBfbWecVS>
X-ME-Received: <xmr:ehdrasSg9iDWOHFok2N1RUxp4QVrrX_dpcr5ipJO9WxLTXZT5y16-lY9JukMf6x8lE7ilxTVe_4Llz9IB47dfp7yEvCizJZ8C27cyBZgugC_WM3DvQiFr28>
X-ME-Proxy-Cause: dmFkZTEQRaEnp20JHpkZN84W0Q6WHP48FXgPbfDynCccs1aRUH7OTcWv14/9sQKcd3mlNw
    cNwb/n+9BQBBGue2hk8pje/LcGgLUW27pJUGEKVe4HF1dVfkZGOdX9ynw3XapXdoE/Aazt
    igSQlf9AzI8Wf7moh0eWcCkc7o1tplhOgXEX9VazN6RbSvEzsHM61maQEBnNB/6olueJb7
    1465y6Br3pCDzlfMELcHsNzFjCqNxPUCGBiVMsMrGOoRJXHJfVf2kJjGdep5Nc0wMPTIEm
    bYl2FFqIRqrq2iLm4PJtQhzdHasuyxV8J8l8WydIceVVYxQD485lKvS/iMIosI/5SG1QtV
    c5nyKbO5G7d/DgiDTWXJJ/+LcPXXj1VpsCUl03Zqfg3gUuB0Woj/EW7fpQfztapc93mIux
    5y4CuiTACzj6jrdpb8AdCYFqXhwJB0mOkEBNgzHiYitO3DJbjhiuEB3etj7FjcK9p+z8II
    qJ97PyC5U5AbBtWthlc4PzijxK+t132PGzc+IUERUO3erf7w1IbZ0/wW/x+2cS9nvOYWst
    3kNSQhXZQpkDwpc4/G64mbxcsFlQfeycafsa3ZkGAWELZ7fMv3qkIq/AlcgubgEFIrRfpH
    T/F6Ua6zE3iq1sr8U/Fl+4jq+Oqk3uKWx5vqQsppwElx4kI5BkSo7fC2r8Kg
X-ME-Proxy: <xmx:ehdrajypCz984vsJKj7yTT5ZJsdSIdNGthbTCfvFcT-pOO-y0w6xUg>
    <xmx:ehdrageFkYVQcv6pjbnEBX8rBRaeI2StydE6LI0uVxYgcjZcx3Qi1Q>
    <xmx:ehdrauPrpTHJeL6gU9oqFvYFtwxJwXig1ILo9xHlF3wqSV7R1_sEOw>
    <xmx:ehdrajuymgdfvvlokb0SflA68nrnbGFHa7LBDXxiAu5C-EdUkUcLEw>
    <xmx:ehdraqnuTjUrkdNX7p5p8a_O4tgxdIJqbc9veteR15J_nJkEC19_nPNB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:20:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/11] doc: interpret-trailers: add key format example
Date: Thu, 30 Jul 2026 11:18:20 +0200
Message-ID: <V4_trailer_key_format_example.ae9@msgid.xyz>
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

All of the examples speak of the Happy Path where everything works
as intended. But failure examples can also be instructive. Especially
for explaining again, by example, the key format (see previous commit).

This also allows us to demonstrate trailer block detection with a
concrete example.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4: Fix doubled word “to to”
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index fb503cbe952..a0f7ed6fdd9 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -405,6 +405,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to use three different trailer keys. But it fails because
+  two of them are not recognized as trailer keys.
++
+----
+$ cat msg.txt
+subject
+
+Skapad-på: some-branch
+Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
+Reviewed-by: Alice <alice@example.com>
+$ git interpret-trailers --only-trailers <msg.txt
+$
+----
++
+Recall that a trailer key has to consist of only ASCII alphanumeric
+characters and hyphens, and this does not hold for the two first
+supposed trailer keys. And now none are recognized as trailers because
+the candidate trailer block has at least one non-trailer line, even
+though `Reviewed-by` is a valid trailer key. Recall that a trailer block
+has to either (i) be all trailers, or (ii) consist of at least one
+Git-generated or user-configured trailer (and some other conditions).
+And (ii) is not satisfied since we have not configured any trailer keys.
+
 SEE ALSO
 --------
 linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
-- 
2.54.0.22.g9e26862b904

