Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE352D238C
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946403; cv=none; b=G624k6nPiAh0nS8o1YWbEvkOvWkJ1hvV/IAXx1jcMwLr2Jk0gNxtWGkfwCYjorwUVnx2kHuQOpIoTFRdnrRLnz5W/VZsfgA7NkCTX5G2kThYYAS5vb6Mx5+gtSftha2vD6gh4wnuS2CTGBSfYYYG/V25ufj9fyeLA0xU483qHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946403; c=relaxed/simple;
	bh=a+Ds2rT0E3z/PCmqeHKkLw7X9KiQcMqeB8YxyZswd+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EwEr4KiSvtTuIwdTmiR0CSjJNS3mskAkGBlyqDYslWlFun+BZJrjr48dfFjiszuuBk3eoog2Ln/uNPhcjao8or5FlR5zT6y5qaeZ9EtXczDS/ggC8JCQ8v+uwmJeUhSYRE3aHwVgJuNWJkjJtW0x+hfUA/XnfgASQ+FMc6+8TwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQ1PCCMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezdwuBn8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQ1PCCMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezdwuBn8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B322EC0014;
	Fri, 31 Oct 2025 17:33:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 17:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761946400; x=1762032800; bh=B+3vkJzwiw
	sdC/4cXHcbhB2qIWlPrPNlS5L1ghLm4/0=; b=AQ1PCCMiQQg5woMV/HJb4x2tQS
	+0XyMwFv3jdg+OFOEU/IdXzSVCPD/6nHW/9iUHy2NMFGXg1eu3OTg5YKBFvR/2VA
	unlEvwBkmrf9TtWXOCamzttRjxCHouPGuUK+Vqt6FR14IWyPHqDoDWeuGPMeqZB3
	zDtxNNp2kccfPGK3fT/19mFI6OD0XCfPiuzoNAqHy2wK4+0Br1AmIDq0+tUM46Z1
	INkBmYaQcj+d3u6C8W+oJmUOTZzFkfUQlIPMagw5MbAXf+csCsuilwJtg47lUzsm
	bLuFsEYQUpdgrBXpxjhRslX6AOlNYM4kvRibcMJtyXQ9w+UClWtsTwG+IqwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761946400; x=1762032800; bh=B+3vkJzwiwsdC/4cXHcbhB2qIWlPrPNlS5L
	1ghLm4/0=; b=ezdwuBn8M7Uo42jir3+cnIsNLS+PH6L3+kfwm9ccXJoUIls8laX
	FZxKF06KF/GLpDbbxG8YuqNkVdrWWO1L1XUF2+qkCOFwIYmzuPrFuiZa7OFB/5zu
	DzUVJQeDP7Gdr4ltpYS7schrafpHBDu4hhS+0sUoOK6B7jyfoyxoMi1mqoSfS/mL
	2iaDs6HIrW3HFh+ILHXn19u4xHNbCfHDDdimCOm+hPvCMDA901uOLynodwlTflNM
	o3izmZTMziAyQgtLzSfXY0Q/lQ3gcMVhIMfcWi9zoczFcNCNEiheDhSth7hB7iy+
	Z25ltGXjBji0t9vsdqAQD+N0q02UyKBHKRg==
X-ME-Sender: <xms:HysFafe0gcsIZ0ed1u4TUSz_pQAsXVwvt78zY01Dev8G1qJ73NWRhw>
    <xme:HysFacruVeZhwfto4bTUEkmCBQXTINrZj-808NqIK45MFa7Y7nRX59wWAW8MnEOLx
    P2GEI_XzjC_DkwSE6J0bDoWBGEHYcDxpFdbfC0K4G6P6s8cMmORMA>
X-ME-Received: <xmr:HysFaV4w1sl1MKgZ9y2UbFhHe0xhpZEGFmFYt9goM0rs8C75ouPueosdlbnNaMya3xEM_SPTLkGbWMtsnrYTxf8Szn4K8QY9DZks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HysFaaqPGWP9Dj1bybBp30jsQqUuWsPL-22bO-MonBUsXumWfBLgmw>
    <xmx:HysFafhiDnAy0QuRUWtK2iPE9O55wrdEhq2cxr-yEwS8wsIS542msw>
    <xmx:HysFacJ0PPqJKnN-C4mDYh4Te_ZCOqdC1QeWGegujFfK16MiAL469A>
    <xmx:HysFaXAMTyk5vRb9NDnXt4kGVY1-DzMVPuV8Um9ymlud9u_YkgR66Q>
    <xmx:ICsFaYTXHZMhhklyXFyUhVASL05GjmRaNV_9rICz0yk3Wb9hHLXCa-g1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 17:33:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #11; Tue, 28)
In-Reply-To: <87qzuktmoc.fsf@iotcl.com> (Toon Claes's message of "Thu, 30 Oct
	2025 16:49:07 +0100")
References: <xmqqh5vibpqg.fsf@gitster.g> <87qzuktmoc.fsf@iotcl.com>
Date: Fri, 31 Oct 2025 14:33:17 -0700
Message-ID: <xmqqh5ve21uq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Hi Junio,
>
> I don't see the patch I've submitted to speed up git-last-modified in
> this report? As a follow-up to your response on v2, I did submit v3[1]
> which resolves the -Wsign-compare issues, but I forgot to Cc you. This
> version was acked by Taylor[2].
>
> King regards,
> Toon
>
> [1]: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
> [2]: <aPrCaSOA/dclWye5@nand.local>

Unfortunately, the topic breaks make coccicheck.

https://github.com/git/git/actions/runs/18981332553/job/54214401412

We'd need at least something like the attached squashed in.

 builtin/last-modified.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c271d9585b..b0ecbdc540 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -493,7 +493,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	if (populate_paths_from_revs(lm) < 0)
 		return error(_("unable to setup last-modified"));
 
-	lm->all_paths = xcalloc(hashmap_get_size(&lm->paths), sizeof(const char *));
+	CALLOC_ARRAY(lm->all_paths, hashmap_get_size(&lm->paths));
 	lm->all_paths_nr = 0;
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		ent->diff_idx = lm->all_paths_nr++;
-- 
2.51.2-719-gbbf487eab4

