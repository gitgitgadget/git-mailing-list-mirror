Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63780A55
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070831; cv=none; b=fXUmQ/qivQWBTAdqndwchpX61XsTdjkaMdiiC5m+gobOIBYSY0lJx0c7wn9sWnLRQfOcax7pUXnV20RdJ5AvLZMwn5B7FYVhgNovvEky1dlWio7t7fM95SbqVpwgSVykDscD7zUPFM4CQLz/tDxUCx0daZ0lf/PaGll8iBsi+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070831; c=relaxed/simple;
	bh=blfc/j3uD/gaGXFxJvcZpnpP2VvLS4DWJYYA895IsoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uoHwZA5phaNp0tuqGJ2kcHrtMNKCqXlsKktxtE4OupzRHX+MhVMoI+l4I3pj7AezabvcmKREV6ncXcnFAqlNvDPhOCUCOdb7ynExIiXaa5sakKg94AM9V27xqtaUZA262CR2ki4Q0dLnAo2EV712NCQlS6k0G1k2ZF8g0gC0BCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F7P39q7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxwDda2Z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F7P39q7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxwDda2Z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 981187A0122;
	Tue, 30 Dec 2025 00:00:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 30 Dec 2025 00:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767070828; x=1767157228; bh=7KV6h7oAYn
	Xd2ruF1TbHVC1pWd2LwCYtCTxbhWeCMoY=; b=F7P39q7Cpjr4S1LUbWf8wfMPSG
	WlO8qkV8+erWo2zORaAH2Iv55BEaKPV73+Y9BIky2c3iRau2FM0Y/SkclQws57zf
	/zU8KX3R0UnfEeNS9TecVqYZlFvc7h2x13zmwsvOsfC2O5MkDyispsb5zCyn4nm2
	28fQA/ucIZYbmRJqC+mu8fOwVWd93NwWlFSnxPBOdxIsaICl2SahaKSgE41Zb55d
	XN6PbESADRrsGkI0xGCFtQvbICmTxwoTagJundYXXHwO81hsBbhQoWuavl4GLjdn
	IHLX/G7XBpFyDcOKjr8zBiDMS8u+XnUgDez15C9/Z9hXxitsz6TgBLmLkg8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767070828; x=1767157228; bh=7KV6h7oAYnXd2ruF1TbHVC1pWd2LwCYtCTx
	bhWeCMoY=; b=YxwDda2Zft4rj2YDE6zk6nTVgGJNelfiOtI8tfLheMKKZKlPv1W
	l8eltEa32RCXGFMGxC+Db6NCo198EIHRjyin23GYAi/O6mIn1uAmqzXMnxvcpigL
	AiIlcHLZecflIgA/kiK45GwVkXq8nZvC7FDm5Qjs6SvYv11O78JlUDjQp2ijHV/n
	d/V03o14LKAYlPqG0Gx2rMZumeqs7TXXF4Lnhq8x0fNfEpo4mdHVTHmzWsklqpAf
	MFd97tIYDmp33Bc2mLPRAQ9BeuhVq5WN+rEAiMpxXrvEIVU9k3CjxbBYiHmgBasW
	IpvKEuinh8z9WTkjjr4IJXGP8qdkDN1QswQ==
X-ME-Sender: <xms:bFxTaU-EYKCKFXN6vmfC9TVKYaVYaYUNwLy4dSh29pv_8hw9L4keWw>
    <xme:bFxTaQaRPHIzftFkJezeRK-mAKt_LlPNgfCI2rmj6c1EVN5nlKUZo2jYg8HHUz7Ql
    RCLzqeC-4AT3RE3dqd7d2P1UyXZ00wbt-nN2TprThOAAhfeszdaKec>
X-ME-Received: <xmr:bFxTaT1-YDwbKUVj-NweZum1kmMIGVeOLbeK5vTjNkgyIDZqPesQX0YdMKyN-rmMMls-TbveKLhWR-_M646uEYR4rrUKXGPMow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgfeduueevffefvdeigeeuledvueejffdtjefhfeevvedufedvteeuvdeludeh
    veenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhdpshhtrhgsuhhfrdgtfienuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrshhtvghnrdgslhgvvghssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bFxTabb9qZDHm25BhuKtwXKVXuF10CUwrE-ksnGOXSCyjyf8cf0CoA>
    <xmx:bFxTabJZkHAMbhJpeyUpIRMo2rkQ71k0fYZzNyeLiG9QvbT27fb0Fg>
    <xmx:bFxTaaE7VDl87AfKgenz2xNv0WrSJXdF-anl3LhY8QAhfuJekN3yKA>
    <xmx:bFxTaSuA5LrRTscA-UM-bnboFBPpdREKjWkyi6RDE2erN2S-xnWgiw>
    <xmx:bFxTaaYvE2B0ZJwqy0ALlRbFGhJQHR9W5Poh5X9Ds9HxodDYpwexO6GT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 00:00:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Karsten Blees via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Karsten
 Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
In-Reply-To: <aUU8O6ltrNj-FmjZ@pks.im> (Patrick Steinhardt's message of "Fri,
	19 Dec 2025 12:51:23 +0100")
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
	<aULB3wCFGsbZbuSw@pks.im>
	<5778a03b-2e33-9224-e051-664c2d530fc3@gmx.de>
	<aUU8O6ltrNj-FmjZ@pks.im>
Date: Tue, 30 Dec 2025 14:00:26 +0900
Message-ID: <xmqqcy3wh8d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > This makes me wonder whether we have a better way to figure out the
>> > actual size of the buffer that we ultimately need to allocate. But
>> > reading through readlink(3p) doesn't indicate anything, and I'm not sure
>> > whether we can always rely on lstat(3p) to return the correct size for
>> > symlink contents on all platforms.
>> > 
>> > One thing that _is_ noted though is that calling the function with a
>> > buffer size larger than SSIZE_MAX is implementation-defined. It does
>> > make me a bit uneasy in that light to grow indefinitely.
>> > 
>> > Which makes me wonder whether Windows has a limit for the symlink
>> > contents that we could enforce in theory so that we can reasonably turn
>> > this into a bounded loop again?
>> 
>> https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation
>> suggests that the maximum permissible target path should be 32,768. But
>> that's not _quite_ correct, as
>> `../t/../Documentation/RelNotes/../../README.md` is a perfectly valid (if
>> awkward) symlink target.
>> 
>> Still, I would say that 32,768 would make for a fine (still insanely high,
>> but not so high as to allow malicious symlinks to cause memory problems)
>> limit.
>> 
>> Sound good?
>> Johannes
>
> Sounds good to me, thanks!

As this is a generic codepath in strbuf.c, platforms that do not
honor Microsoft's promise cited above can break the assumption made
here by going beyond 32k, no?

I am OK if this infinite loop had our own "we are growing the buffer
very long and still getting not-enough-buf error; let's give up"
termination condition.

IOW, a simpler alternative may be

---- >8 ----
Subject: strbuf_readlink(): do not trust PATH_MAX

We have been bitten before by platforms that sets PATH_MAX way too
low, far below the length of paths they comfortably support.  The
strbuf_readlink() limits the link targets to PATH_MAX, which is a
code path that is broken by such platforms.

Raise the limit to 32kB, which matches the limit of a
platform with such a problem [*].

 * https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation

 strbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/strbuf.c w/strbuf.c
index 7fb7d12ac0..1c7659bcd2 100644
--- c/strbuf.c
+++ w/strbuf.c
@@ -566,7 +566,11 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
-#define STRBUF_MAXLINK (2*PATH_MAX)
+/*
+ * Do not use PATH_MAX, as some platforms sets it too low;
+ * 32kB matches what Windows has as the real limit for a pathnname.
+ */
+#define STRBUF_MAXLINK (2 * (1 << 15))
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 {
