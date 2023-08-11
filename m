Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A01EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjHKR70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHKR7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:59:24 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657432706
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691776753; x=1692381553; i=l.s.r@web.de;
 bh=UoSMpWgi31gsDz2gnWsn0owUZ/8bS1yLpXFCsNkRuNk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lB8sj4K2HkaHvtbSAKl7OrBkic5GmErxhomZS96IOHdWA26QirinWDCvmriJ6qLcbhU4JlB
 n9teu0xBAznbrlT2Tfh5aBf1YW0RUKp00mh9m5vIVIiUq/7360EOnMAJ9m85Kl46XYYSoucIk
 7TJ2uH0V0lVdAwgq69cTn2kGi39PpFwSBGcTSJkTwP1y42zGGsWhyI9lz4Z3lxDN0R+TkcwhM
 msENHb1UrvYDMBm8hsiS9iqALnPpuDSgfvGakuwzD+9AzQPhAfPglOYHvb6yXG/YFqGx1F7EG
 1KZ4++803EzN+ytmM1JzJxbzT81kouEuxPEVXI2hn9+6ABX9r8Xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QmF-1qTh4P44P7-001S4s; Fri, 11
 Aug 2023 19:59:13 +0200
Message-ID: <fbeadf7d-c16f-0612-6256-fc4355e89638@web.de>
Date:   Fri, 11 Aug 2023 19:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
 <20230811151102.GE2303200@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230811151102.GE2303200@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6MlAs2A80Rks0/zgznXNoAvzbVE/O84psP5IreIPCZKG6nCkbO5
 I3f3fPym1A35kWIuhV0jwRHne9VHaDtREcHOBaynOf3pM0j+jkQmBCOcmccSBeJjgj3ycQ8
 ic/tnZN6uJKbTqn4fjFktcRSw+or2i/uFDXGwd0t5BK7JvmVobYZ5TMVuZLZALW5oUb5lXr
 Rylnho+ezxV5KnDvFh7lw==
UI-OutboundReport: notjunk:1;M01:P0:WDc/KQIMxe8=;zIhLOs21UnWnjBqf0CiHtMAxVE/
 TwsE9cUmGIARo7LoS2DNyfBKLvCEmv+h4FGuBkEB5zc3l+btq/i8sxbDwC7VetlYLewcGluf3
 bglbMjOUyat6hIFVQX9tE1nmDDTtJqTS/xEWLRvOLkRVpY9bZxTWHr7m/LjrlAADzZmTxb+b0
 elhRRAAUL4y0DXoqEqv3w4c4Rvk3qyIkaGvO4JOhseU35kPvoe8jMqya7oTjAid4PJlGm+sTI
 ++HSbsmjZ/1+nRwCbEfrLV4Rh663e3gXOZaUDhRt1p/d1jAbgN31R09tnknklwwV+ru2VKQRp
 2jmpVVbKWm83de7Q2RkbTuaxd75io2XR37nh9oGAb2yp5DANttkZ7yLlR02CX+tvtWFh7Y29i
 +JxSQreGLAZObSyQtpXuXMrPStdCpd6Jedi8dbGkU9Gp6cNiuCn+/+U5n73353CpbK6mY5mVo
 s6sc1EH1Ha7P3Ez5+XepnVVHP2g2/dowD4qffEROhp3EgBLkywj58gQyAq69fKmTg2N6LDhx1
 SzVW7K2p8Yf8ud2KevfEMRE2+kQOeFinRS4tZuYSmyFFlImVJH9nvBURpXgJcI1pwMeQ+68xm
 /pZTZw/azTOTEgphceOqDR2Zn5CN5Zm4wU7IYOn8PigEG4N/x3BKlivUfGlpQNWTbaRGe1zc2
 /S67oNMo8SAaQDvYbIs8g9r+bOAn7UJ8SsQfXV+bxGS0s98NMRyYLKBuscENn9gPQ45ohO6LH
 ukJdhW4Moi4irwdZaU3bs8yNEuTI3CbJ1WiLUjpBYwSFieKIKUnH4iK5TPqnc6pHYshJ4GSYW
 WNspnUFDbNfRNxVBq6CxyECM9HR+2pVsVpcl4bYWZQzqM7KKnpwFgplbsIvBloqDXFYx+TXba
 yiihnG0QJXOvgcJo4p5l9KS0OglPKZDp4QgmQT3M5R42Z26pM92KeV6EQEj4dkmnWEu6mDQFC
 Od7Wx4kxJuKXOl3VOc//ClKCuwQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.23 um 17:11 schrieb Jeff King:
> On Thu, Aug 10, 2023 at 09:10:33PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> I'm not sure there's a portable and non-insane way of doing what we wa=
nt
>>> here. At least at compile-time.
>>
>> We need a wrapper with the correct signature.  The wrapper is plugged
>> into struct option.  The typed callback is called by the wrapper and
>> can be used for a type check in the struct macro.  Demo patch below.
>
> OK, clever. So we have two functions, one with a real body, and the
> other which is used with the void pointer. How do we make sure that the
> real-body one matches the type passed to OPT_CALLBACK(), if it is only
> seeing the void wrapper? I guess that is this bit in short_name:
>
>> +#define OPT_CALLBACK_F_T(s, l, v, a, h, f, cb) { \
>> +	.type =3D OPTION_CALLBACK, \
>> +	.short_name =3D (s) + (0 ? cb(NULL, NULL, 0, (v)) : 0), \
>
> which would cause the compiler to barf, and presumably eliminate the
> dead code (or at the very least never call it at runtime).

Yes, a fake call that doesn't make it into the generated object code,
but is real enough for type checking.

> So I think that works. Though...
>
>> +#define DEFINE_PARSE_OPT_CB(name)				\
>> +static inline int name ## __void(const struct option *opt,	\
>> +				 const char *arg, int unset)	\
>> +{								\
>> +	return name(opt, arg, unset, opt->value);		\
>> +}								\
>
> we are defining an inline function with the explicit goal of passing it
> as a function pointer. I don't remember all of the standard's rules
> here. Are we guaranteed that it will create a linkable version if
> necessary?

I don't see on which basis the compiler could refuse.  We can't expect
the function address to be the same across compilation units, but we
don't need that.  If there's a compiler that won't do it or a standards
verse that makes this dubious then I'd like to know very much.

> We could probably drop the "inline" (and perhaps would need to add
> MAYBE_UNUSED in such a case).

Yes, we can use a non-inline function as well, but then we'd need to
define it once somewhere and declare it separately, though, which is
inconvenient.  It needs to have the same visibility as the typed
function.

We better not use MAYBE_UNUSED because the wrapper is the actually
invoked callback.

>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index b28a4a1f82..ce16c36de2 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -558,15 +558,17 @@ static void describe(const char *arg, int last_on=
e)
>>  	strbuf_release(&sb);
>>  }
>>
>> -static int option_parse_exact_match(const struct option *opt, const ch=
ar *arg,
>> -				    int unset)
>> +static int option_parse_exact_match(const struct option *opt UNUSED,
>> +				    const char *arg, int unset, int *value)
>>  {
>>  	BUG_ON_OPT_ARG(arg);
>>
>> -	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
>> +	*value =3D unset ? DEFAULT_CANDIDATES : 0;
>>  	return 0;
>>  }
>>
>> +DEFINE_PARSE_OPT_CB(option_parse_exact_match);
>
> I wondered about combining these, like:
>
>   DEFINE_PARSE_OPT_CB(option_parse_exact_match, int) {
> 	...the real body here...
>   }
>
> But I guess that may confuse non-compiler parsers, and it doesn't leave
> room for annotations like the UNUSED above (which ironically is still
> needed, since now we pass opt->value as its own parameter).

I get the idea.  Something that looks like a function attribute or
decorator.  I don't see no nice way to achieve that, though.

> So I dunno. Clever, for sure, and I think it would work. I'm not sure if
> the extra code merits the return or not.

Sure, why check types -- script languages get work done as well.  (I'm
fresh off a Python basics training, nice quirky language..)  But we're
in C land and static typing is supposed to help us get our operations
correct and portable.

A good example in parseopt: The patch below adds type checking to the
int options and yields 79 warning about incompatible pointers, because
enum pointers were used in integer option definitions.  The storage size
of enums depends on the member values and the compiler; an enum could be
char-sized.  When we access such a thing with an int pointer we write up
to seven bytes of garbage ... somewhere.  We better fix that.

It also gives me 73 sign warnings because we like to use unsigned int to
store int options for some reason.  No problem storage-wise.  I have to
admit that I don't really understand why -Wpointer-sign is in -Wall and
not only in -Wpedantic.  But it could mean a user gives a negative value
for something and we interpret it as a huge value.  Probably still worth
fixing to avoid the general weirdness.

My point is: If we don't check types we deviate.  It just happens.

Ren=C3=A9


PS: We could simplify the type check like this:

	.short_name =3D (s) + (0 && (v) =3D=3D (int *)0), \

This yields -Wcompare-distinct-pointer-types for all 152 cases, which
may suffice.  But comparisons of pointers are only defined for those
that point to the same object or just past it if I'm not mistaken, so
this way works only by accident and the comparison part of the warning
is misleading anyway.  Sill looking for a simpler type check..



diff --git a/parse-options.h b/parse-options.h
index f957931cfa..dafea28b55 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -168,9 +168,14 @@ struct option {
 	parse_opt_subcommand_fn *subcommand_fn;
 };

+static inline int parse_options_noop_int_ptr(int *p UNUSED)
+{
+	return 0;
+}
+
 #define OPT_BIT_F(s, l, v, h, b, f) { \
 	.type =3D OPTION_BIT, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -180,7 +185,7 @@ struct option {
 }
 #define OPT_COUNTUP_F(s, l, v, h, f) { \
 	.type =3D OPTION_COUNTUP, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -188,7 +193,7 @@ struct option {
 }
 #define OPT_SET_INT_F(s, l, v, h, i, f) { \
 	.type =3D OPTION_SET_INT, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -227,7 +232,7 @@ struct option {
 }
 #define OPT_INTEGER_F(s, l, v, h, f) { \
 	.type =3D OPTION_INTEGER, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.argh =3D N_("n"), \
@@ -245,7 +250,7 @@ struct option {
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { \
 	.type =3D OPTION_BITOP, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -255,7 +260,7 @@ struct option {
 }
 #define OPT_NEGBIT(s, l, v, h, b) { \
 	.type =3D OPTION_NEGBIT, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -267,7 +272,7 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { \
 	.type =3D OPTION_SET_INT, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
@@ -276,7 +281,7 @@ struct option {
 }
 #define OPT_CMDMODE_F(s, l, v, h, i, f) { \
 	.type =3D OPTION_SET_INT, \
-	.short_name =3D (s), \
+	.short_name =3D (s) + (0 ? parse_options_noop_int_ptr((v)) : 0), \
 	.long_name =3D (l), \
 	.value =3D (v), \
 	.help =3D (h), \
