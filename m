Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05153C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 04:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41D206D3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="E9diOVAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBAEoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 23:44:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36655 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgBAEoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 23:44:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so9252700ljg.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 20:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKBE+kcES2pxMznnE7Bfg8ePcWAtjQxaFjqPcAmQAwc=;
        b=E9diOVAptlQPS7RnllJasH4KQmZ3Nv6F4Ovy1xz1aeHrAIo5AEvZm2DyGF/XGtDSyM
         nQpO4yJXp4KGe2GQaFA2cmzFUZVPQgiHslkK6z+sOEG4zRcb/dzdYo6doAyFZiiiyFAH
         EwLRtC8aUZyOyjV2+dB4whqlh5YUgcY9d2WakmPT81kqRh9Gq8+mHaP49LMqRFv2EWct
         2e2bpVkR2fDHmvo37wNmEvGl//pHZxVW452OiDBpJpWNBcmDfeXtCHbQ/lMycyJwoR8a
         jLyKwkXUwMG58MtyAWBwiZy60OL7r4+0afFkTCbo/N1bH7MSbj7cJOu0GhGDmw3TxmjA
         Qe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKBE+kcES2pxMznnE7Bfg8ePcWAtjQxaFjqPcAmQAwc=;
        b=XXQ1OqpjJC+a0L5kYHMjF8gWsOLO9x6AXC+8m8Z1Md42yRSx7dUYowW+wI4tcB5RRq
         aXzX27PwcjQSnW3PPiCJ3oDx/87FSDUJrBvhloHYdZ5QAURU7dFsi03fvoR1gr0xuBA6
         wxHXbb4ZaSzeDbYHcN9Xrd/m+SZtWoOy6w7/aThTjnm01gtc2Svf2xOeci2NQPVp4P4z
         ozrMsfM0n0BWuw5c1h7HV980MzsxMZyYw+EHqhOOo3hFbyKWkA3F5NpgSUFafCEK5R+X
         r/24nS/nkdj1Xy+eWO47GRxXIXbz3spdnFUzR3nc6/uoyUqfVTqxbg3USsB2HwSC0v4k
         FhYA==
X-Gm-Message-State: APjAAAX1vkOYxkGPRJ2oWO3HsZZg04g9KRl6TVokrGfekJowIx6Bl0Wb
        mGHD50Fyhw/gwEkysjINNxL/yTzcSc7Tz0eH5NLFlAow
X-Google-Smtp-Source: APXvYqxhGgtJ2Qj+akYv7YPzt9jLzu8NTEScKZQpb+QdPKRs/CkmrKyeCLqruRtulgnSxpHT1rgDYkwbbHV13/5G1zM=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr7783040ljk.73.1580532255290;
 Fri, 31 Jan 2020 20:44:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580413221.git.matheus.bernardino@usp.br> <20200131090329.GB2857810@coredump.intra.peff.net>
In-Reply-To: <20200131090329.GB2857810@coredump.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 1 Feb 2020 01:44:04 -0300
Message-ID: <CAHd-oW4WBc0AmcZwmOBNNMVQW=JZ-pVhXf8ebL9exgPp13VvOQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] fix inconsistent uses of the_repo in parse_object()'s
 call chain
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff

Thanks for the great feedback.

On Fri, Jan 31, 2020 at 6:03 AM Jeff King <peff@peff.net> wrote:
>
[...]
> The hash transition document says:
>
>   To convert recorded submodule pointers, you need to have the converted
>   submodule repository in place. The translation table of the submodule
>   can be used to look up the new hash.
>
> which I take to mean that the local copy of the submodule needs to match
> the superproject hash (this says nothing about what the upstream owner
> of the submodule wants to do; we'd be translating on the fly to the new
> hash in the local repo). So using the_hash_algo would work either way.
>
> I don't think we're particularly interested in supporting multiple
> unrelated repositories within the same process. While that would be
> convenient for some cases (e.g., you have a million repositories and
> want to look at all of their trees without creating a million
> processes), I don't think it's a goal anyone is really working towards
> with this "struct repository" layer.

Thanks for these explanations. One thing that left me thinking,
though, is about changing the_hash_algo to r->hash_algo (not only in
oid_to_hex()). I previously thought this would eventually be required
for the hash transition. But if I understood your comment correctly,
it might not be necessary since the submodule should always match the
superproject hash. And, as you mentioned, supporting multiple
unrelated repos [in a single process] is not one of the main goals, as
well. So wouldn't keep using the_hash_algo be OK?
