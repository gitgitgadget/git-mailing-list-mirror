Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B926AC6
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569026; cv=none; b=t5WTbswR0VSzap2ZqEPBxk/WZ3A4dG8jY2txvblP6J1harwNJIKiSrFCrAaNNTMTsUEbA52fg/5CJJk12/6heunN1G7XaIYSmiaz4+Gk7SX3y+KrczphmJ6kXtX+cRJcU6qql1ZxyiAN/jm6RhVlWQeM/zEz7mKk2oUnaNUDtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569026; c=relaxed/simple;
	bh=wyFJpfI2kk6GbEX6bupv1da0y9YbZK+AxdOdp2qG4Xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GSMpGntbGiCXjjhhr7ixL3iMWieY4M2RRLf5K3X2j7IelJW3ew4Hrw5k81lrRydCOF+BmgQBhOy1BENY5He6HOAb3/PyZwCYs4Jj28EpmB7nL3+DNqf5EceS2z6MUa/FACK3NR52HAbDQIKt1XJ8SxuNevrNF7lQJ4YpLYsBBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j7j0jIok; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j7j0jIok"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58A6128260;
	Tue, 13 Aug 2024 13:10:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wyFJpfI2kk6GbEX6bupv1da0y9YbZK+AxdOdp2
	qG4Xc=; b=j7j0jIokOJ7PETtbOt+bugAELgYAalNoVuwlEelcDXI+KO8dv2hppC
	x0fvLjsD4Dxt0d8xB6Xa0fqfHmmzPcIgeZsQKKe+H8ew7QzFDGj+/IAf7XumfuVD
	3PRP9W58V9JUXKjKNZQFNUnq+mO1jOsJ/8x6t8tAo2IIl1nccTpcY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FA562825F;
	Tue, 13 Aug 2024 13:10:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3BFB2825C;
	Tue, 13 Aug 2024 13:10:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/4] t: port reftable/readwrite_test.c to the
 unit testing framework
In-Reply-To: <20240813144440.4602-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 13 Aug 2024 20:04:46 +0530")
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
	<20240813144440.4602-1-chandrapratap3519@gmail.com>
Date: Tue, 13 Aug 2024 10:10:21 -0700
Message-ID: <xmqqsev85oxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECF9BB68-5996-11EF-844A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Changes in v3:
> - Order the header files alphabetically in
>   t/unit-tests/t-reftable-readwrite.c in patch 1.
> - use check_char() and check_int() instead of check() at two
>   instances in patch 1.
> - #include 'reftable/basics.h' in patch 2 when introducing
>   free_names() in the test file.
>
> CI/PR: https://github.com/gitgitgadget/git/pull/1770
>
> Chandra Pratap(4):
> t: move reftable/readwrite_test.c to the unit testing framework
> t-reftable-readwrite: use free_names() instead of a for loop
> t-reftable-readwrite: use 'for' in place of infinite 'while' loops
> t-reftable-readwrite: add test for known error

Will replace.

Let's see if we get any more comments and otherwise let me mark the
topic for 'next' soonish.

Thanks.
