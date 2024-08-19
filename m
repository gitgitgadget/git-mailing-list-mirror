Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8D179206
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086546; cv=none; b=RwWc5NrSZyYyjMfCxWkUue+d0WNrKpoeo7NXrgCs7EUzyMdLStjW0yRxtj6y4u+Z31ABPv1eiM992LRB4P+BxAS/H9IkS8Dhw/7uptDNq6GYR6qmXG8pJyFqpeeYx+qHcajQclE3ET+xt+1gqJY4PyG2jibrgzsWY3WGth25/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086546; c=relaxed/simple;
	bh=tlsD1+Y6xbiADGuu+WjafxoZ0hDL/yAR0s3Ccxrv/K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDeOJ2sWrohpfrzguTsj2ORZv4oy+QdRp/Y6N5NjV3rwicZDEGQzLCNiOaqowPXlIQnHz5IyFuGoXkxP8AHGZ190xxlJR6BZJsBFJ2kPTmDu4KIiFfptjTQwXMyFQBRk7xSK3WkDKI2WZaaZPJXzRdxxKdXvPU5oSD5QKk5C9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPR8U6HL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPR8U6HL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso553131866b.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086542; x=1724691342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuXrV/SykQ8mXPy/4viWt7vDGEavR4bvq0aRWl0hta4=;
        b=EPR8U6HLxuD5u4iUmidO/AD3ePNiq2jRYr+k0c8trlfSF8EAJwtKUjkkp6oUOYQJKE
         qBnpGqqHy49/ysxZ4tIBCvRQMpXNpCgA9F2pFtibKOuN00NVwRt4dNfaHsQ9snuqqKC6
         kz99XEKYhmxUaY11IWvdTMxUwXTv0p4kwW/bt7ptamshM9GWhbeIU6ztrQ2UUYwt54zC
         Sj+hCRhj+PGfolkXlZ4sdnfjJ5PZRpWmhhrpsdrGyELanX5qY7Th67xj2BOx/PTVUWEk
         QKV4rYIYLq3kuwNUC0tCpmoscLVlQb7vNn+Am/0egufB4CANcCyDr/Kf33PsCvWWkx6b
         nqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086542; x=1724691342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuXrV/SykQ8mXPy/4viWt7vDGEavR4bvq0aRWl0hta4=;
        b=W6lRBEnpg7/lHVxGFAMTwnMm6NMUMfcy3e8u5JZgzvag1gOUiySbepic9Sw8F3XDJM
         XxHpPVklAI0AdqpZ5cjPePQD50wU3Hz7iVl3eAY0+axalT4XC8U4dq13daMs/UwwpE3G
         cG4i/OEiKXddONjNvh3ymLk2TA0fkoAqFqPMFUjwHKKl+fyH+dk7NFkMSSXplQepV7jP
         hFbXngDKBuzI9GTSfoWOQKtv5oziXA8k4DV6k/EqvvIh99Omjc44bCctrVH/9WtQE3wH
         NyACoJHNZWKW3G8wEGt2cC8XEaw7MAnU5U70ceZXURnGBDEhWwJ+PUVpRo3BRFD3lcI/
         Obtg==
X-Gm-Message-State: AOJu0Yyd/m6myN/SDlqjnTSVrsX9mOF11sqFHKxerXJV9vWbbh12O1AC
	J+MAC6vOgH35r8TdyHVMu2XU7lEbKHUKAI/SXNNCflPi1DOdEKdCEfAMQufl5Gd9pIj2H2NJmgK
	1OBKsvmpdAsppA7CwcLHX6ipWcTu+Shik
X-Google-Smtp-Source: AGHT+IE0urD5W6dak/DAuCB2S5Dunad4GxMBdf3EkgqEFS5B6J9o4HlMcgOx0YqBjUIXD49Awj0TBajgHr1+srz4sYU=
X-Received: by 2002:a17:907:f14c:b0:a7a:bc34:a4c0 with SMTP id
 a640c23a62f3a-a8392a16d99mr829060866b.45.1724086541782; Mon, 19 Aug 2024
 09:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703034638.8019-2-shyamthakkar001@gmail.com> <20240803132206.72166-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240803132206.72166-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Aug 2024 18:55:29 +0200
Message-ID: <CAP8UFD3E2idN6mUYzEyh11Fzmj07q+BQuyVCtUkPP=cuxsUODw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-oid-array.c to unit-tests/t-oid-array.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 3:22=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-oid-array.c along with t0064-oid-array.sh test the
> oid-array.h library, which provides storage and processing

Nit: I think "oid-array.h" is more an API than a library.

> efficiency over large lists of object identifiers.
>
> Migrate them to the unit testing framework for better runtime
> performance and efficiency. Also 'the_hash_algo' is used internally in

It doesn't seem to me that a variable called 'the_hash_algo' is used
internally in oid_array_lookup() anymore.

> oid_array_lookup(), but we do not initialize a repository directory,
> therefore initialize the_hash_algo manually. And
> init_hash_algo():lib-oid.c can aid in this process, so make it public.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> Changes in v2:
> - removed the use of internal test__run_*() functions.
> - TEST_LOOKUP() is entirely changed where it now accepts a lower bound
>   and an upper bound for checking return values of oid_array_lookup(),
>   instead of passing the condition as a whole literal. (i.e.
>    v1: TEST_LOOKUP(..., ret < 0, ...)
>    v2: TEST_LOOKUP(..., INT_MIN, -1, ...)
>   )

Nice improvements.

> - TEST_ENUMERATION() remains unchanged.

[...]

> +/*
> + * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
> + * GIT_TEST_DEFAULT_HASH. The fallback value in case of absence of
> + * GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1.
> + */

In this comment, it might be helpful to say that GIT_TEST_DEFAULT_HASH
is an environment variable (while GIT_HASH_* are #defined values).
Also while at it, it might be helpful to say that the function uses
check(algo !=3D GIT_HASH_UNKNOWN) before returning to verify that
GIT_TEST_DEFAULT_HASH is either unset or properly set.

> +int init_hash_algo(void);

[...]

> +static void t_enumeration(const char **input_args, size_t input_sz,
> +                         const char **result, size_t result_sz)
> +{
> +       struct oid_array input =3D OID_ARRAY_INIT, expect =3D OID_ARRAY_I=
NIT,
> +                        actual =3D OID_ARRAY_INIT;
> +       size_t i;
> +
> +       if (fill_array(&input, input_args, input_sz))
> +               return;
> +       if (fill_array(&expect, result, result_sz))
> +               return;

It would have been nice if the arguments were called 'expect_args' and
'expect_sz' in the same way as for 'input'. Is there a reason why we
couldn't just use 'expect' (or maybe 'expected') everywhere instead of
'result'?

Also after the above 'input.nr' is equal to 'input_sz' and 'expect.nr'
is equal to 'result_sz' otherwise we would have already returned fron
the current function.

> +       oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> +       check_uint(actual.nr, =3D=3D, expect.nr);

I think it might be better to return if this check fails. Otherwise it
means that we likely messed something up in the 'input_args' or
'result' arguments we passed to the function, and then...

> +       for (i =3D 0; i < test_min(actual.nr, expect.nr); i++) {
> +               if (!check(oideq(&actual.oid[i], &expect.oid[i])))

...we might not compare here the input oid with the corresponding
result oid we intended to compare it to. This might result in a lot of
not very relevant output.

Returning if check_uint(actual.nr, =3D=3D, expect.nr) fails would avoid
such output and also enable us to just use 'actual.nr' instead of
'test_min(actual.nr, expect.nr)' in the 'for' loop above.

> +                       test_msg("expected: %s\n       got: %s\n     inde=
x: %" PRIuMAX,
> +                                oid_to_hex(&expect.oid[i]), oid_to_hex(&=
actual.oid[i]),
> +                                (uintmax_t)i);
> +       }
> +       check_uint(i, =3D=3D, result_sz);

As we saw above that 'expect.nr' is equal to 'result_sz', this check
can fail only if 'actual.nr' is different from 'expect.nr' which we
already checked above. So I think this check is redundant and we might
want to get rid of it.

> +       oid_array_clear(&actual);
> +       oid_array_clear(&input);
> +       oid_array_clear(&expect);
> +}

[...]

> +static void t_lookup(const char **input_hexes, size_t n, const char *que=
ry_hex,
> +                    int lower_bound, int upper_bound)
> +{
> +       struct oid_array array =3D OID_ARRAY_INIT;
> +       struct object_id oid_query;
> +       int ret;
> +
> +       if (get_oid_arbitrary_hex(query_hex, &oid_query))
> +               return;

In fill_array() above, we use check_int() to check the result of
get_oid_arbitrary_hex() like this:

              if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), =3D=3D,=
 0))

It doesn't look consistent to not use check_int() to check the result
of get_oid_arbitrary_hex() here. Or is there a specific reason to do
it in one place but not in another?

> +       if (fill_array(&array, input_hexes, n))
> +               return;
> +       ret =3D oid_array_lookup(&array, &oid_query);
> +
> +       if (!check_int(ret, <=3D, upper_bound) ||
> +           !check_int(ret, >=3D, lower_bound))
> +               test_msg("oid query for lookup: %s", oid_to_hex(&oid_quer=
y));
> +
> +       oid_array_clear(&array);
> +}
> +
> +#define TEST_LOOKUP(input_hexes, query, lower_bound, upper_bound, desc) =
\
> +       TEST(t_lookup(input_hexes, ARRAY_SIZE(input_hexes), query,      \
> +                     lower_bound, upper_bound),                        \
> +            desc " works")
> +
> +static void setup(void)
> +{
> +       int algo =3D init_hash_algo();
> +       /* because the_hash_algo is used by oid_array_lookup() internally=
 */

I think this comment should be above the first line in this function
as it also explains why we need to use init_hash_algo().

Also something like "/* The hash algo is used by oid_array_lookup()
internally */" seems better to me as there is no 'the_hash_algo'
global variable used by oid_array_lookup().

> +       if (check_int(algo, !=3D, GIT_HASH_UNKNOWN))
> +               repo_set_hash_algo(the_repository, algo);
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +       const char *arr_input[] =3D { "88", "44", "aa", "55" };
> +       const char *arr_input_dup[] =3D { "88", "44", "aa", "55",
> +                                       "88", "44", "aa", "55",
> +                                       "88", "44", "aa", "55" };
> +       const char *res_sorted[] =3D { "44", "55", "88", "aa" };
> +       const char *nearly_55;
> +
> +       if (!TEST(setup(), "setup"))
> +               test_skip_all("hash algo initialization failed");

Nice that we skip all the other tests with a helpful message if setup() fai=
ls.

> +       TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
> +       TEST_ENUMERATION(arr_input_dup, res_sorted,
> +                        "ordered enumeration with duplicate suppression"=
);
> +
> +       /* ret is the return value of oid_array_lookup() */

This comment is not relevant anymore in this version.

> +       TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
> +       TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent en=
try");
> +       TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
> +       TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
> +                   "lookup non-existent entry with duplicates");
> +
> +       nearly_55 =3D init_hash_algo() =3D=3D GIT_HASH_SHA1 ?
> +                       "5500000000000000000000000000000000000001" :
> +                       "550000000000000000000000000000000000000000000000=
0000000000000001";
> +       TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
> +                   "lookup with almost duplicate values");
> +       TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
> +                   "lookup with single duplicate value");
> +
> +       return test_done();
> +}
> --
> 2.46.0
>
