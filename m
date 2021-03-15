Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C5C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2440B64F5F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhCOXwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhCOXwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:52:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2608C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:52:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w18so19406969edc.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EtzcqEN8xSCl3poWwkl8mpSurk/1M+QOX+r55d/wT8Y=;
        b=UBLD2QeOiD1QdRjk09TfPw7uYOxfLb+XSu0CaEWNN2gcpyoh5dZaxQbAPlzNuqvJ16
         MQ4pp9LwsRr/7TcOe+Ll+mDQetocIrQQE7i3yt8djtzs4RWlT5U1KbZx8fYeqvHz+wfO
         gziclEvGMQzE3qF1g//ugdYlregmMdbfFlUj8RRupeDMn3Y9na5fvJF0fSRoCcspbCZ/
         ANp5UuYai/ttrpD1gOYmV9jGnZX8SYMjuD7are1eB1bc9Yf/rhJurdycpLtwCSkgJua3
         kZg6M9ZJQ6Zxmru+psjrXX/YPJo2WJsxZa1iF2qkw3pbjPkaD1M6bDuxbfN+fSBRVryq
         yLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EtzcqEN8xSCl3poWwkl8mpSurk/1M+QOX+r55d/wT8Y=;
        b=j2EXVk5kiZ66WRnCnD2ms/yG7CR7KKbvvbY2Y9BFm3trOD7H/SVfgOAGP9ntOUckbX
         h32RjLJRjjRhTMxxB3bGfWevGzeRGOC+5ExHXunFG8xsIgf+aysuk/tXbTUzg4otC6GK
         2r6FZh5lTXtp4WQRej/HDcGmpCtJUkb0B8KIOrRTBPmiuyp0SjMs+VN4ejO18C0yuD6f
         hEYHBIFO7OCH35E4jKXomy0LODZtmL5kSchwbBvK7wONg1ywk0tAb7kP10Xvaezkpc43
         bmQyTselWaeaGTSFeovHic4O50zbVoslAaaa2npXOWzt3EAPovN63MTWYkOX4lIF3WMP
         dDWw==
X-Gm-Message-State: AOAM533dReI1yzR/fsfGAp7spkOZaubPae+bi3KWiiY+OeYOUsLsThtn
        S5qiCy8+6MMFBpxOL0sIWl/mivdshcZyxg==
X-Google-Smtp-Source: ABdhPJyyweoqzv4+B96tVEUm/JYer4ZHpfUFbTELxKmvhchT9YzcbuH6+I3spNBrYY85hVZdANVZnQ==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr32924972edt.249.1615852329560;
        Mon, 15 Mar 2021 16:52:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n25sm8825662edq.55.2021.03.15.16.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:52:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
 <xmqq1rckc1cb.fsf@gitster.g>
 <c5e42675-5f03-728a-60ec-880da368085b@gmail.com>
 <xmqqft106sok.fsf@gitster.g>
 <c730cb8d-06ff-6f86-4eae-812472157327@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <c730cb8d-06ff-6f86-4eae-812472157327@gmail.com>
Date:   Tue, 16 Mar 2021 00:52:08 +0100
Message-ID: <87eeggf00n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 12 2021, Derrick Stolee wrote:

> On 3/12/2021 3:08 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>=20
>>>> =C3=86var, the assumption that led to your e68237bb (tree.h API: remove
>>>> support for starting at prefix !=3D "", 2021-03-08) closes the door
>>>> for this code rather badly.  Please work with Derrick to figure out
>>>> what the best course of action would be.
>>>
>>> Thanks for pointing this out, Junio.
>>>
>>> My preference would be to drop "tree.h API: remove support for
>>> starting at prefix !=3D """, but it should be OK to keep "tree.h API:
>>> remove "stage" parameter from read_tree_recursive()" (currently
>>> b3a078863f6), even though it introduces a semantic conflict here.
>>>
>>> Since I haven't seen my sparse-index topic get picked up by a
>>> tracking branch, I'd be happy to rebase on top of =C3=86var's topic if
>>> I can still set a non-root prefix.
>> I think all the clean-up value e68237bb has are on the calling side
>> (they no longer have to pass constant ("", 0) to the function), and
>> we could rewrite e68237bb by
>>=20
>>  - renaming "read_tree_recursive()" to "read_tree_at()", with the
>>    non-empty prefix support.
>>=20
>>  - creating a new function "read_tree()", which lacks the support
>>    for prefix, as a thin-wrapper around "read_tree_at()".
>>=20
>>  - modifying the callers of "read_tree_recursive()" changed by
>>    e68237bb to instead call "read_tree()" (without prefix).
>>=20
>> to simplify majority of calling sites without losing functionality.
>>=20
>> Then your [05/20] can use the read_tree_at() to read with a prefix.
>>=20
>>=20
>> But that kind of details, I'd want to see you two figure out
>> yourselves.
>
> You've given us a great proposal. I'll wait for =C3=86var to chime in
> (and probably update his topic) before I submit a new version.

I've re-rolled my series just now at
https://lore.kernel.org/git/20210315234344.28427-1-avarab@gmail.com/
sorry for the delay.

You should be able to rebase easily on top of it, although note that the
new read_tree_at() uses a strbuf, but is otherwise the same as the old
read_tree_recursive().

Note that the pathspec can also be used to get to where
read_tree_recursive() would have brought you. I haven't looked at
whether there's reasons to convert in-tree (or this) code to pathspec
use, or vice-versa convert some things that use pathspecs now
(e.g. ls-tree with a path) to providing a prefix via the strbuf.
