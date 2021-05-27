Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115CC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA40961090
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhE0LnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhE0LnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 07:43:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BDC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:41:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o5so481847edc.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8/h2gZZohIc2WC7Lb7wDB1cWNEaGHmPVJA0qAD+6o7U=;
        b=VWfoeg5xdtYee2UPerG14fF9Giih3bYLtwT1xF486Br8577KVNfqi+R1HDTYfoArDt
         v+pUzDcsWjP+/oaXKKwU6EZteaRnfYJNd7K/D9xhUot2Nw16FvFDXUCV8XebM90Eqxf/
         NoxhsgbhE89Xabh7ewvLabtWde4KyRHxoT9T/QAFsDsfI2Xq4Gmj6Yc5OQUQOhd8bC/f
         N86lFPzLeWdgN0l4Z7dIspnK7i3dsfB/uEW/TK6SHoWgMIQ6IxL8DvjlS0OFwrTdOBFL
         ChNFvMZgjzm+64/3/yaKZjUJtvdZAnYB+CH++HhroplheQ50EVJPAmPhGsqPsiwA+2xE
         54RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8/h2gZZohIc2WC7Lb7wDB1cWNEaGHmPVJA0qAD+6o7U=;
        b=qlGB+XtIq0snv8xmikO4QFbAdtqwpmvF5EwpspwasT5ra4cHBY1Ji7T/IYzmQBWN56
         yveOguTISa6cGgJfYbzWHdBboZ6tZkbJVw3GrLhUQXeDCfQQIjEMFlfBB9klXHqbwvbW
         wStT+6qRqaADwI9HN9d51gOtTAekqF3OmffsmdCRljMDSoNh/Bnin39Luj+ZC+38imUL
         6A9hCeJmibGcgBNIx1vFVmntOI1/Gc4Oou+Mc9c2HQOcqR54mnYyhII+Xi7vM8qdR0lR
         yeBe+ppBsiJi4tDrP0rktd2yC6H90QAhv4lX/vDNej7hn51EibVHzwbu36YYl4cVWB+b
         AXNQ==
X-Gm-Message-State: AOAM532rWXUdqTL9T/7cfbk8aMGQGzJ5MGV4mfnK9O48xfGJTgvMFLOF
        yFgLGnsPioNxqx5Ae1ZJ3p4=
X-Google-Smtp-Source: ABdhPJxXaNns4uTMaxm4taG5PKUkzzMph/TpSvJxT9DHvHYIWNBEIwt59fCGIHb2SxpwBOsnsf5UIA==
X-Received: by 2002:a50:ab16:: with SMTP id s22mr3544551edc.323.1622115691557;
        Thu, 27 May 2021 04:41:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i2sm911471edc.96.2021.05.27.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 04:41:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/13] send-email: lazily load modules for a big speedup
Date:   Thu, 27 May 2021 13:36:37 +0200
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <patch-10.13-61e3e3c93c5-20210524T074932Z-avarab@gmail.com>
 <xmqqv9759e0z.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqv9759e0z.fsf@gitster.g>
Message-ID: <8735u8mmj9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -use File::Temp qw/ tempdir tempfile /;
>> -use File::Spec::Functions qw(catdir catfile);
>> ...
>> +		require File::Spec;
>> +		push @files, grep { -f $_ } map { File::Spec->catfile($f, $_) }
>>  				sort readdir $dh;
>> ...
>> -	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP =3D>=
 1), @rev_list_opts);
>> +	require File::Temp;
>> +	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(=
CLEANUP =3D> 1), @rev_list_opts);
>
> I suspect I would not be the only one who finds it curious to have
> the distinction between the use of "->" in File::Spec->catfile() and
> "::" in File::Temp::tempdir (and all the other function calls
> touched by this patch).
>
> Wouldn't it be more faithful to the original to do:
>
>     require File::Spec::Functions;
>     push @files, ... map { File::Spec::Functions::catfile($f, $_) }
>
> in the first hunk?  It would save the time readers of "git log -p"
> has to spend on wondering why "catfile" is an oddball.
>
> Of course "man File::Spec" would educate readers where the
> difference comes from, but it is not immediately obvious to me why
> we want to switch in a "lazily load for speedup" that is supposed to
> be optimization-only, even if the class method ends up calling the
> same underlying thing.

It was idiomatic to me so I didn't think of explaining it. Yes it looks
odd, but it's the most straightforward and correct thing to do in this
s/use/require/ change.

The reason to use the File::Spec::Functions wrapper is because you want
File::Spec class methods in your namespace. I.e. to do catfile() instead
of File::Spec->catfile().

To do that requires importing the "catfile" symbol. Since we're doing a
s/use/requires/ here we won't do that (symbols like that are
compile-time), so we'd need to call File::Spec::Functions::catfile() as
you point out.

Except the whole point of that Functions.pm package is to not need that
fully-qualified name, so once we're doing that we might as well call
File::Spec->catfile() instead.

The implementation of File::Spec::Functions is to literally give you a
generaler boilerplate function in your namespace that calls
File::Spec::catfile("File::Spec", <your argument here>), which is what
the "->" class method syntax does implicitly. Calling that wrapper
doesn't make sense here.
