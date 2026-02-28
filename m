Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A69278779
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772281284; cv=none; b=ubOopPkUIhrhf+kWmBYx3I0sRe0hsEaM6W9l1sQIxnfMhbwfzMD3ro2J9NMYtm7/VVRF1yfGPhALS/LDVWhVJBnTLswDzetqYfhErzTe6weEnr5eBsOW2DJCfVGDXH+zHdjYLdGO2IVk64+GrBKyc1xHtuyreLhK6hmOtbSh0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772281284; c=relaxed/simple;
	bh=/SC+wkNPsAPm4eyIZGDT+pkUxLoH6GXa89L6g10pMdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjxLAigNxKTFiIVDh5aGHG6+I6nHIavyNAiAZrQjqOxo7r9laurp5dnsndliT3J9RfGpbYhd7BTH60TZBVU7gauA4JIsXJ9bkCd48eCXubMPEdXyoqdrUdzOFnJEvOztkzUJQ7A5ULNcNn27VucArUAfeqU9J2s6xWtaqLspaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MCx9vcsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjsRIW6c; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MCx9vcsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjsRIW6c"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D5DDEC0313;
	Sat, 28 Feb 2026 07:21:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 28 Feb 2026 07:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772281281;
	 x=1772367681; bh=lG0luSqchUoNFsJYzjBABiYnix0Y8YzJD/zsA0rl8ns=; b=
	MCx9vcsmxHsZqCWO2C5ze4SGNhwb6CHuAUORvfeCeK4905dj6R5ShY0kFm+Xe6Lb
	w7VTPVCyHh7Qhovx3Tkn1KGWEbu626wddN6nFaWRdiNOGZb+hhKGwnEars8kF6Fk
	B3IIHWKJH3q4Ct82uVolaokcIU443Zpyf7xsT2+mazFQggdw6j52tP3sS+wMUVSh
	oTwo5/PXwiLzQXLqJvKjBz9S2g5ANqk9caxKV3tilg9WCwjaP+uNwqF77ub3k/wH
	4s7SPZ7SfIJ/OPeNiwsQqAKj8YzBX9H9Vjx3xqbLlF2YnCkzFpXGHUOek5+bX2lH
	riEauKfgksygp+rzfrUCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772281281; x=
	1772367681; bh=lG0luSqchUoNFsJYzjBABiYnix0Y8YzJD/zsA0rl8ns=; b=q
	jsRIW6co48dhVT0L/31U6XMBxqgJUe8x8RY22dll1+KHCVqgAbaKVSxbthdnY0Pf
	WwtWO6Nw+A63BM3ZQErDZ9kS0SzaRzgFvWZNK+A8/EqUo8fBNuSNIiM6z4smzU8F
	gUQDuoYS8AID8ssCuSg4RVVJu7tiPHiwCfqxz0kLtGi9DXGXZ8dxix3IYblBmw5/
	vL3rBEPFJtzpUGTyfG+x2sXUFESriE+HZ5mkIosUGtuCvILGeN6sjnzpSNlP4o29
	1MLFNS8lAVPthzRw7QXfWxt7hdvMAiDm8AKldm/XYSBxBSzgfso3zsYGx8tDshUe
	wNJMBjk6rqhgvDZKVTg0g==
X-ME-Sender: <xms:wd2iadI6dB8T0lZKQkXJ_W5RO21MSTjPY3hLI7kwRJM0uEbQ71TxqyQ>
    <xme:wd2iac34Xh4MX5EnHEHQWI0sNCJgbSUevnQG52oX5NVukx1XbKdiPAAqj-rkjmoRJ
    hY6Dj23-byMQj3ACptRMS58rhP-lXuw0xS2fCfkV9vePsQKjy4koQ>
X-ME-Received: <xmr:wd2iafh3t60_a9NW1V3wExx6N62PHq1y-oWVLuLy6iQeSxr29FWh7KKcL2KZoxQjNK1BaS8DfNJrFJ-IUcdyua4wOVMKlfGPgRUBBjxUMR-6I7DX7Qw134I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    oheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:wd2iaVVUdFmcKXiMBiwyNNQzglOOx-o-lMEG-bRnVzYWu8gmOlUFCQ>
    <xmx:wd2iaWUVHnXqLkwLW99we78gV3J_-TcNs4Dkrd5_utQnGxCPucL_Lw>
    <xmx:wd2iadj4U8PdzzuJ11aAe7tj2CDWEkgQuVlcHQNAq9PRUJ10rnd5fA>
    <xmx:wd2iaZZ6e2HK29B6Ritoc53cJr7arHQ5t6afaG8sIiQeeT9KT0_a9w>
    <xmx:wd2iaZnUAUYdErekk9UopOrXDc5RXvS524_OuqUSDEGDVRKbngPTTxBB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 07:21:19 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org,
	jn.avila@free.fr
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com,
	peff@peff.net
Subject: Re: [PATCH v2 2/2] doc: diff-options.adoc: show format.noprefix for format-patch
Date: Sat, 28 Feb 2026 13:20:33 +0100
Message-ID: <better_for_translators.424@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
References: <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

On Fri, Feb 27, 2026, at 10:57, Jean-Noël Avila wrote:
> Le 24/02/2026 à 00:30, kristofferhaugsbakk@fastmail.com a écrit :
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>[snip]
>>  `--default-prefix`::
>>  	Use the default source and destination prefixes ("a/" and "b/").
>> -	This overrides configuration variables such as `diff.noprefix`,
>> +	This overrides configuration variables such as
>> +ifndef::git-format-patch[`diff.noprefix`,]
>> +ifdef::git-format-patch[`format.noprefix`,]
>>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>>  	(see linkgit:git-config[1]).
>>
>
> Hello,
>
> This kind of sentence assembly does not fit well with translations. Each
> hunk of the sentence is processed separately and it is a difficulty for
> translators as they need to understand the surrounding context of a
> segment when translating it.
>
> It is safer to just write the whole paragraph, or at least a sentence in
> the ifdef/ifndef sections.

Thanks for bringing this up. I have never taken doc translations into
consideration.

Would the following be the correct approach?

-- 8< --
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: diff-options.adoc: make *.noprefix split translatable

We cannot split single words like what we did in the previous
commit. That is because the doc translations are processed in
bigger chunks.

Instead write the two paragraphs with the only variations being this
configuration variable.

It’s not easy to spot the difference here. So let’s leave a comment
for translators.

Reported-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/diff-options.adoc | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 8f632d5fe1a..e4d02cc93a9 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -859,12 +859,19 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 `--default-prefix`::
+// TRANSLATORS: format.noprefix / diff.noprefix
+ifdef::git-format-patch[]
 	Use the default source and destination prefixes ("a/" and "b/").
-	This overrides configuration variables such as
-ifndef::git-format-patch[`diff.noprefix`,]
-ifdef::git-format-patch[`format.noprefix`,]
+	This overrides configuration variables such as `format.noprefix`,
 	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
 	(see linkgit:git-config[1]).
+endif::git-format-patch[]
+ifndef::git-format-patch[]
+	Use the default source and destination prefixes ("a/" and "b/").
+	This overrides configuration variables such as `diff.noprefix`,
+	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
+	(see linkgit:git-config[1]).
+ifndef::git-format-patch[]
 
 `--line-prefix=<prefix>`::
 	Prepend an additional _<prefix>_ to every line of output.

base-commit: b9b583bd007ca814ebd362bdd6441aac02e9414b
-- 
2.53.0.26.g2afa8602a26

