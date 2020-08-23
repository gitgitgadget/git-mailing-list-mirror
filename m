Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B72C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD7820706
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTKTNEU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHWQEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHWQEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 12:04:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF6C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 09:04:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so6346441wrm.6
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upwlPRMC8OlFUQJqFDoiso/ZCRpqAE3EqTACQyQ9qqs=;
        b=DTKTNEU1bxtteAYim+WJWXV11unGdaZwjWjfua6Kzg3/0a0bSDAj0G4DHfDqZFEzja
         12SNBx9tO1YsXb7UPUQBQQqxYPAoWy8nyD8FnK/StU/HTv/AVfWEoWQ3JH3Zpr6yuTiR
         LTZn5pz1sXO1TdOB3Bb5ppWYqHEu4GaWmxeaL116zohLGVu+X/vdqi7nRpoFsEEBseYB
         HGhj6UrSb75YkzRRcY1KP1Hoj9Hqmezn8qV5sGrME8AMUorpZMP9oLHrIr8AI08hW3Ov
         KR+kL8Rud90Cor2T7UG3cwRuyy4lcuP8NhOdFNGqjMQDzKg63DsxM1P6K9zJbpyyvVpB
         1NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=upwlPRMC8OlFUQJqFDoiso/ZCRpqAE3EqTACQyQ9qqs=;
        b=Uc/SicVB56uepkXFDazgBcWuwND2EqPP101kxNAExNd1g0tttVfnVRFoj0znr2tXqy
         MphAjRSeuyaRvkEC28Nuzz+R8vajmk+YdcHniMXVJGTgqUFg+yvuFYU8CGeJRHJckIWe
         JITPY3BT3EDqSEshibrp3nfA7eGnfVlawPZG4cPg4I75V2jSJIGd6PmYoJ6NOCwuQh6N
         Acl8xGnZ+CSO9nVVsp3GmRKlSpZ7lTvJPYSbtHJ7+RyllfutEMnZ4//dUpw9oR5ojreO
         0KpVZ8ItzgAATs53pKe+7/u4vj2TgWA67RGXvDSo44N+IXh1YxHs5B8oAQxrsewwVvkY
         Awbg==
X-Gm-Message-State: AOAM533w+cs3M5gAKHUQeBy6XF/m+qCMiOIYZozG/fQLx580AHafUuua
        Sfh7N18tboy6re7HnKj/SEEr88GWc3E=
X-Google-Smtp-Source: ABdhPJwaAeiWo64dSEFJ1MuttOiYnmRYtBDlbVo/XlXgmzR1E+6F9/ll1/mZXCxDkusxEXuSXXwFdQ==
X-Received: by 2002:adf:ae42:: with SMTP id u2mr1954829wrd.337.1598198638710;
        Sun, 23 Aug 2020 09:03:58 -0700 (PDT)
Received: from [192.168.1.240] (16.45.90.146.dyn.plus.net. [146.90.45.16])
        by smtp.gmail.com with ESMTPSA id s16sm19420857wme.13.2020.08.23.09.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 09:03:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git add intent-to-add then git add patch no longer allows edit
To:     Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
References: <C52FB27V04G0.2ML0PLGDE71MG@ziyou.local>
 <xmqqmu2o9d6j.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4607f4b5-a5d6-7965-553f-19a52656fb13@gmail.com>
Date:   Sun, 23 Aug 2020 17:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu2o9d6j.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/08/2020 17:27, Junio C Hamano wrote:
> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
>> I fixed half of this in a topic that's on master now (it errors out
>> entirely if you try to stage it at all in 2.28.0),
> 
> Yup, thanks for that one.
> 
>> but new file diffs
>> still aren't splittable into hunks. Phillip Wood (on cc) is looking into
>> that; the tricky part is that when split into hunks only the first hunk
>> actually staged can be a "new file" patch.
> 
> Out of a change that adds a file with three parts A, B and C (in
> this order), you could pick the parts A and C, while leaving the
> change to further add B in the middle, and create a patch to add a
> file that has A and C, and apply that to the index alone (i.e. "add
> -p", pick A and C, and "add" that part by applying that "new file"
> diff).  After that, the path is no longer i-t-a but has the real
> contents (i.e. part A followed by part C), so further "add -p" would
> see the difference between the index and the working tree as a
> modification patch.
> 
> So as long as you could come up with a good UI to pick parts from a
> single hunk "new file" diff, "the second and later application must
> be done as modification" should fall out naturally, no?

I think I was talking about edit rather than split. I'd forgotten that 
it used to work with i-t-a additions. I just checked seen and it seems 
to be working again since dscho's patch although the user is presented 
with the full diff header rather than just a hunk header in the editor. 
As you say once the user has staged some part of the diff the rest falls 
out naturally.

Best Wishes

Phillip

(I'm about to go off line for a while)
