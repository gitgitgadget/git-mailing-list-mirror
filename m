Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14B189913
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594424; cv=none; b=NxJQZrDNEoBVjRrRTcEVSBszWx3yCDkdCwyr6KguBbs49c71bQf39H7815UDnHAFmmv2JmVVhsFIoQHqjsoSEn6u469h/C+LEjpZ98bqMFcKi8arc+hD9ZdCvirjXGx96XK2oWgyd6keN1zuQJd3VpcXr07ot9oHqrRfW9C7ouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594424; c=relaxed/simple;
	bh=ZByuQoKupY53bhwSPg/QZAURrtWPdqF52WlwhB/jkR8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuDVd6vVkHTpSzmFZA7PRuG085BCMD+3X6TCFVf0aY8Mg6fnFQHfs3eIwD4nnnEKMKTgHYk3zVyMyyeMvmnF+TQtxNTdNkNbqAIgj/3OEfm1febjFbioh84TMSGH9joufi8gy+gzwu2QRO0wqYly4Zp74LMrdSZa89XPg7rZKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj3f0saY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj3f0saY"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50108b373d2so1215601e0c.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726594421; x=1727199221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=joRrSErmqVfPx4T3jpwU4aAhewFGK7S2n2mbBpZ/Oeg=;
        b=Gj3f0saYnPuJaNle2V2GRQJ5nCUAhaXi6hfaYW/6uVbR/HBuIJjrxpKPIDX4rG80Fw
         JNmCqc+wQMXw+to/8EZrn3cJyGCL0C8ZiBo2efmuiNsM9+vNgrLrYRi59ejO9a85Ex1l
         S3SwEH5cX09ZO1CMhMBe3+ORECByt3NII6EwQjAp+USA+S4zN6Wqu8EcN/wNIhc4L0r6
         vRqlzrDHDcaCbIFQEk8uBtQPchbH9JYTY9dotXFMCwms6IQTM+PF/wW/987zLuzXLCzt
         aFCjpzm6y0YeFXZQlktoGgnIp8uFrYfxwWrTNjr7+0QYyJFINc8murKqlxdkIbh+hFuR
         +Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726594421; x=1727199221;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joRrSErmqVfPx4T3jpwU4aAhewFGK7S2n2mbBpZ/Oeg=;
        b=wk3iocmfL/uHZTfsspLzuYQknbHz3YZUX+0WSQVTXraqylVPKBar4nu9fVpGNrF+pK
         O6VyWT6Ez33Iyj9GA/0nHY4w3IPZEPs9UqkQcLjp9sITASs7GjFkeBluZPj7S2acWcfM
         PYYjJABuhEHN4Ur++BeyVvQtny6ibyaIQpv5Grpqo3218pyssl40LdzaHiGiGi5pR3QU
         xM/E5fUBTqCLyFlTPuaQaLm0K+4XJE5MXOEo2PizqIm4lCLZ8dFz2nOHqt7iCrlvV/Ka
         O9/0e6O/wABBd0e+2UXWfGpwQgbcTJBTwYgo5JO0bixOHUyZvVPVznOlHRNaiaJ2uRjR
         ilpg==
X-Forwarded-Encrypted: i=1; AJvYcCWtl62/0jr5sJXInRHBy3SAUHD/X3q/60iWUT9VCDxa33Qi/Sn4cmyja+Xa1+9C6nwQ0fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJyJEG2B8G+kNl6XzCUQmDI4PlwpHOW7Z1WnHlifIRpUIybKc
	7Hs5Ynwc3+lpqV2w74lGiFD8m9tCothqzRByn3/JrU1/6o4/Q7f1/RFdGtDm/TfknfKiBKB8P+p
	B2PQ6/f0Jm9SHdZXhpxBdDvuaYI4=
X-Google-Smtp-Source: AGHT+IEPk0uMCgc6NT+Qqdd9S/ynAm/qVGGbNbJXqQJbxzXrKx98fpQu1lorJgJDIxT69kIGNB1Wn3BaZ2inMeu0q8Q=
X-Received: by 2002:a05:6122:3b12:b0:4ef:6870:ff5 with SMTP id
 71dfb90a1353d-50344b7fffcmr9709720e0c.5.1726594421343; Tue, 17 Sep 2024
 10:33:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 13:33:40 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im> <cover.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 13:33:40 -0400
Message-ID: <CAOLa=ZTeZPeAOhSx3JnDGeeRwD9=af071FJZj+gWGqE29d4Adg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] refs/reftable: wire up exclude patterns
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000027e9c2062254179b"

--00000000000027e9c2062254179b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

Hello,

> Hi,
>
> this is the second version of my patch series that fixes preexisting
> bugs with exclude patterns and wires them up for the reftable backend.
>
> Changes compared to v1:
>
>   - Some typo fixes in commit messages.
>
>   - Mention that the newly introduced function in patch 1 will be used
>     in patch 2, which is why it's declared in "refs.h".
>
>   - Use `check()` instead of `check_int(ret, ==, 0)`.
>
>   - Sort exclude patterns lexicographically. This fixes a bug where we
>     might not correctly skip over some refs when patterns are passed to
>     the reftable backend in non-lexicographic order. Add a test for
>     this.
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (6):
>   refs: properly apply exclude patterns to namespaced refs
>   builtin/receive-pack: fix exclude patterns when announcing refs
>   Makefile: stop listing test library objects twice
>   t/unit-tests: introduce reftable library
>   reftable/reader: make table iterator reseekable
>   refs/reftable: wire up support for exclude patterns
>
>  Makefile                            |   8 +-
>  builtin/receive-pack.c              |  18 ++-
>  refs.c                              |  35 +++++-
>  refs.h                              |   9 ++
>  refs/reftable-backend.c             | 133 ++++++++++++++++++++++-
>  reftable/reader.c                   |   1 +
>  t/t1419-exclude-refs.sh             |  49 +++++++--
>  t/t5509-fetch-push-namespaces.sh    |   9 ++
>  t/unit-tests/lib-reftable.c         |  93 ++++++++++++++++
>  t/unit-tests/lib-reftable.h         |  20 ++++
>  t/unit-tests/t-reftable-merged.c    | 163 +++++++++++++++-------------
>  t/unit-tests/t-reftable-reader.c    |  96 ++++++++++++++++
>  t/unit-tests/t-reftable-readwrite.c | 130 +++++++---------------
>  t/unit-tests/t-reftable-stack.c     |  25 ++---
>  trace2.h                            |   1 +
>  trace2/tr2_ctr.c                    |   5 +
>  16 files changed, 594 insertions(+), 201 deletions(-)
>  create mode 100644 t/unit-tests/lib-reftable.c
>  create mode 100644 t/unit-tests/lib-reftable.h
>  create mode 100644 t/unit-tests/t-reftable-reader.c
>
> Range-diff against v1:
> 1:  8d347bc5599 ! 1:  7497166422e refs: properly apply exclude patterns to namespaced refs
>     @@ Commit message
>          to the non-stripped ones that still have the namespace prefix. In fact,
>          the "transfer.hideRefs" machinery does the former and applies to the
>          stripped reference by default, but rules can have "^" prefixed to switch
>     -    this behaviour to iinstead match against the rull reference name.
>     +    this behaviour to instead match against the full reference name.
>
>          Namespaces are exclusively handled at the generic "refs" layer, the
>          respective backends have no clue that such a thing even exists. This
>     @@ Commit message
>          refs in the tests, and then we indeed surface the breakage.
>
>          Fix this bug by prefixing exclude patterns with the namespace in the
>     -    generic layer.
>     +    generic layer. The newly introduced function will be used outside of
>     +    "refs.c" in the next patch, so we add a declaration to "refs.h".
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> 2:  0317a5a7ede = 2:  3dc6ae936c8 builtin/receive-pack: fix exclude patterns when announcing refs
> 3:  503c44e6cab = 3:  4ba503520e6 Makefile: stop listing test library objects twice
> 4:  3df4040dd3c = 4:  6747076420f t/unit-tests: introduce reftable library
> 5:  a281f936a2b ! 5:  3278cdf92fe reftable/reader: make table iterator reseekable
>     @@ t/unit-tests/t-reftable-reader.c (new)
>      +	block_source_from_strbuf(&source, &buf);
>      +
>      +	ret = reftable_reader_new(&reader, &source, "name");
>     -+	check_int(ret, ==, 0);
>     ++	check(!ret);
>      +
>      +	reftable_reader_init_ref_iterator(reader, &it);
>      +	ret = reftable_iterator_seek_ref(&it, "");
>     -+	check_int(ret, ==, 0);
>     ++	check(!ret);
>      +	ret = reftable_iterator_next_ref(&it, &ref);
>     -+	check_int(ret, ==, 0);
>     ++	check(!ret);
>      +
>     -+	ret = reftable_ref_record_equal(&ref, &records[0], 20);
>     ++	ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
>      +	check_int(ret, ==, 1);
>      +
>      +	ret = reftable_iterator_next_ref(&it, &ref);
>     @@ t/unit-tests/t-reftable-reader.c (new)
>      +	block_source_from_strbuf(&source, &buf);
>      +
>      +	ret = reftable_reader_new(&reader, &source, "name");
>     -+	check_int(ret, ==, 0);
>     ++	check(!ret);
>      +
>      +	reftable_reader_init_ref_iterator(reader, &it);
>      +
>      +	for (size_t i = 0; i < 5; i++) {
>      +		ret = reftable_iterator_seek_ref(&it, "");
>     -+		check_int(ret, ==, 0);
>     ++		check(!ret);
>      +		ret = reftable_iterator_next_ref(&it, &ref);
>     -+		check_int(ret, ==, 0);
>     ++		check(!ret);
>      +
>      +		ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
>      +		check_int(ret, ==, 1);
> 6:  f3922b81db6 ! 6:  050f4906393 refs/reftable: wire up support for exclude patterns
>     @@ refs/reftable-backend.c: static struct ref_iterator_vtable reftable_ref_iterator
>       	.abort = reftable_ref_iterator_abort
>       };
>
>     ++static int qsort_strcmp(const void *va, const void *vb)
>     ++{
>     ++	const char *a = *(const char **)va;
>     ++	const char *b = *(const char **)vb;
>     ++	return strcmp(a, b);
>     ++}
>     ++
>      +static char **filter_exclude_patterns(const char **exclude_patterns)
>      +{
>      +	size_t filtered_size = 0, filtered_alloc = 0;
>     @@ refs/reftable-backend.c: static struct ref_iterator_vtable reftable_ref_iterator
>      +	}
>      +
>      +	if (filtered_size) {
>     ++		QSORT(filtered, filtered_size, qsort_strcmp);
>      +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
>      +		filtered[filtered_size++] = NULL;
>      +	}
>     @@ t/t1419-exclude-refs.sh: test_expect_success 'several overlapping excluded regio
>      +		assert_jumps 3 perf;;
>      +	*)
>      +		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
>     ++	esac
>     ++'
>     ++
>     ++test_expect_success 'unordered excludes' '
>     ++	for_each_ref__exclude refs/heads \
>     ++		refs/heads/foo refs/heads/baz >actual 2>perf &&
>     ++	for_each_ref refs/heads/bar refs/heads/quux >expect &&
>     ++
>     ++	test_cmp expect actual &&
>     ++	case "$GIT_DEFAULT_REF_FORMAT" in
>     ++	files)
>     ++		assert_jumps 1 perf;;
>     ++	reftable)
>     ++		assert_jumps 2 perf;;
>     ++	*)
>     ++		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
>      +	esac
>       '
>

The range diff here looks good based on my earlier review. Thanks

--00000000000027e9c2062254179b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 65e49688bdb8bbe1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1icHZYTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDJlQy93S01qNHNZMlBNeS9kRU05WEtPeGNWd0FVSwpmTnpEYSs4anBy
SU5MdTdHT0dDaWhCQ2l0dXdONy9CV3lwMFNaYSt2UXc4anlkZTJCcGlZbllTQ1RtWFRZV2tvCk92
bUdUdVBZTGNicHg0d2dCZm9FZktiUk9YTTVqWmlKamRjQ1Q2dWdOV3BhcmFsT1NjejJUaXAyeFA0
UXc1R0gKMmI3TXJiMmQ4cytSbmdPbDNJbTFrWDRSbjljM0JEYXlCZFFlVmUyeHNhR3JFYUluMitI
VkZicUY5QWhRejByLwpLUXV3K3g3SkxOR3AxeFZqV3JiTHBxZEREbnQrRElITEdRZEplUHZaTnZB
eGdSZVY5WUdpL3NSNk1ILytNZW1mCkc5cmVNWTJPT2ZPVWVtNmVPdVplU2hvWWtodS90VTRnSXlk
SGQ2STZNMWpDN3gzek9NazhvU21mWlpnWjN0alMKOTNGRUVrM3p4ZUt6SGROdTJGV3ZYYkJsQWw2
NW8xcE5FVnZQTjUxYmpwUWFlQmI0Yit2czlWSXhJbEF1T3FwYQpQWWxMRnBqazlTK29GTmQzVDYw
ZC9aT29yTWtlMTdxZy8vSG1LT1hWdXpyNElEaDRpdTNVVWw2Sk1sMDhvQTBGCmVGWFRjQktkYkdq
SVErbGNCL1R1dVAzR3Nld2lNZTVqMVV5dlR6WT0KPXRuRksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000027e9c2062254179b--
