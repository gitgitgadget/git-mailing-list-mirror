Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26313C19F2C
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiHDHrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHDHrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 03:47:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D333A03
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 00:47:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so12667534ejb.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=5GdI898DNOs2MPlSDx7btf627IJG7aiakaUf9I6DObs=;
        b=QlUhsRsVDtW0M7+uebX2JYHajumALtNGlA0+/0RKifh9GQ5QAWwAYX1x0HcSgdR5lK
         oT6lA6GCkTHOwN5q6CKdmk0Nm9N90QIKTHiAbDXESrkecxe6m3+YR2WemklxeI5yu0za
         haMRoTekotcQa+KMg6IyRn3tgbOYbN5qC6h6qvL4+agX+UCtCgr7MI7ZerFr3/Y1l0hN
         BawaAB0kJyXBU4Bp6HgrQSSgROug//YFVDqo/9ZYYVjIPTwQmEjL3XK3zKgcqBJOj4FS
         7lay6jSDlcJgEp/ceRjZsU/rMFsKxTn7G0S9RMhvNUXRTH47SSxmG+XTM9IEGss19CXY
         oFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5GdI898DNOs2MPlSDx7btf627IJG7aiakaUf9I6DObs=;
        b=DhBp1SeSH+X7akhIHxtNQm0Lq2HzE6oyTQ5DkSbCd6qFrtPpN/1HUUdIkxvvvccXpd
         Jvb/E4ur2+WWLW1nQATL2bFGGFZ6SJtowa788D3AChYRAsA/nV6UP4msxs2jx775+geK
         Yjb+ePW34iM5eNyzri0+sS6Wa9pXqUpyUCeIiwwWKSG8XpODI6I1CFLffryffFbj/wH3
         XaJ1AEpYeZheZsrle6O9J0D75GoGjaGR6fElojgARm4MskE0/BRLmsmdUkjXA5xp2/4n
         rQKmEv/+7zkGfEusoFJahoReSYQUUMju5mod9YzkgkiTEaU7mzkEdrpG+S7IiTVkDD0w
         Rcvw==
X-Gm-Message-State: ACgBeo0M3467HyhUxreCfPYtccNJb7UHVgsK+ZgVzfZSsQavEbtO2KTj
        9HLmErzvR0GVMdzQ/qMtoIg=
X-Google-Smtp-Source: AA6agR6FsNA2F/Hd9mgvQBdWyiJgGjM4aHPFLJkFYH4xfZwrTN6GTO5K2LSUM9Emu795qUtQiN6eMw==
X-Received: by 2002:a17:907:761c:b0:730:babc:11ad with SMTP id jx28-20020a170907761c00b00730babc11admr504302ejc.98.1659599224490;
        Thu, 04 Aug 2022 00:47:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z7-20020a50cd07000000b0043bea0a48d0sm269435edi.22.2022.08.04.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:47:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJVZO-009fqH-2T;
        Thu, 04 Aug 2022 09:47:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Date:   Thu, 04 Aug 2022 09:08:04 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
Message-ID: <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 29 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

Thanks for the re-roll in general, there's a lot of good stuff here & I
hope I find more time to comment on it in more detail, but just focusing
on things that would be hard to back out of once changed:

> [...]
> Another alternative would be to exclude the known namespaces that are
> not intended to be shown. This would reduce the visible effect of the
> change for expert users who use their own custom ref namespaces. The
> implementation change would be very simple to swap due to our use of
> ref_namespaces:
>
> 	int i;
> 	struct string_list *exclude = decoration_filter->exclude_ref_pattern;
>
> 	/*
> 	 * No command-line or config options were given, so
> 	 * populate with sensible defaults.
> 	 */
> 	for (i = 0; i < NAMESPACE__COUNT; i++) {
> 		if (ref_namespaces[i].decoration)
> 			continue;
>
> 		string_list_append(exclude, ref_namespaces[i].ref);
> 	}
>
> The main downside of this approach is that we expect to add new hidden
> namespaces in the future, and that means that Git versions will be less
> stable in how they behave as those namespaces are added.

I see that as a feature, and not a downside. If we simply explain this
in the documentation as e.g.:

	When adding decorations git will by default exclude certain
	"internal" ref namespaces that it treats specially, such as
	refs/magical-1/*, refs/magical-2/* (or whatever). Other such
	special namespaces may be reserved in the future.

There's no lack of "stability", because the ref hiding only act on
what's known to be something we can ignore, because our git version
knows about it.

If git v2.40 knows about refs/magical-1/* but not refs/magical-2/*, but
git v2.50 knows about both it's not a lack of stability that v2.40 shows
one decorated by default, but v2.50 shows neither.

To v2.40 one of them isn't a magical "I know what this is, it's internal
& I can hide it" ref.

I'm aware that we disagree, and some of this was discussed in v1. I'm
not intending to just repeat what I said before.

But it's not just that I disagree, I genuinely don't get your POV
here. We:

 * Know that we have (admittedly probably rare) in-the-wild use of
   non-standard and custom namespaces, and that this series would change
   long-standing log output.

   If I could see a good reason to change the existing "log" behavior
   here I'd probably be sold on it. We try not to change existing output
   in general, but this part isn't "plumbing", and arguably not a very
   "stable" part of the log output either (decorations being optional
   etc).

   But it does rub me the wrong way to sell a change in the name of
   "stability" when it's from the outset doing the exact opposite,
   to....

 * ... are willing to make that one-time change so that we can have
   stability for users that are relying on "decorate" working
   consistently across versions once we're in the new world order,
   because we *might* add new magical refs.

Since the latter group of users don't exist today by definition (this
having not been integrated) why isn't it a better win-win solution to
give those users some --decorate-only-known-refs option/config?

They'd get their "stability" going forward, and without the needless
breaking of existing behavior, no?

> +test_expect_success 'log --decorate does not include things outside filter' '
> +	reflist="refs/prefetch refs/rebase-merge refs/bundle" &&
> +
> +	for ref in $reflist
> +	do
> +		git update-ref $ref/fake HEAD || return 1
> +	done &&
> +
> +	git log --decorate=full --oneline >actual &&
> +
> +	for ref in $reflist
> +	do
> +		! grep $ref/fake actual || return 1
> +	done

I haven't tested, but isn't that last for-loop replacable with:

	! grep /fake actual

?

Or do we have other "/fake" refs we want to include?
