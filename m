Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F7B201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbdERUaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:30:35 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36125 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755638AbdERUac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:30:32 -0400
Received: by mail-io0-f170.google.com with SMTP id o12so36158256iod.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YSeh2usqO2KQ5ptmEnMeyoR86lQBaFvFOlUz0o9sJBk=;
        b=D8tMmHRGHrL/avgaS8ae5jgm5ob0iP0EgkYF663+T8i9KCgvEVKAZ/LSVYCuH4GPAR
         Vz7csx+iIPcxTniwVs2d6AxGtXmeSaBhDrcbKPANBUiscBCqgLSZVq+6s9IRb8x7kone
         54o/2KpN/sE4OaTiTNzieZUKlflKon/QoXRpYys9xx1Kv/xI/rjfBw0ISwYWZe5DeNqP
         4Feu97msuRUVK3KxTDP5NHNsnLMoTCEnuAUWYml5vqLOPFkYra4uPM6XKp6/g8wO4ExD
         9DBPi7XTouMzBlPsOBrRlpYhlAVDDtHFyECd5H7RtZmcf/xiRTW3Ir25h3q5y//+E+A3
         Nm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YSeh2usqO2KQ5ptmEnMeyoR86lQBaFvFOlUz0o9sJBk=;
        b=WpAjLXs0S1k+gAPZ7znFs66IlGl3G7pmNnVBW1n5raeJVTZp6ZmzLbFzK88VCcsHwE
         nj1poGpzey/vNVPbpqUsMkH4yWefYE059Y3wmKFgr+gvqvmXCaxvx/8RbGn0Xi2e+5l7
         Djc4oRWeGdTFWOF1VpnBu+tjZFSZyo6ELuAMKdQ8C8g2MfxaPVIy4ikzx6dJOX5VAoD9
         mG6x8IfvfukbR8nsBAFngC+C0A3QsBZ7RCAoRnBCKUTSnsNI+Ylroy3GpUMjTC8HUfur
         +uapc84jB4xQwVSdGwwPJcf7SV6fwRQqWMwOKzV07mqx/64rtabi+FgLAm8/ftimcIwg
         JZtw==
X-Gm-Message-State: AODbwcA+MbAEH+zH9/qf+HGajMtUnYtcjkXw/rs/UlwsZKelNLgSOzjW
        aDBkQq8OdDkvAi6EQSMH6EtaZz98DQ==
X-Received: by 10.107.195.70 with SMTP id t67mr7514976iof.17.1495139426690;
 Thu, 18 May 2017 13:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Thu, 18 May 2017 13:29:46 -0700 (PDT)
In-Reply-To: <20170518094038.x3xvpsfte3zxpuqd@ruderich.org>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com> <CACpkpxn1D_g=im0um4ncLiq3A18HRPpfu-sb1FLoY__tet0--Q@mail.gmail.com>
 <20170518094038.x3xvpsfte3zxpuqd@ruderich.org>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 18 May 2017 16:29:46 -0400
Message-ID: <CAJZjrdUXXEU9g+n5Xhq3eq4pW8zdaev9gVcwdcNeiDvPpgDzgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Manish Goregaokar <manishearth@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 5:40 AM, Simon Ruderich <simon@ruderich.org> wrote:
> On Wed, May 17, 2017 at 06:45:31PM -0700, Manish Goregaokar wrote:
>> Hm, my invocation of git-send-email keeps getting the threading wrong.
>> Is there a recommended set of arguments to the command?
>
> The threading looks fine here (for both cases where you mentioned
> it being wrong). Why do you think it's wrong? How does it look on
> your end?

If you're on gmail (as Manish and I both are) patches in a subsequent
version will be threaded (wrongly) against "earlier" versions of the
patch. So if you have patch series A0, A1, A2, A3 and new version B0,
B1, B2, if you thread them as

A0
- A1
- A2
- A3
- B0
  - B1
  - B2

gmail will show them in your inbox as

A0
- B0

A1
- B1

A2

A3
- B2

Depending on whatever heuristics they use to match up "threads",
presumably because most emails aren't threaded correctly.
