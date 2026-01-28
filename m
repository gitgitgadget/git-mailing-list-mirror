Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649E2E6CA6
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598253; cv=pass; b=ndavw1gcE7Q+PXAZqBPiZWVB5UmLeR/pKFSJM9IN7mwrLluSQE1zn6PTmiE0ezVLr9zqwh/QeJj38UTlZH8jeqqDGTT98f9Ih3pXluLc+j5U29zrUnLRghyA3TAigjVKUyEhuibFfjj586sZUAvEoKgTraBkZMSVNGykv333aMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598253; c=relaxed/simple;
	bh=249mpX1GDDnPTlYdX7ZeVRFSYV+MnJIPl4MgQr6PByI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeggVMUFnRkwHM+56qIBPtF+hpD4QV1xweB05pZ88l5b9V7rsKnjYQLeHDASgobPthhktgALjSIpQOeIZZVYWk00b5+59YM+huS+Ml6wA3gIbRbnm8ycaQNq3nPIv3o2GyUt3Nd0HtGISulBmto+fQ1VsFNax7ds/nLCD/C8IS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnMJoPCe; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnMJoPCe"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eea31b5cb7so1920797137.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 03:04:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769598251; cv=none;
        d=google.com; s=arc-20240605;
        b=lwSb90pAmvJBnXZLkknMVYnwrrYOXp7hTDIlTTN34BWYQmKXzF/kC1zHWUQHSxMaaF
         Lmvmc1f/R7cBY3jrHnBkuwj1/gNDmO190y3Ao9SBHEjQkgcfmsjm9HQk1504Y1oiVG38
         83BR8zw5drfiKcdEjiw7RNksrmpB2nxoB367r9WLS4kSJW4qVmdeUTUQEm+8+aG9aTTF
         x5jlZC2g9f0c2UCHT1AnCp+jJyf/O1QK+f9s0X//SPQyMg+xTfmNpr7aYFnIXV1Bd6Hh
         SF+h7R6bltZA2IPlRhWGmyzxJKqJdn3hoPX3Swl9zL4rNX579lk+HU/Wm28mBh2rQa7q
         L0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=js+31LzM3rjr8H82yljraMYjtKVazzxMY2dUp+prI0g=;
        fh=DTV+mueopqm9Ka6tDP4G4XOfLpxxjdmkmPFWQEuoc5w=;
        b=PNJOfdmJeo3DChwJzXUOZox8NJ7XBvPWhyDFmrVOpTRGloenArG0+koCMga84UiZyy
         PRUnjHhdJz5szqm5EyHkWd2fwfzE3Of7SJ00jU0cXZ+l6R6oG05tl5ttLhnZiC7QCCvr
         akJkqVQPXqaL7/OuIrr9YVKYDFa1NW6rYyXp4MXFicwKEcdZq6wEF3lYDJjqvutzifMh
         HzMMojnPSuFAaeVB39pvK8G4iW680pnpd/c761VQpItUe8QHF7abZE83QwYK8T5s/NUf
         1CQ9kuKBdh/XPj0HoEmsKpvvzbyC2Gd09K/Y2KjYMPo5uofg0kWIA+emP9rwdtbYr5Hg
         8bjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769598251; x=1770203051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=js+31LzM3rjr8H82yljraMYjtKVazzxMY2dUp+prI0g=;
        b=TnMJoPCeCOiPUoeEHzctlbrAMVDPQJRZMDV2/+uAgiXKZet1HiBuW9NZtkDzM18FfP
         F9ez3vwGri4Le25oi35WZPU4Futd6NpANJVtacW9Qpcf48DTgbMzpELcJouzyMibSvoi
         8f0TywOk3U6BQ2a2ahUry0kD8HaW6ZyPYU0VbXbVwNbqG7HHSwXOJd53tAwAZI16SI0L
         IQumHz1eDadlF+z8nDx7WNTLs4XWf1/pMCrt7/N1J1H8I6T++amm3nqW7u0qnzUUA9xa
         eQ4iz3uaeqqM5DjjTBJkaSkLZ2mju/kIWtyfhQb5OMsFu4KODV+cCAImv34pzLb0zke2
         oY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769598251; x=1770203051;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js+31LzM3rjr8H82yljraMYjtKVazzxMY2dUp+prI0g=;
        b=lhGNjrVHZ+Olir30ORg6ZzzdiOEW4LLkU1sUxl20TK1AkhDH/Y0YhhNYTh8Xt1nXwJ
         8WYIvPpix0ybcR6W86ACip3MPbxVO6PYse/86wYviODwuehK5M1mMJowJX52U+yq5KvS
         MrrQbA05W5jjow9tur4i5CD3lT6gcaDMLGLX9gSWEX5I21JlpbPgjyrgZdrY7f8YJsA/
         5/7v5nQm+KIQRtujiaRD05X1s2zblz1UwOwCFZwFJn8hoHEF1ZZ3orWDOkbxTtfc13cC
         CB+EG9pwwtfXzzlenawm+zIKC1QiNXQoLl+AIA0zYqMpsILKnyn5yw70guiYXUQXTyOm
         nnCA==
X-Forwarded-Encrypted: i=1; AJvYcCXVwuUCkdo/tbOfE4WHiCTU2MxdWSPKVd0FETCsO4dyZuMxPpuYj2T8smddrI8tVjPjmMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8n4GXcx0SEjuTqEDMY2vmRF0+DEFSUectwiHnApA5HPNFtRg
	H7PIppz0vWZ9PIPbcAvzz0gG0KxphFr0t/BskvvVSRAxRo3l32qOCXTGk2I3fkJXvxhckCJlfii
	aHjnYhqDu0DIZimX1hjGEnOGN6VY804I=
X-Gm-Gg: AZuq6aIqerVLB8qAgUgZknkSia4D7JwI7BSSiXZTtwRPgKT4gd74mRzfNgZmdvmyxtq
	ACBu/vR2W0w4yN9veKpo1GfY5S0I73PNVfS5N2pdajr3DChqPZPifxFINtQrBQOyDyfIFNJjV1P
	p3iX1bVMSzMper6trodYFdYQhZ1C6kM8O1dhv8RQYaLrvow3787FMHHDmbcaBtbSV6vdooUI7im
	kuMWOEQCeXtilq8HfBOW40au7hOCVrdwdlMr3Sdc75tVUHHZukhtpjULwdHQ5PknBclKSLefoxX
	ulki97nuqAanUFC2R15vWmshKK8e
X-Received: by 2002:a05:6102:4194:b0:5f5:37f6:2b33 with SMTP id
 ada2fe7eead31-5f72362c977mr1492552137.13.1769598250538; Wed, 28 Jan 2026
 03:04:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 05:04:09 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 05:04:09 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 05:04:09 -0600
X-Gm-Features: AZwV_Qj1hkH5YmKqgbKlTKSG3EuVTEkpSEAWtBQJgZj0GGFwI-KGDiDPg451Nbw
Message-ID: <CAOLa=ZQyCbVUWTOWHYK4MVV+Mcf4XMQ4rY4n-CR6a97VMCjWqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000001e7260064970b3ec"

--0000000000001e7260064970b3ec
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "pack.preferBitmapTips" configuration allows the user to specify
> which references should be preferred when generating bitmaps. This
> option is typically expected to be set to a reference prefix, like for
> example "refs/heads/".
>
> It's not unreasonable though for a user to configure one specific
> reference as preferred. But if they do, they'll hit a `BUG()`:
>
>     $ git -c pack.preferBitmapTips=refs/heads/main repack -adb
>     BUG: ../refs/iterator.c:366: attempt to trim too many characters
>     error: pack-objects died of signal 6
>
> The root cause for this bug is how we enumerate these references. We
> call `refs_for_each_ref_in()`, which will:
>
>   - Yield all references that have a user-specified prefix.
>
>   - Trim each of these references so that the prefix is removed.
>
> Typically, this function is called with a trailing slash, like
> "refs/heads/", and in that case things work alright. But if the function
> is called with the name of an existing reference then we'll try to trim
> the full reference name, which would leave us with an empty name. And as
> this would not really leave us with anything sensible, we call `BUG()`
> instead of yielding this reference.
>
> One could argue that this is a bug in `refs_for_each_ref_in()`. But the
> question then becomes what the correct behaviour would be:
>
>   - Do we want to skip exact matches? In our case we certainly don't
>     want that, as the user has asked us to generate a bitmap for it.
>
>   - Do we want to yield the reference with the empty refname? That would
>     lead to a somewhat weird result.
>
> Neither of these feel like viable options, so calling `BUG()` feels like
> a sensible way out.
>
> The root cause really is that we try to trim the whole refname. We can
> thus easily fix the bug itself by calling `refs_for_each_fullref_in()`
> instead. This function behaves the same as `refs_for_each_ref_in()`,
> except that it doesn't strip the prefix. Consequently, it correctly
> yields also exact refnames.
>
> One resulting weirdness is that two refs "refs/heads/base" and
> "refs/heads/base-something" would now match if the user configured
> "refs/heads/base" as bitmap tips. One could arguably change the
> semantics of the configuration such that a string without a trailing
> slash needs to be an exact reference match, whereas a string with a
> trailing slash indicates a directory hierarchy. But such a change would
> potentially cause regressions with dubious benefits, so this issue is
> ignored for now.
>

When using `refs_for_each_ref_in()` this would yield just
'refs/heads/base-something'. That too feels like a BUG(), so I would
think this is the better solution.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c               |  4 ++--
>  t/t5310-pack-bitmaps.sh     | 35 +++++++++++++++++++++++++++++++++++
>  t/t5319-multi-pack-index.sh | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 2f5cb34009..8d3b5ac037 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -3334,8 +3334,8 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
>  		return;
>
>  	for_each_string_list_item(item, preferred_tips) {
> -		refs_for_each_ref_in(get_main_ref_store(repo),
> -				     item->string, cb, cb_data);
> +		refs_for_each_fullref_in(get_main_ref_store(repo),
> +					 item->string, NULL, cb, cb_data);
>  	}
>  }
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6718fb98c0..7ef91b502c 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -466,6 +466,41 @@ test_bitmap_cases () {
>  		)
>  	'
>
> +	test_expect_success 'pack.preferBitmapTips can use direct refname' '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +
> +			# Create enough commits that not all will receive bitmap
> +			# coverage even if they are all at the tip of some reference.
> +			test_commit_bulk --message="%s" 103 &&
> +			git log --format="create refs/tags/%s %H" HEAD >refs &&
> +			git update-ref --stdin <refs &&
> +

We create a bunch of commits. Nit: is '--message="%s"' even needed here?
Seems to be the default behavior anyways. Since we don't provide a ref,
it uses HEAD, so finally we'll only have one commit being referenced.

But then we also create individual tags for each of them.

> +			# Create the bitmap.
> +			git repack -adb &&
> +			test-tool bitmap list-commits | sort >commits-with-bitmap &&
> +
> +			# Verify that we have at least one commit that did not
> +			# receive a bitmap.
> +			git rev-list HEAD >commits.raw &&
> +			sort <commits.raw >commits &&
> +			comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
> +			test_file_not_empty commits-wo-bitmap &&
> +			commit_id=$(head commits-wo-bitmap) &&
> +

Alright, so of all the commits we have, some of them won't have a bitmap
and we pick the first one.

> +			# We now create a reference for this commit and repack
> +			# with "preferBitmapTips" pointing to that exact
> +			# reference. The expectation is that it will now be
> +			# covered by a bitmap.
> +			git update-ref refs/heads/cover-me "$commit_id" &&
> +			git -c pack.preferBitmapTips=refs/heads/cover-me repack -adb &&
> +			test-tool bitmap list-commits >after &&
> +			test_grep "$commit_id" after

Alright makes sense, since we fixed the prefix issue, providing the full
refname appears to work now.

[skip]

Thanks

--0000000000001e7260064970b3ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a79035166386b887_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sNTdTY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3VJQy9vQ3lxd1cxUnJJZjZ0cFhHMG5PV0RuN1krZAo3NWsvdUhxUXor
Skt2QzArQlhrV05mZTJzN2t6S3VER1dIL0Q3Yy8zQ0E4RG5ZeGhpMUhtQnpXcTg5c1lTakpHCjV4
dldHVS80U0N5OW9VVDJ6dTJCVC9SbzNja0lpSTdscmxWbWRsRXJXMXU2ODNJMkhTbFhRWG1mdGtP
VGhJSXEKRGRLM1NsZ2Fxa0RLVUxwYTEwOFRBQytUNHdHaTE3UkhMdTAvVlZzZENnL3Z6RDFKMUxX
TTZLZnJKcTFUT2FFTApSNXIvb2o1RGtUT29HU1hFRysvZy9JbTZkSG1Qb05MMExKcW90eHIwQWRE
SkUwZFdiMjNlY2lHMDVUWW9ldElqCkZzTDRVYWFCbmtHVyt1WEFIOTJxQXoxcmhzYk1aNHNpZGtE
dVMxVTV0TlZ5dXdSNTB5RDBRRkpHU3I3eWRCQXQKRVJGcFl2RjUxaDFCQUhYQXN6RW5PaldiWlZp
aE5NdHFCd3c0TlZoeHV5aTYvS2Z4b3dGbnd0dTRPMExIZmtDMgpXRWN4c3I1bllpcEJkSHc3R296
T3ZFWXJlVmxZUmVuUlFEYUFyMHp5NktLRHF5WlVlbVJCelJ3ZGpxcGZENmpVCkk3TEtiZVExQnZw
TzVUVWpMTlhqZEliTndzbUxMaVVDdmRibWx6ND0KPUc4REEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001e7260064970b3ec--
