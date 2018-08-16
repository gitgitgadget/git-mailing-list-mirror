Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949041F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392114AbeHPSpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:45:05 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39098 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389292AbeHPSpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:45:05 -0400
Received: by mail-yb0-f196.google.com with SMTP id c4-v6so782591ybl.6
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCmUSd/7tgmIswADFDe6dA4B8DB7tDaDF5Xu8uh24Ik=;
        b=CMhU/LeFyvFL0MxpssOqDhx8pwq7wyvt2hGNuratTuEjASe/sXcd7nDuutBIK6SzEm
         r6EHZ00mihvJemirtS2RhnO5frRHBMM5818GLPmLRtT4jEgmlyub82E4kKBCv42n5hfV
         Cpm6IBGGnPe4y5FyUagsIjRcyABkEGPRGkYzRMhQWOHFKtwbTsNonGJJufy0cU4nvHw9
         aROo7mJzuEAUcjF6FyLimLu6zZdKl0sT0WE0LbbZSw5njex0dddjPSAKp3cvm5wq58fv
         a/bDKZpdBMSV9ZHbblk8O8K6qXADCKxPJPOLD7eZXs985G/fcFsrsPNXcMDBLqUJ1HUg
         4TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCmUSd/7tgmIswADFDe6dA4B8DB7tDaDF5Xu8uh24Ik=;
        b=fyhOGt8+jBifkOZzaKCgDdZOt9f+529EjdBzWmb0pqxkGJ5fRHwc+EvpcEfBgK+aRw
         f5vB2mt6BbuknbOUWPX5VJShXEHwi58ScswQNw+Z6wqh3ih4hKgruJLtObxjcxIMa+dv
         Pu0W5AI8HslSbxpfqkADWYl/LcO7hDwUtoncTFVHM88PCOlv5bvAtMxWZahxMjJxHEel
         TlQleoyKoiTECQZ7mdekxDVFxREns7rW7LQGsNHphcgTd7CUPSJaIhMkKxvDe4mmWTlW
         OXVwZpuSpMX5+0qk4UgMlulk2hu2Rv57JVsjP6vycDwUbFNes4w0gZxnqdEQrorIOPTW
         JEWg==
X-Gm-Message-State: AOUpUlHtbycb5fnxqwKSLyhf4w15yIGWsmBYpj/RZEyzT3NjutItQeug
        6bxsUoUnGrFZSiO+6JPJcOCDJq7howlwzJ7xr+fvBA==
X-Google-Smtp-Source: AA+uWPx1GvK0x/HreecNN8yJmLg6G8snRDMyRVOCaUpi9CgVUuHfo9PwYW8dS6IlQzWKgSB/p3x7MBMuZVlX6wrBfTs=
X-Received: by 2002:a25:ada7:: with SMTP id z39-v6mr15802858ybi.201.1534434347725;
 Thu, 16 Aug 2018 08:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180816023100.161626-1-sbeller@google.com> <xmqqd0uigxby.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0uigxby.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Aug 2018 08:45:35 -0700
Message-ID: <CAGZ79kbe_acinQSK5is=i1FufSwGjtqMZPL77nTTuT93ifhi0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Unset the submodule URL in the superproject when
 no longer needed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 8:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >   Originally we have had the url in the config, (a) that we can change
> >   the URLs after the "git submodule init" and "git submodule update"
> >   step that actually clones the submodule if not present and much more
> >   importantly (b) to know which submodule "was initialized/active".
> >
> >   Now that we have the submodule.active or even
> >   submodule.<name>.active flags, we do not need (b) any more.
>
> Up to that point the description is sane.
>
> >   So the URL turns into a useless piece of cruft that just is unneeded
> >   and might confuse the user.
> >
> > Opinions?
>
> You spelled out why you do not need for (b) but not for (a) and
> worse it is is unclear if you never need it for (a) or under what
> condition you need it for (a).  So there isn't enough information to
> form an opinion in the above.  Sorry--readers need to go to the real
> patches.

Regarding (a): Once the submodule is cloned, you either need
to change the remote in the submodule or you can use "git submodule sync"
which can bypass the superproject config, too (that copies the URL from
.gitmodules to the submodules config/remote)

I don't think (a) is needed after the clone of a submodule is done.
