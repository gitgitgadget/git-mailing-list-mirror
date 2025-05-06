Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC57262D
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560375; cv=none; b=DZEskNa6MjrQsNt6G8sD86VBHJTTYICsWxnQxuzno1pBDluBOvb+csVeMAy/KYI/x/ErjJgm2dddqSnSoMptjtuDiKsqQSiXO42ZkED/WaRQoeBPI0KJxWQzYD56vah9ZewQvu6sM5V+sSjvt73saJZe19g8nKMY85g7JgDG9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560375; c=relaxed/simple;
	bh=cXS0Z0woIoXfk4oNLLgqFntw8ToO9gC13iLZ4xiScw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnqo6ASHfUFXqTGuYCscFAhhlCp41JiJKzZjXhH/xtPYLAEeFha0hI3g6tzkNw4JQPv9OaizYoAP7CbRhmhnguXgcwmU4FaR+00sOnui8Gv2Iana91cpw98WEDxgK/UfFLrWvEfUbcNv1Fcf6Ls0Cwbmmx6Va/OyGtBkKmt5vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPHFgptS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPHFgptS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7080dd5f9f1so42609267b3.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560373; x=1747165173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0T17t9wzvkDZLolNGxTfJ96ElOVERc7EWVaR8u+Nf4=;
        b=JPHFgptSnA6/6rrNAwtB8fVRFmfIrQq/DtBb8cMLf0oFuakKESMT6WwlJUWPAclqNv
         vEg2fQ9l6Ao68C8UYOCEe3T1wQb9dmfsQCsraBwTZB6TvQHQ2+Nrbt6vjsnJNklSCWh6
         SBwFofRnM+ri+bItKA+kI15M6e4uV4i8Fde/4l15UbFnqPvbPwrTMnSZGyc5RE6cbQh+
         +P1vxc+jkWdg1HT/DDlsbUcN4+bUXH6gimh28mPDOh8nqAPvaXklmNV+0Ta8E1eVYl3n
         8Oz/mQYZZ5/3sr+XzInm6k0EPhmdOUnfAGLuuzT6eH19FZ7k00VkKVRcDrEVufEDyns1
         AvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560373; x=1747165173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0T17t9wzvkDZLolNGxTfJ96ElOVERc7EWVaR8u+Nf4=;
        b=HqHYyh6TsnlwdYrAbpv4R+roAnQ+gfsEIliqKJbQW9JgT5j1MLVuIrcsTl/P/IbaEf
         gGfscwiwXeJ3Np4HGbQX4hC4yXXdCUsBBU2Ffw91wodOs5LavkACuGS2xYaa6XEj73jL
         BYE2Y8GA2NWmcBtUagVEsfOAePW3cPvTmh3H9SpIpRNfbsnIMKharzqo5EfyMpGR2OBf
         zg1c/sL3teQ/qyl2vi9vAYIg/Za9h2rGLbbdDIaXy4mtiVjyDHlZ1ZcITjGg693nz2HW
         nDQAGUxGK1RWc0qKOu/BeJi06K7ToxmW4wmmKLPq5h8itTHvDwhde2K6Z4h/jVPlpUDr
         2/BA==
X-Gm-Message-State: AOJu0YwGrh72ivmlyLBz2Dvf55BlaYX3K9ANaujhK0La1/y2jAdiHOy7
	/+MP2MvdWt9wDqV0QK9O0BVx+N9G66Tzsh5vrpMCgZp/lzMn1Gsk
X-Gm-Gg: ASbGncsmSyEi1T6IkF+GR3RCSsO7e08yTcrPqW3pYvWaNKW57iyy4QyFOscbgDWVquS
	3Z/QxDtYDJv6A9hlnkSD9uzGQMXD+1x6EIe1s6t106mbBRdWTUyol872H9hr2PwBqKSS8dQ7UhM
	RilXo+U6wq0Q/uGseBCgsFNRaZ0wxMQtXSFstjeBlsJd2XPaMObMqveKF6pAg4RFX3PnZy9L1tA
	gWglKxhyZ315DKIZLIOO6vWvHslqWZ58CgIiFwtEwXM2QWG0X1zimoRXqPsxw4r5wgrirHmgI1c
	2O6zITsjXphs4LxlLmLhThxLufs8KbvjNhTQplRxjv02ZHD6TfqauZSTem4bMkoCCF0Lzp9Iiye
	jTRp+bjPBp2qmMZWYDqv6xmoT+nwv
X-Google-Smtp-Source: AGHT+IHLHCMU8fVzOlLKg3ZjcwjGT0sFUWcwXTUnbXzNYhxfVUyHr9JzjS/nqY/X+bR9shZ2x5HKlA==
X-Received: by 2002:a05:690c:4889:b0:6fe:b761:5798 with SMTP id 00721157ae682-70a1daa7650mr9569477b3.21.1746560372740;
        Tue, 06 May 2025 12:39:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c4033a6bsm28449297b3.38.2025.05.06.12.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:39:32 -0700 (PDT)
Message-ID: <052c534a-c2a4-4ff6-9130-4c1e96e1ef72@gmail.com>
Date: Tue, 6 May 2025 15:39:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] pack-objects: add --path-walk option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <a271d6245c243d50d95ea6c7e624b3165f7da558.1742829770.git.gitgitgadget@gmail.com>
 <aBVTcvhW+lW0GLpQ@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBVTcvhW+lW0GLpQ@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 7:21 PM, Taylor Blau wrote:
> On Mon, Mar 24, 2025 at 03:22:38PM +0000, Derrick Stolee via GitGitGadget wrote:


>> +--path-walk::
>> +	By default, `git pack-objects` walks objects in an order that
>> +	presents trees and blobs in an order unrelated to the path they
>> +	appear relative to a commit's root tree. The `--path-walk` option
>> +	enables a different walking algorithm that organizes trees and
>> +	blobs by path. This has the potential to improve delta compression
>> +	especially in the presence of filenames that cause collisions in
>> +	Git's default name-hash algorithm. Due to changing how the objects
>> +	are walked, this option is not compatible with `--delta-islands`,
>> +	`--shallow`, or `--filter`. The `--use-bitmap-index` option will
>> +	be ignored in the presence of `--path-walk.`
>> +
> 
> This is perhaps a stylistic difference, but I don't think in general it
> is necessary to say "by default [...]" to explain some existing
> behavior, unless the alternative behavior enabled by the flag is
> impossible to understand without contrasting.
> 
> In this particular instance, I think that "--path-walk" can be
> explained in isolation rather than in contrast to the default behavior.
> 
> I would probably write something like:
> 
>      --path-walk::
>      Walk objects in batches grouped by a common path. This can improve
>      delta compression, especially in the case where filenames cause
>      collisions in the default name-hash algorithm.
> 
>      Incompatible with `--delta-islands`, `--shallow`, and `--filter`. If
>      provided, `--use-bitmap-index` will be ignored.

Sure. I'll give this a shot.

>> +static inline int is_oid_interesting(struct repository *repo,
>> +				     struct object_id *oid)
>> +{
>> +	struct object *o = lookup_object(repo, oid);
> 
> This function and its caller tripped me up a little bit while reading,
> but I was able to un-confuse myself. Here are some notes that I took
> while reading, which perhaps you can validate to tell me whether or not
> I'm on the right track.
> 
> Here we allow lookup_object() to return NULL, and then immediately
> return 0 if it does. But...
> 
>> +	return o && !(o->flags & UNINTERESTING);
>> +}
>> +
>> +static int add_objects_by_path(const char *path,
>> +			       struct oid_array *oids,
>> +			       enum object_type type,
>> +			       void *data)
>> +{
>> +	struct object_entry **delta_list;
>> +	size_t oe_start = to_pack.nr_objects;
>> +	size_t oe_end;
>> +	unsigned int sub_list_size;
> 
> Could you help me understand why sub_list_size is an unsigned int and
> not a size_t here?

This is based on a similar "list_size" used in ll_find_deltas(), but
since we are starting from scratch here it would be better to use
size_t.

>> +	unsigned int *processed = data;
>> +
>> +	/*
>> +	 * First, add all objects to the packing data, including the ones
>> +	 * marked UNINTERESTING (translated to 'exclude') as they can be
>> +	 * used as delta bases.
>> +	 */
>> +	for (size_t i = 0; i < oids->nr; i++) {
>> +		int exclude;
>> +		struct object_info oi = OBJECT_INFO_INIT;
>> +		struct object_id *oid = &oids->oid[i];
>> +
>> +		/* Skip objects that do not exist locally. */
>> +		if (exclude_promisor_objects &&
>> +		    oid_object_info_extended(the_repository, oid, &oi,
>> +					     OBJECT_INFO_FOR_PREFETCH) < 0)
>> +			continue;
>> +
>> +		exclude = !is_oid_interesting(the_repository, oid);
>> +
>> +		if (exclude && !thin)
>> +			continue;
> 
> ...here we only skip calling add_object_entry() if the object is
> excluded (which lookup_object() returning NULL would cause above) *and*
> we're not using thin packs. That makes sense, since if we have a missing
> object, but we're using thin packs, then it's OK to skip.
> 
> So I think all of this looks good. However, I find the interface here a
> little awkward. The function is called "is_oid_interesting()", but it
> determines that fact by checking whether or not the object has the
> UNINTERSTING bit set on its flag, and then negating the result. But then
> we negate it again here at the caller to obtain whether or not we should
> "exclude" the object.
> 
> I was wondering if there were other callers of is_oid_interesting() that
> don't negate its result. But it doesn't look like there are (at least in
> this patch). I wonder if it would be cleaner just to inline this instead
> of having the result negated at multiple levels.



>> +		add_object_entry(oid, type, path, exclude);
>> +	}
>> +
>> +	oe_end = to_pack.nr_objects;
>> +
>> +	/* We can skip delta calculations if it is a no-op. */
>> +	if (oe_end == oe_start || !window)
>> +		return 0;
>> +
>> +	sub_list_size = 0;
> 
> I'm nit-picking, but I would imagine that sub_list_nr is probably more
> conventional, but this is textbook bike-shedding ;-).

Sure.

>> +	ALLOC_ARRAY(delta_list, oe_end - oe_start);
> 
> ALLOC_ARRAY() will barf if oe_start > oe_end and we wrap around the
> range of size_t, but it might be nice to have a sanity check here just
> their equality.

I'll look for similar examples.

>> +	/*
>> +	 * Find delta bases among this list of objects that all match the same
>> +	 * path. This causes the delta compression to be interleaved in the
>> +	 * object walk, which can lead to confusing progress indicators. This is
>> +	 * also incompatible with threaded delta calculations. In the future,
>> +	 * consider creating a list of regions in the full to_pack.objects array
>> +	 * that could be picked up by the threaded delta computation.
>> +	 */
>> +	if (sub_list_size && window) {
> 
> Do we need to check that window is non-zero here? It looks like that
> check already happens above.

If we've already checked, then

>> +		QSORT(delta_list, sub_list_size, type_size_sort);
>> +		find_deltas(delta_list, &sub_list_size, window, depth, processed);
>> +	}
>> +
>> +	free(delta_list);
> 
> Is there a return path through this function that doesn't allocate
> delta_list? I think the answer is "no", but it might be a nice guard
> against future refactorings to initialize this field to NULL just in
> case.

OK.

>> +	return 0;
>> +}
>> +
>> +static void get_object_list_path_walk(struct rev_info *revs)
>> +{
>> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
>> +	unsigned int processed = 0;
>> +
>> +	info.revs = revs;
>> +	info.path_fn = add_objects_by_path;
>> +	info.path_fn_data = &processed;
>> +	revs->tag_objects = 1;
> 
> What is the purpose of setting revs->tag_objects to 1 here? Do we need
> to restore it back to its original value before returning? A comment
> here would be useful, I think.



>> @@ -4237,7 +4340,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
>>
>>   	warn_on_object_refname_ambiguity = save_warning;
>>
>> -	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
>> +	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))
> 
> I was going to suggest something like:
> 
>      if (path_walk && use_bitmap_index) {
>          warning(_("cannot use --use-bitmap-index with --path-walk, ignoring"));
>          use_bitmap_index = 0;
>      }
> 
> , which would avoid the need for this check here and insulate us against
> having to make similar changes to future conditionals that care about
> use_bitmap_index.
> 
> But it looks like such a check *does* already exist below, so I am not
> sure I understand why we need to check for path_walk here.

This is probably cruft from an earlier version of the check. Thanks.

>> +	if (path_walk && filter_options.choice) {
>> +		warning(_("cannot use --filter with --path-walk"));
>> +		path_walk = 0;
>> +	}
>> +	if (path_walk && use_delta_islands) {
>> +		warning(_("cannot use delta islands with --path-walk"));
>> +		path_walk = 0;
>> +	}
>> +	if (path_walk && shallow) {
>> +		warning(_("cannot use --shallow with --path-walk"));
>> +		path_walk = 0;
>> +	}
> 
> Here's a tiny idea I had while reading this code.
> 
>      if (path_walk) {
>          const char *option = NULL;
>          if (filter_options.choice)
>              option = "--filter";
>          else if (use_delta_islands)
>              option = "--delta-islands";
>          else if (shallow)
>              option = "--shallow";
> 
>          if (option) {
>              warning(_("cannot use %s with --path-walk"), option);
>              path_walk = 0;
>          }
>      }
> 
> This may be too DRY for your taste, and it does have the disadvantage of
> reducing the grep-ability of the error messages. I don't have a strong
> feeling about it one way or another, but I figured I'd at least write it
> down.
I like the reduction of work on the translators.

Thanks,
-Stolee

