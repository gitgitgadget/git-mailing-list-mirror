Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0922DC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6A122527
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz9ZOPUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0Vj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:39:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Vj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 16:39:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so13479940wrn.7
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ltdm75/XuDMr+ZIWRyCkzSPVFbc14DFXStSz7lu4Gs=;
        b=hz9ZOPUSV4AQqZmgStKtVQD6vqFWZi5zfnYByK84oOMC7SJoShJYZbtJ56Xpkym1fW
         Es7GIOFP5powGa8WnLfgHZOqe+ksvpqNI5sJ38VJkuP86FAYuisueEP0AAqZ73Flt8l2
         QhtlaBZZ1TkS26jn4wNHhHRu/e7VFG6o1wX4LSCnoPl3CL45n+ZJgClUxNt8qr7U+OYJ
         F76u5q6gkv4hI/GxOoaLr5uy6PhN3u2rJiOmg6hqkJKZXThkp2J0MBQtZYg8OUF/OmpY
         O1l2lh4g1BoqnMtSyolnhThj/d9RySARgFUa4Z5P2H3UA1Uoac9YVo3e74RcIGbdKKfv
         oFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ltdm75/XuDMr+ZIWRyCkzSPVFbc14DFXStSz7lu4Gs=;
        b=NDaKPbiRPg2qOQSXlucM3ztXSHzbmCmqWSDMnFwE/Z4WMHaFy4oBSoOk9GtgNI6pk+
         Ul9EsYCOQrXw0GfOeNM7t5z70GYDXpjQFyIiSx+hcG/T0pKRY5RC1c0zDe3/mv8MjcCk
         EQK/heflwtyPwLJEWXCiufOg7S7TwcFaeWN+9FEExc9rh4i0xg9tv56c1uGs5KGUcAF+
         nrr8Ecfkglg6f7x84vKtNz0Gxay4V7uJjUJwEV08Mv/kxIE1Ds/fP4HNyfMOEkqTzwSy
         4VYiTqwB8uOW6QnPqWgAZYGYOMeVLGk1wwdf/6mC7ZDA9FzA92UCpoqp21bWTiIUlnOG
         DXfQ==
X-Gm-Message-State: APjAAAX2axnjBbAVkGQIUMwHAJkMQXiWESBx9JdrOu0a0QmfaVzTPDrP
        zmjNmSUmLmGFdsg0AP7vkI4=
X-Google-Smtp-Source: APXvYqz0b2est/1YFgZ0g4WRdl8KztxZvreX5lrnXa9fxHojE+uZr6Y/A5t/GIlTyP4PSyHUsF7WXw==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr22607064wrr.138.1580161195480;
        Mon, 27 Jan 2020 13:39:55 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.gmail.com with ESMTPSA id m7sm22584136wrr.40.2020.01.27.13.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 13:39:54 -0800 (PST)
Subject: Re: [PATCH v5 0/2] rebase -i: extend rebase.missingCommitsCheck
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20200111173917.15690-1-alban.gruin@gmail.com>
 <20200125175436.29786-1-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2001261043540.46@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <5f9b02f2-6b77-91da-2af1-d36cb6b137a3@gmail.com>
Date:   Mon, 27 Jan 2020 22:39:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001261043540.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 26/01/2020 à 11:04, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Sat, 25 Jan 2020, Alban Gruin wrote:
> 
>> Changes since v4:
>>
>>  - Added a test to check that no errors are raised when editing the todo
>>    list after pausing the rebase; it was provided by Phillip Wood.
>>
>>  - Fixed the issue pointed out by this test by creating a backup of the
>>    todo list even if the edited list is incorrect.  This step was moved
>>    before the user edits the list, so the backup can be created with
>>    copy_file() instead of todo_list_write_to_file().
> 
> Please note that I changed this to always use `todo_list_write_to_file()`
> in `js/rebase-i-with-colliding-hash` (see e.g.
> https://github.com/gitgitgadget/git/commit/26027625).
> 
> The reason is that the copy would be made with _abbreviated_ commit IDs.
> And during the rebase, those abbreviated IDs could become non-unique.
> 
> I have to admit that I did not follow the evolution of your patch series
> terribly closely, but from your description I gather that we want to be
> careful to ensure that the `.backup` file is written with non-abbreviated
> commit IDs always.
> 
> The way I read your patches, they will conflict with
> `js/rebase-i-with-colliding-hash`, so maybe it would be a good idea to
> base your patches on that branch?
> 

Let's do this.  This will also solve the conflict this series already
has with master.

> Thanks,
> Dscho
> 

Cheers,
Alban

