Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526DFC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3DD611BD
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE3QJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhE3QJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:09:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC61C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:07:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so8738968otl.3
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nv0oYB2Ma21k7vvEqMvoj52IJcYPq8Q7jFndKFf+SM8=;
        b=sU4eUDVWG952ahmPQzmPmG1gDCTEL3NX5ipwzT2cqAuj8molAOyrpQqRTBW+zou10E
         coV1kYeavFWwUFNMYqxAMLECYdQTIVU/g3zzG4bTctnloEKNWEpalp87xGlQLtaQQoM9
         cCTx39uPo2bRI94LZErgXf78htUeVjOumqPCJCWu4O1doAXsUF8pgXTP/qJ4liFscjXx
         VMH7lbuPY1aNMl8iWwArcvgn+z+3adm8Na6ayYcg2tGG9vyL7HsH1Mhx1wbMa62ph3LF
         3uvlRtLzPs6wHrE1F1OUUduC/X3HK+4YmIzDSO1XOY4UPYRoF2CtVxswjDUtclHbHJ+/
         KUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nv0oYB2Ma21k7vvEqMvoj52IJcYPq8Q7jFndKFf+SM8=;
        b=h/fV/1lvS1QyPit+uZR1sJvZi54u+PXd+ywX8JQursIapKrNDz5Xri5MAC6gQtsx5r
         5o46XGkgn3d59fNhIOZhIAvdfvdQXyb77jIeoR3+HHjCU/Sq3J2QVdTxzCGmy7QyrOWB
         i7IaGFxe7Zr3ebW02sj1xa0/LVTzdTyM8h2UAETXvqn/uZtB84SQIVZ9vB+Ejnsh7u4+
         x81zqHJZUmd9TFHJOL6lI+MJqQ8bOfikFSN/kB/m0gDnasSixym3yunSRzOGDUU82O1w
         jjMzH9sOJclcQ36bncXCOgFGjjesPPEoia1/wHKTYuPs3w9U5EujBPlEcJfTrcZwnoll
         7FJQ==
X-Gm-Message-State: AOAM531rzyVJY7ETpUnqbx+HMJ5y8AZqMaFKpw9AR95kTyVFltKONkfk
        JEC/xHAbol/hg7cnOervlPg=
X-Google-Smtp-Source: ABdhPJwSTRbmeYVQU65ogPDEGAco1rd3JUBDMJFZGlvq0vOHqbmUV5qvP5S0bBqNlsOz50C91f1ixw==
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr14201145otp.34.1622390859299;
        Sun, 30 May 2021 09:07:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t16sm2272204oie.42.2021.05.30.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:07:38 -0700 (PDT)
Date:   Sun, 30 May 2021 11:07:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b3b84967a62_b937208c@natae.notmuch>
In-Reply-To: <877djg313c.fsf@evledraar.gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
 <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <60b11101e5288_50514208b4@natae.notmuch>
 <87czta2b47.fsf@evledraar.gmail.com>
 <60b2557b5c7da_2650882084e@natae.notmuch>
 <877djg313c.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up by
 >2x
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sat, May 29 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> =

> >> On Fri, May 28 2021, Felipe Contreras wrote:
> >> =

> >> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> >> Returning a flattened list is idiomatic in Perl, it means that a =
caller
> >> >> can do any of:
> >> >> =

> >> >>     # I only care about the last value for a key, or only about
> >> >>     # existence checks
> >> >>     my %hash =3D func();
> >> >
> >> > I was staying on the sideline because I don't know what's idiomati=
c in
> >> > Perl, but Perl and Ruby share a lot in common (one could say Perl =
is the
> >> > grandfather of Ruby), and I do know very well what's idiomatic in =
Ruby.
> >> >
> >> > In perl you can do $ENV{'USER'}, and:
> >> >
> >> >   while (my ($k, $v) =3D each %ENV) {
> >> >     print "$k =3D $v\n";
> >> >   }
> >> >
> >> > Obviously it's idiomatic to use hashes this way [1].
> >> =

> >> For what it's worth idiomatic/good idea and "has an example in the p=
erl
> >> documentation" unfortunately aren't always aligned. A lot of experie=
nced
> >> Perl programmers avoid each() like the plague:
> >> http://blogs.perl.org/users/rurban/2014/04/do-not-use-each.html
> >
> > Perl is an old language, and each() was introduced in 2010, it's
> > expected that some old-timers would not adapt to the new idioms.
> =

> each() has been in Perl since 1987 with perl v1.0, you must be confusin=
g
> it with something else.

I see. I read the each() documentation [1] too hastily:

  When called on a hash in list context, returns a 2-element list
  consisting of the key and value for the next element of a hash. In
  Perl 5.12 and later only...

> In any case, the recommendation against it has nothing to do with its
> age, it's that similar to strtok() it has global state.

Yes, that's what I understood from the blog post you shared, but at
least personally I never assume I can modify a hash like that. I see why
some people need to be careful with it, but "avoid it like the plague"
seems way too defensive programming to me.

[1] https://perldoc.perl.org/functions/each

-- =

Felipe Contreras=
