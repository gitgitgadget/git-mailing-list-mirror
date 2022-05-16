Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB2C43219
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbiEPUv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348708AbiEPUvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:51:24 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA718427F7
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:27:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cd6-20020a056a00420600b00510a99055e2so6643306pfb.17
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uFya0/I1eMuhB0cRNJD+NnBrVttVtQN8mD0it6Jx8HU=;
        b=gf/FAln9YZ8wssMq8aficTEMCRrRoUVw21k0xMbXz46sBCE8iY601md88A4gWhJvh/
         L3DiswaS2RAAxfE+K3uifhiTXBG2wMKPJe+u1QpAu1V5CiRBBYlvv0/MUWhOF6Fht/eu
         pikMa3wXmAgdbSrCvVshzBThr8ml6W1Vj3m88t2ycpbyBxrr0C8BfnJDsQ3tbDGhxjX+
         sLx6t3WpqADZFFWI87UvcTWvIb55DKyKJ1M3+NvCywlEZOBQ7sd1HV1syI1mxmEeUlLP
         PGyqgLznf64+FmHxkmP2YdkcFbeCGyWWeW8m6mZ/Vgd19JxenzAG/jCGPAHBn0HVwI7k
         nCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uFya0/I1eMuhB0cRNJD+NnBrVttVtQN8mD0it6Jx8HU=;
        b=ILbiU2q/ciy5WLIi2r40uGPPINR+XKbiAniwh3jwQVQzritJWhqZbkdU28eKcSKHxZ
         ATwNvIhbFPgIicNa+bZI5gHbY8gW50Tj9mZqh1UU8PfYq0/6AiMieOtl2koVVJu1RL58
         EXPwDXEx9Urh/4w8uf8zJ50Ys8y47JuRc56v0hQ+o9dD4CsfTY6ufFZSllHQsmo8X0e8
         hNRoH4lLYeuremAlh5Badj4dCWJb2gEFgcbcSc63aARwbvK3xU6fI8zDd2oL/u5OBeJf
         6PCKM2T8jGiS/SRDzVsBzvRgorcvnhzkBgF4t2xMXT0fPVTO/cmLSfnIEdLj84vGWDNZ
         ye4A==
X-Gm-Message-State: AOAM5329qqZXNi9KRrB0AidvvE1a+B95Mj2KZ/igqzSLkvVKqPH0FyJx
        ygbv7Q11P2rGbaFTAuurcdoSWXivi6fbiw==
X-Google-Smtp-Source: ABdhPJzrisNBBQXu81PxB9tazRbXlj2BlxQ4hSshjTKsLPXPgLcuEejPH7Y82eJtjpHR+bu7SPPME6Rp+XRcgw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6e0d:0:b0:3c6:12af:15b4 with SMTP id
 bd13-20020a656e0d000000b003c612af15b4mr16471471pgb.338.1652732830120; Mon, 16
 May 2022 13:27:10 -0700 (PDT)
Date:   Mon, 16 May 2022 13:27:00 -0700
In-Reply-To: <xmqqk0al1e50.fsf@gitster.g>
Message-Id: <kl6lv8u5i5pn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <xmqqy1z12zxr.fsf@gitster.g>
 <kl6ly1z1iati.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqk0al1e50.fsf@gitster.g>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>  * die()-ing is necessary if we're trying to flip the default value of
>>>>    discovery.bare. We'd expect many bare repo users to be broken, and it's
>>>>    more helpful to fail loudly than to silently ignore the bare repo.
>>>>
>>>>    But in the long term, long after we've flipped the default and users know
>>>>    that they need to opt into bare repo discovery, would it be a better UX
>>>>    to just silently ignore the bare repo?
>>>
>>> Would a middle-ground of giving a warning() message help?  Can it be
>>> loud and annoying enough to knudge the users to adjust without
>>> breaking the functionality?
>>
>> Personally, when my tool changes its behavior, I would strongly prefer
>> it to die than to "change behavior + warn". I'd feel more comfortable
>> knowing that the tool did nothing as opposed to doing the wrong thing
>> and only being informed after the fact. Also, I sometimes ignore
>> warnings ;)
>
> Heh, personally I would try very hard not to change the behaviour
> without explicitly asked by the users with configuration or command
> line option.  Flipping the default has traditionally been done in
> two or three phases.
>
>  (1) We start by giving a loud and annoying warning to those who
>      haven't configured and tell them the default *will* change, how
>      to keep the current behaviour forever, and how to live in the
>      future by adopting the future default early.
>
>  (2) After a while, we flip the default.  Those who haven't
>      configured are given a notice that the default has changed, how
>      to keep the old behaviour forever, and how to explicitly choose
>      the same value as the default to squelch the notice.
>
>  (3) After yet another while, we stop giving the notice.  If we
>      omitted (2), here is where we flip the default.
>
> Strictly speaking, we can have (1) in one release and then could
> directly jump to (3), but some distros may skip the releases that
> has (1), and (2) is an attempt to help users of such distros.

Ah, that is very helpful. Thanks. It's pretty clear that I misunderstood
what you meant by "giving a warning() message" - the warning() is there
to prepare users in advance of the change; we don't actually want the
warning() in the long term.

For something as disruptive as discovering bare repos, having all of
(1), (2) and (3) sounds appropriate.

>>> Hopefully "git fetch" over ssh:// and file:/// would run the other
>>> side with GIT_DIR explicitly set?
>>
>> Ah, I'll check this and get back to you.
>>
>>>                                                        I do not yet
>>> find these "problems, such as..." so convincing.
>>
>> What would be a convincing rationale to you? I'll capture that here.
>
> That is a wrong question.  You are the one pushing for castrating
> the bare repositories.

Let me clarify in case this wasn't received the way I intended. Earlier
in the thread, you mentioned:

  The longer-term default should be "cwd is allowed, but we do not
  bother going up from object/04 subdirectory of a bare repository",
  [...]

which I took to mean "Junio thinks that, by default, Git should stop
walking up to find a bare repo, and thinks this is better because of
rationale X.", and not, "Junio does not think that the default needs to
change, but is just suggesting a better default than Glen's".

If it is the former, then there is obviously some thought process here
that is worth sharing.

If it the latter, then I'm in favor of taking Stolee's suggestion to
drop "cwd", since nobody else finds it useful enough. (I like the
'simplification' story, but not enough to push "cwd" through, especially
since it does quite little security-wise.)

>> I'm assuming that you already have such an rationale in mind when you
>> say that the longer-term default is that "we respect bare repositories
>> only if they are the cwd.". I'm also assuming that this rationale is
>> something other than embedded bare repos, because "cwd-only" does not
>> protect against that.
>
> No, I do not have such a "different" rationale to justify the change
> proposed in this patch.  I was saying that the claim "embedded bare
> repos are risky", backed by your two examples, did not sound all
> that serious a problem.  Presented with a more serious brekage
> scenario, it may make the description more convincing.

Fair. I'll mull over this.
