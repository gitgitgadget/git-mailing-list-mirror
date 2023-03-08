Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9AC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCHXSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCHXSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:18:33 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC05550D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:18:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so199312pfv.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678317507;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpYLpYbfloWBpj51vvrOBvTQcHojAND+q7/MdFm2NXQ=;
        b=YmvyHJvnhotui35WwKn5K6dCl/jiGmwIX5H3b8YW0HS629RK1VLYXhG030CP6OGZZP
         gdj+4T9qV1cJwl8G56/xCaapN3O30jngirlOqmxJRCPIIpHoo8+JFvJqE6q0/0JnfcIm
         ce0+XqymAo1KrosKtDbpqZiFiBVtZU/6PnpKmuvAeiZxVkLII4IBStI+njLTLrddygjX
         FW7irNrElRtJ8ut2HKc94Vei1VKjFHaWzqDWeH7beveie9sMoPfEN46uGrCBtYyupr/W
         J8X94Nt/qT7MuZHAbO5OpyYTVCM+VmbROAayjHPaMPMXFXADNCxhaTx6Chmw6RGNVhgH
         GFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317507;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CpYLpYbfloWBpj51vvrOBvTQcHojAND+q7/MdFm2NXQ=;
        b=7FmUWPcbfF0kkWfnIFi7bwHO3TNSHkEyh7K1NVeeuad9n61G6lrmFUavGcEjbxXSBm
         4eQLpG7YvcyEh2HuUZNJFbX0iqUao8276bTkCEWJJmK/jfCBGyH3zWLJuPgSL8Rw9Bxw
         XaehylQZv7kKrscOC7Cn61LS3FRbHDq1DIK5qc5trQCHkXD+enfGjlW5A6gzzJQgQI1x
         Li5AxqlP0paqCPqw0cBrYefM/7gkoTrJkOj34jhPS3aExVuyW7GXd2HVyuXTRwlz3gQX
         0p1MJJbJ9y/hEwZEV7W5+CRLPMwsFXr73xzQvTbrzuEvm0evbJ9sAJTHq7dGUqz9Env1
         4FhA==
X-Gm-Message-State: AO0yUKVAKCtR4AJ5DDezsTo8Shy1VssLn9Xa7oogxguU2F/bClXpCN6O
        hHQkOFthQKuwrMhSBA8f1QjI4eEWOeRe3g==
X-Google-Smtp-Source: AK7set+l2+vJCBAjOxFnRwEU1D1zWt2pQtUWPpc+H/mHoM6JCoLMsFt683b/Fzzk3HzZ+CKXWCOrOBTgRzbPWQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:cf46:b0:19e:f660:81d0 with SMTP
 id e6-20020a170902cf4600b0019ef66081d0mr1616542plg.12.1678317506893; Wed, 08
 Mar 2023 15:18:26 -0800 (PST)
Date:   Wed, 08 Mar 2023 15:18:25 -0800
In-Reply-To: <230308.867cvrziac.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
 <230307.86wn3szrzu.gmgdl@evledraar.gmail.com> <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkl4xsj2.fsf@gitster.g> <kl6lcz5ki36g.fsf@chooglen-macbookpro.roam.corp.google.com>
 <230308.867cvrziac.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lmt4mhlxa.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Yes, exactly. Having a config_set on the repository makes sense, but I
>> don't see a good reason to have the reader on the repository.
>
> [...]
>
> I hadn't looked closely at this aspect of it, and just took it as a
> given that we needed to persist this data outside of the configset
> lifetime.

There really isn't a need to persist the "config_reader" state, we'd
only need it while reading the file, and as you've hinted, once we've
cached the info in the configset, we'd just use that instead.

> If that's not the case then we don't need it in the file scope, nor a
> "struct repository" or whatever, and could just have it materialized by
> git_config_check_init(), no? I.e. when we create the configset we'd
> create it, and throw it away after the configset is created?

Yes, except that I'm proposing that we should do it even lower in the
chain, like do_config_from().

> 	The catch (aka the reason I stopped halfway through) is that I
> 	couldn't find a way to expose "struct config_reader" state
> 	without some fairly big changes, complexity-wise or LoC-wise[...]
>
> I didn't look into exactly why config_fn_t would need your new "reader",

Ah, this is what I was referencing in the CL here:

  I believe that only config callbacks are accessing this [config
  reader] state, e.g. because they use the low-level information (like
  builtin/config.c printing the filename and scope of the value) or for
  error reporting (like git_parse_int() reporting the filename and line
  number of the value it failed to parse)

> but if you accept that we could stick such a thing into "the_repository"
> then there's no catch or need for the churn to change all those
> callbacks.
>
> Of course something that wants to use the API as a "real" library would
> need to use some alternate mechanism, as you reference in adding a new
> "config_state_fn_t". You note:
>
> 	but I couldn't find a great way to do this kind of 'switching
> 	between config callback types' elegantly.
>
> So, I don't know, but I was suggesting looking into doing that based on
> "the_repository" in play...

And yes, since the primary purpose is to make git_config_from_file()
usable by a library caller (and secondarily, prepare for a future where
reading config is thread-safer because of less global state, as Jonathan
discussed [1]), I'd prefer not to use the_repository.

1. https://lore.kernel.org/git/20230306195756.3399115-1-jonathantanmy@googl=
e.com
