Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69228DA5
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523968; cv=none; b=uR+Uy7Gvup+hlqWgCCsB6AQcU9z4De4Ot/fzgbjwEJRyjmmO7JGAVkPyltOm3hMijbYf9q5RIojPzKgXjaOh81dInRv8klcGc0w9MJz3ZzjYi0BEzKWOk2zVWzCZxDnRZzIt5rr4PcqRCyQGgWURI8M8TCp5iYAdezQkg7rBBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523968; c=relaxed/simple;
	bh=OS2fj+Zmj63obF9k5HP5j50lQo6BViC20qqcRCF/FC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6wMuK8Bv42pgdjQY5h3L3u8vl4kJwEfgtZw/MUCkPaiTzCkVVFsckte/VfgkZE42sW59PYE96vlBJq9HZmcLvBM9z+YodiPdEt5qRBgSnWI4pS0t0/D7yT9EDGfx7LTl32xdu3g68OlG8MZvmdLQNOcCIMcFuqroB7kDhfZzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kq5oQDaG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kq5oQDaG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E109B2D489;
	Thu, 27 Jun 2024 17:32:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OS2fj+Zmj63obF9k5HP5j50lQo6BViC20qqcRC
	F/FC4=; b=Kq5oQDaGHQ7CG/x3jGMPH0Gpels8+FpaJ0aWPyUdRZZG30c4o3kntR
	2TOinBk+uexJOEmW4yvdF5DqD5ujfr6nnievsoTB0t8zn/8RAScDJf2iKoL13b5H
	muQ4jjE+XhqyW2n1GczlNiMBptJLB1gkMR7InIspJVgdk2J2LAjKY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D801A2D488;
	Thu, 27 Jun 2024 17:32:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E39D2D487;
	Thu, 27 Jun 2024 17:32:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v5 01/12] fsck: rename "fsck_options" to
 "fsck_objects_options"
In-Reply-To: <Zn2BXRatUdX16PD3@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 27 Jun 2024 23:12:29 +0800")
References: <Zn2Ah3WDhtOmzrzn@ArchLinux> <Zn2BXRatUdX16PD3@ArchLinux>
Date: Thu, 27 Jun 2024 14:32:44 -0700
Message-ID: <xmqqa5j6rs03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CADF2DE0-34CC-11EF-996E-965B910A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> -static int fsck_error_func(struct fsck_options *o UNUSED,
> +static int fsck_error_func(struct fsck_objects_options *o UNUSED,
>  			   const struct object_id *oid,
>  			   enum object_type object_type,
>  			   enum fsck_msg_type msg_type,

It is curious that the addition/renaming of fsck_objects_options is
presumably to allow fsck_${xyzzy}_options to be added for different
$xyzzy (the first one being "refs"), and this function is only about
fsck_objects_options.  What name would the corresponding error
function, called by checkers that take fsck_${xyzzy}_options, be
given?  fsck_${xyzzy}_error_func()?  Shouldn't this be then become
fsck_objects_error_func() or something?

Having said that.

Do we really need such a parallel system between "objects" and other
kinds of things being checked that you are introducing with this
step?  What benefit are we getting from this additional complexity?

I would have expected that adding ref-related new members that
object consistency checkers has no interest in to the fsck_options
structure would be sufficient for the purpose of this series.  Or if
we really wanted to prepare for more complex future, use of the
"union of variants, switched with a tag" pattern to arrange the data
this way:

	struct fsck_options {
		enum fsck_type {
			FSCK_OBJECTS,
			FSCK_REFS,
			...
		} t;
		union {
			struct fsck_objects_options objects;
			struct fsck_refs_options refs;
		} u;
	};

would still allow functions like fsck_error_func(), and
fsck_set_msg_types(), etc. to work on the common "fsck_options".

I dunno.
