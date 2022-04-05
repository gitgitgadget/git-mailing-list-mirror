Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945AC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiDECsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiDECsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 22:48:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347C2F495A
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 19:29:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d7so1354736edn.11
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 19:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LbZFjg5/a9btn6FisgHtRa68QRvyHmiiNTT6UrQs3bc=;
        b=cYRF5qtmn0IZ0QISsUKIwKPFBENAz+vZS28Zhb90w/S/TIK45/lZ7JWXvt6oc4AnE8
         PWVprn305a8IV+BVdsZs4H6NXiJfXmkLAgtPBen42e9DH5Ec1U+GbX/v6gWjPCY9YMii
         AlLVBZyL4uBZ+VTE6OtQcQKEUfE5M0qe5m4AOKwlReGs77katgWQWY9g2nPdrq3uGh1G
         tPgyyT8h1j9hLd03WbpPynMSJBDdW9GbAN84GcbytWFi+sNShuY9TBy1xzPhU0Iv1PyZ
         /YMgnavgYjZQqBsxmgS90ZIP603XGiC6guSNo7uVm9GVuEsTPbZYuKMp3lkpSHgvcyYI
         W0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LbZFjg5/a9btn6FisgHtRa68QRvyHmiiNTT6UrQs3bc=;
        b=1IFn/kX6AKB+Km9W9CPbQxrS6bg8Zg1W9tD0u/kVRzWo2tqAi7qn61am7JAx5/Zw3i
         hFEMuQB2fuRSiFx/We923jWeBVmPVJ1pBv/AYSnzXLYJoVbOVkGqSBTuj2FrkrlZ1BGD
         EvR6NyetX3bwPx+a+CtjSbArJdIZ74SHviYFPv6vqfHw0LBHcUgolmjowGoyyoi7CdLH
         +EeP1OrBakUdxPj4DJLVDj4KFfLNPM1y9nFoanlCrVCkkZSAqkhuKzO0chb0jkTyL6Pv
         Hxe0+5ZmhQk0h2xwxi085IZRODJmTvUCwkFPAXJo+UrOVH/2ZSdoVHjulTWjcPVX5y0m
         0yZw==
X-Gm-Message-State: AOAM533W2Wyg2CjH6wvja3Jb5oAJvYuf+nf98r1KgtqwdNfisf41ksFZ
        gS6gdWTfxG14SjhDG7sQTrA=
X-Google-Smtp-Source: ABdhPJxd2bawOFTWZlbxqsb53gsUhRvbq6wH+5/6RlsrnyU8J+PDHvQvJu6xqUmqZB7IFhjqmSTgbw==
X-Received: by 2002:a05:6402:348b:b0:419:172c:e2aa with SMTP id v11-20020a056402348b00b00419172ce2aamr1188835edc.261.1649125789632;
        Mon, 04 Apr 2022 19:29:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm5920826edz.29.2022.04.04.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 19:29:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbYx2-002nKD-FQ;
        Tue, 05 Apr 2022 04:29:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
Date:   Tue, 05 Apr 2022 04:22:49 +0200
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220403132508.28196-1-a97410985new@gmail.com>
 <220404.86lewljovj.gmgdl@evledraar.gmail.com>
 <660d068f-1c8c-7057-0a92-5100791daf80@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <660d068f-1c8c-7057-0a92-5100791daf80@kdbg.org>
Message-ID: <220405.861qycmfdv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Johannes Sixt wrote:

> Am 04.04.22 um 09:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> While we don't use helper macros for these currently there's no reason
>> we can't, I thin the above might be more readable with e.g.:
>>=20
>> 	#define JS_AA "[$_[:alpha:]][$_[:alnum:]]"
>
> Please consider including "identifier" somehow in the macro name. And
> add the trailing '*', which...

Indeed, although for something like this a cute short name is probably
OK, and we can just #undef it right afer.

>> Which would make this:
>>=20=09
>> 	+PATTERNS("javascript",
>> 	+	 /* don't match the expression may contain parenthesis, because it is=
 not a function declaration */
>> 	+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
>> 	+	 /* don't match statement */
>> 	+	 "!;\n"
>> 	+	 /* match normal function or named export for function in ECMA2015 */
>> 	+	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*" JS_AA "*[\t ]=
*\\(.*)\n"
>> 	+	 /* match JavaScript variable declaration with a lambda expression at=
 top level */
>> 	+	 "^((const|let|var)[\t ]*" JS_AA "*[\t ]*=3D[\t ]*"
>> 	+		"(\\(.*\\)|" JS_AA "*)[\t ]*=3D>[\t ]*\\{?)\n"
>> 	+	 /* match object's property assignment by anonymous function and Comm=
onJS exports for named function */
>> 	+	 "^((module\\.)?" JS_AA "*\\." JS_AA "*[\t ]*=3D[\t ]*(async[\t ]+)?(=
\\(.*\\)|" JS_AA "*)[\t ]*=3D>.*)\n"
>> 	+	 /* match assign function to LHS with explicit function keyword */
>> 	+	 "^(.*=3D[\t ]*function[\t ]*([$_[:alnum:]]+[\t ]*)?\\(.*)\n"
>> 	+	 /* popular unit testing framework test case pattern. Most of framewo=
rk pattern is match by regex for "function in class" */
>>=20
>> Wry try to stick to wrapping at 80 characters, so some of these comments
>> should really be wrapped (see CodingGuidelines for the multi-line
>> comment style we use).
>>=20
>> 	+	 "^[\t ]*(QUnit.test\\(.*)\n"
>> 	+	 /* don't match the function in class or in object literal, which has=
 more than one ident level */
>> 	+	 "!^(\t{2,}|[ ]{5,})\n"
>> 	+	 /* match normal function in object literal */
>> 	+	 "^[\t ]*(" JS_AA "*[\t ]*:[\t ]*function.*)\n"
>> 	+	 /* don't match chained method call */
>> 	+	 "!^[\t ]*" JS_AA "[\t ]*\\(.*\\)\\.\n"
>
> ... which makes me wonder why it is not present here. If that's an
> oversight: nice catch!

*Nod*, I just did a dumb search replace and didn't notice that myself,
 but it's clearly making things easier to read.

Asanother thing I noticed: shouldn't that '.' in QUnit.test be escaped?
Presumably we don't want QUnitXtest or whatever.

>> 	+	 /* match function in class and ES5 method shorthand */
>> 	+	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?" JS_AA "*[\t ]*\\(.=
*)",
>> 	+	 /* word regex */
>> 	+	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and=
 its big version */
>> 	+	 "0[xXoObB][_0-9a-fA-F]+n?"
>> 	+	 /* DecimalLiteral and its big version*/
>> 	+	 "|[0-9][_0-9]*(\\.[0-9][_0-9]*|n)?([eE][+-]?[_0-9]+)?"
>> 	+	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
>> 	+	 /* punctuations */
>> 	+	 "|\\.{3}|<=3D|>=3D|=3D=3D|!=3D|=3D{3}|!=3D=3D|\\*{2}|\\+{2}|--|<<|>>"
>> 	+	 "|>>>|&&|\\|{2}|\\?{2}|\\+=3D|-=3D|\\*=3D|%=3D|\\*{2}=3D"
>> 	+	 "|<<=3D|>>=3D|>>>=3D|&=3D|\\|=3D|\\^=3D|&&=3D|\\|{2}=3D|\\?{2}=3D|=
=3D>"
>> 	+	 /* identifiers */
>> 	+	 "|" JS_AA "*"),
>>=20=09
>> Just a thought, I wonder how much line-noisy we could make this thing in
>> general if we defined some common patterns with such helpers.
>>=20
>> Anyway, insted of :alnum:and :alpha: don't you really mean [a-zA-Z0-9]
>> and [a-zA-Z]. I.e. do you *really* want to have this different depending
>> on the user's locale?
>
> That's worth considering.

If it's intentional it makes sense to add some locale-stressing tests to
the tests, i.e. if we really mean to match non-ASCII identifiers etc.

>>=20
>> I haven't tested, but see the LC_CTYPE in gettext.c, so I'm fairly sure
>> that'll happen...
>>=20
>
> -- Hannes

