Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E0CC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D7B22517
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLXAVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgLXAVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:21:45 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4AC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:21:04 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 11so581836oty.9
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/HXn8KbntVHqLOBX3GUfAnr1u/7CRx75lqoLlWpW+j4=;
        b=VutiUaNXyukYvcqpx0qaYErNrntpSzx/P4YP7gk1vbjCOhdbUns5rJI7IQdD5JNVR7
         yDQuP+elMQbvv4Ube3QNfAxsLvu4d0YUt0Fl/EnGsw4C0Qtmv2nWI/lh80CfL2ItYnGO
         vf/C0wJfHb5WPcH8abJYDo1yw6oe59M17QdrlpexkslmTk2+Dc/dJkW8Ubf4fMu0RYfT
         CF/v7AXyM472cn4OckOAUwbepgXQrgu8u5hV7ZOWQewxlvNomyx4KIf+PFIFgykH8Ut4
         iJBwuMKh24gPztqTaqbj+PRa2LNYecALcYamJoPEqwkQl38CwSuL04RW0YB/lKiCIPgz
         cSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/HXn8KbntVHqLOBX3GUfAnr1u/7CRx75lqoLlWpW+j4=;
        b=t181yK7BtMJy5/UAcBPOGcCZ7xlgBwj87D0DZKaV6kpaswcsQY6NQXuI3qadqpPxIG
         z9jeBfA7hJsljypjeB1AS5KakdGwswW1t1+BnarxOppnk6afM+Rt3gbW/ixeB8ws0Jao
         KAjpUtz7c2iex7SAQ9+g045PKb5hbnR9kOrtmXC55dJlZBoAGFehMZiTPr+b8cxc2ECf
         heiExGQjmbKoGB9u5yy83YcsSzdQiqKy3uv4gHzaGkjav0d4TepFpHszN/xFp3OBgCBy
         DCbWcXZvHjE53UWeNj98QSqi/gjUhF/CeJdhA0lKojfgZ0I+Jdpko6t2bvkdk5ZQTu9P
         GzOg==
X-Gm-Message-State: AOAM533aKjF1LkkDTM+kgGC3YHMm+dJhTmpF+fIiv7SHqZC0WJMJA5I3
        QUrwuO9UXjTM09ubrxtTmxc=
X-Google-Smtp-Source: ABdhPJxIPt57SUGzqa7ZpJ3OvCfa+QPIZjqAXlfBoL80rtnsHSrBtLvc8Q03nJTulorrNSTKYagk9w==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr20693912otk.187.1608769264259;
        Wed, 23 Dec 2020 16:21:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x130sm6087774oif.3.2020.12.23.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 16:21:03 -0800 (PST)
Date:   Wed, 23 Dec 2020 18:21:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <5fe3deee26d38_7855a208ed@natae.notmuch>
In-Reply-To: <xmqq1rfg8e3j.fsf@gitster.c.googlers.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
 <xmqqy2hoanps.fsf@gitster.c.googlers.com>
 <5fe3484465fac_198be208bf@natae.notmuch>
 <20201223141950.GA23264@szeder.dev>
 <xmqq1rfg8e3j.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> =

> > On Wed, Dec 23, 2020 at 07:38:12AM -0600, Felipe Contreras wrote:
> > ...
> >> I see 5 courses of action:
> >> =

> >>  1. Drop the offending patch: this is wrong because the bug is still=

> >>     there, we are just not checking for it.
> >>  2. Add a BASH prereq just for that test, or test_expect_unstable (w=
e
> >>     would need to add extra code for both of those).
> >>  3. Add the fix, but not the test for the fix.
> >
> > I'm for this option 3: this patch does fix a bug for users of Bash
> > v4.0 or later, while it doesn't change the behavior with v3.2 or
> > earlier (and with zsh, if I understand correctly).  OTOH, the test
> > doesn't seem to be all that useful: while it does demonstrate the
> > issue, it checks only one of those callsites that passed the wrong
> > suffix, and, more importantly, it doesn't protect us from adding
> > another callsites with similarly wrong suffex in the future.
> =

> Yeah, I might have preferred, if we didn't read your "doesn't seem
> to be all that useful", to keep the test with prereq on bash 4, but
> I think either way is fine.

Even if we add a prereq on BASH4, he is right that the test wouldn't be
all that useful, because it's checking only for one conditional branch,
and the function has quite a few, from the top of my head there are about=

10.

A more useuful test would at least add one check for each one of the
cases. It still would be dependent on the current implementation, but
would be more useful.

I can add that in a future patch series, once the other issues are
resolved.

Cheers.

-- =

Felipe Contreras=
