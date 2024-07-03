Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB217C7C
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023652; cv=none; b=igQyUx3BQarJ66ohwTgXbXEc4cMBgcbmw5PZqNSs1M2+nf47H1M6lvxMuJntPgQrea5SEz/sZst6KTGZTnfjH3penuWNOBlNj0UwTFPyT2OxN/fC68fzvkgJgMRhbq/u8q6v20fZj4QBIJ0DjOW/VuM5ENXBLOo9u5CnaTXbpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023652; c=relaxed/simple;
	bh=p3m3bZKppkj52lMR836XdfnP7gp1hS0XJHoaGGrp8pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWc9aro9cYaO05HHHXNbP6lsTkAGtwmkMAK4g+xHcM43jb5w8MalUd8TXSsp2EUZnFBCNwC9xO8zQM3+oCfJqAtiD34G1l++T2dRWb9YCOX17GPJ5OuUW3ObxGpsWYJJUU4oMCyvIHiyfooMHedBE5rd1F/7widiFwdgO2w5Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZPGQIIdG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZPGQIIdG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D685F2AE84;
	Wed,  3 Jul 2024 12:20:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p3m3bZKppkj52lMR836XdfnP7gp1hS0XJHoaGG
	rp8pc=; b=ZPGQIIdGi6zXVLopJrnxE3K71YFyF5QoisFNad2ph1WzaO2Bh9NRxE
	acAFc71cPlIafN5ufhoHmzkHY1aflMw7NS3ru2GaF4mxuAH+0dl9nnXYTlqxNqtH
	kYQV7X83SG0d34RPGwaJnC87iK1d9E6Vnn3j2AUyEnTK47k5xyP3w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCA752AE83;
	Wed,  3 Jul 2024 12:20:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 103142AE82;
	Wed,  3 Jul 2024 12:20:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
In-Reply-To: <20240703062958.23262-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 3 Jul 2024 11:59:53 +0530")
References: <20240703062958.23262-2-shyamthakkar001@gmail.com>
Date: Wed, 03 Jul 2024 09:20:47 -0700
Message-ID: <xmqqle2ie9b4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3597E07A-3958-11EF-B68E-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h.
>
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
>

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Reviewed-by: Josh Steadmon <steadmon@google.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>

The trailer lines should come more-or-less in chronological order.
I do not know exact sequence of events, but mentoring would have
happened first before the initial iteration was posted, then Phillip
helped to improve it during iterations, the latest was reviewed by
Josh and then you folded the little test improvement from me and
Phillip?  And to seal the whole thing off, you add your sign-off at
the end.

Technically speaking, any change after a review invalidates an
earlier "Reviewed-by", but the updates we see here, relative to the
iteration that received the "Reviewed-by", are not significant or
large enough to warrant that, so let's pretend that Josh would be
happy with the end result, even with our little additions.

Which leads us to the trailer lines ordered like so:

    Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Reviewed-by: Josh Steadmon <steadmon@google.com>
    Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>

The changes since the previous round look exactly as expected.
Looking very good.

Will queue.  Let's mark it for 'next'.

Thanks.


