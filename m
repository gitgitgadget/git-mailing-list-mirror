Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF95C433F5
	for <git@archiver.kernel.org>; Sun,  8 May 2022 15:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiEHPFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 May 2022 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiEHPFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 May 2022 11:05:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0992101EB
        for <git@vger.kernel.org>; Sun,  8 May 2022 08:01:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p4so9373956qtq.12
        for <git@vger.kernel.org>; Sun, 08 May 2022 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xx3Vs5tq02ryj3e7uosqMMzQ4DlSiIb38VkqPY3wPBg=;
        b=qJ1lGbh5kBgkIxSnASmHaJFXL7e9Q1H4RBKYjLCim6KXhdBd8011WOEUBFWc1mfkK7
         frN+t5LkHnOpX+vWk8silwA/eN+3wFozZHjZpEg8WTovElAGlegg1T7ZGjojOirBtHGK
         /IZqKx80YDYHj6DMXY2rvGl2g/p4IjkfSlu7fix9AuYnICfghUhlnMkHdQYCBpbqpFx+
         ccXWdel5x173UoBrGQ6jWAZP+rwaQ2E9itDdup/dj5lWjlkE6thh8UrAsqtkVVFTEYpH
         ga7akpoQKNpbgNBaiBiNKSQUGySD7pDGd67lVbItaoz9AOvGcqYRPxQIrWuppF9pHaO2
         LX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xx3Vs5tq02ryj3e7uosqMMzQ4DlSiIb38VkqPY3wPBg=;
        b=R3i0DlBHgQVwLsvuVYzb9p5KDF2FI9GnATt8ZsPcQJ0JIh3ylAhf606CfOGlJy632R
         INT9XJ9H5tbbCE0x8iE+vIDRT4yl7zZ4m5dUQNyOrbUcaxPIBV7Dw/6JF/smIcfWCx23
         lan9kVNn2sFnjVRm2BzoGpLhQOtoAeQKTtTn5RFlnKGRCf28VCDOcJa5VtiW5NSJ0E5b
         4Plvd8WiLyBiH5l66XZ54v0zDO3Ts+BOnBHEYMePBYdHEo2skKFiPoLZmmyVic6d/Mdh
         ppIZRRQDjgCv3ISYWQkHgqjXvkv3ii+j9bYbG6UtkcrtCemg+j+QrzD0jGH3ok8WWPTB
         bAVQ==
X-Gm-Message-State: AOAM532flaf6nEr5Df/DmsYppmdq/cHr79RJjQWtDpRcZAjKzBMlPXms
        5Ff+tzKMlH8WdjM1iaTpjA0=
X-Google-Smtp-Source: ABdhPJyUvApGIMlYs7JINddKW8HuwdJzmymE3H7iuI3o/RQLFtHlqPbqDxAikgVZuqb1XeJuEFmj0A==
X-Received: by 2002:a05:622a:104b:b0:2f3:d94d:8829 with SMTP id f11-20020a05622a104b00b002f3d94d8829mr1483332qte.678.1652022115315;
        Sun, 08 May 2022 08:01:55 -0700 (PDT)
Received: from carlos-mbp-2.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id k1-20020a378801000000b006a054356d60sm2483008qkd.43.2022.05.08.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 08:01:54 -0700 (PDT)
Date:   Sun, 8 May 2022 08:01:53 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        vascomalmeida@sapo.pt
Subject: Re: Question about pre-merge and git merge octopus strategy
Message-ID: <20220508150153.74dvhl5cgi7wu5a4@carlos-mbp-2.lan>
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 04:14:56PM +0800, ZheNing Hu wrote:
> 
> I am thinking about if git can "pre-merge" multiple branches, which
> can check if merge
> will have conflict, but not to merge them actually, like a option `--intend`.

why not merge them and find that way if they have conflicts that are left
unresolved, or are you also interested in conflicts that were solved by the
merge?

if you only care about the unresolved conflicts then (unless this broke
recently with ort) the following (untested) should work:

  $ git switch target
  $ git merge topic && echo "SHIP IT!" || git reset --hard ORIG_HEAD

obviously will need to be changed if you want to merge more than two branches
but the principle is tme same.

Carlo
