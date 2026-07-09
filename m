Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AD449981
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623573; cv=none; b=Qz1UTnbbaR5O+ZI2tBKfNZWH+v5NcUp6jB4qARZKXwqX2HulbZ61huEnbH5+IQmfiDqAMJ53kFzkfRK/wkCgn51FYwxA4+2X6jw58po6Ik2wtWBbTbfzztS4KjoEuokx/wOE4he1jX/EDCNk6TaMDKzw/j5cbWyS/2vitx97fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623573; c=relaxed/simple;
	bh=ApaQzsfMpjjftBXWIGTt46mc0LM/zxBRdi2Zv1b50dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FdYgttjfc4TCd6XDPSNS6pDTkj/+vfbS4VT4rT1x0oHnsjzHAKuMc/t51IQUrfrKxkjA/D5JM9h+rYo/ajJM3M8i05a8PtzmNpgXjXov+8th589I5FyIORjhlFrzoxP4gVhcsC0HemhmL7fxKvUAkQ/yU3Xm4N3w8nrqb2c6tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XRhyOs+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJ76E3yG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRhyOs+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJ76E3yG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AF8FEC021D;
	Thu,  9 Jul 2026 14:59:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 14:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783623571; x=1783709971; bh=ejsMEkbskQ
	3JuhyT2i3RjKKB3bkGQxjNILboiQMQfv0=; b=XRhyOs+kKCWm95DA5RTsJ2ZsIP
	ELr8wBmKyLYHu/s8MfJu/oruVuh0H3Ck0gogld5sjhDzkBeqAmTh6Ozzyt7mNnXD
	kcmsEhoqlYhchSQvPrYSSdG4LQl73GK6kZf8UXtWR9d1SXab5s9jEIKW7eMFhGR2
	gZCuqHVRHJdHWYKqC9Kevlh/9TCbH33F0EWntsn3Q7Wve6D1rK1zg511+y/DF+dy
	h95JNkynW8oAp0L2IHT+akUk1vMEhZN+G9UB76gEOm8vPIDxqLT3kR8HDf7sOeUl
	usqcte+PXMtYpcY7dngfzCliNy3y3ItoGys7CI16Uk9PrTXmZNt5pQuiCksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783623571; x=1783709971; bh=ejsMEkbskQ3JuhyT2i3RjKKB3bkGQxjNILb
	oiQMQfv0=; b=iJ76E3yGtaZ+6KKvpf8NkxNVSCiTzdnu8fBLvPubo54mjtkEfe9
	G9/Xex9KRCGVPZyyfqkFU18zG2UmIhqT+iMQy7ldiRtHZCTaemTKblK4z3BR8e2d
	b5YfcKNKKPbcEf2Nxahs1g/mruJGN+hvYAXckvUeXeQt0tPkE4Ka6Rd7kq7JfdFc
	+eTWmrLvkHDQNYbcs10qZjHaU6AGD6u/UxOh/oUghtuFxQz4x/c54ftl99GWLNib
	JpvxB7TuYSYkOwLTxQ8CHTSPD8wta3deaa27AOF6chfP/pVzVP9n/69ZP0zXpWzX
	e+SRKfCwUbJDKxzwlOvmTKhiCuVPsWB4kWw==
X-ME-Sender: <xms:k-9Pag2k3E5z_4W1OJHBhjHKgs_LS099myQubmU4NEstH2Z2MIJ_4g>
    <xme:k-9Paih_IwMplqPP1jJ4vke7g6SChy3IUzQ32NxU101bQ4J_oAisQKuZODL6Dop0u
    UPRe8MfryeNDJZk2C4QszhcP4rgKDuSxecE8sRveZyI_Ssu9jt8xg>
X-ME-Received: <xmr:k-9PamQcuVdgKvgNI2gXN0YkGQ5-uZmcTVcQVRSTWSjMBYeJeVdMqOBcoBLwPfpjE8brfQtNiw9uARYvnoKYa8h59oh3O-tySahJD6Q>
X-ME-Proxy-Cause: dmFkZTFzWu62xClWjzdZ3U5V5gRtS89z7wqRNSMMIu5z/rlvl87iYYz9/S6BR5OssTM4qE
    upnvLmHbgQWAqCbqYntmdKCnzmndUeZa1X67Ar56YluS0mLT3dPlwvUmjPg3e/J5qAAKkY
    PC6REHLqBLqFxPX4AM1qFNuVgY6usDelbIFiggUfXsUZwM0PAqWd7jvwDRO71MzQyXNxdG
    S48L08gEAAq45eojePeEOWyIHcB/l/IX9f9rvzAqXhC+m9kxm1efLPmGSbvMPF6d+mZHtv
    op5wUp+TwtjyiFo4NV8x1PveR1t2qIFHI8DJIBXzeJOMadCbZgCKl7U4ZVkcUJLpZqDrsq
    WwetuvcX3XiqJETEA0E8VnuclAWsqznzBo4kZQZ035eJeezDj0G7th/1m8urc0lYheAAaI
    J3JsKg55uxJaXcw3n6Uhuiogwq4lRGTsyhfAyPwelTPNJx2R3QEM413bINWAbUTQusIhq/
    y3+oipmF1YkA20QM8gRXma4WGjhiDhDIYYMFpa9RZIHzjY5iTJsXEZ7e9/Gk5Azc2wVaEl
    no9zKdCqLoOL900jk1nnSS64tK3ErkdU70KdxqjvLKKAW/VmyCw38Eb3d3ziUktafGXW03
    HHt/d0yahXtLVMiaR1Y83wDsqpO+UOUOPFFPq7xPsuSz3felm3HwqbRxZogg
X-ME-Proxy: <xmx:k-9PajhyTXZLbDcGsQtbO6L1rS-5DkuPC6pG5aGDeWEHvpvL36RwcQ>
    <xmx:k-9Pam5tmTnRxt67HfmI2-qaG62twwBY70aCwpq9L39wUnkVH3_-zg>
    <xmx:k-9PagDtna5kId7t9zijwrIU3ULI8HrBIY5X4jscwKrSYKcIn-Xz7Q>
    <xmx:k-9Patby_iW1AuuNXWoQxCkdMfpT7ztlG-D-Fteo1k-IOao4idsfvg>
    <xmx:k-9PaiqhFUeCgMSE5LOMTO8toU5HyIJ0aDapYbyUOkJXlrB-L3-oflBu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 14:59:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/cat-file: filter objects via object database
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-7-82fe014b12b3@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Jul 2026 10:35:27 +0200")
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
	<20260709-pks-odb-for-each-object-filter-v1-7-82fe014b12b3@pks.im>
Date: Thu, 09 Jul 2026 11:59:29 -0700
Message-ID: <xmqq33xsoupa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Refactor git-cat-file(1) to use the new object filter option when
> batching all objects. This significantly simplifies the logic and
> ensures that we don't have to reach into internals of the "files" source
> anymore.

This would become more convincing if you spent a few lines before
presenting the solution to give an observation of what the current
code does, e.g.,

    When batching all objects, git-cat-file(1) reaches into the
    internals of the object database and manually manages bitmaps to
    apply object filters. This creates coupling between the command
    and ODB backend internals.

to highlight the perceived problem in it.  That would flow naturally
to the description of your solution.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 76 +++++-------------------------------------------------
>  1 file changed, 7 insertions(+), 69 deletions(-)

Very nice.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b4b99a73da..1458dd76d6 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -20,7 +20,6 @@
>  #include "userdiff.h"
>  #include "oid-array.h"
>  #include "packfile.h"
> -#include "pack-bitmap.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -844,28 +843,6 @@ static int batch_one_object_oi(const struct object_id *oid,
>  	return payload->callback(oid, NULL, 0, payload->payload);
>  }
>  
> -static int batch_one_object_packed(const struct object_id *oid,
> -				   struct packed_git *pack,
> -				   uint32_t pos,
> -				   void *_payload)
> -{
> -	struct for_each_object_payload *payload = _payload;
> -	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
> -				 payload->payload);
> -}
> -
> -static int batch_one_object_bitmapped(const struct object_id *oid,
> -				      enum object_type type UNUSED,
> -				      int flags UNUSED,
> -				      uint32_t hash UNUSED,
> -				      struct packed_git *pack,
> -				      off_t offset,
> -				      void *_payload)
> -{
> -	struct for_each_object_payload *payload = _payload;
> -	return payload->callback(oid, pack, offset, payload->payload);
> -}
> -
>  static void batch_each_object(struct batch_options *opt,
>  			      for_each_object_fn callback,
>  			      unsigned flags,
> @@ -875,56 +852,17 @@ static void batch_each_object(struct batch_options *opt,
>  		.callback = callback,
>  		.payload = _payload,
>  	};
> +	struct odb_source_info source_info;
> +	struct object_info oi = {
> +		.source_infop = &source_info,
> +	};
>  	struct odb_for_each_object_options opts = {
>  		.flags = flags,
> +		.filter = &opt->objects_filter,
>  	};
> -	struct bitmap_index *bitmap = NULL;
> -	struct odb_source *source;
> -
> -	/*
> -	 * TODO: we still need to tap into implementation details of the object
> -	 * database sources. Ideally, we should extend `odb_for_each_object()`
> -	 * to handle object filters itself so that we can move the filtering
> -	 * logic into the individual sources.
> -	 */
> -	odb_prepare_alternates(the_repository->objects);
> -	for (source = the_repository->objects->sources; source; source = source->next) {
> -		struct odb_source_files *files = odb_source_files_downcast(source);
> -		int ret = odb_source_for_each_object(&files->loose->base, NULL, batch_one_object_oi,
> -						     &payload, &opts);
> -		if (ret)
> -			break;
> -	}
> -
> -	if (opt->objects_filter.choice != LOFC_DISABLED &&
> -	    (bitmap = prepare_bitmap_git(the_repository)) &&
> -	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> -				       batch_one_object_bitmapped, &payload)) {
> -		struct packed_git *pack;
> -
> -		repo_for_each_pack(the_repository, pack) {
> -			if (bitmap_index_contains_pack(bitmap, pack) ||
> -			    open_pack_index(pack))
> -				continue;
> -			for_each_object_in_pack(pack, batch_one_object_packed,
> -						&payload, flags);
> -		}
> -	} else {
> -		struct odb_source_info source_info;
> -		struct object_info oi = {
> -			.source_infop = &source_info,
> -		};
> -
> -		for (source = the_repository->objects->sources; source; source = source->next) {
> -			struct odb_source_files *files = odb_source_files_downcast(source);
> -			int ret = odb_source_for_each_object(&files->packed->base, &oi,
> -							     batch_one_object_oi, &payload, &opts);
> -			if (ret)
> -				break;
> -		}
> -	}
>  
> -	free_bitmap_index(bitmap);
> +	odb_for_each_object_ext(the_repository->objects, &oi,
> +				batch_one_object_oi, &payload, &opts);
>  }
>  
>  static int batch_objects(struct batch_options *opt)
