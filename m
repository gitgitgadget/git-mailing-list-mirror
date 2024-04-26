Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87561DFED
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148705; cv=none; b=Z1Au/kWMbNJZtO5j8CyRFyQnHCYZxJr4FycQld/ilU/q+i3EofV1t4rDeeHE1dN9XqgNHNlJtUnNP7DHSpUKHPym/tvRJcaeUvYixBpmL+eu2TapZYyhk4inzwUlsIaDVixJCnRFmXyuMOf4InPBbMMcEcQlQlbaufp2ZJqz4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148705; c=relaxed/simple;
	bh=byPtuuGW/B0142W2KpbImMR1+7/k3sIHgeMVaW1jD5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyTfL6mczQ4dwKN6Az19QlgLGn8npXCjy2n7YMY8iaO66A/ImAyUr+bTt2zaET21ifTffEhOj0xqzLaQwmteU/EJflrdTCcy6KEyMuqkRYEmFqvlFYuztXjeUCdRd4t/oKqx33bqNYTtdPjs04mTtovW+YwzFlO7KZguk7kxiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIQtiP4w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIQtiP4w"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ae546adf3so37918017b3.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714148703; x=1714753503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URa+wniEC8RVfoRskc/sPpodjAcYRwflqGKjHfvPfFU=;
        b=oIQtiP4wrsN0qq6vVQzKuBlZ1j8yQLiV2A6txEtf1Czr26Hf5DmCms7d6Htzp7HrgG
         ciYgfHJVSXlMh2FWWVoN6lkskl2n2DWxreiLFBjx+K2R2v8lyPFZG7Pu1RNyPhRsbsmR
         R4neIfEYyztdTnxn690Oa4awXIHFT1vnvN0M6kDTJci+/iuLwCoVcHGfl4mwY6JQXKDX
         zHAN1nFxpkN9nQAYcCpsot75CngXnH4Yru5JRDF6pFgByR67FKEPEmBzL/8iApAG+d1F
         cx+871esZkxrwugCvXQuQFfK3RqCfcSTGb/csTNiaXNsxvOprcki54TYpoPOB/l7ZMvE
         FIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148703; x=1714753503;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URa+wniEC8RVfoRskc/sPpodjAcYRwflqGKjHfvPfFU=;
        b=TLcoLP0tX+Q00M5o8BjtCDni0r33Tj0XsW3LD4c8bBJl3MG/7g18Ve5bu8mxeZoW9O
         8YkXE/+sa3Vk2xoFQf9u1ATSWaDs0+jQ+gZRQ72F9c3VQk//kPwy+E9Axc5/1Od4KFbc
         5Wrl1Q+u3fDQVa52O3iwHjn2dcM3w7Jm9O9SBHoVayqlFOhgViCt3fOeAg+ZHhuJq5kZ
         9+WliBJ3w0TB5NdXe22aeWvCUdyIMnTKfn2m2DIhmmumFlVBURcXn10u1kg2CNmH9Blc
         1rNXRbu6uYgVe2BgTysh7RdVIfLfwiDS+d93tgm5DorSCJUvAMeMGY3PVOZU0LXHEbal
         DHoQ==
X-Gm-Message-State: AOJu0YwmV3WuqskYgaHdMBkyLrxdYrfVgSCkctqBchKMrQb8+WR+s5zA
	+xxRitsr6av7WpJp8rGR6igM7eW9yX30/S9hIHQ1mHKmPxt8mqlKYIcvDSXrf70pZx6atS7PjHX
	8Cw==
X-Google-Smtp-Source: AGHT+IETL9MXsIJruM8ifOHPvnhj58u/SBMbsvJlDWoARzZKddkjeudLdwVyIYihIRhG+/dMsbM8lv+meGY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:110e:b0:dcc:8927:7496 with SMTP id
 o14-20020a056902110e00b00dcc89277496mr283458ybu.5.1714148702671; Fri, 26 Apr
 2024 09:25:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:25:01 -0700
In-Reply-To: <CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
 <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com> <4ad0fbbb33cab9d5841689cc5660befe6921d515.1714091170.git.gitgitgadget@gmail.com>
 <CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
Message-ID: <owlywmok3xcy.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 02/10] trailer: add unit tests for trailer iterator
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linus@ucla.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian!

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Test the number of trailers found by the iterator (to be more precise,
>> the parsing mechanism which the iterator just walks over) when given
>> some some arbitrary log message.
>
> s/some some/some/

Fixed locally, thanks. Will send as part of a reroll pending further
review comments.

>> We test the iterator because it is a public interface function exposed
>> by the trailer API (we generally don't want to test internal
>> implementation details which are, unlike the API, subject to drastic
>> changes).
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>
>
>> +static void run_t_trailer_iterator(void)
>> +{
>> +       static struct test_cases {
>> +               const char *name;
>> +               const char *msg;
>> +               size_t num_expected_trailers;
>> +       } tc[] =3D {
>
> ...
>
>> +       };
>> +
>> +       for (int i =3D 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
>> +               TEST(t_trailer_iterator(tc[i].msg,
>> +                                       tc[i].num_expected_trailers),
>> +                    "%s", tc[i].name);
>
> Nit: the members of struct test_cases are used in the (msg,
> num_expected_trailers, name) order, while they are declared in the
> (name, msg, num_expected_trailers) order. I think it would make it a
> bit easier to use in struct test_cases the same order in which they
> are used in the TEST() macro.

This bothered me as well, but ultimately I preferred to see the test
names first in the actual test cases where each one is defined like

     {
        "name of test",
        ...
     },
     {
        "name of another test",
        ...
     }
     ...

instead of the other way around. FWIW this style comes from Golang where
it is the standard practice there. I suppose in this instance we have
test cases like

     {
             "without body text",
             "subject: foo bar\n"
             "\n"
             "Fixes: x\n"
             "Acked-by: x\n"
             "Reviewed-by: x\n",
             3
     },

and the separation between "name" vs "msg" could be a bit confusing on
first glance, but I don't think that's a big deal. Plus our
test_expect_success shell functions also expect the name as the first
parameter, so it would be consistent with that style.

It's unfortunate that we cannot put __VA_ARGS__ as the "first parameter"
to the TEST() macro, like

    TEST("%s", tc[i].name,
         t_trailer_iterator(tc[i].msg,
                            tc[i].num_expected_trailers),
        );

but I suppose that's a limitation of __VA_ARGS__. I also do wonder
whether we even need the test case name to be __VA_ARGS__ at all though
(we certainly don't *need* it here as the test case names are already
unique) --- so it might be fine to have another macro that only takes
the test name and a test function. Something like

    #define TC(name, t) ...

on top of the

    #define TEST(t, ...) ...

we already have, perhaps? IDK.
