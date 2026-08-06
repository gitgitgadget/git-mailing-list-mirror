Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D413DEAF6
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052101; cv=none; b=Q9N/8i3hAfy3RjPrKenGw34djh+EWHOj31Zte9kj0W22XOGNgYeTKLXRv5JyNlI0FHNo/cQO2dU9gQV0vaRj05PGhOZruF/imrq4qfHJLpsjhp+UFtaVorZMFomxdnkSHmNCfCjr9rmbo9yTRwBAKBkdDNCciepfaeYGIaLU4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052101; c=relaxed/simple;
	bh=YdSsLdl7s7UMqmamt7tPe1hFNvzQzcslCh3Vkq9pHoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpVcAzAqFClYOha4c1GILV8GX01TUFjRuYKW/m7DO0wooE4vKicmSjK1S7NKdUoJXinBM5P5BFsDf9YyWERQHvq0a6zu+yT0nQ+BF2wFAUJb6PTz6x0JH5sX9461381UwwcmJKfMGOQ0s+/AM2PP+rjyS4r5qdb6pqYBqdjCa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zBq9On4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJQYT6Mv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zBq9On4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJQYT6Mv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1CB97A00BA;
	Thu,  6 Aug 2026 17:34:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 17:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786052098; x=1786138498; bh=nt6E25OnBS
	EjNLVqmloOZ4LCD6q5xA78GgWSbNIG2gU=; b=zBq9On4D3xWhFwnO3eVj+i4qN2
	6EJZ8DRK+NdzjyhVT1dnck1fS7xzR6fSADpklFY7DDBOj8s2sUyohpUFej+zFWoc
	+ZdychNRKG64MhFb6/u7tyO0fH105q2KLMtvhumjzTet3G+SI104wzUzhrZOBuno
	ZxCD7lGZkIYHTgnX8jNFyOb+VdOvdlMNw0L3dcO5RWVLaGPrhS1xkCuRnCdNaIic
	/kaav7B8pnS71Zazlkgkbn2m1i+Aftx71kdq3GfAGXm9dw35MIl1vPT4pXZ1e5aq
	yTjyngqoPIUWN9HnDPZpyI6Vo54fk5nPmdei0+bwkqY1ue0D9li6GeYsDpzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786052098; x=1786138498; bh=nt6E25OnBSEjNLVqmloOZ4LCD6q5xA78GgW
	SbNIG2gU=; b=JJQYT6MvRZFDWkh5vAh+VOKfrLK0BRl4KrjGFwGEAeuj4kMmyFQ
	Fvoe93HWL/ElDCBjE1+6JY600ZMElWd0W5ft01vwQSh65rVMjAFYGaTB/sRehmEg
	SGlKf+xBu+FJSTMjfE0+IKcJTo6l/aCI1ouFFnVk5SfjcFeSQ8t7dJM9UHS7GX0p
	OL+BNkfDZPxfmxkAHHwFBXl9+VCa2AyagP0alpXaEBfG4a8fzIDZkqNQjo9lQFNt
	p217Ex/qtWZnqNfklphcoetgU0WGn11Pi0rQi5RL9pD1SLvbrEXS5+vza4njFWui
	qRrisnsp0hd7yFB49HZA4tJGTRZM7MghvSA==
X-ME-Sender: <xms:Av50ao29xgAY7_57aGOzZD49BV-r8T4gdqeIiB5oYvtAx7MXximM3w>
    <xme:Av50avpJs166K12FmVA30brsdX8X_A9k2fSH9UlAGtu7U6TJvwt2iKNdT7DNvcxVD
    UOAu46KEH58OGE7rcfwUTS9WPMmX1lRkpeSmSQt-1FX5rAf_b3d>
X-ME-Received: <xmr:Av50alVU69jxKVMZSyqw8OOpBb0yVesq-ZxwC2vVLdSfxpqbhProWr7Y6yOcfRjASkxTHB4dlZM_hWPPtXmmS4xECLEzrZ2u7Q>
X-ME-Proxy-Cause: dmFkZTFcrz+WVB6tp5ICcp9uC5aJEyB4vNKWNpnJY5ZpTJy2iRl3mjhwpPuBKH7Y5l6T3C
    aEA2wOl7RLcnbjv/n3CMRD5eUMXic/EyY57ZvuYaMF6GNiutUg4QZsXDUp5k4sONlGB3ZS
    tT0mIk1XojiaIVMI8GJrZQERzo+JVPMhCWWQbnaNiH/8CkQKYz0JzRCXY5LXppZMlquuf3
    OSCk9udM+QTVdZy2wGVxkDWzBK0zViLD4vYHmMd023+uSdur1FalQ/6F+JqNIdG9JWnX1a
    Rp4ws/gu8JCxHaJdGzDHiQ5FARXVlHPBrT9wDeWUh6oEK3MD7HAtpk4cXWc8NnIwbyPgid
    978Php9QQMv0FNMHlYbsBUxZuOGnSae9iK+jPpv12GVv8F/f4rs4NxJhRO4ZPBtCC3ihsB
    WyjFqpHznbj+g9oUhlWS8pk7TwrchEkznLl0EuUrMmUKep/OhogPCQanlC5y2t2NL7/lZA
    gXMvcbZaUsyut88PkZU2N4W70fgHbQsXhSr2rc1krnFdD+Ik8QeRpTHlo3TENxpUmcBgMX
    7Mvui/YrjxaI+XvN2y4BetiEQD3VHf0HSzR7Tdx6lErt1swN9F6Jjv7+WvnyGHAVJpf+Mb
    YpOmmmCAJC1nUQ8gUgOdSUMpBKPD2FGz+xTEpgwGeGDjycpRFAIO3llgeQvQ
X-ME-Proxy: <xmx:Av50aopHyG7WPjQ1Zj6HzXAsYqsqKUwC1SbOhxca5ryVvNS5sZ1-nA>
    <xmx:Av50asBJ4ha531K0cbRmj4_QSiH7YATVAKKKQIe1HmnVRLN5GRObWQ>
    <xmx:Av50akhenmLAG12BzPqwE592COAkqsf27WCmakEpglH0lq5mdIcT7w>
    <xmx:Av50aqY9QzSbt_-7cSc3w0AZWTNQKpvoHocRBPs9kDQl1Ci5kNnnRw>
    <xmx:Av50aphHRVweUrimkKikjYgp_NB1HkyY5q953c3w3XLAVbp79g1I-v0a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 17:34:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  me@ttaylorr.com,
  ps@pks.im,  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Thu, 6 Aug 2026 16:51:55 +0530")
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
	<20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Date: Thu, 06 Aug 2026 14:34:56 -0700
Message-ID: <xmqq4ih7hr0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

You would need something like the attached patch.  

Didn't you get these when you ran "make test"?

t7706-repack-drop-filtered.sh:145: error: bare grep outside pipeline (use test_grep)
t7706-repack-drop-filtered.sh:146: error: bare grep outside pipeline (use test_grep)

 t/t7706-repack-drop-filtered.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/t/t7706-repack-drop-filtered.sh w/t/t7706-repack-drop-filtered.sh
index 6774886f1e..05d58fa456 100755
--- i/t/t7706-repack-drop-filtered.sh
+++ w/t/t7706-repack-drop-filtered.sh
@@ -142,8 +142,8 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
 		repack --drop-filtered --filter=blob:limit=1k -a &&
 
 	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
-	! grep -q "$BIG" present &&
-	grep -q "$SMALL" present
+	test_grep ! "$BIG" present &&
+	test_grep "$SMALL" present
 '
 
 test_expect_success '--drop-filtered refuses when a merge is in progress' '


