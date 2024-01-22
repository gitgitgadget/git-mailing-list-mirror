Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9347F72
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956264; cv=none; b=eWXuYJrlHSNAZDA26eXvs8VhqPitscvCDsk7jC6UJPrDEi7JamcBbF+zv1g8eq9KWg3Ud2dNWBzcgQ9Inm3nyuMfqc3x4r/lCSgBeiCyHj/7Ib/ZGzsnUBtIaX5lcqdz3Tl3tpEEUWScDt7pxSxGDozJhiXwGOR9313TB1A7LbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956264; c=relaxed/simple;
	bh=UGiJL9iduO7oK7tj0JNKcU3dV55N4OvcvFR0MMilhH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXzRiHQpwj9QNG9Al2TiBDW131fnHvk9QcwI26BCjvKNo/3a/wSatGYhCtN3zeah/H1shd3xuVepUvu4WHwMmVOLg0MQ1771NAaBNIGweJM+qT0PY5oY+T+Jwj63gIhNSthkiMAVUnrLxEVmAL4PiiftwmvOS0t/AZSQHp1EwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LZnlYHB2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LZnlYHB2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6491D2D5D;
	Mon, 22 Jan 2024 15:44:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UGiJL9iduO7o
	K7tj0JNKcU3dV55N4OvcvFR0MMilhH4=; b=LZnlYHB2GSa0S3r962qGXAyy4NLU
	GfwvLSxu7M1L++f7EVLAoAZAiBKf2ryNuQ9UJVLbMan/VDxvS25Qxj6Ow8ETR6Ds
	6FVdiCh4bJRncxwLJCOB9hLVLzXa8KNO8od5muPq5N2IuI87X6Zf7TcIy2vL0BG6
	e3tsfIeqXbJrkrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66DBA1D2D5C;
	Mon, 22 Jan 2024 15:44:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8ED51D2D5A;
	Mon, 22 Jan 2024 15:44:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH] editorconfig: limit code lines to 80 characters
In-Reply-To: <20240122201420.72802-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 22 Jan 2024 12:14:20 -0800")
References: <20240122201420.72802-1-carenas@gmail.com>
Date: Mon, 22 Jan 2024 12:44:19 -0800
Message-ID: <xmqqle8hrtcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 04CD1238-B967-11EE-AA7F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> Since 6f9beef335 (editorconfig: provide editor settings for Git develop=
ers,
> 2018-10-08) a multi editor/IDE configuration file has been provided to =
help
> developers follow Documentation/CodingGuidelines.
>
> The settings are also supposed to mirror what is found in .clang-format=
, but
> the "ColumnLimit: 80" setting wasn't included, so correct that.
> ---
>  .editorconfig | 1 +
>  1 file changed, 1 insertion(+)

Sounds quite straight-forward to me.
