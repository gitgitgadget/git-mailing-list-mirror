Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F0ACE79AC
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 06:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjITGiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjITGh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 02:37:59 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917A5B9
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 23:37:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c43e6ba8d1so37098385ad.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695191873; x=1695796673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPOFkKutNREIftnuP85sMoeualKwRK8bKW9z2bDxfR0=;
        b=phST0qM3KPQpuCt1ueMWgLYJQCLTPo1+flur++RNXqOtFEvI0o3LeHr3ZEj+IZG+Tn
         NfKe17jIKcqDtsBLNnUkbp3LOQf0jgBLqntxk3oPCm/ewoNmfk7MW71Bkr0+A8Pmtnpd
         V4ZDBLpLyaSRT7slQkVFNkwADXz2IHSsMUmYVHBG+pPu4B6WAhFlUDGjsT9R9fhoVKX3
         KiYVr4LWEODlMSDZekoyJkoVLE6PVOJjsKEJTcjGKtBz8Kwkrad4syhu1wvFjIHqeJrS
         Ubp3Nq4BwcRgRzKXShtoXWSOrTawC3QbGoDVSumKVQAN9OrhUI9w+ieCP+OeE0Jupw87
         OE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191873; x=1695796673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPOFkKutNREIftnuP85sMoeualKwRK8bKW9z2bDxfR0=;
        b=ssYYd3xMaBrcH5/Gqh3KVwEqsPjHEocSF8X0Hnq9Aou19C+0plL6oGCIHn2o3+BFjW
         +J2MRMbHxLXjfGOfv+YCOGYE3tmLm96jFDOI9vOpNpfJIV1X/MTCjkhUuIsYlcdhThoU
         kXdfXWnMiAQhmhrF3clQRhRtG90QgbQils+4sHo4e13uvpt4WqUa3e1kXcElhrm7WPhD
         d1WRb6ca1OJ0MWEI2+M5NPGxYNecx2WpaHWlOT5Mx/UJ8tjqqu8A5a2vEPtPv9nZ8fWK
         n+Iorct14nUN9K8dNFZBAnICf+mhVoVlfdrnzNAkMz1m7s9ipTvXDa7hXUPV3ivTCD4O
         wvCg==
X-Gm-Message-State: AOJu0YwQUNsXGJUaJm97ckZkF+N6fh+d2OEi4CfnEXo3mgiV0sm/Azmt
        ZHUioxPriRSrwcrOFUZUF3NcGuOV23o=
X-Google-Smtp-Source: AGHT+IErrY0BREdj33Ql8RF5WG76IKWCIJkQTZmV6wP/19QExIIG/+PqRwYOo+2/MV37CbUHsPqiGbceEjc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:f685:b0:1c3:ab84:cd76 with SMTP id
 l5-20020a170902f68500b001c3ab84cd76mr17498plg.11.1695191872808; Tue, 19 Sep
 2023 23:37:52 -0700 (PDT)
Date:   Tue, 19 Sep 2023 23:37:50 -0700
In-Reply-To: <xmqq34z9g8jz.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqmsxmdhdw.fsf@gitster.g> <owly7comj5ll.fsf@fine.c.googlers.com>
 <xmqq34z9g8jz.fsf@gitster.g>
Message-ID: <owly1qetjqo1.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> [Cooking]
>>>
>>> [...]
>>>
>>> * la/trailer-cleanups (2023-09-11) 6 commits
>>>   (merged to 'next' on 2023-09-12 at 779c4a097a)
>>>  + trailer: use offsets for trailer_start/trailer_end
>>>  + trailer: rename *_DEFAULT enums to *_UNSPECIFIED
>>>  + trailer: teach find_patch_start about --no-divider
>>>  + trailer: split process_command_line_args into separate functions
>>>  + trailer: split process_input_file into separate pieces
>>>  + trailer: separate public from internal portion of trailer_iterator
>>>
>>>  Code clean-up.
>>>
>>>  Will merge to 'master'.
>>>  source: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
>>
>> This isn't ready yet (still need to reroll).
>
> Whoa, wait.  I wasn't aware of any more comments that needed
> addressing.

Perhaps you missed my comment [1]?

> Whatever improvements you have in mind, if they are
> minor, letting the above graduate (they have been in 'next' for a
> week without anybody complaining) and doing them as a follow-up
> series would be sensible, I would think.
>
> Thanks.

Hmm, I don't think they are minor? See
https://github.com/listx/git/tree/trailer-libification-prep for the
current state of things.

I need to still follow up to your last comment on "trailer: rename
*_DEFAULT enums to *_UNSPECIFIED" [2] (I was going to see if we needed
the "obvious solution" as you described).

If it's too painful to move this out of 'next' now, I'm OK with it
graduating as is and doing a separate follow-up (I expect several more
of these to happen anyway). Up to you.

Sorry for not noticing that this was in 'next' sooner and communicating
accordingly.

[1] https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#m0131f9829c35d8e0103ffa88f07d8e0e43dd732c
[2] https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#md4ff2235720e921a2e031665f4da054d82edd506 
