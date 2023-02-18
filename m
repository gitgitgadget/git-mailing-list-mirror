Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12CAC636D6
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 03:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBRDE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 22:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRDEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 22:04:25 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D66B315
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 19:04:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fn4so2365262qvb.12
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 19:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676689463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TKLn9DApnyMed9LbyV+xiCSnmnD89Ib0RH6CCa5N2I8=;
        b=IpSwogVmue8a/GzyG81WcL+hn3JkSXVxu5iVOMR7iTDMDCNo0JYBQwP6g1gcLcp43v
         n1sPz4c8g9dK3GAKLyjULNqkss0LstHEcDoPmUMuSQvCtTo6iJqXsgaM+PKuqv3aIC7Z
         gNyyOR/y0h2F8Mv6eTC9H3oafn/LdMqIdSdqVDyGaqFNlIau46OoQ96Z2oIxvbdeM50a
         dpohyZ42NJ8T5t9vPvR5hSy6q99/qIRv/zeCcPScfpXn2KmnpzyX3/hZJ0FAwdv+ZN5a
         PXGyduBPJQ4AeNfmohZhC4Mz4Ya9CAvOep28dfE9n3Ss9Obj71K2joze7Li4mHhUhTNp
         A3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676689463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKLn9DApnyMed9LbyV+xiCSnmnD89Ib0RH6CCa5N2I8=;
        b=iL3GUqlZ81BkDFOhisE0CmWTX47JNsdBxDoDrrLjDT+NsZKTWl5JaCz1odslKs3+Dr
         owAZGg6DLkck/0Bf4TtlseP5Xed9uvBEd1bSH5b86NqYvZb8Qs7i0KW13f+RjBrIWVUz
         rRjQ008oFL1pWtI+l+7Ydo21gokGMRyawZbGV2PN2ewDC3NHjlrJDVXlIazL/juagZix
         SkRoywmOwLAl4oUdUf3PZUUg9u3v6JyAJoslfA5jOYnQWJMpnjhOVnFIJA2SkvXe1vmN
         r2bIcERNEfBExeLuwQAS28htAaA8BOLZ5CbkMkXj0OS5yen3qOIoT93MZz1HDvkW+PJ8
         0sMg==
X-Gm-Message-State: AO0yUKV2urxOmKXxh9yo54+KKs3S90dmaS99vGuBn0X+vlhh+ipnCdE2
        Tc43+g8ku48SQWXiEBPGY2ncVkmCYnfRN8FGjPA=
X-Google-Smtp-Source: AK7set+AxbOKYj62rq0II3rEIeGJw77XjmpVGxhGNaHkeeb+JT1z42GKMJU7Q8QaoB6AS6+zAQ/CRYtGhLy4YvoQZ2A=
X-Received: by 2002:a0c:ca8e:0:b0:56e:a6db:e97d with SMTP id
 a14-20020a0cca8e000000b0056ea6dbe97dmr512471qvk.3.1676689463333; Fri, 17 Feb
 2023 19:04:23 -0800 (PST)
MIME-Version: 1.0
References: <Y+6G9n6cWRT9EKyl@google.com> <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
 <xmqq5yc1p7yn.fsf@gitster.g> <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net> <xmqqpma9m4i1.fsf@gitster.g>
In-Reply-To: <xmqqpma9m4i1.fsf@gitster.g>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 18 Feb 2023 04:04:12 +0100
Message-ID: <CANgJU+VaF7-SJgGPqYGEV5VcJd_nTt2SMOQ5u9mNZ_wsArKT6g@mail.gmail.com>
Subject: Re: Feature request: Add --mtime option to git archive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Feb 2023 at 03:39, Junio C Hamano <gitster@pobox.com> wrote:
> > I do wonder if people would complain (both with the patch above and with
> > brian's proposal) that the resulting tarballs extract everything with a
> > date in 1970. That's not functionally a problem, but it looks kind of
> > weird in "ls -l".
>
> And owned by root:root ;-)
>
> I am sure people would complain.  What matters is if these
> complaints have merit, and in this case, I doubt it.  I especially
> like your "it has been already changing once per second" reasoning
> for this change.

I don't really get the argument as far as it is presented as a reason
/not/ to support a --mtime option as was requested in this thread.

You yourself say "people will complain", and you seem to be planning
to just ignore those complaints as lacking merit.  I honestly don't
understand that, wouldn't it be less noise, less stress, and better
"customer service" to let the user choose what constant is in the
archive?  Then no complaints, and you don't have to explain/argue
to/with everybody why their complaint is without merit over and over.

I could understand this position if letting the user set the --mtime
implied some harm that must be mitigated, but it seems like an odd
choice if there is none.  Especially given it would also future proof
git against people coming up with a good reason not to use the 0 epoch
in the future that you haven't thought of right now. It is not like
epoch's and unix time have a totally uncontroversial and stable
history. 0 has meant multiple dates over time, and the current
definition of 1 Jan 1970, 00:00:00 UTC is problematic as UTC didn't
exist until 1972!  Given it clearly wouldn't be hard to allow users to
select the epoch in these archives then why not do so?

I have seen devs have issues with stuff like this in the past.
Unpacking an archive on one machine showing a different date than one
another, or other weird artifacts. Mac used to use a different 0 epoch
than windows and linux as I recall, etc etc.  I dont remember the gory
details, but i have definitely seen people gnash their teeth over
these kind of decisions before. Why not side-step that if you can and
let people choose their own defaults?

Just my $0.02.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
