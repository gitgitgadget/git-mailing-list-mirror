Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49E32BF4B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631040; cv=none; b=lg7ymA1XxtWNDESkmZjNV16ok3ecinJbD5Tjsz6fnOIob4pqRXU3PozHjgzchX9wpdGPkTUzkOa4km0yaJ3bUnjNmvdVm31mk1Fz5oUVViSSqtoRruJt13XzxAUjYiFrk777ljUpWXgnNnF5XqkreHeBAeaWPh065swBPZLq5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631040; c=relaxed/simple;
	bh=FYjwtVbhkvFw+h79q37MgxVGx+T7tS3YQxvZtnR2HvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWhqQUUYEhcLhBr41Ni4DeUE7tQlIxVpVLzMdkcl+Z05eIYzG67TfWVMwcbbfyjD1+Tv/dun/08WxOPLoEH+5j9dVZ5m4LPeQVJuNrPO8C1ixpf/n4MPcj22drKKKKqRnhL6xfm05E9mW/jfl/or/RZokLVBhVLSdrd29qH74aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kb9Lmw63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKfJYGmp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kb9Lmw63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKfJYGmp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 236B814001BD;
	Thu, 13 Aug 2026 10:23:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 10:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786631037;
	 x=1786717437; bh=KCK5Eu/MVWRwdGVhvl0qBVNTvm25KI/FK8+zhmXMp9Y=; b=
	Kb9Lmw63DmMIUitDg4TYgs79DryMcto0942rYesCksnVYn7sNjHzbdHmbfzR8vIA
	R2fNcddTLXFjmQbywHl36szgqdk0jxiZ9FBufocczjDoQgukkIPSdjt+3TlXlaGz
	nl5RKbKX0gbMQPMFe8NAUJsLGWpQo7aXNSVxoQLUY1g9vKweB+/A+qGWZaweuS+e
	6WtcUYRMgbfwr1uegM4TqKNLI4kI0cZV+5V9v4HfcDwQwQMIkXqoaj6HQ79y9Xy2
	AeV5KVN9ZCJEbPMl5pKekntbq6OA4PSSlqpRMOAD37y72Xc5kjq+UPsCczZUeCtw
	nN5uRQ1q91Hzg8LDZR/ayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786631037; x=
	1786717437; bh=KCK5Eu/MVWRwdGVhvl0qBVNTvm25KI/FK8+zhmXMp9Y=; b=H
	KfJYGmp66OWG2F0nSTkHe4xHysfs8sgTt5XPR4GAr8Qf0nzm299FVtw3s9E6CzAV
	TQg67/xmv7QjfsK2mRqdScshmnBimKKxlwjpb2vjk6JUqDvTIVkcpc3+CfUwlQSQ
	bpDWf1M4DZ+6m37jt9dciB9ad4Bl0FM7SRZxGcQ3N3/Y92LcCDeiPw9HphOICuIw
	Z1vA7RruFlvDuT2aiqtj59a2YGMisXiIiniGyyXWSwjgwuRBDAwYhLu26Uex1q7Z
	Ex8AEbN1KnGYaE3aiO1wkE9PpXXRvRyy7ij+zECkwSq/FPMn6BXe1/NTuyYJ+El7
	d+fZ/JHJTLtpq4QoV+yVw==
X-ME-Sender: <xms:fNN9ajEsdhmm2uOBVkrxTvpb6oPSNrvtVGTfmnm_GDwzRYW4G3kdirk>
    <xme:fNN9anWXX6En9-d5qo_7hvm4PcCGUTX5r_FLSnZV6g4G8qmMiuEH0fzSHgGfog6v2
    shb1DbHelDLAydTRvN1NimvWkvsO-Go_XQl1RZZWHILxuM9VCI2Uw>
X-ME-Received: <xmr:fNN9aqKojBv540YtWpmC7IWMKftUDKuM7uaZEgvGtFgPUZTEWhcuj7gk0pBXMsYI4xCYJdfJ4vEtiXi7M24Ypxseg-SImId4oFP30v4EQqDKBN-JJA>
X-ME-Proxy-Cause: dmFkZTEy2s7uQW/AQx5Qe1I6Q2Y3Ih+1QauI/B8AA0jEl+1+6jJIS9pBKFeGc7Jy3X5Arc
    86D5hH2l5nhC942V8TWRpWrV0YbGHJV2TBNcUFQBBnC9k0lGfGrTDEJd9eCZmWWdPBZoW4
    umA59SRNAn92nflHkiMrusoklFUoIlhUKfJZLFEdjQeziXv1MdsX+suI7gVXNkNai+gJ+N
    kRA/9yPyrf7bBy/ogFBvqzm6Fcl7J7a7cK7lbix4VG5fRPG3Sho7SZ28T1+SxlGwYRGWWC
    72jqMdCcyzUV+Ax1s2APYKTYXp/DzOKn/BFTBvqm8fkJkVno7IaIFA9tCtL2JWdXN1rZlE
    mlT0WQlWdey+omIgw2ZpOnDQgmlyxATMCdKjaIuVY+Gtylgc8upUXAbJdvcFr8eoITuPty
    /aLT/1FUmU+Bqt0Q13Oj7Sh/1agSmANJ4F3+wovPAoZOzN7jWJzScQK/8ZQBUS6b+opoY0
    YR/DvFUUPIcBPsNl7J62DxJVRVHhqRb2MZqeD/43Gg9ThLeBRhuxlEfexzMhyIIUR8hxQm
    kwpuzZ4CCpOEKZQeeSW31kV+guAcMCXpojtMSb59udBaWTGu5MVvI+twQsHIXJGTjFp3gg
    DECaEEWPKSicfbdNd8CPgY5SwuQr7G/hZoGIBGNUcJaaHKH/WV98eb7YRfpw
X-ME-Proxy: <xmx:fNN9av9m3eTuBrXjGVAuYI8WUTGeMbb8yh06Mo2gRNjoxFLUVRO0jg>
    <xmx:fNN9alIqIx_find4LtQ16A9S7JLVyXx48dqyW_fB8Iqm2SWG6WxaSQ>
    <xmx:fNN9asn-LEimSjJ2N8p2OMor3wh742Af36xwI9WLX-xg579eGFua0w>
    <xmx:fNN9ahMlSN_wffhGl57F5Wwne-bTdj7tXmvciVXii2fbGdwqoYQiuw>
    <xmx:fdN9alG6lY0dDj27HXij29bTRXd-fuoThWaQvoMw_GBHT7yNhTxThO-j>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 10:23:55 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 0/2] doc: format-rev: use [synopsis] on code block
Date: Thu, 13 Aug 2026 16:23:44 +0200
Message-ID: <V3_CV_synopsis_block.b64@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <synopsis_block.af9@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-format-rev-1

Topic summary: Use '[synopsis]' on code block in order to highlight
placeholder properly. Also quote the subject consistently.

§ Changes in v3

• Patch 2/2: Add Ack

§ Cc

(See v2)

§ Link to v2

https://lore.kernel.org/git/V2_CV_synopsis_block.b4a@msgid.xyz/

[1/2] doc: format-rev: quote subject placeholder before and after
[2/2] doc: format-rev: use [synopsis] on code block

 Documentation/git-format-rev.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Interdiff against v2:
Range-diff against v2:
1:  c82aec7969f = 1:  c82aec7969f doc: format-rev: quote subject placeholder before and after
2:  f528d7e9dcd ! 2:  b9a93c83c88 doc: format-rev: use [synopsis] on code block
    @@ Commit message
             [verse]
             'git name-rev' [...]
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-format-rev.adoc ##

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0.22.g9e26862b904

