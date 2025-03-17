Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABDEAC6
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251047; cv=none; b=l51hyam/RbLBPXXvpegWOLlCB0Z79UJY3OhxNxu9mF6BXa+ScgCATBQmmiVzlLNVr+3JTId1j9HEmYjToPp8tXrPgnn4mo3uc2IocY7Z88PpOa+d1McCOVrmL3I8u4oPCvJLQCD1yW++mjFsJIZwgZV89seE8jALae0tXWkJPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251047; c=relaxed/simple;
	bh=Y4G9zjw/p8ffZxp8G5RV6cOzbuy6KwIZLku6XFnN9ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2QNMVwLbNWmiV0jrYVnpz6svAO9lIOy4f9Afs5pSPNsVnQdyhnGQL0PekL+zx0Eu+9Dnek3E8vRCsvJ5Lq063yACJhwl0Mw1qsqeJqMx07iLj6dByNvu6tDl1FSIeCrVyXOLlBM8zW1gO9TAryhprvGCKJopkgtDqlMXCwe7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UkPsGx+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7bgH0Zkp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UkPsGx+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7bgH0Zkp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60ABA1140250;
	Mon, 17 Mar 2025 18:37:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 17 Mar 2025 18:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742251044; x=1742337444; bh=roQIAc5GRd
	fI7ihUA0Xmf3Iil7epCp9UKnGI1p1a0AU=; b=UkPsGx+A3ILK00kb3VF9sGTfs9
	+kQuWIWPTb0Mph6hLfTh36Hbuz9NTZdwdQk0+XTACAC9Ue5XC8dIcZhnxcSmFHTL
	PT7COzc6RWCupkGnehV4wNmbcMaNy/Cm5jZdoeFW1gXcNWfOyQ3WAOMAkvCGc8qM
	Bg0kF1QWxnhS2QZ4i29mzUkYoqziJCuHevFzWqFgSn0Mmi/mYFmutsje3rT/dp8I
	F558RoLcnQBTBS+dObfa/fP18h5S64ieaTDpsiBzkW1ylqs/abTSJ5Nw+CSQxyNl
	jjRy+DfZhXw63Qeg8ZheDZ1dNzDub8WCyq4YQ5pZf5fuM3zLijblhTHM1xSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742251044; x=1742337444; bh=roQIAc5GRdfI7ihUA0Xmf3Iil7epCp9UKnG
	I1p1a0AU=; b=7bgH0ZkpgOmH9iUifaFGKm/ZdPjAXq+qsrYY3VpIY40lkfQUgrC
	F9a+nC9XnKySK/jUXi7WiJ8dBw16eGEWdBW9JSSYfHCZrcVybhaQAmynN4FZGFwr
	HZ4IFcRJPNQSdA9YlSPQRfuphx7tSTa3j2dJ9Dy1hTuog6Ghws5go94suFUJMR4L
	X13e4Tj920huFgkqJvI/ZKByAfsYrUmsuLletX86dNrq+ru22DALtbLn4YhsYDgA
	tAeLRRtDp8DvEYNwTe1zEGTBjMcNFZdySzeyKoSiSmN6dWYFi/FH4vvQrSS3DSVZ
	7U1UpDPqrC2ApAjMZgdhJmgxej79OWLmqfw==
X-ME-Sender: <xms:JKTYZ5e_s7M_u5SpTo6gJ6g3xcdwz6LfYcpsYHOXXlWKoOjNgUWXkA>
    <xme:JKTYZ3NZ1NroBmSRcuy2MFHT22XlvLFCvKbRiXsnpl4aT_mmRTJkMZegDlvXICyud
    1SQIQfrWZ4ForCIWw>
X-ME-Received: <xmr:JKTYZyjAKxxEQimR7p3GpZONSMVohw-Utv-uDlU5emM0ltNJwwuAOgCvYp3RvPpfBuc7b7I9DnrUTZr-825ism0ks-HtYsBbPOPie-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepudevvdffudekieduvdduueeugeegjeej
    tdfgheeuudfhffdtueefheetffetfffgnecuffhomhgrihhnpehsthgrtghkohhvvghrfh
    hlohifrdgtohhmpdhrvghfvghrvghntggvrdhtohenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JKTYZy8tCGflMeSlJxSGbguoM5YTzAk88yJWppO_EuSkKA6UWrCYOQ>
    <xmx:JKTYZ1s7q9x55LQVqs7me7pIhhx2uIAEoLp2uOwDx4DWLepZ2XA_lg>
    <xmx:JKTYZxGkBu8_THtx1U0dd_OCW8JCY6erx6vybjw5alOdPtlm-_x-Ug>
    <xmx:JKTYZ8OyhC3xwzl0mXvMVv7HSDFsLqCwkHCReu3q933Spz7aXi_6zg>
    <xmx:JKTYZzVHJoG3qTZ1lacB38gPbh1erU2lYsF90XRWN6bZZcPZ_VrZtCH0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:37:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/3] ci: add build checking for side-effects in
 assert() calls
In-Reply-To: <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sun, 16 Mar 2025
	06:42:01 +0000")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
	<58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
Date: Mon, 17 Mar 2025 15:37:22 -0700
Message-ID: <xmqqfrjb707x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...  All but 9 of them can be determined by gcc to be free of side
> effects with a clever redefine of assert() provided by Bruno De Fraine
> (from
> https://stackoverflow.com/questions/10593492/catching-assert-with-side-effects),
> who upon request has graciously placed his two-liner into the public
> domain without warranty of any kind.

Nice.

> diff --git a/ci/check-unsafe-assertions.sh b/ci/check-unsafe-assertions.sh
> new file mode 100755
> index 00000000000..d66091efd22
> --- /dev/null
> +++ b/ci/check-unsafe-assertions.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +
> +make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
> +if test $? != 0
> +then
> +    echo "ERROR: The compiler could not verify the following assert()" >&2
> +    echo "       calls are free of side-effects.  Please replace with" >&2
> +    echo "       BUG_IF_NOT() calls." >&2
> +    grep undefined.reference.to..not_supposed_to_survive compiler_error \
> +      | sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' \
> +      | while read f l

Let's lose the unsightly backslash by ending each line with "|"
instead.

Also let's stick to HT indentation, not whitespaces.

Thanks.
