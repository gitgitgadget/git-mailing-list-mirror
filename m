Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74213C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 23:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhLIXgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 18:36:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38468C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 15:33:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z13-20020a627e0d000000b004a2849e589aso4526952pfc.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=MnfHyr70lM278LXeTzisYzZZkED8KGZ7FrSbMygZ3+4=;
        b=gbV7vqtW8Q8Xdsk2V0UxspOVSdquodKnXtHYSNRlYn550hA/ZoArTMhPFMHrveq8xT
         mZ8XwzrylY6hOpV7E2eE3L5DXjhvKJB3eefIa8iGvJhkZp6kYdo5FHIkq9vI0P6FcyfW
         jiW5g0c8YRytgJq9qA2ASQ+YAtWDX3jO/guh2Y6NCHQaIPrenzoqW4cLqy2QujhLxLCe
         o7fZO85pMeUoeh987+9C2vrlBqe3AFArEqn1VN+KM5jzS7KLh8hVBlMrKoLlBYEnxbnI
         1x2BLl4yQojSrYbVdWr0RviEHt9Il7zzZQJzbzV75J/ddXWRdYUX5oQo3jMnOepRUz2Y
         QpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=MnfHyr70lM278LXeTzisYzZZkED8KGZ7FrSbMygZ3+4=;
        b=1TNpuS1KqgP4kjtUhBr/sssMbual3CUG14vcVQEjmmuvC1P1O/A3yxwv2uOhHG7oWz
         H8Dsc9SAkSOqtqxetWc5lT+TWMwQ/8FhLW/GIu0GyerNuehOdwjtj028K4/2Ku7rGx99
         co2b+yD2DG7sf3k3Ye86+Ah0O/NjTy/HYB9pMz413FUJNG1Kt8nAnIpv+bwBZyeCSxG+
         fQAFfGmEKejVizAfWUangDzDfxBzPyaCQEPHY1Y1WB4WNCnmTmMcYD+KqSSHjwObLv1L
         pPRq6BRWSQQjleDaAp+9Z0YOt5lQxcQaTHcU89/JdnyACSQKOXs4DMHd0RtDMTb8HOVM
         nkjQ==
X-Gm-Message-State: AOAM533Ik9vwZwN0xMwqBhXtnYc5+JIrcF2Fov2Af4F6doGsn537D7V+
        khEb83Bv44qrV80l+kzlKNmgI2u2rSyDBw==
X-Google-Smtp-Source: ABdhPJyMuT9igwr7ptKHrmgY1OQFUrh0Zybau54Rx1BmC2PRlyktG8zRoeO0H+Aoz+LiJdLq4KPrgI+ZukpB6Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:d217:: with SMTP id
 a23mr886475pgg.143.1639092799648; Thu, 09 Dec 2021 15:33:19 -0800 (PST)
Date:   Thu, 09 Dec 2021 15:33:17 -0800
In-Reply-To: <20211209223919.513113-1-jonathantanmy@google.com>
Message-Id: <kl6l8rwt9ww2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lwnkean33.fsf@chooglen-macbookpro.roam.corp.google.com> <20211209223919.513113-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > +`hasconfig:remote.*.url:`::
>> > +	The data that follows this keyword is taken to
>> > +	be a pattern with standard globbing wildcards and two
>> > +	additional ones, `**/` and `/**`, that can match multiple
>> > +	components. The first time this keyword is seen, the rest of
>> > +	the config files will be scanned for remote URLs (without
>> > +	applying any values). If there exists at least one remote URL
>> > +	that matches this pattern, the include condition is met.
>> > ++
>> > +Files included by this option (directly or indirectly) are not allowe=
d
>> > +to contain remote URLs.
>>=20
>> Wondering out loud.. Reading this and =C3=86var's comment [1], I wonder =
if we
>> should make it clear to users *why* we choose to forbid remote URLs.
>>=20
>> Since this series is setting a precedent for future "hasconfig:"
>> conditions (files included by "hasconfig:foo.*.bar" cannot contain any
>> "foo.*.bar" values), it would be useful to git developers to explain
>> *why* we chose to do this. And if we're documenting it for ourselves,
>> we might as well write it in the public docs. That way, users would know
>> that this is more of a guardrail (because it's simpler to understand
>> this way) than a hard limitation.
>>=20
>> [1] https://lore.kernel.org/git/211207.86k0ggnvfo.gmgdl@evledraar.gmail.=
com
>
> The explanation is rather long, though. It goes something like this:
>
>   If the main config is:
>
>   [remote a]
>     url =3D bar
>   [includeif hasconfig:remote.*.url:foo]
>     path =3D foo
>   [includeif hasconfig:remote.*.url:bar]
>     path =3D bar
>
>   and "bar" contains:
>
>   [remote b]
>     url =3D foo
>
>   Should "foo" be included? For now, we avoid these situations
>   completely by prohibiting URLs from being configured in "includeif
>   hasconfig".
>
> If you can think of a concise explanation, maybe we can include it.

Yeah, I can't think of a concise-yet-clear way to convey this to users
(if I had thought of one, I wouldn't have prefaced my original comment
with "Wondering out loud").

Spitballing here...

  `hasconfig:remote.*.url:`::
    The data that follows this keyword is taken to
    be a pattern with standard globbing wildcards and two
    additional ones, `**/` and `/**`, that can match multiple
    components. The first time this keyword is seen, the rest of
    the config files will be scanned for remote URLs (without
    applying any values). If there exists at least one remote URL
    that matches this pattern, the include condition is met.

  - Files included by this option (directly or indirectly) are not allowed
  - to contain remote URLs.
  + Because new remote URLs might affect the correctness of the include
  + condition, files included by this option (directly or indirectly) are
  + not allowed to contain remote URLs.

Although, upon further reflection, I wonder if this approach of banning
config variables really gives us the safety we want after all. Reworking
your example, say we expand "hasconfig" to include
"hasconfig:branch.*.merge" then we can have this in the main config:

   [remote a]
     url =3D baz
   [branch c]
     merge =3D bar

   [includeif hasconfig:remote.*.url:foo]
     path =3D foo
   [includeif hasconfig:branch.*.merge:bar]
     path =3D bar

and "bar" contains:

   [remote b]
     url =3D foo

we end up with the exact same question of "Should "foo" be included?".
This shows that the rule isn't actually "files included by
hasconfig:remote.*.url cannot include remote.*.url", but the much more
restrictive "files included by hasconfig:<anything> cannot include any
config values that can appear in hasconfig". This sounds pretty unusable
to me..

But I think that with the semantics you've defined, we don't really need
to forbid config variables. This section describes:

  The first time this keyword is seen, the rest of the config files will
  be scanned for remote URLs (without applying any values). If there
  exists at least one remote URL that matches this pattern, the include
  condition is met.

which, to me, gives us a pass to say "the first time we see a hasconfig,
we will do an additional scan without applying values". That doesn't
sound _too_ confusing to me, but I don't know how it looks to someone
with fresh eyes.

Forgive me if this exact suggestion came up before on-list (I know we've
discussed this exact approach off-list).
