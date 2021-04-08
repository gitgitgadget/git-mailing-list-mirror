Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B5C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D555610FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhDHXfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:35:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658FC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:34:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba6so4397217edb.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GQE9RS4/OtVAwwu1SuQeEdlTVA6EpMbeNstZV/gwohQ=;
        b=We8OFKfvh4XJlCdPuU41frNtMVLk/PX46yWmFoGOVe24wiQuFyFNPzsOZ7NSL1KpHT
         YkF5cqKNQqOI8pNE8VGtaFN5iR2xrCjY0IiGmh/Tjw/F4iqZTdi+QHaye65r49mi/E/Z
         Kd/SKiX5saTa3vc8muK7KJRmOZf64nhvKZX7LnCV/z8+yn4r5T0rMGRyyn6DVybBw7zZ
         LnjIeYvF/Aa+Qql3ecoFb0/2yzI16FoSR3Ks3LLRCO4XDAxNrOTM/uSnV4Pol1ROPlAp
         +m/sngBfAiSWlYi/RlprQhsTzeCvEGOpBXO2g3ItrCy5FA42WtNt+rWMLlXkTN9xt7lw
         p0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GQE9RS4/OtVAwwu1SuQeEdlTVA6EpMbeNstZV/gwohQ=;
        b=Jgt2dUI2lRhMIU3+hN/osESsGKkcWJnIPDMEnhGq2SFcqI+Kk9HIR4lENxJtklamSp
         b/8ILsuAObeDAjUSUximv21bF2+w+eE+hss5RC/hTbnpCnJyAT0urN8Iv40KNCNFxGzD
         ncrgxKsFur0ABuZCzsIAJQD/2VXb9u8iv76ApQZoA+Nz16MpD+N8i6aTSz3UrTc1JLWY
         pvG/PqiIUn1WZiUJF4rTCLa0D9KO5nqIEznOe26eWiAUvrB47cmf6YZkfjrosQxKu++q
         gkzXmiKxUs+venJ9F5tNaWSZIo8W48fCmivI9v0L8/beIcn0gFxfhPfFA2inRwB8TC2V
         10vA==
X-Gm-Message-State: AOAM532CWMvLQ1XgJT6SDy86BT7GnUwffXHj7EwhoPnxhayis1jP9ZjN
        5jn1wzskOexigyi5K6xN69ZTj7mcRrcpZA==
X-Google-Smtp-Source: ABdhPJxQKkdJq1ZmMF5WzVFWRmz2uJaioTYPl5KzfHbWQnyoDxGDIIqPQf1JcwgB1l+LoG9Jf/E/hQ==
X-Received: by 2002:aa7:c957:: with SMTP id h23mr14537571edt.301.1617924898165;
        Thu, 08 Apr 2021 16:34:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ca1sm415346edb.76.2021.04.08.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:34:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <xmqqczv4vgck.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqczv4vgck.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 01:34:57 +0200
Message-ID: <87zgy8gxjy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
>> +test_expect_success 'GIT_CONFIG_NOGLOBAL' '
>> +	test_when_finished rm -f "$HOME"/.config/git &&
>> +	cat >"$HOME"/.gitconfig <<-EOF &&
>> +	[home]
>> +		config = true
>> +	EOF
>> +	mkdir -p "$HOME"/.config/git &&
>> +	cat >"$HOME"/.config/git/config <<-EOF &&
>> +	[xdg]
>> +		config = true
>> +	EOF
>> +	cat >.git/config <<-EOF &&
>> +	[local]
>> +		config = true
>> +	EOF
>> +
>> +	cat >expect <<-EOF &&
>> +	global	xdg.config=true
>> +	global	home.config=true
>> +	local	local.config=true
>> +	EOF
>> +	git config --show-scope --list >output &&
>> +	test_cmp expect output &&
>> +
>> +	cat >expect <<-EOF &&
>> +	local	local.config=true
>> +	EOF
>> +	GIT_CONFIG_NOGLOBAL=true git config --show-scope --list >output &&
>> +	test_cmp expect output
>> +'
>
> This test was what initially piqued my curiosity, as the fact that
> the result filtered with the new mechanism has only 'local' misled
> me to incorrectly think that we are suppressing both 'system' and
> 'global' with the single variable.  Until I realized that we cannot
> test the 'system' configuration in our test suite, that is.

I haven't tested this, but that seems like a thing we want to mock in
the test suite by just having git_etc_gitconfig() check a GIT_TEST_*
variable.

I had a git_env_str() in [1] that we could use for that, or maybe it
should be git_env_path() in this case with the same --path handling, or
just do what repo_default_branch_name() does.

1. https://lore.kernel.org/git/20201113161320.16458-1-avarab@gmail.com/
