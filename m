Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B54C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjAHKp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 05:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHKp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 05:45:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589FFAE2
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 02:45:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c7so5695336qtw.8
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDnsK+iDLufdfkXq/s7A2tgRz0X1ESmGRBqByQntAWw=;
        b=SsYvpR/mpq3ovzdpqZAIcgyh1kRoGaMV1jnpsBZm0BkynAms6mt97QwdpSSBehf86o
         3Sn5fcWgwbs+GW4SgwcrFKUdCugJIVmSKJX5FWaM0B3CqklimMcmW9R9XnAL5PPJyqzF
         mw2ArRUvBnhRD+9TxcxohQ+gS5MzXvIT+vs1o6ZQ4Vf+dS36TSN19NEO0Bq/46r1+jGH
         kc/3h9lpy/a8YBxVdZqp26tfmYmYuGyGH2hGM5NA0Zf57nl0FFaq9J4RoFgG+H4e0Frp
         HslSzWBCkVRLERAGsbrvCy0coiogIVAlT7oeEZCYboCcoZO+mGwsPalrp63QeCfX2AFf
         MhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDnsK+iDLufdfkXq/s7A2tgRz0X1ESmGRBqByQntAWw=;
        b=URhgqvzexp2T/dh2fN8yAQCtBVWupS+DhtKTvLT0G1worE4IKyZyJ800sy1nIGsCnl
         Zm+CewCNOPK+MqbUOfOA8VYSk5UyFZhAeedupskFrW++jIq4WjVg7Wu6DGwRWFoEiKqb
         8zV7S69cYiFjdVsKPqxv4Utr0YR/7stvqErJ6q4WKlYz0QmohNrABnf2oiMLvQgLISPR
         NQbLBu0W1WRsSh3dJNqTPytjIkYU9IgWtIDnpoj+x4AftKti/QsyTNBQLp4i9olL8zj9
         DUsPZj8GtWj8ispx195Hh/V1slTl8OWz+oaQHs0BSpzxRMhPuKoQn95/LLMYXGspUITI
         nVzg==
X-Gm-Message-State: AFqh2kqEXfW1xukenVGEjK4D1zb3GR0vPZfOPzWkuX1NtcD5Q7dMQCMz
        kj+4to9/fx3uVxQLFZxl3XhkUjK1pbBPzGOydQI+YAj7RuXzCg==
X-Google-Smtp-Source: AMrXdXvqRboNDuuEE8yTeEvuzEcKK95+/hoc3xZc+9cyfJ3TT9wnl08dLAlrpPRwNDDl/finuKLyvuTLTAu0J2PWWeg=
X-Received: by 2002:ac8:720b:0:b0:3a6:18ff:c6c1 with SMTP id
 a11-20020ac8720b000000b003a618ffc6c1mr3848287qtp.683.1673174724600; Sun, 08
 Jan 2023 02:45:24 -0800 (PST)
MIME-Version: 1.0
References: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
 <xmqqmt6tzrcx.fsf@gitster.g>
In-Reply-To: <xmqqmt6tzrcx.fsf@gitster.g>
From:   demerphq <demerphq@gmail.com>
Date:   Sun, 8 Jan 2023 11:45:13 +0100
Message-ID: <CANgJU+UeZJP=tBx7ALd8_X=b25RkAdQ1NkQpueSL-p+kpCO17Q@mail.gmail.com>
Subject: Re: should git rev-parse -q --verify on a range produce output?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 8 Jan 2023 at 03:34, Junio C Hamano <gitster@pobox.com> wrote:
>
> demerphq <demerphq@gmail.com> writes:
>
> > I was curious if it is a bug that `rev-parse -q --verify` produces
> > output for a commit range, and only reveals it is supposed to be used
> > with a single commit as an error message?
>
> I know that the original scenario that the combination of "--verify"
> and "--quiet" was invented for was "I have a string that ought to
> resolve to a single object name, but the object may be missing", and
>
>         if git cat-file -e "$name" 2>/dev/null
>         then
>                 rawname=$(git rev-parse --verify "$name")
>                 true
>         else
>                 false
>         fi &&
>         ... do something that uses $rawname here ...
>
> is a mouthful.  It becomes easier to use if we can say
>
>         rawname=$(git rev-parse -q --verify "$name") &&
>         ... do something that uses $rawname here ...
>
> I do not think the behaviour in usecase outside that was carefully
> designed to the details.

Is this something you think should be fixed? I would give it a go if
there was some direction on what it should do in this case. Just error
early and produce no output?

BTW, the weird behavior of it is documented here:
https://github.com/Perl/perl5/pull/20657

We have some tooling which we use to generate lists of contributors
for each release from the git commits, and we test this code each
build on specific known commit ranges. We noticed this because some of
our tests run in shallow clones and we were using rev-parse to disable
the test if the clone didnt have the right commit range. But it was
failing sometimes when it didnt have the complete range and we were
"doing it wrong" by not checking the error code and just checking to
see if it output anything.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
