Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2691F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeFLSTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:19:25 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34730 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeFLSTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:19:24 -0400
Received: by mail-yb0-f194.google.com with SMTP id n23-v6so7010661ybg.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdC0cNrqNPZvzHXqLMH1ubDNPzClKtmMEcpJW68SJ2Q=;
        b=iJ9MlXrUULGlBu1XKBH5hCv0jMntTg3XRxg8orJBiT+RKgxJ3DbwQPuUJS5shvrx0A
         z+hf9nndUTA22xorX/uIzqM9ZAj/LFi3vShkJI7npv5kHSVjwIpvREfpEKi4pM9ktJfx
         NR1vPRHnLWdpwFizupni+ofNAsY9mQq8mNDvrxJN+d2IWX9NiSDXinPtzEqFiBH8jPVG
         mma8RG7jQPF6v/RZtE4kyQG9GvAfkpwgMUIN+iuyfjaNETC+7dBSc/bRaP0aaD6UeJiu
         QQOj9do6d7SbLuxq1sstraKRcKtrVi/nOoGV5WlhPU8z/y19z0AK0Tf113vOmr3xiwCR
         c1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdC0cNrqNPZvzHXqLMH1ubDNPzClKtmMEcpJW68SJ2Q=;
        b=YNFwbIfStOeMo7s2bZ7j3YFFZfDmn67YWk3kIYBNurbzCmPfRQHh3G58UyQbzGV7Bc
         O4Wp55zxaZ7acGAvPgTmBNxSP7jO+ZYRr/0e2Zg3WivfXD+10+7o/f1xliOKYWAUUD59
         jJxkFYcIPduq/ozC5xUhojWtroBYHW2oN3Geld6ScvAZxg97Ut/J8uy852P3IeH7or1Q
         gisuxTdcpe/ni2CRt5qSGpnixWSCOoK08UY4XB57SLAcjlX2vVBDGXwYvtB0dJLgay7Y
         DCUeQh6XGMhg6tr35Oqm5g+UdLJGHZRrl5irLbVdBeeiBHeyiIuTSPQJTE01+WVOhHxr
         kP9g==
X-Gm-Message-State: APt69E1hsckWQelZZZPPGq+2tYREJMpnq76B6RtVkNhG0XoFBLpvpRlI
        fenS/FYaioc6loK8elPPts7eRCc5Ws9SCt6Jod5NYOQwFp0=
X-Google-Smtp-Source: ADUXVKIvK8hFN8KUfDvUwaREy2rred+1SvOvs+OZBExfKsvoaNL0Ik3EIaM0Uhf14na5Rxh4Nl2NZ5RJ065R7SIp9H0=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr764465ybp.352.1528827563394;
 Tue, 12 Jun 2018 11:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com> <20180612175344.65466-1-sbeller@google.com>
 <20180612180705.GA28554@aiede.svl.corp.google.com>
In-Reply-To: <20180612180705.GA28554@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 12 Jun 2018 11:19:12 -0700
Message-ID: <CAGZ79kadthZi1oj-2FFpiUiwDtK744Cr05Hj1MkMFPs8uto7ZA@mail.gmail.com>
Subject: Re: [PATCH] builtin/send-pack: report gpg config errors
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:08 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
>
> > Any caller except of git_gpg_config() except the one in send_pack_config()
> > handles the return value of git_gpg_config(). Also handle the return value
> > there.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  builtin/send-pack.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> The other callers do

except builtin/log, which I followed. :/

>
>         int status;
>
>         if (!strcmp(k, "key.i.handle")) {
>                 ...
>                 return ...;
>         }
>         return git_gpg_config(k, v, NULL);

This conflicts with Masayas patch, that has a return of the
standard options.


>
> or
>
>         int status;
>
>         if (!strcmp(k, "key.i.handle")) {
>                 ...
>                 return ...;
>         }
>
>         status = git_gpg_config(k, v, NULL);
>         if (status)
>                 return status;
>         ...

This looks like a good idea.

Will send a follow up patch.
