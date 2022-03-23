Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbiCWFxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCWFxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 01:53:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000543AEA
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 22:51:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so453497ljr.9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 22:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WC/kvTVD9yL1xJSE7oWkJlHDFpme/2JpMaa3pfkdtPU=;
        b=OskP9kcHpFu+HniSIu6K8h6nys9mFOFSC6jZhDsJYRnwe6DoH0cECDYcxFBzs6mH4D
         EzloRDYSIBIBS4Zr5o6CACNurY6O+iarTzYPAaU+/06oh7sGy3kyU8p8YzzWuNP7EMsl
         2fjKtdNBPS7Sc4KhrfYCaLSzDV3GlDSjSXpXxDiK2S7a0zzloCoUQ1Vzgv2s2RS7IBDm
         VTkFmgTHogw+f55MZwQ3STBqVEgL5RfRK6iirgHzgZN4Vv/z+KfB3YLlfQQKnFV9WO0f
         4+brhjIAFdHwLC7VpcJZV2lxYScrKrhOHt7YXPcY7bUo8CVBETTAoUnPRT7iKTGUI6hF
         cxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WC/kvTVD9yL1xJSE7oWkJlHDFpme/2JpMaa3pfkdtPU=;
        b=LlIYIrggs66I9ShzGvTQxJEwYWlYmUQ97ZHvkLyygAX4IymZHOR3yMH6+8/xqiHbDu
         jkenn1if+eIHtwGRLFNUqOScpJ6e9fGYbx8MHwfhzkEJdHPBBkxrNO8S64miHgNRQhS4
         QjXVfXeLZw0Ua2lN7dWQzboZeuKyOTjnQ3GqhtoFXRscq0UdX3/koEnzbqPWAFygY+uM
         t+6nmRXvIgSpPt8cC4nvhdD5/fbCed73/OYH+Ps/tY61EBxgki5zSl1ne3odOfGxQpwI
         MwO7aNtvdf+jX7nkoiVJomR3J4l4BBaZWkG3w5ueT5VC7jlxWtXLdlv42PUUJanz7IM/
         Kktg==
X-Gm-Message-State: AOAM533uwZ7hJJgAF1guUh0OoqS6pdf/JWNdGd6tQbeTH8/ek4JmHBmi
        zgCN48IDsTMT+s+e6RIEM9yW067wRaDC5qoFfVY=
X-Google-Smtp-Source: ABdhPJzsHvmIa7Oabw2Fp6dByBkaUezTZkA5tKY456izPoUgXltXpexkhS9JusnKmu5B8AqL4E6DPTaR0YPlDHnkpEw=
X-Received: by 2002:a2e:9b96:0:b0:249:8705:8f50 with SMTP id
 z22-20020a2e9b96000000b0024987058f50mr9127065lji.73.1648014706910; Tue, 22
 Mar 2022 22:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com>
 <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-patch-7.7-481f1d771cb-20220323T033928Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-7.7-481f1d771cb-20220323T033928Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 22 Mar 2022 22:51:35 -0700
Message-ID: <CANQDOdcfoS-kLkaoXSKBhemDV13aWsoLSf=xUaU84B6_ajqbJA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] update-index: make use of HASH_N_OBJECTS{,_{FIRST,LAST}}
 flags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 8:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> As with unpack-objects in a preceding commit have update-index.c make
> use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
> mode again for "update-index".
>
> Adding the t/* directory from git.git on a Linux ramdisk is a bit
> faster than with the tmp-objdir indirection:
>
>         git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=3D-O3'=
 -p 'rm -rf repo && git init repo && cp -R t repo/' 'git ls-files -- t | ./=
git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update=
-index --add --stdin' --warmup 1 -r 10
>         Benchmark 1: git ls-files -- t | ./git -c core.fsync=3Dloose-obje=
ct -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'ns/b=
atched-fsync
>           Time (mean =C2=B1 =CF=83):     289.8 ms =C2=B1   4.0 ms    [Use=
r: 186.3 ms, System: 103.2 ms]
>           Range (min =E2=80=A6 max):   285.6 ms =E2=80=A6 297.0 ms    10 =
runs
>
>         Benchmark 2: git ls-files -- t | ./git -c core.fsync=3Dloose-obje=
ct -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'HEAD
>           Time (mean =C2=B1 =CF=83):     273.9 ms =C2=B1   7.3 ms    [Use=
r: 189.3 ms, System: 84.1 ms]
>           Range (min =E2=80=A6 max):   267.8 ms =E2=80=A6 291.3 ms    10 =
runs
>
>         Summary
>           'git ls-files -- t | ./git -c core.fsync=3Dloose-object -c core=
.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'HEAD' ran
>             1.06 =C2=B1 0.03 times faster than 'git ls-files -- t | ./git=
 -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-in=
dex --add --stdin' in 'ns/batched-fsync'
>
> And as before running that with "strace --summary-only" slows things
> down a bit (probably mimicking slower I/O a bit). I then get:
>
>         Summary
>           'git ls-files -- t | strace --summary-only ./git -c core.fsync=
=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-index --add --st=
din' in 'HEAD' ran
>             1.21 =C2=B1 0.02 times faster than 'git ls-files -- t | strac=
e --summary-only ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Db=
atch -C repo update-index --add --stdin' in 'ns/batched-fsync'
>
> We also go from ~51k syscalls to ~39k, with ~2x the number of link()
> and unlink() in ns/batched-fsync.
>
> In the process of doing this conversion we lost the "bulk" mode for
> files added on the command-line. I don't think it's useful to optimize
> that, but we could if anyone cared.
>
> We've also converted this to a string_list, we could walk with
> getline_fn() and get one line "ahead" to see what we have left, but I
> found that state machine a bit painful, and at least in my testing
> buffering this doesn't harm things. But we could also change this to
> stream again, at the cost of some getline_fn() twiddling.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/update-index.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index af02ff39756..c7cbfe1123b 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1194,15 +1194,38 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
>         }
>
>         if (read_from_stdin) {
> +               struct string_list list =3D STRING_LIST_INIT_NODUP;
>                 struct strbuf line =3D STRBUF_INIT;
>                 struct strbuf unquoted =3D STRBUF_INIT;
> +               size_t i, nr;
> +               unsigned oflags;
>
>                 setup_work_tree();
> -               while (getline_fn(&line, stdin) !=3D EOF)
> -                       line_from_stdin(&line, &unquoted, prefix, prefix_=
length,
> -                                       nul_term_line, set_executable_bit=
, 0);
> +               while (getline_fn(&line, stdin) !=3D EOF) {
> +                       size_t len =3D line.len;
> +                       char *str =3D strbuf_detach(&line, NULL);
> +
> +                       string_list_append_nodup(&list, str)->util =3D (v=
oid *)len;
> +               }
> +
> +               nr =3D list.nr;
> +               oflags =3D nr > 1 ? HASH_N_OBJECTS : 0;
> +               for (i =3D 0; i < nr; i++) {
> +                       size_t nth =3D i + 1;
> +                       unsigned f =3D i =3D=3D 0 ? HASH_N_OBJECTS_FIRST =
:
> +                                 nr =3D=3D nth ? HASH_N_OBJECTS_LAST : 0=
;
> +                       struct strbuf buf =3D STRBUF_INIT;
> +                       struct string_list_item *item =3D list.items + i;
> +                       const size_t len =3D (size_t)item->util;
> +
> +                       strbuf_attach(&buf, item->string, len, len);
> +                       line_from_stdin(&buf, &unquoted, prefix, prefix_l=
ength,
> +                                       nul_term_line, set_executable_bit=
,
> +                                       oflags | f);
> +                       strbuf_release(&buf);
> +               }
>                 strbuf_release(&unquoted);
> -               strbuf_release(&line);
> +               string_list_clear(&list, 0);
>         }
>
>         if (split_index > 0) {
> --
> 2.35.1.1428.g1c1a0152d61
>

This buffering introduces the same potential risk of the
"stdin-feeder" process not being able to see objects right away as my
version had. I'm planning to mitigate the issue by unplugging the bulk
checkin when issuing a verbose report so that anyone who's using that
output to synchronize can still see what they're expecting.

I think the code you've presented here is a lot of diff to accomplish
the same thing that my series does, where this specific update-index
caller has been roto-tilled to provide the needed
begin/end-transaction points.  And I think there will be a lot of
complexity in supporting the same hints for command-line additions
(which is roughly equivalent to the git-add workflow). Every caller
that wants batch treatment will have to either implement a state
machine or implement a buffering mechanism in order to figure out the
begin-end points. Having a separate plug/unplug call eliminates this
complexity on each caller.

Btw, I'm planning in a future series to reduce the system calls
involved in renaming a file by taking advantage of the renameat2
system call and equivalents on other platforms.  There's a pretty
strong motivation to do that on Windows.

Thanks for the concrete code,
-Neeraj
