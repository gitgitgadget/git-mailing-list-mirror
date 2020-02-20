Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDDC11D24
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102B020801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="e1M1zLYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgBTWTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:19:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:19:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so134803ljb.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzxx7KLvP8c0LOMP/udfpih9fk2Crwa6P1rezFnXJO0=;
        b=e1M1zLYHXUQxruF2RS0PUPC+SHqtQljfGl/46OpTfvoMjnJx8Ggi3tGT+LrwD0E8DB
         CLuvou+ocQlRGvkz1mSZeOGe9Mq8Iws3+i0chY+kjotUbk+vi6AdhUopOBtE8JjceJ8n
         Z1Zf+CEXYnur0evB0Fo6eaxApjJEmJhXPOjf0M77RIFS7rrkpyTyT/KnQzzgWcKfdvDc
         2DoG44LTOWxR+X1aDUkpxmoKV5DHYq+/jblrwh8GAA0wdousZBgxPXRq9B7h+aX8knSl
         UHjxYTLFcoQ6uZNyhuYKvYOlF22wme7ZmAHqhtQTt9PZtLMw1R1Q5AUwnhVfGxUCNdrs
         jPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzxx7KLvP8c0LOMP/udfpih9fk2Crwa6P1rezFnXJO0=;
        b=RikoPIlULIe5n8sW0ZpOawk1Cv+Ac3En237jrflSUmOFnKlqwqBtxK1oRwymsxyMqL
         AfwcX0PLRPkPgThc81fZt1OP20eKrKYwphvjItbTDILsj5Lunj3Md0WeJ+udbyzIZETB
         IqkN5rdoagmDuzwKzZB1ggDJ9hRKCgj1txV0wghOkzq6nVX8ImEpAhT7oLWRCZAA/xvS
         EY9aiYE2+tm6yC/K/Ub8PihGv+T1A1pICHjVgEWWiuggrqboqydsv6WHmsmL6Jvv3jJU
         fphCGlsIic8eapQyb32KQPRWnyHomjh00Kb8eSOLHIUh2uEZPhtYwTcnQWsNhRi3YqtO
         821g==
X-Gm-Message-State: APjAAAW5UMet1jxUezFWF3jE0ONks07HA6WEDuqUP7Q9r/kFVPfuKg1l
        iDLDnoBNIIaGRCu8UdZZv1EdD9pRuh0dd+a9u4A3XQ==
X-Google-Smtp-Source: APXvYqwOrPNI803dyYBU3ANlQDnb+aGUZQdju6yK0UMwLYmd/IV5RR7UHFyRDRtfasamnFgzFPWT2C/vZtjUDRe0LGk=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr20111553ljj.116.1582237171578;
 Thu, 20 Feb 2020 14:19:31 -0800 (PST)
MIME-Version: 1.0
References: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net> <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net> <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com> <20200219015733.GA81560@coredump.intra.peff.net>
 <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com> <20200219035650.GA84414@coredump.intra.peff.net>
 <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com> <20200220112539.GB1252160@coredump.intra.peff.net>
 <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 20 Feb 2020 19:19:20 -0300
Message-ID: <CAHd-oW7HJb2d10U_dcbB6G-UdopQ7HKyghAji=9VhmAgn3Dw_Q@mail.gmail.com>
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Roland Hieber <rhi@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> Another thing that is not satisfying is what should happen in "all"
> mode.  We add "tags/" prefix so in the case we've been discussing,
> the output would be "tags/v1.0-0-g0123456", but the whole reason why
> we add the prefix is to say that the early part of the name, "v1.0",
> is a tag, and it would be natural to associate it with refs/tags/v1.0
> that is *not* Bob's tag.

Yeah, that is not very satisfying, but at least the emitted warning
would make the user think twice before wrongly associating
refs/tags/v1.0 with Bob's tag?

> Having said all that, here is what I have at this moment.
>
> -- >8 --
> Subject: describe: force long format for a name based on a mislocated tag
[...]
>
> The output from "git describe", at least in the modern Git, should
> be usable as an object name to name the exact commit given to the
> "git describe" command.  Using the tagname, when two names differ,
> breaks this property, when describing a commit that is directly
> pointed at by such a tag.  An annotated tag Bob made as "v1.0" may
> sit at "refs/tags/v1.0-bob" in the ref hierarchy, and output from
> "git describe v1.0-bob^0" would say "v1.0", but there may not be
> any tag at "refs/tags/v1.0" locally or there may be another tag that
> points at a different object.
>
> Note that this won't be a problem if a commit being described is not
> directly pointed at by such a mislocated tag.  In the example in the
> previous paragraph, "git describe v1.0-bob~1" would result in "v1.0"
> (i.e. the tagname taken from the tag object) followed by "-1-gXXXXX"

I now this is just an illustration, but shouldn't this example be "git
describe --contains v1.0-bob~1"? Otherwise, I think the tag wouldn't
be found as it comes after the given commit. Testing here without
--contains I get the error "fatal: No tags can describe <sha1 hash>"

However, when using --contains, the output is also not what I
expected. It doesn't fail, but I get "v1.0-bob~1". I.e., it not only
prints the refname instead of the tagname but also don't print any
warnings... This is not what we want, right?

> Show the name in the long format, i.e. with "-0-gXXXXX" suffix, when
> the name we give is based on a mislocated annotated tag to ensure
> that the output can be used as the object name for the object
> originally given to the command to fix the issue.

Another case that came to my mind is when the user runs `git describe
--abrev=0 HEAD` and v1.0-bob points to HEAD~. In this case, v1.0 will
be displayed without suffix, so it is not usable at get_oid(). Should
we, perhaps, also force the long output in this case?

And talking about the forced long output, using `--abbrev=0` in HEAD
(i.e. tag: v1.0-bob), after the patch, will make the complete hash be
displayed. This might be an unnecessary cosmetic nitpick, but we might
want to follow the default behavior when --long is given and use just
as many digits as necessary?
