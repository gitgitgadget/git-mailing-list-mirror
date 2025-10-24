Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AF1547C9
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271409; cv=none; b=KgYJs0BIUQJr3GI5zKreICXkumVgvnUfA0RphbVQCJhatbOlvuo5Vv9OIlWC3IGH5ivtLPmIJa7/oVpixI8n6kmsFV+aJncIGyVrD7BPx9qOq4punVSM+0s2it/OTc6SA3rOZCvGI8SvJgCIdfRE0MNRQLkoeST9UqSLCobIadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271409; c=relaxed/simple;
	bh=Nn1akrfwEEDd5vKgkuoQ91S7wQJEJ5V9mcxUblvGDnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caO0sRN5han2DBitjtBGHp6QdpV/71UE+qSrzCFMVjoW1ubil/6F12bt9lZQx8i+cw/uW9bIeJ0Xl8yiVGhTBXlnfVF+i1htcM2K28DbSK1IfAm4/1C/mQD1qCE5QFbSAkiqt1wjxXphGHsXJyZcY4mabkAho2EUKlwK00dUINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxoYup9B; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxoYup9B"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9379a062ca8so61353939f.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271407; x=1761876207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPDkiAGae6EIZf3Ke/EqynVCZu02E1t8BRpCwHb7v8g=;
        b=jxoYup9BGYak9Xpk82dGTrGu97GuPWnPiwRBX9Ow3rHNV7DLBq5O2aBXB4NL1MzZO8
         ZXfXsuUEM9yF5kyogOcvW1LscwhroeIeMm1rzpsO0+NqDLxaMwc3t13QIvGkLEXlbPVK
         fATDPCcRcogMW+kcptf6Y3mtnXP97OCKCcS3MsMTAyVOj5BrKyc5Vva6bCaInLvycXRl
         VY0ZSJl4KykGRhbzrYquOYoZ64NXFVetprSnoux4W8VaybpyrhLUWSLptTm6fngISIdh
         bYNvQfxFBVQNMB7a7RszLd7nxfLqDTNG9WmatX0Z9oY6XKN9tiWA/oCERJpsBVJVinq3
         8yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271407; x=1761876207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPDkiAGae6EIZf3Ke/EqynVCZu02E1t8BRpCwHb7v8g=;
        b=c2ShRSRRaRBW9Gwfi0aI7KU7mNA9o1dCqtbNbDZ/Omqf+GTiOwYsSy5TUYhYiciRIJ
         OM/smWilj2AdNYqtJb+rOrPdZXLLFv2pYhVzGM3L6qdmQ4rJ4G9lwnru1Oijvjq1tZkD
         BuuzmMeJoKv3jHBQHnZ1NQ8zYLqNsjVnpzbK0MTe3nx7cVoW6XiWCrIoVVsnZR/G3DWX
         maHRY7+F7g/QJDjws0DWNq6IpTQ7qZCQdz58NSs9OYkqrAKTsjwDwascfUmM33ol8wIy
         B+TlCd9yP57OEHNGE2i/8V4s6wJ8slxWV6sW3hXz3tn7dOl1NtapUwNkbh//8JD4+2ms
         5Uwg==
X-Gm-Message-State: AOJu0Yx/blLzxyBUi2A12Qy88D9T8QLHDL3dF/5ThwKkmi42sMg3kvtZ
	eyTXkIAYeyfMCfaegY5SM605CX17HwRkAe6DtbMgTKGzdQR1zny7zt/Y1xuA4xXW3JRQf6bGdAb
	pJcjPN4ejCOW8yme2AFW6AHVQVFmFkfY=
X-Gm-Gg: ASbGncurNV1/5ppz3FL8WzQPv6AVz1NHdRAcVjNob+MdXyDjaGOE0Ppubgy27R3K7U0
	f68XtRj1yRRBBWhNLIxDTsqhT+mlb2U76QoE2vmjqzirb1by6uN4p8Ry4CHOEXFB3U7P1hZGQXc
	vSauBqhsWkVkAS6kpGJfu2nGdc7IlG35y04wCCJRz49NjACKImsmXwE1VAhooG29uZBLrtZgN1C
	hCog/pZdoh3ahb0kJAjSzvvNG2VFb4PKiAm81Mt12TNwjNwd3p0H6/1iznX
X-Google-Smtp-Source: AGHT+IH8TLjd1PwW6HISR2tj6vzUVRY8i18Ic84/Xhb7KsFNVrrU+R2rCZMcRLJIWkBZW7wOc25uxXIbWBqO0bZTcwU=
X-Received: by 2002:a05:6e02:3086:b0:431:d83a:9a8 with SMTP id
 e9e14a558f8ab-431d83a0c8cmr97764835ab.25.1761271407226; Thu, 23 Oct 2025
 19:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <20251013084857.1646783-4-christian.couder@gmail.com>
In-Reply-To: <20251013084857.1646783-4-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:03:15 -0400
X-Gm-Features: AS18NWBj8YToAax1kw_khQoavt92MFBdLLW2Lw4Lf7bhsaixeUgEkG0qLyGnekI
Message-ID: <CABPp-BFEUuVWZHCHfF89KPDr+=BRT1OyiJwB6hc8SW3o3o2MaA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] t9350: properly count annotated tags
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> In "t9350-fast-export.sh", these existing tests:
>
>   - 'fast-export | fast-import when main is tagged'
>   - 'cope with tagger-less tags'
>
> are checking the number of annotated tags in the test repo by comparing
> it with some hardcoded values.
>
> This could be an issue if some new tests that have some prerequisites
> add new annotated tags to the repo before these existing tests. When
> the prerequisites would be satisfied, the number of annotated tags
> would be different from when some prerequisites would not be satisfied.
>
> As we are going to add new tests that add new annotated tags in a
> following commit, let's properly count the number of annotated tag in
> the repo by incrementing a counter each time a new annotated tag is
> added, and then by comparing the number of annotated tags to the value
> of the counter when checking the number of annotated tags.
>
> This is a bit ugly, but it makes it explicit that some tests are
> interdependent. Alternative solutions, like moving the new tests to
> the end of the script, were considered, but were rejected because they
> would instead hide the technical debt and could confuse developers in
> the future.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t9350-fast-export.sh | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 8f85c69d62..21ff26939c 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -35,6 +35,7 @@ test_expect_success 'setup' '
>         git commit -m sitzt file2 &&
>         test_tick &&
>         git tag -a -m valentin muss &&
> +       ANNOTATED_TAG_COUNT=3D1 &&
>         git merge -s ours main
>
>  '
> @@ -229,7 +230,8 @@ EOF
>
>  test_expect_success 'set up faked signed tag' '
>
> -       git fast-import <signed-tag-import
> +       git fast-import <signed-tag-import &&
> +       ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1))
>
>  '
>
> @@ -491,8 +493,9 @@ test_expect_success 'fast-export -C -C | fast-import'=
 '
>  test_expect_success 'fast-export | fast-import when main is tagged' '
>
>         git tag -m msg last &&
> +       ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1)) &&
>         git fast-export -C -C --signed-tags=3Dstrip --all > output &&
> -       test $(grep -c "^tag " output) =3D 3
> +       test $(grep -c "^tag " output) =3D $ANNOTATED_TAG_COUNT
>
>  '
>
> @@ -506,12 +509,13 @@ test_expect_success 'cope with tagger-less tags' '
>
>         TAG=3D$(git hash-object --literally -t tag -w tag-content) &&
>         git update-ref refs/tags/sonnenschein $TAG &&
> +       ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1)) &&
>         git fast-export -C -C --signed-tags=3Dstrip --all > output &&
> -       test $(grep -c "^tag " output) =3D 4 &&
> +       test $(grep -c "^tag " output) =3D $ANNOTATED_TAG_COUNT &&
>         ! grep "Unspecified Tagger" output &&
>         git fast-export -C -C --signed-tags=3Dstrip --all \
>                 --fake-missing-tagger > output &&
> -       test $(grep -c "^tag " output) =3D 4 &&
> +       test $(grep -c "^tag " output) =3D $ANNOTATED_TAG_COUNT &&
>         grep "Unspecified Tagger" output
>
>  '
> --
> 2.51.0.438.g6987fc0bae

When tests are not read-only, I tend to prefer either giving each test
in a testfile its own repo, or doing hard resets with
test_when_finished.  Either way allows tests to be more independent,
and allows new tests to be added or removed from the testsuite without
adverse affects on other tests.  But, restructuring an existing
testfile is a significantly bigger change, so this seems like a
reasonable path you've proposed for your series.
