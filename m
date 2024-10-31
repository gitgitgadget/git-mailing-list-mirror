Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10119883C
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367278; cv=none; b=kmlyULI/jhp8jh53vxmbQHvF3OX+TCQ2IC1do/hLWjaGouwOQ3IRQ6HZR7UT+aLbqA+CWQwzRncA0AJCM3cl2W8EF/2WCEQExH921iJHjGBJ4p+1AbP/eKkeBT0NvqnFVnS6JXqkzXVxFJpaeyLIRIkdbZfFgc/nx9SMsRN3ZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367278; c=relaxed/simple;
	bh=Cee6wJ/MEX657jfcu9Kj1ixuYZBDupm3nwY42Uf/2B4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okun0rfyj3GGImtfZyye4bkTdEayoJl3+/iiycOX6w/6eZViXg3bcs/7K11v22PdA8UNz8dXGdxTT7FeJ6264MoamMuZpZNAg1MAMCfHOxOeTGHO16W61r6sFqBwn0uyyPUkmkgt49EXdiUWMGaX9owdg4XjCFia09+4yyRX+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cREq+MZ5; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cREq+MZ5"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50de14e7d8cso239220e0c.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367275; x=1730972075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa8yGAA0P9cHAymjEGbbh82i1x5DybTx1kl+k4+p0Xk=;
        b=cREq+MZ5u2EGRyYkUDWpm87Tk4OmXufaOVJ/xpizK0TVcvLX1IPdQceay2GdIYV+dG
         dWtKl44UDBAJ3xAv70OxXllT3uohXmjIl+Ba5CBtGi7R8V+pfPF6scxYjTLKbGI6rEWj
         L3rXHHfQ+EYAPv3+XA5Eoau9XIC8IcC7ayG7JKTSbAWSXhgH5nP40Hc245cHgRqWmlgP
         JTnvGH+E3gIPFzaFXRqY3oD9siDgEyMjwEwp1YbA779IxlQYK6FCjobkBwJkQpa65wAW
         nA5X4cHx8/HloVY0OMe/PN9iGJKh5ezJSCTuZ9oe+Ftw0SFjPHE1PZ9zHLb+peYmTdkl
         o6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367275; x=1730972075;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oa8yGAA0P9cHAymjEGbbh82i1x5DybTx1kl+k4+p0Xk=;
        b=LNJ1mUeURKNqdUXWPyY9lDKeb3obSvHCPfKhsw0UWB6YSQUOsPbFTgPZ6PCXsAszvQ
         n7aHW+QqFgIEXJhYQtVSR3dsq0B1wt+NlS0piiTBty0AncQFSQ+XDYcgMaWKheoGVzA8
         GcsiWQnzfEJ73HvUNPQUlJRY/S/7cl8SBXDP7XYDc3CaI7/G6Hb8gVRcH1f/gJdJzo5M
         CqQ3yzhNvsDf/FRGIRjzNzzgAufMKhvbu3UmARxF3EGbGt/EOv4NWDcjUdoYguyzP2bl
         igtf4uLwBQ7mMguA0dYuxsV3Gc40wE/2QCXnMR9hxAke5wUFSEgIL3vf0kIc2XnU/utW
         xE2g==
X-Gm-Message-State: AOJu0Yz3sSCjZ4FXtExCLn7aXGDdWWxOX6reUs+MIgl2ufLl04QXba15
	o8+hCjSjYHBR32KPZ2Ds3JLKVtCuKGm/bV72O4eQ14lOm5pSR8Kzpmi6QVeWsKENd8DnHAkkRnp
	wCwV/zDEx+LszyKo1+oDh5aEgoOw=
X-Google-Smtp-Source: AGHT+IESYCgDSbHzDfN+7zv+1Zc8aHLkMO7ftX00hJReuRQ61sCDjwjftCkRsE63mWeN/9wLumaR8uViafbh5PhuxiI=
X-Received: by 2002:a05:6122:659a:b0:50d:c2e6:2730 with SMTP id
 71dfb90a1353d-5105d002b39mr7570576e0c.2.1730367274901; Thu, 31 Oct 2024
 02:34:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 31 Oct 2024 02:34:33 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZyKTTYGPDQ0SWJCZ@nand.local>
References: <cover.1730297934.git.karthik.188@gmail.com> <c0b386412d5c464aa838dbe7c7679d4c8618a2c7.1730297934.git.karthik.188@gmail.com>
 <ZyKTTYGPDQ0SWJCZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 02:34:33 -0700
Message-ID: <CAOLa=ZT6_JkyLoBTTAkfRJhuw9xvvYe95N32w8sT5gHmiKt1Rg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] midx: add repository to `multi_pack_index` struct
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000c08cc40625c2864e"

--000000000000c08cc40625c2864e
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Oct 30, 2024 at 03:32:34PM +0100, Karthik Nayak wrote:
>> The `multi_pack_index` struct represents the MIDX for a repository.
>> Here, we add a pointer to the repository in this struct, allowing direct
>> use of the repository variable without relying on the global
>> `the_repository` struct.
>>
>> With this addition, we can determine the repository associated with a
>> `bitmap_index` struct. A `bitmap_index` points to either a `packed_git`
>> or a `multi_pack_index`, both of which have direct repository
>> references. To support this, we introduce a static helper function,
>> `bitmap_repo`, in `pack-bitmap.c`, which retrieves a repository given a
>> `bitmap_index`.
>>
>> With this, we clear up all usages of `the_repository` within
>> `pack-bitmap.c` and also remove the `USE_THE_REPOSITORY_VARIABLE`
>> definition. Bringing us another step closer to remove all global
>> variable usage.
>>
>> Although this change also opens up the potential to clean up `midx.c`,
>> doing so would require additional refactoring to pass the repository
>> struct to functions where the MIDX struct is created: a task better
>> suited for future patches.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  midx.c        |  1 +
>>  midx.h        |  3 ++
>>  pack-bitmap.c | 97 +++++++++++++++++++++++++++++++--------------------
>>  3 files changed, 64 insertions(+), 37 deletions(-)
>>
>> diff --git a/midx.c b/midx.c
>> index 8edb75f51d..7a34473010 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -131,6 +131,7 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
>>  	m->data = midx_map;
>>  	m->data_len = midx_size;
>>  	m->local = local;
>> +	m->r = the_repository;
>
> Same note here about calling this 'r' rather than 'repo'.
>

My bad, I'll fix it in the next version.

> I do wonder if it creates any awkwardness to have the_repository
> assigned here unconditionally when we do specify the object_dir. I think
> it's OK so long as we don't start replacing 'm->object_dir' with
> 'm->repo->objects->odb->path'.
>
>> @@ -1980,18 +1997,23 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>>  	if (!use_boundary_traversal)
>>  		object_array_clear(&revs->pending);
>>
>> +	repo = bitmap_repo(bitmap_git);
>> +
>>  	if (haves) {
>> -		if (use_boundary_traversal) {
>> -			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
>> +		if (use_boundary_traversal)
>> +		{
>> +			trace2_region_enter("pack-bitmap", "haves/boundary", repo);
>>  			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
>> -			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
>> -		} else {
>> -			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
>> +			trace2_region_leave("pack-bitmap", "haves/boundary", repo);
>> +		}
>> +		else
>> +		{
>> +			trace2_region_enter("pack-bitmap", "haves/classic", repo);
>>  			revs->ignore_missing_links = 1;
>>  			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
>>  			reset_revision_walk();
>>  			revs->ignore_missing_links = 0;
>> -			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
>> +			trace2_region_leave("pack-bitmap", "haves/classic", repo);
>>  		}
>
> Odd braces?
>

Indeed. Will fix this too.

> Thanks,
> Taylor

Thanks for the review.

--000000000000c08cc40625c2864e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cc1a2f4ea88f690e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jalR5Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2FrQy85UU1ZZDhzOElRUUZCSi9GNFhMZTdkS1YwbQpsSHZyM3dJNXIz
WmtQSHJ4dXgyTHJ1OHRQRjNKVG85bDVIVWhkcHFYai9XS1NjNk1kN0RlSVprTzNSRk1Pd01CCjlF
em8wM2wzYzhQdzNXWUJWaTd1cjRZS1laeUdaNlRRbWNRTmM5cXYxYzE2ZER4QWxZcW5oemNOTkd2
UElrSTEKOURmT2x6aGsrRldySnNiTTdyU1h5VFFkU0xoSmZFMC9ZMU1IcnhoWFUxWlpwVis1SFE3
eWRDM0NnbWtIaVRNNgpSdkZ6UmpMOGh0ckNTd0dBMFZTb1oybHNvNHo1eHpTeFUyS0NDYTg4MnQ2
OEZoZUxRaUdyQkZTaWYwVjZsQlcwCjRqZlA5ZWQxeC8rdkV4RHFKQVRZYjQycFEyYzBIVFVUMEFC
dExhVW1YRkdzMmhobm8rVnRPeXc5d3BCSHdDUmkKTytPQ3YyRXZwNWRWcjNLVFVDNi9PL2N2L3FH
SnA5a3hmbVNvYldybkh5QTlJWGQzeUhTNG5KT1ZLRVJoQTA0TwpqTWt5d3IrVzQ2Sk1rQVNuUmNK
cUtyTDFXazJFUHZuTXZNSlFHT3ExSmhtUDN3R1NVZ3owejh2OTIyVHZ5bFBSCjBHVXR3MjZtN1Nu
aExnZG1PdU9WS2RtKzczeURJcjRQNjdtSnhkST0KPVNiWmsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c08cc40625c2864e--
