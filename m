Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842D8F5E
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407865; cv=none; b=BSkhn9143WQLO/k+vajExd9n615HAY0vD5owHi6WZ9eBAAyjzQTJaNGbG2GemTt9vaXYxURawh6Cmg5i3q9ioGikU+Ppa89yWAZIaxQAbYfRx2MeV0H7AwfnP/D2skDBBjYt9g6Cfrxh35Q9gA1THUhaGUtZkRntuWHqQ8S2uK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407865; c=relaxed/simple;
	bh=y2bYU6dUGohEolVFIjCa+yCjYVynKWzzxf2k/r+PhDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tp3oAUmHpfj2KnFONhH9PQpAJ4Y6nzJMTeHf9pWO4PnfskNHJlut+Tl4s64GZkxY4zDPJfIgz/aa04BjEHekTK/uTvvXUOISjj+s2zghtVFLioDk/QRpUC6cU9T+azDJAGgw0jxVYKXZaL+1iO1o/f7LFGdy229VrPona8Nk6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdNyfdMu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdNyfdMu"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53a91756e5so971889276.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 23:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736407863; x=1737012663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hV+HoiLxZOIhFvXwg1A5Ktj5soUfarnEj6YzPOLF+RQ=;
        b=jdNyfdMudV5KGtUvaWjmzN9YwcrJ3bw0YtO6mxkCCsxc6NmtD8XCi+S/5KOFgI5cWy
         73UNLlJ+CS7TyTSOln5RNx0sp7kjQCVSdZn8KfwDob85F6XpMvhP8DUZ+1AyD8OWzz0/
         3gx2vB5xm+G6fRcnLgqF1aZosp40zyf3HRItZn1PxNyfKZh3dB6Ftpt7YeA+a7fnOZSA
         /FbL+Ge2ExpGpS3OKkklU3pWdizvbP2Yf/TA/rKcUcoEPz5SN60kvTIYvKMfjgr+8fJ9
         0XFIlefP2qQln3nositxS0Wz1jdpPECEXxR1Np/1f1asz73knjoSH28Vvpp/KzEbG8O/
         yKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407863; x=1737012663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV+HoiLxZOIhFvXwg1A5Ktj5soUfarnEj6YzPOLF+RQ=;
        b=LKn/5avsM5qGXGl3JsIKzjb5wUscIbbbWmszBgXJbZKrJfVGYVJ21C7Qot2BoCAxIe
         x7Bliub22L+lMzn22IK4GZ2/IZnAiaUVH/hvjukziw2eccNWgRfWtgUjZhvAaR7RA392
         bVSrBUou8loRqhLYHgITMIjipX9EC+vaBrqbC9H5NkWIS6z3cild53NVU89ooEZAMdhi
         5SfgAKiIRHmF2MDc3bXgZnNByMxj6b9LMjav+R2LZ9aoLimkA6T2rc+VBbGnCzCWT1Ag
         ZKyWZzYTBwoE6G8XavYcSvudwc08hPnGQGMC6Zvy9b1I9ZzSuhkPskHXct4TWB7pIGOR
         +grA==
X-Gm-Message-State: AOJu0YxI4mynryQbPJZq43RbmDjx/8qziU10EHwbhfo7nNuh1ezVec32
	qQF278U8I4vE3J0Ab4nTYc+pAvdsb/XlwNiHNL56QNTefTaKI4AX82d2uKBAjUkRPBg2r1pN3fh
	BDLN1pQQqAgGaaosd7sWt2qU+qdU=
X-Gm-Gg: ASbGnctiUm/q6HQXqxqrlLEOOuxJPjNy03Uxm9vtzf1PSIWvYklaQs49JVuP2EF6Wb7
	RWBFbZp8LDDUlMg/6CuFWw5mPUustmATPKZBv
X-Google-Smtp-Source: AGHT+IHoSaIkFcEaAcnikThKfPuqBi9JKPD86nFMMaoBYg9H2VGVJ+6XtrK9tjkLeJ3X8hSbUSz7eJ5gX+4Mv0Aooa8=
X-Received: by 2002:a25:6a0a:0:b0:e4b:25c6:54e5 with SMTP id
 3f1490d57ef6-e54ee1f3e9amr3454351276.37.1736407863161; Wed, 08 Jan 2025
 23:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107091932.126673-1-kuforiji98@gmail.com> <20250108120339.225596-1-kuforiji98@gmail.com>
 <20250108120339.225596-2-kuforiji98@gmail.com> <xmqqv7upnwsp.fsf@gitster.g>
In-Reply-To: <xmqqv7upnwsp.fsf@gitster.g>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Thu, 9 Jan 2025 08:30:49 +0100
X-Gm-Features: AbW1kvaXmge2bYCPNAlHXI9TG4SOPXdesln45YEE9sbmxxg44n9bNdXSHWUd2g8
Message-ID: <CAGedMtd8GxYHj_N9XRwFb11jyRxk4qFASoKHw8iU2KWMPfucoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] t/unit-tests: convert hash to use clar test framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 16:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> >  CLAR_TEST_SUITES += u-ctype
> > +CLAR_TEST_SUITES += u-hash
> >  CLAR_TEST_SUITES += u-strvec
>
> This is inserted in the middle, presumably because a list without
> inherent ordering is by default maintained as a lexicographically
> sorted list.
>
> > diff --git a/t/meson.build b/t/meson.build
> > index 602ebfe6a2..d722bc7dff 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -1,6 +1,7 @@
> >  clar_test_suites = [
> >    'unit-tests/u-ctype.c',
> >    'unit-tests/u-strvec.c',
> > +  'unit-tests/u-hash.c',
> >  ]
>
> So, shouldn't we do the same here?
>

Yes, we should. I'll make the necessary adjustment in the next
iteration. Thanks!

> > diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/u-hash.c
> > similarity index 79%
> > rename from t/unit-tests/t-hash.c
> > rename to t/unit-tests/u-hash.c
> > ...
> >  #define TEST_HASH_STR(data, expected_sha1, expected_sha256) do { \
> >               const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> > -             TEST(check_hash_data(data, strlen(data), expected_hashes), \
> > -                  "SHA1 and SHA256 (%s) works", #data); \
> > -     } while (0)
> > +             check_hash_data(data, strlen(data), expected_hashes); \
> > +     } while(0)
>
> Unwanted droppage of SP between "while" and "(0)".
>
> >  /* Only works with a literal string, useful when it contains a NUL character. */
> >  #define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) do { \
> >               const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> > -             TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
> > -                  "SHA1 and SHA256 (%s) works", #literal); \
> > -     } while (0)
> > +             check_hash_data(literal, (sizeof(literal) - 1), expected_hashes); \
> > +     } while(0)
>
> Ditto.
>
> > -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> > +void test_hash__empty_string(void)
> >  {
> > -     struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
> > -     struct strbuf alphabet_100000 = STRBUF_INIT;
> > -
> > -     strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
> > -     strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
> > -
> >       TEST_HASH_STR("",
> >               "da39a3ee5e6b4b0d3255bfef95601890afd80709",
> >               "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
> > +}
> > +
> > +void test_hash__single_character(void)
> > +{
> >       TEST_HASH_STR("a",
> >               "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
> >               "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
> > +}
>
> OK.
>
> I'll skip the rest as I expect they would be faithful conversions.
>
> Thanks.
>

I'll make the required changes, thank you for pointing them out.

Thanks
Seyi
