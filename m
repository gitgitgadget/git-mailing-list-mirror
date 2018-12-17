Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6FB1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeLQO0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 09:26:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLQO0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 09:26:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so12859594wmj.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=unDxkn2eqF9NJNY2ZEanvN/Deaq6XZDPSwiVVxcltcQ=;
        b=XK06ApUXdToKV2/qqUEd18IBrBUK/JJML1mgp6pquPOqqjwuqew6SwB35XiPjxJOO5
         sAy/mh/Txi7fUpPJ8kXCyb+r51GUhmDAyZxC0Bu2xdd4Qzp5cB5SSGi5XAhKLA7I0F7t
         Nu/X+zt/d2E3hyw0ocHdKn/qxOL0Ep+FtPTT7i29+lf6QSGVxsukiQk4PAjsuJQ7YFlI
         +mi3iX7kwuJobicQy/z2aw7+Z4nHL5HWygFL9Qkh/ntUVKY5jNMk7G5Ox7PREDvlhhf4
         qm76IEm2nCqaO6Xbm6MquU0sZ6abCPPJOAMyLj0+lLstHDBj86eVroQ17r/Mo1oTICFK
         HTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=unDxkn2eqF9NJNY2ZEanvN/Deaq6XZDPSwiVVxcltcQ=;
        b=Iv4k7UwHCd0FznLOIr/vk/CokxGuwR4cz2pogZh+UNGr1BC1MAG5XMlfBDpRLM8JlJ
         2HNMIyGEJAIfq2V0UYpyr0YtY3TT/DpL5HboVDx7arKd9i4Ujavdugiw2tO8w5teAH2n
         RwkxKsIrLIBWw6CvxO7/G3Mo4l2NT6iULsXkiaTasIPAKmPspVNUKqOWgcs+TQ9YLDE0
         z/+ThXOgndkRN4rJA/MOM3dIgFe3XqdEaWjUyi3WtU1OU1oFGs88wSnQi7yV8ixXQl1G
         UjNJFhvokFvHvVK1bZ63b3RrkhozDfghTvUJyXOya5j86SiME/RHtnyyo4/oKto7bvR4
         4OOw==
X-Gm-Message-State: AA+aEWaAx9E0/tT1eCpgBBXo7q0q55p+328K9bWCI97xqN5oEb6HG3LV
        /P/U7SA96UE2XDFPs4E138+qAb/y
X-Google-Smtp-Source: AFSGD/X+JWUFAAboIwDU2dhNa8OxMetbUtlN29eeG8dpj9Aao2D+FRIUh8TstavOvd9p6sIZG+7qww==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr12301692wmd.36.1545056782347;
        Mon, 17 Dec 2018 06:26:22 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id v19sm604181wrd.46.2018.12.17.06.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:26:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/6] revision: implement sparse algorithm
References: <pull.89.v3.git.gitgitgadget@gmail.com> <pull.89.v4.git.gitgitgadget@gmail.com> <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com> <87efaj1y77.fsf@evledraar.gmail.com> <867aa5c3-60e0-2467-795a-40aac58f306b@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <867aa5c3-60e0-2467-795a-40aac58f306b@gmail.com>
Date:   Mon, 17 Dec 2018 15:26:19 +0100
Message-ID: <87a7l41b78.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 17 2018, Derrick Stolee wrote:

> On 12/14/2018 6:32 PM, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Dec 14 2018, Derrick Stolee via GitGitGadget wrote:
>>
>>> Despite these potential drawbacks, the benefits of the algorithm
>>> are clear. By adding a counter to 'add_children_by_path' and
>>> 'mark_tree_contents_uninteresting', I measured the number of
>>> parsed trees for the two algorithms in a variety of repos.
>> We spend a long time printing those out before we ever get to
>> "Enumerating objects".
>>
>> Which was where I was trying to test this, i.e. is this a lot of work we
>> perform before we print out the progress bar, and regardless of this
>> optimization should have other progress output there, so we can see this
>> time we're spending on this?
>
> It is true that part of the problem is that a 'git push' will sit for
> a while without presenting any feedback until this part of the
> algorithm is complete. The current series intends to significantly
> reduce this time.


> As for adding progress to this step, I'm open to it. It can be done as
> a sequel series.

Okey. To clarify I wasn't complaining about the lack of progress output,
we didn't have it before, just clarifying (as I've found out now) that
when you're talking about "enumerating objects" in your commit message
it's *not* what we're doing when we show the "Enumerating objects"
progress bar, but an unrelated step prior to that.

I thought I might have been holding this wrong.

> What would we use to describe this section? "Enumerating remote
> objects"?

Isn't this "Discovering objects to push to remote" i.e. "Selecting
objects", but then what's "Enumerating objects" really doing? "Looping
over objects we selected before and creating a pack"?
