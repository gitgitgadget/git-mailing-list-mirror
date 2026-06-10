Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F140D580
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126687; cv=none; b=BfVtaghMSvCLkfJrs2bLArK8EcYd5VZSj2ZlFo3KOa90UjtgOwlUOzGeLPCcR62foeAR3D9z/jb1WFuLQ6yNJ4PDlx3s8dnEu15wddsl4rj71VPJLyBQc5l56/RZ+BOqQOD2DUUrilcZtUQ9HmkDNC05YjMpVwbN31qivToKop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126687; c=relaxed/simple;
	bh=SaB5vSyLFfcPcomtLPjIba/IytTX16SJKw9xZOUibC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkMqKHLdULezKh5USGd6q3FcmN/IGp59+UKe4mxXiT2rw+KwPs0Bcgi6oxw8nws1UnqaTikhJzCF2I6ZcTGdvCTNajkK6Ji458ppwtluJnfBwOTpDQp6xEZk0xMjPwDFv3ASzRfOEU25kWTGGyAo1WSeUx6w3sJxZXgX4CiNYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qsuqG1Of; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1sXxeTc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qsuqG1Of";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1sXxeTc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A49F41D00077;
	Wed, 10 Jun 2026 17:24:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 17:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126685;
	 x=1781213085; bh=OnDgcc6dsNiTxvEaFBX24lNPp8qlwwM0jVZTxKUcXzM=; b=
	qsuqG1Of5NA2Xyj89+dkkJZyECDIn92UebdU+ly8tPJROUJkSu3pEOwdSvmz3vLZ
	IzInSzfquD9Y5fdmSIOh6eWV1Ao2HT0aUDPl3urQ01hO13DrxFl19lm90FZknlTN
	nxa751QZ4+Wmxp+7GstaOe9FLojLJxq3TLuX6GlXLK/ycpzPLC2hDsTi0Ctxu6ak
	WTRwq3yauc4KpKLXMngGDg4ClhBeGlv4bwc6/4wj3MBTEXiY0c8lVzCqb9tr+q+w
	9MC8c4yeGY0zjmSTovb4tjJaYNlpb9JDmaeSQ+l0gZ74TjYKEaFwsqtN/3YIq6yr
	dGzL0ZI2V+1lkFtdotxsPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126685; x=
	1781213085; bh=OnDgcc6dsNiTxvEaFBX24lNPp8qlwwM0jVZTxKUcXzM=; b=U
	1sXxeTccvXbUfrBfAI9ZIfa8ZgOfHVERoTikVY3qNGX1d7GGq2+37DwEGN3HFdgf
	MKxvAoNSVmAswkNwWwCDh0tKpiI7o10gYIawxjU2nOK4UnGg3H5JeCgucNKYie+e
	PySQD5F8o46NSDa60Lu0okgFQiwA/yNQWA3+rsQJSH8c27Xt5IGG215XnGMqg1kv
	I6JLPlAay3XbJG7oUqqD/fdnZhWIxEqBOW1gLMNuD9mWmo1qp/3fBLvhzjj3EtLg
	Xo1TXJZ8OAffyvAK3Ih0AHcdLvBvpNj+fMIuVwav1dU74ERgLNVkLgLWlOB3vwtC
	hDZ73h5FZ1sWr0KiPhrFw==
X-ME-Sender: <xms:HdYpap7Y07-lhaPS7NgpgPhyA1dSSZByhf8wXh9ca1bpQTfz8PuKKXs>
    <xme:HdYpaqlw6q5HWCYQi8dKhmVR4tQ57wYyNb4EV2tOBDoxAJK1zqVDXIpLTtZlpgqJ6
    HLUKkMEQ0ssx1FLS-NBCpbUREoY9g4zGV2WXmXG4GFmdyIfEqwptA>
X-ME-Received: <xmr:HdYpaqQomc2tpqbxm3H3T6sQGm0Ga-Nz1pRxgTb3NA4A8bFukQowRk3L1H9yTm3Xri9HzJNZzwnLXKvntHdZ3WA-IyHApHcD42DTA_PNdALdI-F7hZi_YnqmSQ>
X-ME-Proxy-Cause: dmFkZTGXj8QUS5rdS5SCsXNlKLYF9SF516GNLvyrVKbzxO+NMjXbUIEnKgiQf17iwMMajc
    n8cUq5Hq6VOZvBYCIYytjWs2igA4WuU+KIpxgJ7A4PiQLRllT6NzX+8FV5+VT0o14nahvP
    y7p9Byq5bk1PKVDsYDKR7iSsgCXKx0kj4dgrpN498nL4Cf42GkDV/m4P3UtmdzlG9h+KVI
    BW9Z2+RA5Olzt2P1yzSXtbzJ1OCVbdBIrjNK7Sn9GV5BlwxZZ/+WNVEg6K8dG43GF2zToY
    tCe1xcqEkg5vuiS8ZJ/eh+t0HZGpm3mNgMfY0+jjYhyu+a+e5d/t7uNOAVj+7vXNAjqtXE
    RGusXLj63bh4tkwfddjkojwJIgQSBGetU2kelf3Cc9F22KlsHHW3f9hboW/T+HMoVq/KzL
    Q63pd2VlL7/Vk59iF7CjlOmYXkFuE7WgvEFyqajxnqen0+PTSH65aAzKY21tH7Z6di1k5w
    jNOSYz+RPAtLwpsRDN+sjx8ofeW3CCdZoVpQ5+O0Qn3Vbs6puEyQfgdBw5hvI6MPfnzOFa
    1ASI+8DOgbT5Eiw1KlzK9M5xxed4q62D07lWafLtJcDTtaKqD+pS2lEa3vlvdWF7s3x71K
    uyCkW+oJ/rsF1cWpM2bfHL8CoqUtipPJJiqjrmT5X3aX0RYAMs+PB+Lafomw
X-ME-Proxy: <xmx:HdYpapEV17d173L6DBSAwixcd48L39NggdANeH50iJyTE3FFMYj-pA>
    <xmx:HdYpavFDFooL-owqF8Wl4eCgkB8g7xDsUx2tby9qsRKtZKZQojN2Uw>
    <xmx:HdYpanSS4fsI4OD5s95XMGV13nMfpX-gQ_FMvjdcIBWNtTCvVHWIPQ>
    <xmx:HdYpagIKmJGg8-lQlJM3X-o_XZt1jAslFgRszhVRBtvfiSiLO_fnXQ>
    <xmx:HdYpamGQyBp7h39o6yj7-_0UZQAvWrKADMq0c9slYvndoJ1lgvStCTUV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:24:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
Date: Wed, 10 Jun 2026 23:21:28 +0200
Message-ID: <>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Two commits ago we moved new-trailers paragraph next to each other.
But there is something curious about two of them:

    By default the new trailer will appear at the end of the trailer
    block. [...]

Then a source block and a paragraph later:

    By default, a `<key>=<value>` or `<key>:<value>` argument given
    using `--trailer` will be appended after the existing trailers only
    if [...]

Why are there two paragraphs that talk about how “By default” a trailer
will be appended?

We can make these paragraphs flow better, and with a more distinct
character each, by dividing the flow like this:

1. Declare that we are about to talk about `--trailer` appending
2. Explain the default behavior
3. Explain how this affects the trailer block
4. Then state the same thing (“More concretely”) in concrete terms with
   placeholders

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: [new]
    • Based on draft: https://lore.kernel.org/git/fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com/
    • See msg:
    
          Two commits ago we moved new-trailers paragraph next to
          each other.
    
      This commit here might fit better one step back. So that it
      becomes the commit right after. But I can deal with that commit
      movement if this change is accepted. For now I didn’t bother.

 Documentation/git-interpret-trailers.adoc | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 9f4c84abfd9..fb9b1e94dd7 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -60,12 +60,20 @@ are applied to each input and the way any existing trailer in
 the input is changed. They also make it possible to
 automatically add some trailers.
 
-By default, a `<key>=<value>` or `<key>:<value>` argument given
-using `--trailer` will be appended after the existing trailers only if
-the last trailer has a different (_<key>_, _<value>_) pair (or if there
-is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
-to remove starting and trailing whitespace, and the resulting trimmed
-_<key>_ and _<value>_ will appear in the output like this:
+Let's consider new trailers added with `--trailer`.
+By default, the new trailer will appear at the end of the trailer block.
+Also by default, this new trailer will only be added
+if the last trailer is different to it.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line (specifically an empty line)
+will be inserted before the new trailer block in that case.
+
+More concretely, this is how the new trailer is added: a `<key>=<value>`
+or `<key>:<value>` argument given using `--trailer` will be appended
+after the existing trailers. The _<key>_ and _<value>_ parts will be
+trimmed to remove starting and trailing whitespace, and the resulting
+trimmed _<key>_ and _<value>_ will appear in the output like this:
 
 ------------------------------------------------
 key: value
@@ -74,12 +82,6 @@ key: value
 This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
-By default the new trailer will appear at the end of the trailer block.
-A trailer block will be created with only that trailer if a trailer
-block does not already exist. Recall that a trailer block needs to be
-preceded by a blank line, so a blank line (specifically an empty line)
-will be inserted before the new trailer block in that case.
-
 Existing trailers are extracted from the input by looking for the
 trailer block. Concretely, that is a group of one or more lines that (i)
 is all trailers, or (ii) contains at least one Git-generated or
-- 
2.54.0.22.g9e26862b904

