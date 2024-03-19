Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA639AC4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872385; cv=none; b=gXTbOU9RxO32Rh3Ir92jDaWfzYP5sVJzZUyc0NNOLnaW0d6uiCVca7HfuS6tZ9DtIkjSVxX7ruu8+ugzMucf7vYSw5kS368f/d8N/Ta7+dU4jrdmo+3IfgYtOATkJWH2vEXAKRZi9+zH6rBopPFCXhG61HONZfnmqVY+d4xrrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872385; c=relaxed/simple;
	bh=5+081n8x8mEezwRYqjIAZoODqORlMJglKksxrUzm76c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBuZULTARzzbqyBW/yFj5/CgBtCSacyWa9+XYl70FiR5BLxwXJKDxPgQKhu/pNOju3F0yYcQVuqwmpgLeNH6HeyBryf7JER0WnGQiCh41d2nN3usai6GL0QQd8n58E8A+GDREBZXHJ2EOfPjLXJaATV3vknt7TDpynZTlnn2Kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dEa+2xJf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEa+2xJf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B671DB526;
	Tue, 19 Mar 2024 14:19:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5+081n8x8mEezwRYqjIAZoODqORlMJglKksxrU
	zm76c=; b=dEa+2xJfsqHTmNmIdlwyc1ok4NEvCcelAkAr6B6isBy01eIPI0cmni
	ukFbhotzVDhf+udtKKFX3PLJ5yc2txXLiOkE1s19FwbxZ5YIXAy5DsfE3wnKM1U0
	nfHQC15SEtB5QqE5E/w+CLvknh7QSj1pYmz2E3MDwAqnCz6uOwi9c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B23F31DB525;
	Tue, 19 Mar 2024 14:19:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26D8B1DB524;
	Tue, 19 Mar 2024 14:19:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Max Gautier <mg@max.gautier.name>,  git@vger.kernel.org,
  =?utf-8?B?TMOpbmHDr2M=?= Huard
 <lenaic@lhuard.fr>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
In-Reply-To: <CAPig+cSWLoRdTgrrU2SBswnKr82L_BPCKtaP6atMyZVDAU=hpw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 Mar 2024 13:17:27 -0400")
References: <20240318153257.27451-1-mg@max.gautier.name>
	<20240318153257.27451-4-mg@max.gautier.name>
	<ZfmAfIErHRZVbd49@framework>
	<CAPig+cSWLoRdTgrrU2SBswnKr82L_BPCKtaP6atMyZVDAU=hpw@mail.gmail.com>
Date: Tue, 19 Mar 2024 11:19:35 -0700
Message-ID: <xmqq8r2eqe2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E7BCD66-E61D-11EE-961D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> You may be able to use "$TEST_DIRECTORY/.." to reference files in the
> source tree, though the documentation in t/test-lib.sh doesn't seem to
> state explicitly that this is intended or supported use. However, a
> few existing tests (t1021, t3000, t4023) already access files in the
> source tree in this fashion, so there is precedent.

I think the following from t/test-lib.sh should give us sufficient
assurance.

	# The TEST_DIRECTORY will always be the path to the "t"
	# directory in the git.git checkout. This is overridden by
	# e.g. t/lib-subtest.sh, but only because its $(pwd) is
	# different. Those tests still set "$TEST_DIRECTORY" to the
	# same path.

Everything you said in your review is correct.  Thanks.
