Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D3C14
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394607; cv=none; b=Wv4G2bu5NDbmV4zNqazaVPC6udvA4Ab1KGZdCFJMK2wQ5Sx/Mhn8mdErnrGanjENd9q5xzayYMrre6I9ruhD3PTfSPyk3O7iTbZPrGWUHO3tZDAhJcroQwoDOSvnHzrXcBVCBMXIouAtTJcV4h6x220BXWfAKRNd+oUyJkWg+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394607; c=relaxed/simple;
	bh=HXyyXE56ln5s1d+x2dW+yLzUtJYKKITZQ1k1aGZVc2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZrHFkHv9qO1BYhJtDx9Pbv+HhDMBwQj1yE40YwvAF6m5KdMvCqLJy/JLnVLrsRJCQosdxaSNBy4jnwxErUaj9rEzamEWmphUoO649YWNu33JH8HzHHIlbYfn91LcQ+bZWxABnIvCTOUK/0yHfpQarXZoOxpmXFQwYJtDwQFOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbPgjBvR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbPgjBvR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fbaf4cf2b5so30082347b3.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 02:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740394605; x=1740999405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCtg0pu4MY7WFIaPAMsAYix1171jRoh0X3jrDt3kSdc=;
        b=EbPgjBvRuWNcKgm1Jrztrp8FzQW+tPaDyQH6fu6i3COLky51jC13orkLlIh63QnAq6
         +wrrJrlhZjMXTco/2zXDfs7A4nJqMeZoRwmKJ1qQN9dD7fJGexsCkTeHZ7RIuGLEnD0u
         GBH0GnhGnxX7RH1T3bwjt8AWx7mkcDDCAfiVEWQCwosBmPxd3W8wKvIuV9GGfNsUDUiY
         n+4Ij06i9ya2yJsdczC5mbAGYjaoOpZfQuKT2DDV7nHzaqs92ivdTJZQf29dP90cljEP
         kbu/eH1TSA0X5+7UmUVcyw3nBgech4RUkDlVJQ4KLi/rXdz5F4PdCNo3wc6yhrBtjyPc
         +rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394605; x=1740999405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCtg0pu4MY7WFIaPAMsAYix1171jRoh0X3jrDt3kSdc=;
        b=SqT5ZI/x+i5cLQo/WaYhGt+qqq8AwK8j2JJK0cKmFRhdsvw9xqoSwgULf8+WBVzthn
         3JEROsdS1F9OlAjwifw/PwQIBIZL6kS0oBD7QJ5+1QnKeLZt2xDc7PkJE2zqGKhr3Bmg
         0CHlWgOuGkmxOnwqyH/OVEC2yjZ2oTPRg2Ij/Pv88kzxB4k+TZ75HJY5Zu0H7ahRM3RB
         I/HigHw1ozE5WpjL88w6qh1YcOFTrii+PCUL0ryewuYp8rFQ75XNbKSTCSnS4lVQ4xHj
         JIT6QSCG62XhCCaHQCjxjZvbPObQ5iogx2LShsSd96eE4eVqwEwDF53fLT8Ve+9BThD+
         O5PQ==
X-Gm-Message-State: AOJu0YwM74f0/mjjyjIZIfa6G7zuzTfmKdAab+yr30Hn32rAnSJOqMjk
	aRoRzgZa2ui7SUKaWLCDTsmENCClYrZU9XojJBTOISu2U37V7VRjdNlSutC7BXxKxWoOoHR2Y9K
	pHhOEMztrqCVgjcnfiIRux4X0qh8aU0WwocXevQ==
X-Gm-Gg: ASbGncufB+464ICuybiaTC0t/mcV7ALEJ7O5OeZxD6d4RcuaE3U71zjocRti/oYVZMO
	PlWnT89cGGiG5BXk/WtzpZpROP8WMgK3m4D+NNTdVxegVLmDfjOTQMMCB1PFHQ+EeoeqpM6F/rd
	VjYo4kW3Y=
X-Google-Smtp-Source: AGHT+IGk65RxlkkqYrP6CY6wY++hCHK3lxmefLZEaDEHVsr8nF/MbC4dKpOT5JJ/rW7Pn5XzOjBdpf7yqPtO6RuNk3E=
X-Received: by 2002:a05:690c:650f:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-6fbcc3a7888mr91265017b3.38.1740394604976; Mon, 24 Feb 2025
 02:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220082959.10854-1-kuforiji98@gmail.com> <20250220082959.10854-4-kuforiji98@gmail.com>
 <efa58be8-e958-429a-a5bd-8df442f28bee@gmail.com>
In-Reply-To: <efa58be8-e958-429a-a5bd-8df442f28bee@gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 24 Feb 2025 11:56:33 +0100
X-Gm-Features: AWEUYZmXU9_cb7SFLgUrv8MO5Fl0jXCsrb8JgWnTJhu97IbUd7Kyw4iQ6fJRanw
Message-ID: <CAGedMtfEMkA80NkozBucNKeN-wNqeqk2PqJVcvNg9obyZ7Ei2w@mail.gmail.com>
Subject: Re: [PATCH 3/5] t/unit-tests: convert oidmap test to use clar
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 11:04, <phillip.wood123@gmail.com> wrote:
>
> Hi Seyi
>
> On 20/02/2025 08:29, Seyi Kuforiji wrote:
> > Adapt oidmap test script to clar framework by using clar assertions
> > where necessary. `cl_parse_any_oid` handles the necessary checks needed
> > for the test to run smoothly.
>
> I'm not sure what the last half of this sentence means. What checks are
> performed and how does that lead to the test running smoothly?
>

`cl_parse_any_oid()` ensures the hash algorithm is set before parsing.
This prevents issues from an uninitialized or invalid hash algorithm.
Without these checks, the test could behave unpredictably. I=E2=80=99ll upd=
ate
the commit message to make this clearer.

> > Introduce 'test_oidmap__initialize` handles the to set up of the global
> > oidmap map with predefined key-value pairs, and `test_oidmap__cleanup`
> > frees the oidmap and its entries when all tests are completed.
> >
> > This streamlines the test suite, making individual tests self-contained
> > and reducing redundant code.
>
> This seems to be saying that by sharing global state we're making the
> tests self-contained - I'm not sure how that can be true. We need to
> move to sharing a single oidmap between all the tests because clar's
> setup and teardown functions don't take a context pointer. That's fine
> but I don't see how it makes the tests self-contained.
>

Right! Thank you. I'll adjust the commit message accordingly.

> Everything up to this point looks good.
>
> >       while ((entry =3D oidmap_iter_next(&iter))) {
> > -             int ret;
> > -             if (!check_int((ret =3D key_val_contains(entry, seen)), =
=3D=3D, 0)) {
> > -                     switch (ret) {
> > -                     case -1:
> > -                             break; /* error message handled by get_oi=
d_arbitrary_hex() */
> > -                     case 1:
> > -                             test_msg("obtained entry was not given in=
 the input\n"
> > -                                      "  name: %s\n   oid: %s\n",
> > -                                      entry->name, oid_to_hex(&entry->=
entry.oid));
> > -                             break;
> > -                     case 2:
> > -                             test_msg("duplicate entry detected\n"
> > -                                      "  name: %s\n   oid: %s\n",
> > -                                      entry->name, oid_to_hex(&entry->=
entry.oid));
> > -                             break;
> > -                     default:
> > -                             test_msg("BUG: invalid return value (%d) =
from key_val_contains()",
> > -                                      ret);
> > -                             break;
> > -                     }
> > -             } else {
> > -                     count++;
> > -             }
> > +             cl_assert_equal_i(key_val_contains(entry, seen), 0);
>
> I think wed' be better to use clar_fail_f() so that we can keep the
> helpful error messages. Using cl_assert_equal_i() isn't terrible as if
> the test fails at least we know the error code but as we already have
> the logic in place to provide better messages lets adapt it.
>
> There is a change of behavior here as before we'd loop through the whole
> list of entries detecting all the errors. Now we quit on the first
> error. I don't think that matters but it would be good to point out the
> change in the commit message.
>
> Best Wishes
>
> Phillip
Noted! thank you.
Seyi
