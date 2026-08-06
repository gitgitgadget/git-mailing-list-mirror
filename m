Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB047ECDD
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032681; cv=none; b=L7QL4YpJU7MEru7Gi9xVoz9iZsRK0OypSVv9qMpGGnABZbQZqddAKB0c6lx7uTo7nhDdzaMeUe9xQvW5XNdNWMmk87Jx0J7uImvBztL53VGU0BxICN/U4DsQKIVRrqy39cgb6fhPUMumHqw9HobjQEyQBcsdsie7ehrzETa3vwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032681; c=relaxed/simple;
	bh=9ulPvrgPyeutq2wtBMVkNkHQWd4CI4IO1PJf/KSYGeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msfeiMwkUrpnBEACwgiKe4KS2UxPiM7fPDyFvoYWeYUxwswgpCirt/3RQDr7w+ai4jscy9Px5qos6Ct+9TloWROAYp9ml0dmh8rNpqKinv4VaF+lskrU+OlPtIiwqwlCaJOpnjEaN1i0HFfpgsasEeZrWG2qzLswNpANE9R+zFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mKiwc1rB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCg3Nyj+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mKiwc1rB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCg3Nyj+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 36D911D0011D;
	Thu,  6 Aug 2026 12:11:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 06 Aug 2026 12:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786032678; x=1786119078; bh=b/q7nL1fWp
	DC/Z0xq104mUdkVUUvUCX+8eHzBgEehCc=; b=mKiwc1rBJi7r8GPLv32kLU1IKk
	YCJd1tEu8B6h+LSS6Cn02KTnaQF3ZutQOOx29DEJOQhZK0WL+zaMjKw91eK4z+hV
	X2Z5sp33RVhbcWdUtqRtkbknwPjtY3KzfZ9opKiWyUAaOSBFPgMP9P/k5uj8bYsP
	jP99GUj5x0KD/Qig/oaB4ste0xfmryhtRGwILJcg2NBfkpdzp9RmboaX3xtE6a0E
	17LM/fRBR/iD6MD05PfqvOosmdzftF++flbVKkBgB+TGneq26fPgD2EtUtZbReGd
	q3XfR63B22SKmPEsP7dCb22zkmPzY/wgtKMV4IG/ET6lMcwwGrSSI0vHXMyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786032678; x=1786119078; bh=b/q7nL1fWpDC/Z0xq104mUdkVUUvUCX+8eH
	zBgEehCc=; b=HCg3Nyj+ItIe6kmvEQjcPIKw+US6KnnYzDgq3wNJzjM9LopdSsI
	cvKwWoRebmpdDuA1Ei9bunEryOpqvcqdWkVcdaiLy+XohvZPatRfWwr2C7ynWulE
	JjlGDWQjGUPkw228QRV/EMOeNEE/4IctJOCXsgSjvOCPszeN92IU8dwVZyLXaj+G
	Ht+sIkZhvX9yjZ03IrDjen7zwALTkM2NokITVvSsHaeX+RwbUb4AS4/JTZPj1AwF
	3QyIykxnYFgyiHxr76hRbvd2zMpM0luxrWyExcUZb/su6+JSXtOhPBwSpzjfttj0
	W/WwRk80fWLgNdZ9O8ST1q81Dpm3IfqHTcg==
X-ME-Sender: <xms:JbJ0ap5QMaaX1ic_IxTjg9xkdaMO6o7r_EVkcH6KIlTsbFCKfY0_XQ>
    <xme:JbJ0ahdV_9Qyibln9FhsUOuE1i8OLZz4xss2FIiycwsv0Yo1cB4l92pkfjlLlUTqW
    026eohxjQHCI2ROXgrPz4J2Bvjwim-rnb8hWOv0o-VMoALHcDZ7>
X-ME-Received: <xmr:JbJ0atDyfVP-Wi1soHqxVQ656w30M1xXRUvX09h5b2pXpb6TGt47FdQuBY2IOPyPww4d4qnGOuvjbwB8KG9_zEc3uK4BhZjDpg>
X-ME-Proxy-Cause: dmFkZTEAP2v4EvXacrqAqPJs8VTxpry0d4oJZPBHAPT8QfKCUDItPibXxwGCJObZDaretB
    Of6gDef1QtPOZELmtKUBq2GIYcCoCNIdnWv3aCCCTAQ1OI9/fAYxT7FEjXWve/CyNmMjJE
    jnYRkxXCLdj01HKksbDvMMTw/dG1G0aZY9ImOSacK2lSmb2igBHDOvr99nGDiF9e2yG5uz
    LoN3A6SKALDRJDu8P1IowFdZmeEnnv0GXSLmVs8VN2z99dYbiAwOlzQIff224UmEprbl9W
    ynnj9kiX06KEMxaJyKYip2j07NpC3QDW/eDo/HWnb+GeslbffM3fjKglNe/onnH0A2c2Y1
    6OYhP3Hi8AXbmvtXANlpBJ+en+R3m63kn+u+1hVabNsIsyn335b6l7bv534Lf6Sq10HYjR
    ZEbYvf1AwOvl17THHDsxpTOvRTGO402IMnSN9P9/5cWD3rc7gVgeCcrb+s1XDTdi5rvfdG
    YxIjg9sosvgj8hqbilPu3uiJ2s69Ul6ohp0ybzezeu+s/XMPplJua9iTLk8CKiWAoPKZQa
    JtS2uV1tbLc50qsgqB9FugO+VZcpx6hMACPv6ggWv0tHhHzxt8lX0Joe48jl3DgGcrx5zv
    L6DDHqkMZDoQkCScKGPc2ETgDwU00s3IQUKogfLnVEgFBtNbYNTGS9FSqBig
X-ME-Proxy: <xmx:JbJ0ak94yJkihRHKqbNsrIwBoAhj4i0diu9B1R1FNYFos2r3GFmj-g>
    <xmx:JbJ0aoKB3E8CwzRPI_o8UVIilJb5dumUDCfA8sdntVqf2SeHEzZhSQ>
    <xmx:JbJ0atgDAcVxFixeexPRRQ1zszjHlC8rwTnz5lVmaOO3IvQBreoGKg>
    <xmx:JbJ0ao6ZL8EsmpFFthXoVX0J7X5BmuKvttjpMOAZkziVzduHws-FEQ>
    <xmx:JrJ0avh4xEXrkV9NHnaZeO8IF6n3YKd1WAISlOilG04PQCLMEpXbz1C6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 12:11:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression
 tests
In-Reply-To: <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Thu, 06 Aug 2026
	10:59:35 +0000")
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
	<e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 09:11:16 -0700
Message-ID: <xmqqa4qzmdp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Add t6099 to test the case where multiple merge-base candidates exist
> and one is an ancestor of another. This exercises the side-exhaustion
> optimization in paint_down_to_common together with the
> remove_redundant safety net in get_merge_bases_many_0.
>
> Add a mixed finite/INFINITY test to t6600 where one tip is outside
> the commit-graph (INFINITY generation) and the other is inside.
> This exercises the region transition: the walk starts in the
> INFINITY region where side-exhaustion is disabled, then crosses
> into the finite region where it can fire.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  t/meson.build                         |  1 +
>  t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 t/t6099-merge-base-side-exhaustion.sh

The log message and diffstat contradict each other.  The addition to
't6600' happens a bit later at step 6/10, which presumably introduces
this finite/infinite distinction, does it not?
