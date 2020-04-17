Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD25CC2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB4F2137B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="j6mmcde7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgDQVTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDQVTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 17:19:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD2C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 14:19:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so3491045ljp.9
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UVjNG9Gw9PObXvQopqMB4R8ZRqG9xU5d10VAS7WGOBk=;
        b=j6mmcde7tgACRPR1bzeqHvvgbBNgvqVQ2RpInO+nhhee83w6lFHyj0vn5wxeaIBQu+
         JjV9x0MVR4Zim9MQOpScghkpv2d+jigDHq3ca3tPCwDRYcbf+WGUo/GC6aZH3Bw76t9s
         PJci8lEot5/KqmBqqMqeKsEW+h9OM+F3E4zGmZ/z+ctF6Uo7PMNtlAsCbpywb0kT7yFD
         Fww4U6dFK0SBB9tKPC/bg/pzpqzakVs0P5cqNI6VwAW4T+gW+14wFQDQYlqVvGng//Rf
         wLCXbqsxLgRH7gGDsO/Bj70YQiR/HwZpnvibCGA+abL8d6tfj/ifugF29fA1k1r4JszJ
         /CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UVjNG9Gw9PObXvQopqMB4R8ZRqG9xU5d10VAS7WGOBk=;
        b=h6ApMEu+LIGBewHoFecM7LcL1+Sbnja2H37FCSKsVoxtIhTe1+uRX/cljiSf9qxRYU
         Moo2tcsrtOu3HTkdbOdpNJaUnE3hyzdZH5M5zN7K0PWMHEaDG6MMIRyYAUASYeWfkQG3
         ktK6sj6jjmyrR1tqbMYkMlUpCMyISrunisQyapIUt64+7CCB76GAFGhiT/+/nrRfYVRa
         sMRtoxqTKnyO3PVsuBAiCpx5rEHL0X5wpJtArpkJtVq3i1A4mOtLXJpnz/gyOsr6t19H
         Ncr/q0WzeNz0hnwaauUaNhh8NPwqfrojNy+N0kAno0ihWr5Jog7pCrSm9kBtwkxdcDPF
         BxOg==
X-Gm-Message-State: AGi0PuaRQ2vyz8M0WeQ3Eg0Vb8Gg5YjMCcOH2KeaxdVQqczRFOgHC+ZB
        7HTevgofpszdB9K+GNOcV1G+c/wDsAL/pJFA0cOflw==
X-Google-Smtp-Source: APiQypIerImE4B+RxwEQ4AmLhZVZO/yjqu3yOI0+nsocN/com1JXCtkhjL2POsv1bnPhvLYPz/svN1VzIP34OAnSD5M=
X-Received: by 2002:a2e:9655:: with SMTP id z21mr3415599ljh.122.1587158358933;
 Fri, 17 Apr 2020 14:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com> <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
 <xmqq8siuwqxp.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8siuwqxp.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 17 Apr 2020 18:19:07 -0300
Message-ID: <CAHd-oW7B1wtHOE7KCtOR-kAXhuj8Du_MAYobWd9nSsSvm_sChQ@mail.gmail.com>
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual chars
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git <git@vger.kernel.org>,
        Greg Hurrell <greg@hurrell.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 3:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +     if (opt->relative && opt->prefix_length)
> > +             quote_path_relative(filename + tree_name_len, opt->prefix=
, out);
> > +     else
> > +             quote_c_style(filename + tree_name_len, out, NULL, 0);
>
> Yup.  This solves the discrepancy reported correctly (i.e. both
> sides should do the quoting, the original only quoted when relative,
> and the new code corrects the other side).
>
> > +     if (tree_name_len)
> > +             strbuf_insert(out, 0, filename, tree_name_len);
>
> I am not quite sure about this part, though.
>
> Earlier we inserted the latter part of filename (after offset
> tree_name_len) to strbuf "out" after quoting, and then we are
> prefixing the earlier part of the filename without quoting to that
> same "out".  Wouldn't a path ABCDEF (I do not literally mean that
> these ascii alphabets need quoting---just imagine each of these
> stands for a different letter and some causes the path to be quoted)
> with tree_name_len pointing somewhere in the middle be added as (an
> analog of) ABC"DEF", i.e. literal prefix with remainder quoted?

Right. But the ABC prefix here is always a tree name, so the output is
one of the following:

<sha1>:"unusual path":line
<ref name>:"unusual path":line
"unusual path":line

(Always having the entire "unusual path" inside the double quotes, though)

> I would (perhaps n=C3=A4ively) expect that the whole thing would be place=
d
> inside a dq pair in such a case, even if the prefix part alone would
> not require quoting.

Hm, it might be just me, but I think that including the tree name and
path in the same dq pair could be a bit confusing, as they can seem
like one unique thing.

There is also the case of ref names containing unusual chars, as dq's.
Such ref names are not currently escaped in the output of other
commands as checkout, branch or describe. But if we include the ref
name in grep's output quote, it would be escaped, which would be a
minor inconsistency (I don't know if that's relevant, though).
