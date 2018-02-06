Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE481F404
	for <e@80x24.org>; Tue,  6 Feb 2018 17:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeBFRbG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 12:31:06 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34642 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbeBFRas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 12:30:48 -0500
Received: by mail-yw0-f179.google.com with SMTP id t201so1891409ywf.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 09:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rEDXS2bRRSNjc2kjxNITg4u90FKsETOAVVD4thXDziE=;
        b=S61FItpFncAi42F8Bb5FRYUhxr604k6kp2yle0ZlBfRX6zIkZj9SYBMd3JYluG5Bbg
         JFz191fnbzLIm4Zt+MijGJH1FH5H7+/2SIkFX2Gg9iIGXghdnbh0tyE8nL6buOUnLVAg
         BOgLPDWQbb7+K/SUYXIBhFp/XOMAmCh27l+YPQh8KZVvJht2MJgTdQ99giXltwZgsvm+
         B0djMT7EGJ8inv42+wNhT7S3ivmd5GtF3rAE3Qhse89EqqUb+JKZ0LBp+uK1l0tenQkp
         o8QyHMa5GMcGZktloBDTUOS22U1ldwA0CZAsr9Z5H75FTxLIMfaKkcIXkbDloaU3HgzP
         88QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rEDXS2bRRSNjc2kjxNITg4u90FKsETOAVVD4thXDziE=;
        b=iuYFTq0Re1YFYwtvRnC5hKVQCD/IpkPwUxKZX2leS0ZBccmNQbhaJTgIvgr4OB+GGm
         msgFQ7ztLwXRoowThEcPtS/FIv+QgXG9vLhy2mbPPth9w09LtUtZ9NkPZ1a/ld13wKCK
         lWGnPHJfj4rAD74Ld+AvF3jznZGmUTWKUUscee3OaN4U5EGTjVTPiSDh0lZ0d2sr/1sZ
         YuKmouq3b2NAmaIKc3BxvzfFe9iJP8+wBHDE1QdfJ+j94vFfBlY+vma3uSz32W4YOdyT
         cLX2XXJa3yti1JwwZP2C4S+fSTJjSOMhz4+AliJnhvm+pB8JlHXRl9o35Frnkv/XMoLb
         RfEg==
X-Gm-Message-State: APf1xPDI0tIERJt4bDWHZF6LFwNzRW69pz2tWmEztKJbZLuU7Pn/wx/x
        JEKk+bORDUVPJ3tj70H/FivaltoV+kfmbE0kZhnjzQ==
X-Google-Smtp-Source: AH8x226MyPg6+HcjUTUsVWq5afXOYQACNozOSj2NeZuJ7OclxLV/F3gXJ7iSmUNnasmL1Pnr7+ZG6FN4LkZpaGnRroI=
X-Received: by 10.129.108.196 with SMTP id h187mr1958344ywc.249.1517938247855;
 Tue, 06 Feb 2018 09:30:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 09:30:47 -0800 (PST)
In-Reply-To: <CACsJy8Bhu6RvedKgOx8uExrJuo0-b66JvnZA9d9v4Uk6mSwPQQ@mail.gmail.com>
References: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
 <CACsJy8Bhu6RvedKgOx8uExrJuo0-b66JvnZA9d9v4Uk6mSwPQQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 09:30:47 -0800
Message-ID: <CAGZ79kb+SB3q720Q_QbpPTLsY-gfsYHGdSvK2TGOtRXwLMQyOg@mail.gmail.com>
Subject: Re: Are concurrent git operations on the same repo safe?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ian Norton <inorton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 2:16 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 3:16 AM, Ian Norton <inorton@gmail.com> wrote:
>> Hi all,
>>
>> I'm generally used to the idea that if a thing is not marked as
>> "thread-safe" then it isn't thread safe, but I thought I'd ask anyway
>> to be sure.
>>
>> Is it safe for me to do several operations with git concurrently on
>> the same local repo?
>
> Off the top of my head, object database access (e.g. things in
> .git/objects), refs updates (.git/refs) and .git/index should handle
> concurrent operations fine (or in the worst case you get "some
> operation is ongoing, aborted" and you need to try again but not
> corruption or anything else). I think we generally try to make it safe
> concurrently.
>
>> Specifically I'm trying to speed up "git
>> submodule update" by doing several at the same time.  I've noticed
>> some odd side effects afterwards though when trying to commit changes
>> to my super project.
>
> submodule is a hot area with lots of development lately I think,
> perhaps you're seeing some bugs... CCing at least one submodule
> person...
>
>> Apologies if this is answered elsewhere, my google-foo is weak today.
>>
>> Many thanks
>>
>> Ian

"git submodule update" has the network part parallelized,
but not the local part IIRC. (That is cloning/fetching submodules
can be done with "-j <n>", but the local checkout is still serial for
UX purposes, i.e. it wants to stop at the first conflict and only
have one conflict at a time)

Which odd side effects do you see?
I'd be curious to see if that is a bug in the code or documentation.

Thanks,
Stefan
