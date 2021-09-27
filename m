Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A7C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F41760F44
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhI0Rrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhI0Rrn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 13:47:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99799C04395D
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:31:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v18so37016220edc.11
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k4d1R6YP/q4WTaxsDXAHiG935uB/kxRLAJboUgBiHzs=;
        b=DIu5LmF9gv/F0usVHPIVosTUVYneHbG4CF3B28LiqH2DeYjNiIaQUxh3FOHyAGFsMn
         Hl2Z1AZCkA1vHAehg6rDlakOkZ6rfIrYYiatir1m3VfhyU+qPaopeJ8LH3kg7nFkTsuS
         iNQtPTQvEqS0sv75JBiYzyp8HEq5+RAcrwq4jKfdMoueqHOMZ/HlVyT6lq/34RxcpCKO
         uqfrSYLjneAt/tVZfqhLGUPujHC4uZZKCu3AB/l0Zq59qz7BZu73BtGmUjh2wOaMSI9t
         Flg6A1SESunQowR3DRpRqXsLOK5gHEwa9tfADzwulduAYtNhwZ4HsZmwjBkTBk+FBFJQ
         qBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k4d1R6YP/q4WTaxsDXAHiG935uB/kxRLAJboUgBiHzs=;
        b=ebTCYymG/7ZrFc7D9Y5f/0bU1yN9LmC5aVi6iXg7wc6Wzg9aClZCeNQJp9NOxaeWSU
         iI0e8p74eZf11BHLTjHMc/H7ZR4cffaViAq0+GvKyXOy024dlX7FgD/kK0wgkaUWBWnR
         KbzlXisHy8IhpwtADdsSBdMeDC1ObKgb9GQYMklUQzRIgPJpFRCBsnm7jKBXNQMJl2zC
         d1kpuQWmfZeCVbS23qfKX/6sTWltpfhzpiXIc6GfgXtHjmqKbfNYLRicMg6h9YktXFkg
         MqfckfPc4SGdRv1LGy7sCG/Z5PTwH3KOmizIiSTyGhbrGAP9DGApMkePEOuLvJqZd3IB
         G4HQ==
X-Gm-Message-State: AOAM533osfLoeMmnums5az4SbMWOpGpnC8g01DoPfDHyH3AIEoCfCzA7
        R50seYsFVAyrL2rhZ10G6OhVcFV2kDmHJg==
X-Google-Smtp-Source: ABdhPJw1u8Q3vP1xiycJ0wDgauSFJEfUNhLxrVAIj3f6SBW8A1e88mZoeZ9P1zodI69tAxOa28/JgQ==
X-Received: by 2002:a50:d90b:: with SMTP id t11mr1353610edj.215.1632763891077;
        Mon, 27 Sep 2021 10:31:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d22sm8979627ejk.5.2021.09.27.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:31:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC PATCH 0/3] grep: don'\''t add subrepos to in-memory
 alternates
Date:   Mon, 27 Sep 2021 19:30:56 +0200
References: <878rzi1ape.fsf@evledraar.gmail.com>
 <296230071f2cabda213b2a5f6f435f9308718569.1632754555.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <296230071f2cabda213b2a5f6f435f9308718569.1632754555.git.matheus.bernardino@usp.br>
Message-ID: <87zgryylfx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Matheus Tavares wrote:

> On Mon, Sep 27, 2021 at 9:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>>
>>
>> On Mon, Aug 16 2021, Jonathan Tan wrote:
>>
>> > Record the repository whenever an OID grep source is created, and teach
>> > the worker threads to explicitly provide the repository when accessing
>> > objects.
>> > [...]
>> > diff --git a/grep.h b/grep.h
>> > index 480b3f5bba..128007db65 100644
>> > --- a/grep.h
>> > +++ b/grep.h
>> > @@ -120,7 +120,20 @@ struct grep_opt {
>> > =C2=A0 =C2=A0 =C2=A0 struct grep_pat *header_list;
>> > =C2=A0 =C2=A0 =C2=A0 struct grep_pat **header_tail;
>> > =C2=A0 =C2=A0 =C2=A0 struct grep_expr *pattern_expression;
>> > +
>> > + =C2=A0 =C2=A0 /*
>> > + =C2=A0 =C2=A0 =C2=A0* NEEDSWORK: See if we can remove this field, be=
cause the repository
>> > + =C2=A0 =C2=A0 =C2=A0* should probably be per-source. That is, grep.c=
 functions using this
>> > + =C2=A0 =C2=A0 =C2=A0* field should probably start using "repo" in "s=
truct grep_source"
>> > + =C2=A0 =C2=A0 =C2=A0* instead.
>> > + =C2=A0 =C2=A0 =C2=A0*
>> > + =C2=A0 =C2=A0 =C2=A0* This is potentially the cause of at least one =
bug - "git grep"
>> > + =C2=A0 =C2=A0 =C2=A0* ignoring the textconv attributes from submodul=
es. See [1] for more
>> > + =C2=A0 =C2=A0 =C2=A0* information.
>> > + =C2=A0 =C2=A0 =C2=A0* [1] https://lore.kernel.org/git/CAHd-oW5iEQarY=
VxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
>> > + =C2=A0 =C2=A0 =C2=A0*/
>> > =C2=A0 =C2=A0 =C2=A0 struct repository *repo;
>> > +
>>
>> I ran into this comment and read the linked E-Mail, and then the
>> downthread
>> https://lore.kernel.org/git/CAHd-oW6uG1fap-T4UF17bJmjoHAqWCDq9KbY+_8a3cE=
nnfATxg@mail.gmail.com/;
>>
>> Given Matheus's "I've somehow missed this guard and the..." there I'm
>> not quite sure what/if we should be doing here & what this comment is
>> recommending? I.e. do we still need to adjust the call chains as noted
>> in the E-Mail the comment links to, or not?
>
> I think we should still adjust the call chains, yes. The downthread
> message you mentioned is kind of a tangent about performance, where
> Junio helped me understand something I had previously missed in the
> code, regarding the persistence of the attributes stack.
>
> But the issue that started the thread was about a correctness problem:
> the superproject textconv attributes are being used on submodules'
> files when running `git grep` with `--recurse-submodules --textconv`.
> The three cases to consider are:
>
> - .gitattributes from the working tree
> - .gitattributes from the index
> - .git/info/attributes
>
> On all these cases, the superproject attributes are being used on the
> submodule. Additionally, if the superproject does not define any
> attribute, the submodule attributes are being ignored in all cases
> except by the first one (but that is only because the code sees the
> .gitattributes file on the submodule as if it were a "regular"
> subdirectory of the surperproject. So the submodule's .gitattribures
> takes higher precedence when evaluating the attributes for files in
> that directory).
>
> Another issue is that the textconv cache is always saved to (and read
> from) the superproject gitdir, even for submodules' files.
>
> Here are some test cases that demonstrate these issues:
>
> -- snipsnap --
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-su=
bmodules.sh
> index 3172f5b936..d01a3bc5d8 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -441,4 +441,104 @@ test_expect_success 'grep --recurse-submodules with=
 --cached ignores worktree mo
>  	test_must_fail git grep --recurse-submodules --cached "A modified line =
in submodule" >actual 2>&1 &&
>  	test_must_be_empty actual
>  '
> +
> +test_expect_failure 'grep --textconv: superproject .gitattributes does n=
ot affect submodules' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +	echo "a diff=3Dd2x" >.gitattributes &&
> +
> +	cat >expect <<-\EOF &&
> +	a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep --textconv: superproject .gitattributes (from =
index) does not affect submodules' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +	echo "a diff=3Dd2x" >.gitattributes &&
> +	git add .gitattributes &&
> +	rm .gitattributes &&
> +
> +	cat >expect <<-\EOF &&
> +	a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep --textconv: superproject .git/info/attributes =
does not affect submodules' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +	super_attr=3D"$(git rev-parse --path-format=3Drelative --git-path info/=
attributes)" &&
> +	test_when_finished rm -f "$super_attr" &&
> +	echo "a diff=3Dd2x" >"$super_attr" &&
> +
> +	cat >expect <<-\EOF &&
> +	a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'grep --textconv corectly reads submodule .gitattrib=
utes' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +	echo "a diff=3Dd2x" >submodule/.gitattributes &&
> +
> +	cat >expect <<-\EOF &&
> +	submodule/a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep --textconv corectly reads submodule .gitattrib=
utes (from index)' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +	echo "a diff=3Dd2x" >submodule/.gitattributes &&
> +	git -C submodule add .gitattributes &&
> +	rm submodule/.gitattributes &&
> +
> +	cat >expect <<-\EOF &&
> +	submodule/a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep --textconv corectly reads submodule .git/info/=
attributes' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
> +
> +	# Workaround: we use --path-format=3Drelative because the absolute path
> +	# contains whitespaces and that seems to confuse test_when_finished
> +	#
> +	submodule_attr=3D"submodule/$(git -C submodule rev-parse --path-format=
=3Drelative --git-path info/attributes)" &&
> +	test_when_finished rm -f "$submodule_attr" &&
> +	echo "a diff=3Dd2x" >"$submodule_attr" &&
> +
> +	cat >expect <<-\EOF &&
> +	submodule/a:(1|2)x(3|4)
> +	EOF
> +	git grep --textconv --recurse-submodules x >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'grep saves textconv cache in the appropriated repos=
itory' '
> +	reset_and_clean &&
> +	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
> +	test_config_global diff.d2x_cached.cachetextconv true &&
> +	echo "a diff=3Dd2x_cached" >submodule/.gitattributes &&
> +
> +	# Note: we only read/write to the textconv cache when grepping from an
> +	# OID as the working tree file might have modifications. That is why
> +	# we use --cached here.
> +	#
> +	git grep --textconv --cached --recurse-submodules x &&
> +	test_path_is_missing "$(git rev-parse --git-path refs/notes/textconv/d2=
x_cached)" &&
> +	test_path_is_file "$(git -C submodule rev-parse --git-path refs/notes/t=
extconv/d2x_cached)"
> +'
> +
>  test_done

Thanks! I think it would be very good to have these tests in-tree along
with an updated comment pointing to them.

