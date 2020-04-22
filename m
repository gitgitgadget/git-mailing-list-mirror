Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E5DC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFC820882
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nljfZR8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDVRvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbgDVRvR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 13:51:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E7C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 10:51:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so2563747eju.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6qy4mNbFKga5Cp+7mdhpY4H9rqtAS5uU94drXTbOq3Y=;
        b=nljfZR8PznU1yLHFSPw+bwHksH7PhjNdDlmmfDk797eqnVz0JPMV7KdpTfVbo/efVZ
         GIXniv6RK6W26PaN7JWdIHKzVy4j524Utb7kq9Xq8LByZ5TSyh/vPBST5FQwh9wMOFtx
         p5kPq9cAVAui1u7Gx2zBT/0Cu6hOz8lnXGF3zOhTa2JiDVHyNbFdfCYUWVL8rmZX/pVB
         Wg/7D/IXsouHMZZs3RGTbbO2mfw66eqNER6H8X3BtQhliE/63gpkiPaBnSXL7Xm6w6RI
         zIHRllV7wjBc3gPHT6B7eJ0G6UuqzseV7QDi02Rkw4z0LCpzbzGoffY5wvKN0ncH6fwI
         TcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6qy4mNbFKga5Cp+7mdhpY4H9rqtAS5uU94drXTbOq3Y=;
        b=TDew9xagOClHT1cvbLNs+D3XTQldZnz/pgHpBO2VBT0+UD3BxoYhG1tfWsUbc0tzot
         N09YVTKKWoR7WupcjcTnHW160UJLwAD+5wvx3EgY9I+3vRBFDHDR3WfHJzfwSBKotj1Q
         Qnlj2pGuiQN3kbzOo0j+jZdNGYbDhY75fMIBN5VlSi/FFRIcFHdxKGyt7QkXKNCnb7dF
         EO2K/KVlK35qhNgFUi7RAHGMmYun+2+6lFx0VA+7EfoWBsFjMxCWfI7EI9ZmBdm1bXl8
         90EpT46SaI629XI+WsEgCIsmSVRxSm/cbmYRl/LiNfblY8qwPnyp6csBJansx3QtlrEU
         MMPg==
X-Gm-Message-State: AGi0PuaqPtcc7Zz15gQu96VIrmj6L1fnPSB85XyAUn9u9DkTQogferCP
        GIYu8IahEZGf3EHsvyvFHacchLZgTDsxpAcmJVyxHa5YoFw=
X-Google-Smtp-Source: APiQypKVI9nfzndYzoh86R+9afjvQTXizAtVQmC94uT6xSXZhMp2I68Sb7Pney1d/9EdUPyEpp8yi84xI25tWQ+yBwM=
X-Received: by 2002:a19:c8cf:: with SMTP id y198mr16915048lff.197.1587577516178;
 Wed, 22 Apr 2020 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAAihzVJTN5V3o_aFeUuJH_8+nqZrKHJww3vFQ9K5W0DtbeM14w@mail.gmail.com>
 <20200422031455.GG6465@camp.crustytoothpaste.net>
In-Reply-To: <20200422031455.GG6465@camp.crustytoothpaste.net>
From:   Mikhail Strelnikov <mikhail.strelnikov@gmail.com>
Date:   Wed, 22 Apr 2020 20:45:04 +0300
Message-ID: <CAAihzVLiB4Cx3BC66bqXMVgAgacRiNGpviUJHROtiJYwxNYCSg@mail.gmail.com>
Subject: Re: Multiple pushurls, different 'objects\info\packs'
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mikhail Strelnikov <mikhail.strelnikov@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Brian,

> delta compression is multithreaded

That is great news that this is expected behavior and I'm not dealing
with some sort of obscure data corruption. :)
Now see there is `git config --global pack.threads 1` (I'm doing
everything locally, so this might work for me)

> reason for wanting bit-for-bit identical

My plan was to have 3 pushurls and shoot one of them if it is not
bit-for-bit identical to the other two. But you are right, all I need
is `git fsck`.

On Wed, Apr 22, 2020 at 6:15 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-04-21 at 18:07:42, Mikhail Strelnikov wrote:
> > Hi,
> >
> > I have a repo with two pushurls configured like this:
> >
> >
> > C:\folder\1>git init --bare
> > Initialized empty Git repository in C:/folder/1/
> >
> > C:\folder\2>git init --bare
> > Initialized empty Git repository in C:/folder/2/
> >
> > C:\folder\w>git init
> > Initialized empty Git repository in C:/folder/w/.git/
> >
> > C:\folder\w>git add work.txt
> >
> > C:\folder\w>git commit -m "Initial commit"
> > [master (root-commit) 1b314f3] Initial commit
> > 1 file changed, 1 insertion(+)
> > create mode 100644 work.txt
> >
> > C:\folder\w>git remote add origin C:\folder\1
> >
> > C:\folder\w>git remote set-url origin --push --add C:\folder\1
> >
> > C:\folder\w>git remote set-url origin --push --add C:\folder\2
> >
> > C:\folder\w>git push --set-upstream origin master
> >
> >
> > I would expect those two folders (C:\folder\1 and C:\folder\2) to
> > contain exactly the same bytes. And they did for quite some time. But
> > now there is a difference in 'objects\info\packs' (and some of
> > objects\pack\pack-*.idx/pack are also different).
> >
> > (all the commits are the same in both and all my data is also the same
> > and 'fast-export --all' yields the same result)
> >
> > I'd like to know what might have caused this nondeterminism and if
> > there is something to do to prevent that.
>
> You can get nondeterminism because the push to each repository happens
> independently and delta compression is multithreaded.  You can therefore
> compute different packs on push and get different packs in the result.
>
> You could try to avoid it by disabling threading for pushes, but that
> has to be done on each client that pushes to them.  In general, this is
> not worth worrying about as long as the data is intact (that is, it
> passes git fsck) and the refs are identical.  It is also not especially
> easy to avoid, since determinism of pack files is not considered a goal
> of Git.
>
> Maybe if you tell us a little more about your reason for wanting
> bit-for-bit identical replicas we can provide some assistance in helping
> you achieve your goals.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
