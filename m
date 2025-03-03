Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87537212B3D
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020047; cv=none; b=lCxcqh20Qgn4us0gpLAEYKhtHg/i5wz9N90NBAgetCTC2EssMD7EZovTT5I3YiAIVfLLNBt638T05lznd/NPmpyqToLM3yb1r2BtfVmOqBjTIgYpwdkV3hIyCp0l7uH00RrlBr5EGM4jw476zhhADkjp86/rVuIjyYtxI8SAzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020047; c=relaxed/simple;
	bh=wMmr6kwBtd8zwzE2CCgbwnk0LJt2AR3NIu8fPF8n4P0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8ryDJiVOeg72DiDuVNeNxcZc9n9IAouljf8pA/zS0wttkJzJMmVgCPH4qp0WKtGZ9a2r3w6keIGiwOYbgsh9elCq2XypI85qpSUXAvJLflstD9c3fpawhgxK4FRxsvHf5k8KpQMGsZF7thy5eZ8hb1j6YtJplmO/oWKF85r9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aQHYJCPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1BtONehr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aQHYJCPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1BtONehr"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 971E82540225;
	Mon,  3 Mar 2025 11:40:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 11:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741020044; x=1741106444; bh=HeiDgHAFx1
	3LhnRRVghtWfJwlQOjRG8HAb+VejljXG8=; b=aQHYJCPKWgz1auUzm9hfUiBmaD
	gq/ZT4eknw7efHcliHXTyNjYXvIhbjcGLrkKhmr8jXrJTTTMOEnACa1+eLjccNF4
	ZNssvjiviuI+8ae2pVqttDyzPSI8QKfYhGcN+j+0cMmM2c+L1kUeXrlUmELBvBna
	82/IvxoyH4oH0pWYHR/VsdLsYU6RIFNvGvzZ1VvNQjshKauMqiGdTwmxX64WUmiE
	td/IUJKvjqk9RXriwt/ZfVba/62ui/8VITptUtYdP5bIoqtf9kb8mpN2UH7KQx7e
	pXGxYPyvA02skaUxfLfXYpRwhsmHJK5MKqZo9gTifSRVvpv7SZQESnbPD4xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741020044; x=1741106444; bh=HeiDgHAFx13LhnRRVghtWfJwlQOjRG8HAb+
	VejljXG8=; b=1BtONehrfZEwbYtlAHHpmlTroa9JSTmf/EYI3J5VRQTzGHi+Jbw
	JW5UA8sQC38juyuG2ZhuTRJv+CFcKirZw2DAHD9NtXMSDKSmR2BbeUI/gmOqxW5P
	TMk+75XxM6/JuglG/r4ky9pEzSoPLdn+qBSXgcGKMIy1lVphw5FKMXhlNHL/seXZ
	BatWk4WuCDg139pcuo9rjX/WBwzwHTOVv0SP8jPjP6kDCtopebfgeqY4BZng+vaS
	uTqXZmYelumR7+chGlJT4Vzq+9+c+E5NZww7huU4ojLrwm3+AzTzct/6BhhvERg8
	AZzvfWo92A9cVXh/mJZqKyvqEAaAqE8VSgg==
X-ME-Sender: <xms:jNvFZ-WOyU2NbVBvugOAygCZpo6_f7VfHumT4C_pjahg22IaDEbWsA>
    <xme:jNvFZ6mxRc47H_GVeURg1vfjdjEGbteoqjCUNZMT11sayU2HC6_hizxvIgvI6E1Ze
    3LZu-HCbdYAHoTs8w>
X-ME-Received: <xmr:jNvFZybTdr6QppzzBUmn5N7wvRzjm42XZdqb7UaxsQyfftcHpsmHrV3c-hzKt6C9_EAqkjL_h6gb_wyjARUvn_ck-t-5B12zDSUP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehmrg
    hnuggvlhgsvghrghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jNvFZ1V3N7qjfudE3-8bzqCYt9D0rYKndm4GIS2ZN9vJ32Nq5GfN4w>
    <xmx:jNvFZ4nxcxPR38aDKbjVSwCLzTuv0ulJKVBSw8kDrnFYLm6bFphjAQ>
    <xmx:jNvFZ6eJkWwo7kyPzLktj_GM3E0TJYgnoQEfkibl7AiQ_GdUmp_cow>
    <xmx:jNvFZ6E3NSY5iREBImyi3FSDg6FNVDp6Xre4TMKiKRJrte3u5Jm5pg>
    <xmx:jNvFZ5C5n1jcwXYSCWRhPFk7i6c-am3gDODfu_u2RkkJJzTLKSQBcIMZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:40:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] editorconfig: add .bash extension
In-Reply-To: <15fa4f5d838745b5b05248b44aa16a57@mandelberg.org> (David
	Mandelberg's message of "Sun, 02 Mar 2025 15:54:44 -0500")
References: <15fa4f5d838745b5b05248b44aa16a57@mandelberg.org>
Date: Mon, 03 Mar 2025 08:40:42 -0800
Message-ID: <xmqqtt8avzhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

> Both files in the command below appear to be indented with tabs, and I'd
> expect .bash files to have roughly the same style as .sh files.
>
> $ find . -name \*.bash
> ./contrib/completion/git-completion.bash
> ./ci/check-directional-formatting.bash
>
> Signed-off-by: David Mandelberg <david@mandelberg.org>
> ---
>  .editorconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I love these obviously correct additions ;-)

Thanks.

> diff --git a/.editorconfig b/.editorconfig
> index a3c578a43c..2d3929b591 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -4,7 +4,7 @@ insert_final_newline = true
>  
>  # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
>  # them in sync.
> -[{*.{c,h,sh,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
> +[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
>  indent_style = tab
>  tab_width = 8
