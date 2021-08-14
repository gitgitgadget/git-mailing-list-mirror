Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAADC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 02:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C2D6103A
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 02:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhHNCIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 22:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhHNCIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 22:08:19 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35EC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 19:07:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x10so15720905iop.13
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJ+yfQqgupf1QXQ1lxvaRX1l7f+xJbk2+qlIMmIn2D8=;
        b=UWDrApbao3a5llzw8E8hYDh0Dc50eTMn9aBO2AfijVypondhKEfqpA/28vfD++Hb24
         ExN19lOpaU9r1Jt4Y3y1VoFYQ39+BPGTsPn80sMcRSRWBio6h4k2vKOdZR3n/ypYY5GZ
         MAqGLrJrKVUGfFYpmwsHcLm8gNWH4DMWPa26vTTMKKobtxXfYYv9965JjtOcwwpqXrhN
         /xtH6Oz671DOWgK74lb2/4I8nBTkorqIjezFPf3dsCYLsc6B9BCgz+TJuCY3jYzkNcuG
         o/htDYoeyfokCjMRrjP2pjqaCtafGy2hYinEuwofrskqN5NXRjJwLMid687qXuSOZlOV
         ZiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJ+yfQqgupf1QXQ1lxvaRX1l7f+xJbk2+qlIMmIn2D8=;
        b=fpHpkwakDe67K52rzQspPVfGNliHy6y3PcrctapBJIfudO4sRE13EU8LgVj4mNdASv
         TaDaCM5iSnhL3b04u9BwNFidXpa58Kkp3ePS4UCTcZwOKEfPer2inDdFQi9KIVpTBUj5
         8Pm8tA5zVy10n0fAhuRSdWWE+eLBq0EiOoXkk1BvTH+XopQUZK97VLuSXUxx0m6jlnDW
         /RwsrtnLBRcThROfp3m771ioOkDRDwQ3gUiYqpw57Dy9dfN+r+ShV2ib2ErBtbhJqZ++
         K/rFIYmiV186xqKWZT+zmPTlDINIHz6hvG7i83yMM2PXWFUQraG/1t2eEmrtIzK2Nx4P
         UIYw==
X-Gm-Message-State: AOAM531F6R6gzjdYpAZf9+2p6VnFsj+B8rRT/JVU3pXogDs7I+NCLJj+
        Ev4HWsujcHjC6pRz7HH8Q0G/64q84Xrn8yJtMRE=
X-Google-Smtp-Source: ABdhPJyvU7jYhVep9F3AIMsJA+uiwxZy+/SDtE630EG6NFeGZNjyZE+OefMuZWOWfFbsiFJvZAMVSZYa4cxpvvvKRfI=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr4200015iop.106.1628906871644;
 Fri, 13 Aug 2021 19:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
 <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com> <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com>
 <xmqqzgtlumob.fsf@gitster.g>
In-Reply-To: <xmqqzgtlumob.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Aug 2021 10:07:40 +0800
Message-ID: <CAOLTT8Qrz_t60i6U0YvrgXKGkqVEx13ts5T1J1qKht3iMzC2bg@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC] cherry-pick: use better advice message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> +++ b/t/t3507-cherry-pick-conflict.sh
> >> @@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick=
' "
> >>      picked=3D\$(git rev-parse --short picked) &&
> >>      cat <<-EOF >expected &&
> >
> > If you quote the here doc end marker then there is no substitution in
> > the here doc so writing
> >
> >       cat <<-\EOF >expected &&
> >
> >>      error: could not apply \$picked... picked
> >> -    hint: after resolving the conflicts, mark the corrected paths
> >> -    hint: with 'git add <paths>' or 'git rm <paths>'
> >> -    hint: and commit the result with 'git commit'
> >> +    hint: Resolve all conflicts manually, mark them as resolved with
> >> +    hint: \"git add/rm <conflicted_files>\", then run
> >
> > means you can replace \" with " here
>
> Hmph, actually the double-quote that opens the body of
> test_expect_success should be stared at with a very cautious eyes,
> as they often do not mean what the author of the patch thought they
> do.  I can see that it already fooled your eyes into thinking that
> there is no substitution, but $picked needs to be substituted into
> its value.  The backslash before it is *not* about guarding it from
> substitution inside here-doc; it is to pass literal "$" into the
> string, which is the last parameter to test_expect_success, that
> gets eval'ed.
>

Yes, the escaping here comes from double-quote of test_expect_success
instead of here-doc.

> The original of this one, for example, would probably have been
> better if written like so:
>
> test_expect_success 'advice from failed cherry-pick' '
>         pristine_detach initial &&
>         SQ=3D'\'' &&
>
>         picked=3D$(git rev-parse --short picked) &&
>         cat <<-EOF >expected &&
>         error: could not apply $picked... picked
>         hint: after resolving the conflicts, mark the corrected paths
>         hint: with ${SQ}git add <paths>${SQ} or ${SQ}git rm <paths>${SQ}
>         hint: and commit the result with ${SQ}git commit${SQ}
>         EOF
>         test_must_fail git cherry-pick picked 2>actual &&
>
>         test_cmp expected actual
> '
>

Um? This section is not working for me.

./test-lib.sh: eval: line 917: unexpected EOF while looking for matching `'=
'
./test-lib.sh: eval: line 932: syntax error: unexpected end of file

> And because there is no single quote in the updated text, it would
> become:
>
> test_expect_success 'advice from failed cherry-pick' '
>         pristine_detach initial &&
>
>         picked=3D$(git rev-parse --short picked) &&
>         cat <<-EOF >expected &&
>         error: could not apply $picked... picked
>         hint: Resolve all conflicts manually, mark them as resolved with
>         hint: "git add/rm <conflicted_files>", then run
>         EOF
>         test_must_fail git cherry-pick picked 2>actual &&
>
>         test_cmp expected actual
> '
>
> which makes it far easier to see that $picked needs to be
> substituted, and the "git add/rm" are to be enclosed in dq pair.

This section is exactly what I want. Using single quotes does make it
look a lot easier.

--
ZheNing Hu
