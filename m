Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7087081E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195916; cv=none; b=cMiSePqmmds3qqYbg39TSLU6aFc31aRRihS5RyPpWTi+377WlPDnsXJjqBVdn5YZgdnukTiCDypzhPHLuGvEAJTVj6qcQ8rpahDJLAqlOy252nrJlKx3eIWyPIKAFSun2hRcbmfbHEksCCWse8c7y5iQsPt6I3oe5rpqEY6dUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195916; c=relaxed/simple;
	bh=WLkVDEkVaaKZ7b39Yt3fIKPVjBzH+6zZD3hyhaKtVak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7o+elaGjVa/y3d7S/xQpQ0+96BP/utk54Z/+YoQIGwL9Wef2kRvWb0iwKznhzRxI97JIcg86Paxg0qUhXAYN7jXVZZanBoZFE6TP46DrdeTl0NUpJYNK1Soy/kdAlaQfhJe3/kdSrsZ6LHAEJ9s7usuRz/fRGduv5o6AWzZx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GUIwwQUK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LU5K8nj+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GUIwwQUK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU5K8nj+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 029ED13802BF;
	Mon,  6 Jan 2025 15:38:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 15:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736195912;
	 x=1736282312; bh=0EHTpLnNYL2UM5wlViBiaXN3uImr7XnIru+Yhc7XX+s=; b=
	GUIwwQUKuyJGf5gQt51KA8PHv9i8kETUX1bqnzie/Eg0Pdu0AKYyxkCjDkRVi/7x
	SMahe5zvRyd/2yhBM5JXX368kcWc+QTMjQB4dMnW3vPkb3V+Ts6JopWL1BLslPh5
	u3jTWY5CmdboNxYEZZelme4PafMlPTLzCMtkGQaAT9RQvPYVdc6blWpR2ICXbCkC
	H/55+7kNPEnLNSdVxg3JNGMPrtaAVh1l1koNe5Jy1enRInnejN/4G4GZb0sipFXt
	Ub9a63j/QkF0mI8EoLZJZs7+oZOo7j7IWbS0i7y1lOY8e59XMBALcqATJ3gqW0SC
	PrBC2Xeec5269/quqHhKrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736195912; x=
	1736282312; bh=0EHTpLnNYL2UM5wlViBiaXN3uImr7XnIru+Yhc7XX+s=; b=L
	U5K8nj+osE7Jv0J2afs7FnpqKkaxr/xsUqZuWw1k99sZcBudQoNJNwAkZCe3Ouuk
	22zEOTloep7cPIWc1AYVC+9cNrgU0M4UPGfOYtzoe9zBq0n6FvNruza4n1lAidx5
	zrrOPOO3ApwMoc1AiFDZPeg+k596y8MaVnT9ntTENH1SMM3+XtYaNSFg4UcfrGKw
	h3SGJlTiZY83BFqac5a6Xvq5zSpqBX2BfncZAY7CRTyIJovE0vbQkE9jbSWJyHSN
	256JiVW0PoLWlNXFMgavR2MQCSvb6B6jzr0bB1o8IxZ1tGBbQMW4ZW3fYTTRyWM2
	V1z3UsP5ek5Ti0cFj7p5A==
X-ME-Sender: <xms:SD98Z9YUt_HRcam04Uwir5DiUcyoh4kfA0YSTr81uSQS_wrbt6rwGw>
    <xme:SD98Z0Y_6njf5z52AF8YSWS-FEz67Ta28jjrEwtIi8K3qlOg0t8ZQ3Q7kQjzI-anF
    70UYtVhcfHQUnGxIg>
X-ME-Received: <xmr:SD98Z_8sfvCbcB-R1DVSBqwuR83lYSewwmdeXQTaDCWtI_87qOiJC9thSst8kkvCdcaaeJq9Ux_b7BBuIw6UNfKNk9CVggqCHu3F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:SD98Z7quHaSEUY59-D_nrbiJD02gpVaIraP1j649uOy8HQ7N59f4Gg>
    <xmx:SD98Z4pFWid_1E0ZlxEubmvECUIub6Do2o8o_0XeAbT3jIzlCsMOBg>
    <xmx:SD98ZxQ0CCS1tRniI3TR3UsG14n_bpYdefPyYZAau3AwCnuau8G1FA>
    <xmx:SD98Zwq2VYM6Va2fokukfYQkfJNcB7eLttZGiU8TyyfxJIaWKStHrw>
    <xmx:SD98Z9AC7WnmoSseA68OI5CETxOR13Gi8O4KI7HO3SGBk55wdgM3uuBr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 15:38:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <CABPp-BHyWgu47mCDH_f_MkS4CMGh_OtX4K-YGFsB-fZvvaNJPQ@mail.gmail.com>
	(Elijah Newren's message of "Mon, 6 Jan 2025 11:26:48 -0800")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<xmqqbjwjzw9b.fsf@gitster.g>
	<CABPp-BHyWgu47mCDH_f_MkS4CMGh_OtX4K-YGFsB-fZvvaNJPQ@mail.gmail.com>
Date: Mon, 06 Jan 2025 12:38:31 -0800
Message-ID: <xmqq1pxfy8xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jan 6, 2025 at 9:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > Maintainer note: these bugs both date back to 2006; neither is a regression
>> > in this cycle.
>>
>> While I was preparing today's -rc2 release, I noticed that this
>> change broke some of my release scripts with
>>
>>     $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
>>     fatal: Needed a single revision
>>
>> which is the construct that has been there almost forever.  Its
>> expected output is
>>
>>     $ git rev-parse --verify v2.48.0-rc2-161-g6c2274cdbc^0
>>     6c2274cdbca14b7eb70fb182ffac80bf6950e137
>>
>> The series seems to need a bit more work.
>
> Gah, I made sure to copy the object name into a string buf, so I could
> operate on just the relevant part, but then ignored that and operated
> on the full thing.
>
> This fixes it:
>
> diff --git a/object-name.c b/object-name.c
> index 614520954c7..cb96a0e6161 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1318,7 +1318,7 @@ static int ref_and_count_parts_valid(const char
> *name, int len)
>         len = cp - name;
>         strbuf_init(&sb, len);
>         strbuf_add(&sb, name, len);
> -       ret = !check_refname_format(name, flags);
> +       ret = !check_refname_format(sb.buf, flags);
>         strbuf_release(&sb);
>         return ret;
>  }
>
> I'll include it with all my other fixes in a reroll, which I'll
> probably send out after 2.48 to avoid distracting from the release.

In existing tests, we seem to be lacking coverage to notice this
breakage, so let's make sure we add one or two.

Thanks.
