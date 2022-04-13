Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC9EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiDMOkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiDMOkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 10:40:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAD60A95
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:38:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so4355245ejc.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=P5EJsrxg8XEPA/dlVpOKxI/XcIgAF1X3wlC2lbf3CiI=;
        b=ZpY9Fg+A0aQQ5X6wXRE+q5C6s+sajvjHvwYasOWKDbJomJiQsDE+LO6Wnz/x4kPK2p
         qJw/sXOhZpk3ZayKFdVVxkj+Quu2MwMg2HSNVriajmpTlsLiVIZTMCSS2qlXPnaeKSoc
         gnIy03LFRCsupvFrXnHc3YECPu0Lfb+Ki6daqFIJgEzFaoWTydj0N690XW82PN1Fu6lp
         LpKxjSrnRrZ3CRfhiTT6MZUpgE25fZgFUsQjC06Fb3VE/noppIybQ6lU97y+0Nl8DKSf
         8MEUIFKZZ/gTiYyQdZ/jvsH4iG9iqmpKZHKDiZHim8gisTIVc8CpSMEFkQrpyFjXGOLF
         T8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=P5EJsrxg8XEPA/dlVpOKxI/XcIgAF1X3wlC2lbf3CiI=;
        b=jTfkqxBUib/0RrogFb/dhgeYr6ISp+nxAYQAsaqTQK1XzNWUYb3LZCYEJAO/altbV4
         Gz8fyamerjOnkTEGEuwFqvv+Jc7FqsL1tHAogIvCrWSQgWaTtGSvrxNuq8rcp/FwmEFK
         vbgFuOMtsz5z0Li6ZUKIudpqMGUWIyPKHl5aDRnOPXjDwDw4FeoPgajWV+K5tyMD0Vb2
         k2i9n27KY4lWEg3hodwjCf6kAO17ueBRcNk23MZm9GAfKDkyYYyF6Ptid3OLuZaHi3ly
         6BEsC9+UEQKS7wgQGdtF0IUC09xwM2sL5zXSeGIGrrOaXZzmWA9WmZK8DFiTsX3VGG0C
         6Dag==
X-Gm-Message-State: AOAM530BymCl+KowI95xELs5rHtClo6uzhLn+dOhdyVCJxjwXv62ql/y
        iG2z1Ajkmw6vjNQKbit6LYE=
X-Google-Smtp-Source: ABdhPJyO3SwjOfCp5R2HXEc4+cgyKkw+H34EfLUWLYUp2+XDSrvzJAcBKgSQopJwpHXiVkdDX2VN6Q==
X-Received: by 2002:a17:907:1b1f:b0:6e4:b202:db68 with SMTP id mp31-20020a1709071b1f00b006e4b202db68mr40251140ejc.294.1649860688261;
        Wed, 13 Apr 2022 07:38:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb21-20020a1709077e9500b006e892b4062dsm47191ejc.215.2022.04.13.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:38:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nee8E-0055St-Ij;
        Wed, 13 Apr 2022 16:38:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
Date:   Wed, 13 Apr 2022 16:34:46 +0200
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
Message-ID: <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Bryan Turner wrote:

> On Tue, Apr 12, 2022 at 2:20 AM Bryan Turner <bturner@atlassian.com> wrote:
>>
>> It looks like Git 2.36.0-rc1 includes the changes to eliminate/pare
>> back reference transactions being raised independently for loose and
>> packed refs. It's a great improvement, and one we're very grateful
>> for.
>>
>> It looks like there's a regression, though. When deleting a ref that
>> _only_ exists in packed-refs, by the time the "prepared" callback is
>> raised the ref has already been deleted completely. Normally when
>> "prepared" is raised the ref is still present. The ref still being
>> present is important to us, since the reference-transaction hook is
>> frequently not passed any previous hash; we resolve the ref during
>> "prepared", if the previous hash is the null SHA1, so that we can
>> correctly note what the tip commit was when the ref was deleted.
>
> I've re-tested this with 2.36.0-rc2 and it has the same regression (as
> expected). However, in playing with it more, the regression is more
> serious than I had initially considered. It goes beyond just losing
> access to the SHA of the tip commit for deleted refs. If a ref only
> exists packed, this regression means vetoing the "prepared" callback
> _cannot prevent its deletion_, which violates the contract for the
> reference-transaction as I understand it.
>
> Here's a slightly modified reproduction:
> git init ref-tx
> cd ref-tx
> git commit -m "Initial commit" --allow-empty
> git branch to-delete
> git pack-refs --all
> echo 'exit 1;' > .git/hooks/reference-transaction
> chmod +x .git/hooks/reference-transaction
> git branch -d to-delete
>
> Running this reproduction ends with:
> $ git branch -d to-delete
> fatal: ref updates aborted by hook
> $ git rev-parse to-delete --
> fatal: bad revision 'to-delete'
>
> Even though the reference-transaction vetoed "prepared", the ref was
> still deleted.
>
> In Bitbucket, we use the reference-transaction to perform replication.
> When we get the "prepared" callback on one machine, we dispatch the
> same change(s) to other replicas. Those replicas process the changes
> and arrive at their own "prepared" callbacks (or don't), at which
> point they vote to commit or rollback. The votes are tallied and the
> majority decision wins.
>
> With this regression, that sort of setup no longer works reliably for
> ref deletions. If the ref only exists packed, it's deleted (and
> _visibly_ deleted) before we ever get the "prepared" callback. So if
> coordination fails (i.e. the majority votes to rollback), even if we
> try to abort the change it's already too late.

This does look lik a series regression.

I haven't had time to bisect this, but I suspect that it'll come down to
something in the 991b4d47f0a (Merge branch
'ps/avoid-unnecessary-hook-invocation-with-packed-refs', 2022-02-18)
series.

I happen to know that Patrick is OoO until after the final v2.36.0 is
scheduled (but I don't know for sure that we won't spot this thread &
act on it before then).

Is this something you think you'll be able to dig into further and
possibly come up with a patch? It looks like you're way ahead of at
least myself in knowing how this *should* work :)
