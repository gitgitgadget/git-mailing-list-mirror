Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E813BBFAA
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482321; cv=pass; b=cJRaSEEkFJDb+9fiyHOKfV6QLAvbPX8m+qLWCyl7g2X3F46MKkBQTpzgI8cg9qEJsh/0p+IBbeGip0hWw8X3wQLnDRUHATrBZ1zMNfPQ4fq22JuBKe4iNXadQptNg9rKEZW5OqZpftE5aPjZaQDAxa2uRR5otOkQSfXRrnzXaZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482321; c=relaxed/simple;
	bh=AWXnuIz2WygQdcuaazySplK8+phpUvQ6AJPbSd+Jrco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzes1RswuElYf18mY8xr4xW4URNhI2slyy7pTr6GJUAC5IvN6Kz3JSK7y9rUb/LqnepbfJbbQNmsB6tcDMUnch+GVQ4EMt/tWuOQfsrazNripDsFduMDnhUKkouGl/DIdfTb7dU0rHDeQ5PVHqH72D1dx/1naZJXrAPDKi5+wr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co; spf=pass smtp.mailfrom=pierre.co; dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b=EHYZJQSU; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pierre.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pierre.co header.i=@pierre.co header.b="EHYZJQSU"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso545647966b.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 07:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789482318; cv=none;
        d=google.com; s=arc-20260327;
        b=RW04cvOUMZs5LfRlr72nKMlqE9ufZuX/tgZf+5mPWDSL0Fn9p/SlpUImzAPN44S6ya
         JsLwI2D+B2GWSJTsL+TRyZhAi8DbBm75boQYv0N2iDb3kzsEmGapAD4+oH/g7ujuFo+O
         O2j0bZMZjyBIWpVoyx3Uj8haBECbEq0R8yQIcpQvxj9A8PpINuccRh8k/zaKxCtLZsbH
         NIuVQQfFBtmv4PqvXBpjeqKrlek3zTZ4eeIygj4TEcOKqf8Dh9axEtk1+KGw4qiOqfBc
         cDnSUmwoKgqUSx8MoKUTjdy+IY+rlIUt0MkOUS1KmGMswknHSwCDqd7QHuva3n5pVT0i
         168w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qqtc0ikTSLQs0OoJVaTZFuGMYoHrYekiDJqDlgnj1jc=;
        fh=hMJsXBiRhLsba2x+1TjFWUqY1DZYbC4TAZeioTFruN8=;
        b=WADVhjKPVkNjhw5R/vC8nK3eZFWVb6mRaJun97XVMi+xMQhyUm+EYAMWkPBRlz9aCJ
         voI99sxsbNpO6u9FUEsZGyIftDVpJiiFZhcH4iYHaTKMSSZkriOpAHyO4sNkYOS1a8wW
         +3VpTAc4CAw6kV6IX/RP1zTDUT7CD0koJt5XhBCptTjudWYPh7G95GJD7xBdAoB2s5Zk
         wn1YkhEmMTjAUz5qVVeJMKm0/5up86BkTrUpwso32Tt5vb1hvbyKf3DNzMXQg5kM+vny
         1h91dy2LedkhKxaJgxORrLSb18s1lMgZXC95obANO5ZsAVzMtCBdZy8m3E89Jkr/gT89
         zUug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pierre.co; s=google; t=1789482318; x=1790087118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qqtc0ikTSLQs0OoJVaTZFuGMYoHrYekiDJqDlgnj1jc=;
        b=EHYZJQSUyyGr1K1cX+Npwo4WvAdR+loQTzxduKblqsmDHaimbiLQ44s7GRRq+K7uzV
         6xSvl/imcXDHF826stqAsk1zgmrlBUcUR8k8vWuexEWzPiKzYNStKCGDtu+qk4lTW4Tw
         Q4ATwsZ2ZLs3QyYqVu02N2l+8Hcxf96lxJrJv/gCS8zRcCbTTPYYhkpG2t7E5M4LiIuV
         5CWCBY47ZhTpn3j8H2tpTwDwe/CnM7Tlyd7cND4my7UnD7t0hCkNgOMnXfA/6FEvZ2sS
         nF+heae5Kxgt557AOpZ/cRtH50svYhtdtRyZQf1iK4M0/NCZuxBFZwX7GUMyCudRafL+
         zrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789482318; x=1790087118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qqtc0ikTSLQs0OoJVaTZFuGMYoHrYekiDJqDlgnj1jc=;
        b=koIV92tNef6HWm6bT6p5lMlRCixwjvdgvIamyb+8rmybtShF44f2wIY5zFcKWt75RC
         5/MVtlNBQUn+/GBjbmpqpbH3BhAte953VQ2HgWFs6t6yafXdjY4ne1pIZMdUUYEDzjLS
         C0mJXF/4CcQ4W3q+hE/PBzbaBCGqN1guWPqFkPTsPvTtFb2wyGn0NqLRUXRQKQgGuSXS
         eBcbuH18EImcLqGkBVRYSl6MoL5iXd/v+3yf0KyLbk/NmmhAE0HbWwOzpcHZrSH2HlkZ
         VDhM9oZUpYyUjMuLX4OyHzDlCGX27dYZAkuUYDvfKb7qUEP3vSmskLvIGosz7mhl3wJf
         ShBQ==
X-Gm-Message-State: AFuF++m5oM4Zm5j8fIxehgV+VCHLGkY4ALyau6uUo4XT+KRL0UqlVhp7
	frMOJNJX/fz64Fb+S6b/FS9trnpiRz/0dsCBDI8HqhaT+FdP/igeXMUfr2bRpw9EetY7Yk2Ow4l
	i8/fNQ/Pa42FEy83nvTS7m9lsGiFRn8ocFRUCiH0mcg==
X-Gm-Gg: AYBFou3jvEUnO46NcKBG+fJclAQ15HkNIxz1IOKuzVShvP3Vndli2efW0l95KlQdrwi
	GXmFuv/IsG4MCnMRjWtd2nWM8T3nch7zh+Rao8u8dQhAQejtUHgQ+198p/tqPZx9XEH8WZWL2as
	weEVOMHOKZ7IM3PTxlTNAGVegiINW9l6wc0ffSzvVl3BlDjE9mdAb+kR8a6FpMtPM8rWwUDllDF
	1jOVY1/3OKYMsIkGtyObtS3fDqNZrcPqdkJ0gHHh1fxQVnrY8SmBtnLYVWBS3EW5ZTj4csLY3NX
	wgvXIl9q3B1+UsZvmC9d16PyblHvQAZnRq4jfuB3D+kFPZ7cpaFjpXiU
X-Received: by 2002:a17:906:730e:b0:c26:2eee:ffc7 with SMTP id
 a640c23a62f3a-c29b870b484mr470943866b.35.1789482317363; Tue, 15 Sep 2026
 07:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ap-KYtsDXXwbBzDM@com-79390> <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
 <aqAkfGZtLJ97nG1m@com-79390> <CAOWp8q6uCcVL-0cLxvf-ncydSiapheYTDnFhom3CnKiMWyfJ=w@mail.gmail.com>
In-Reply-To: <CAOWp8q6uCcVL-0cLxvf-ncydSiapheYTDnFhom3CnKiMWyfJ=w@mail.gmail.com>
From: Pia Park <pia@pierre.co>
Date: Tue, 15 Sep 2026 15:25:06 +0100
X-Gm-Features: AcwNN1UVXlzYnQ_B5FFwSwtSjqFLlQa_RzsoG-c5Ow0hKXY57FRFhB_7oIYAKGg
Message-ID: <CAOWp8q5UqPrJQosjypdcq=KX1TKcVenAOoZUYfTBDKbRUwazTw@mail.gmail.com>
Subject: Re: [PATCH v2] midx-write: skip writes with no object entries
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! Just following up on Stolee=E2=80=99s suggestion to return silent succe=
ss
in the no-pack case. I=E2=80=99m happy to prepare v3 if there=E2=80=99s agr=
eement on
that approach.

I=E2=80=99ll also be at Git Merge in Lisbon this week and would be happy to
chat in person if there=E2=80=99s a chance :)

On Tue, Sep 15, 2026 at 12:40=E2=80=AFPM Pia Park <pia@pierre.co> wrote:
>
> Hi! I=E2=80=99d like to ping on Stolee=E2=80=99s thoughts on returning si=
lent success on the no-pack case. Happy to prepare v3 if there=E2=80=99s ag=
reement on here.
>
> Plus, I=E2=80=99ll be in Git Merge Lisbon this week and would be happy to=
 chat in person if theres chance :)
>
> On Tue, Sep 8, 2026 at 4:06=E2=80=AFPM Taylor Blau <ttaylorr@openai.com> =
wrote:
>>
>> On Tue, Sep 08, 2026 at 12:10:16AM -0700, Pia Park wrote:
>> > Return success silently. Empty-object writes already return 0, includi=
ng
>> > when --bitmap warns, so preserve that exit status for existing callers
>> > while omitting the warning and empty MIDX.
>>
>> I think that this is OK, and it matches the behavior of other builtins,
>> e.g., running "git repack -d" twice in a row such that the second
>> invocation has no objects to pack. However, I think that if we want to
>> make this case return successfully when no objects are present, we
>> should apply the same treatment to the case where no packs are present.
>>
>> But I want to make sure that others are on the same page. I would be
>> curious to hear Stolee's (CC'd) opinion on whether returning silent
>> success in both cases makes sense.
>>
>> > diff --git a/midx-write.c b/midx-write.c
>> > index 8537102254..3038bbfad2 100644
>> > --- a/midx-write.c
>> > +++ b/midx-write.c
>> > @@ -1617,9 +1617,8 @@ static int write_midx_internal(struct write_midx=
_opts *opts)
>> >       }
>> >
>> >       if (!ctx.entries_nr) {
>> > -             if (opts->flags & MIDX_WRITE_BITMAP)
>> > -                     warning(_("refusing to write multi-pack .bitmap =
without any objects"));
>> > -             opts->flags &=3D ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BIT=
MAP);
>> > +             result =3D 0;
>> > +             goto cleanup;
>>
>> Looks good, though let's make sure others agree that this is the right
>> approach. If they do, I'd recommend changing the no packs case to also
>> return zero either in a small preparatory patch.
>>
>> > diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> > index 68143cb5b7..c239a87d10 100755
>> > --- a/t/t5319-multi-pack-index.sh
>> > +++ b/t/t5319-multi-pack-index.sh
>> > @@ -54,6 +54,41 @@ test_expect_success "don't write midx with no packs=
" '
>> >       test_path_is_missing pack/multi-pack-index
>> >  '
>> >
>> > +test_expect_success 'skip non-incremental MIDX with no objects' '
>> > +     git init --bare empty.git &&
>> > +     (
>> > +             cd empty.git &&
>> > +             git pack-objects objects/pack/pack </dev/null &&
>> > +             ls objects/pack >files.expect &&
>>
>> I think it's fine to drop files.expect and files.actual here. Testing
>> that the MIDX write does nothing should be sufficient here.
>>
>> > +
>> > +             for bitmap in "" --bitmap
>> > +             do
>> > +                     git multi-pack-index write $bitmap >out 2>&1 &&
>> > +                     test_must_be_empty out &&
>>
>> I think it's fine to write "git multi-pack-index write $bitmap" without
>> the redirection, so that this is:
>>
>>     for opt in "" --bitmap
>>     do
>>         git multi-pack-index write $opt &&
>>         test_path_is_missing $objdir/pack/multi-pack-index || return 1
>>     done &&
>>
>>
>> > +             git multi-pack-index write --incremental --bitmap &&
>> > +             test_dir_is_empty objects/pack/multi-pack-index.d &&
>>
>> I was going to ask whether we wanted to test this case with and without
>> the "--bitmap" option as well, and likewise recommend that tthis test go
>> in t5334 instead. But such a pair of tests already exists in t5334, so I
>> think we can safely drop this hunk.
>>
>> > +             echo blob | git hash-object -w --stdin >in &&
>> > +             git pack-objects objects/pack/pack <in &&
>> > +             git multi-pack-index write --incremental --bitmap &&
>> > +             test_line_count =3D 1 objects/pack/multi-pack-index.d/mu=
lti-pack-index-chain &&
>> > +             git multi-pack-index verify &&
>> > +
>> > +             echo another | git hash-object -w --stdin >in &&
>> > +             git pack-objects objects/pack/pack <in &&
>> > +             git multi-pack-index write --bitmap &&
>> > +             test_path_is_file objects/pack/multi-pack-index &&
>> > +             midx=3D"$(midx_checksum objects)" &&
>> > +             test_path_is_file objects/pack/multi-pack-index-$midx.bi=
tmap &&
>> > +             git multi-pack-index verify
>>
>> These two blocks are testing normal MIDX operations that are well
>> covered elsewhere in the test suite. I think we can drop these safely.
>>
>> > +     )
>> > +'
>> > +
>> >  test_expect_success SHA1 'warn if a midx contains no oid' '
>> >       cp "$TEST_DIRECTORY"/t5319/no-objects.midx $objdir/pack/multi-pa=
ck-index &&
>> >       test_must_fail git multi-pack-index verify &&
>> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmap=
s.sh
>> > index 86beab1dae..490008d1d7 100755
>> > --- a/t/t5326-multi-pack-bitmaps.sh
>> > +++ b/t/t5326-multi-pack-bitmaps.sh
>> > @@ -305,7 +305,7 @@ test_midx_bitmap_cases () {
>> >               )
>> >       '
>> >
>> > -     test_expect_success 'no .bitmap is written without any objects' =
'
>> > +     test_expect_success 'no MIDX or .bitmap is written without any o=
bjects' '
>> >               rm -fr repo &&
>> >               git init repo &&
>> >               test_when_finished "rm -fr repo" &&
>> > @@ -318,13 +318,14 @@ test_midx_bitmap_cases () {
>> >                       pack-$empty.idx
>> >                       EOF
>> >
>> > +                     ls $objdir/pack >files.expect &&
>>
>> Similar comments here. It should be fine to drop the assertion on
>> files.expect, along with the content out stdout.
>>
>> >                       git multi-pack-index write --bitmap --stdin-pack=
s \
>> > -                             <packs 2>err &&
>> > +                             <packs >out 2>&1 &&
>> >
>> > -                     test_grep "bitmap without any objects" err &&
>> > -
>> > -                     test_path_is_file $midx &&
>> > -                     test_path_is_missing $midx-$(midx_checksum $objd=
ir).bitmap
>> > +                     test_must_be_empty out &&
>> > +                     test_path_is_missing $midx &&
>> > +                     ls $objdir/pack >files.actual &&
>> > +                     test_cmp files.expect files.actual
>> >               )
>> >       '
>> >
>> > diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-increme=
ntal-multi-pack-index.sh
>> > index f0b82b5f65..fbcc19feeb 100755
>> > --- a/t/t5334-incremental-multi-pack-index.sh
>> > +++ b/t/t5334-incremental-multi-pack-index.sh
>> > @@ -195,4 +195,79 @@ test_expect_success 'non-incremental write with e=
xisting incremental chain' '
>> >       )
>> >  '
>> >
>> > +test_expect_success 'skip initial MIDX layer with no objects' '
>> > +     git init empty &&
>> > +     (
>> > +             cd empty &&
>> > +             git config maintenance.auto false &&
>> > +             git pack-objects $packdir/pack </dev/null &&
>> > +
>> > +             for bitmap in --bitmap --no-bitmap
>> > +             do
>> > +                     git multi-pack-index write --incremental "$bitma=
p" >out 2>&1 &&
>> > +                     test_must_be_empty out &&
>>
>> Same comment about asserting the contents of stdout here as well. I am a
>> little confused by this test, though, since there are no packs present
>> in "empty". Shouldn't we be hitting the "no pack files to index" error
>> here?
>>
>> > +                     test_dir_is_empty "$midxdir" || return 1
>> > +             done &&
>> > +
>> > +             write_midx_layer &&
>> > +             test_line_count =3D 1 "$midx_chain" &&
>> > +             git multi-pack-index verify
>>
>> We can drop this last block as well.
>>
>> > +     )
>> > +'
>> > +
>> > +test_expect_success 'skip MIDX layer with empty pack' '
>>
>> Perhaps s/skip/& intermediate/ to distinguish from the previous test?
>>
>> > +     git init empty-pack &&
>> > +     (
>> > +             cd empty-pack &&
>> > +             git config maintenance.auto false &&
>> > +             write_midx_layer &&
>> > +
>> > +             git pack-objects $packdir/pack </dev/null &&
>> > +             cp "$midx_chain" chain.expect &&
>> > +             ls "$packdir" "$midxdir" >files.expect &&
>>
>> I think testing that the MIDX chain file is unmodified makes sense, but
>> no need to test the content of $packdir and $midxdir itself. If there is
>> a reason to test those as well, please ensure to sort them first before
>> comparison.
>>
>> > +
>> > +             for bitmap in --bitmap --no-bitmap
>> > +             do
>> > +                     git multi-pack-index write --incremental "$bitma=
p" >out 2>&1 &&
>> > +                     test_must_be_empty out &&
>>
>> Same comment as above.
>>
>> > +                     test_cmp chain.expect "$midx_chain" &&
>> > +                     ls "$packdir" "$midxdir" >files.actual &&
>> > +                     test_cmp files.expect files.actual || return 1
>> > +             done &&
>> > +
>> > +             write_midx_layer &&
>> > +             test_line_count =3D 2 "$midx_chain" &&
>> > +             git multi-pack-index verify &&
>> > +             git rev-list --test-bitmap 2.2
>>
>> Likewise.
>>
>> > +     )
>> > +'
>> > +
>> > +test_expect_success 'skip MIDX layer with duplicate pack' '
>>
>> Same comments as above, though otherwise this test looks good.
>>
>> Thanks,
>> Taylor
