Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029426AFC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381295; cv=none; b=kPxNzFoLW6o6BuwLrs8UoxeOwKKbO96fxXISiK4bTUcqbAAyebVBrhW6T1dutRXFppyocoJGQjyVJC/A4nZeitCwXdoBs0R9VZ1UN5V6mrOSiIAxE9UxGB27T/x3J+ZESZrgu73RE/HQT43alO9uNf3xGnBsdBRXcu19Hw3IrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381295; c=relaxed/simple;
	bh=4IceiXtOG4gGacpCihAts0+rsPGS50I7iJgh7kTSLMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IruALO7NVnmOumRl3fYKX1QcQqNWBUtV020HFvhkuTuoWxDgJ72AQ8jI+Vx7ftKsOHf7tt9csBgyl4hBEyMb1X3m91Q6uNCT7E1lRZuhvZxXpd86NIMGeAnH5E1/VE0+A0YaiNbUG9t3wHISbLhsZZDR3qsHrPqDH25KpEh3GB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a1hL5F3v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a1hL5F3v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A08D31ECD;
	Fri, 14 Jun 2024 12:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4IceiXtOG4gGacpCihAts0+rsPGS50I7iJgh7k
	TSLMU=; b=a1hL5F3vYPfEk+rKxe2x7PmubL+oCVF9gFrn3rOmeZoKfMBZKC1EVy
	gjBJ9ydoR7dQU2nRXRK2McfqDRGWAsMnFO/UA2C7DsAj6i2GUEs4y7HTSeGStdAm
	9dIPjba4SSZNXEF/95C7KXtrkw63PzPw7jlgVsDk1Z8Eea379z1FI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5164F31ECC;
	Fri, 14 Jun 2024 12:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8673931ECB;
	Fri, 14 Jun 2024 12:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v7 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <6348f27b591f306d79c69594ed3157e22ac4774c.1718345026.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 14 Jun 2024 08:42:34 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1718345026.git.ps@pks.im>
	<6348f27b591f306d79c69594ed3157e22ac4774c.1718345026.git.ps@pks.im>
Date: Fri, 14 Jun 2024 09:08:01 -0700
Message-ID: <xmqq1q4zik2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 47766B08-2A68-11EF-AC10-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +to see the message and its surrounding discussion. Such a reference is there to
> +make it easier for you to find how the project reached concensus on the
> +described item back then.

Sorry if I typofixed silently and locally without mentioning in my
reviews for the earlier cycles, but I noticed that the fix
"concensus" -> "consensus" I had in 'seen' is gone from this
version.

I'll locally amend.

Thanks.
