Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730601F803
	for <e@80x24.org>; Mon,  7 Jan 2019 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfAGUL5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 15:11:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGUL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 15:11:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2157831wmt.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JDoN0h8JjIgg892bontAZ5bQbmsbYu1CKALRg4g1R+c=;
        b=XyzRmQ7GfWtzsnVwwdN8STm+XBI5kPHkH+1/iWz+7l67Etil257NYj2bH71k02Usbu
         +xgL09GdY+3IdsCnb23SKZFIMQlLVD2r0GOy/DAeTNriUcw4Wqwo7pvm5WlI7H53ijDz
         6Rub55jrUtFiMMSpDHL8ihHVDuBh+UYp+SsUnYAlrD/AdQn50jrlEaJ9qxS/gZ+IA3S9
         hWSlKv62pEc/oWghL53AyN3YqEpp/nWA8B92gcpFEg6JkjourWDNK7s4e244QfVKSpoX
         iKfTIp6kP5QGtETE5+zfvE50JDpzbF3UvBJuhcImDl9FgSjVQfyq0LX9iXCunr/YkDxG
         cSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JDoN0h8JjIgg892bontAZ5bQbmsbYu1CKALRg4g1R+c=;
        b=SYgDoOp38m2659JyqbxwQ/4Ie8A+JNG5BN2gJZNFPkwZB/1rPBDmUmGZXkKcJeVsDJ
         iV3JWFB3gYjoW+FuLON8+rMaR7TdRvgEePopgy5a7lZS299E23zWb+0lX46xGS+RzhOt
         AlSPj/BUuZ5N9vl3PpipbU8K93gha4FNAZzOJDPg1OT6WLz3DS4BNGr3K2oYoR1dxR/w
         E/rhd4F+LpmJERZi9a81p2/qhMzfhlyfAOB8vjTO0p8fE4gGcmxzcbsL9plRTcbILzyv
         cOdNcyYEZKTzQ7nUp8f6ihjzYsehEPQLOccUFeVGKWPAr9ionctDH/bd4jO8sV7moGMW
         hnwg==
X-Gm-Message-State: AJcUukdDsDF35T9EVN0b6rsNaighzxyVryL4ySDCYDGJNvMlt2Zg5yw+
        XAmm/7JixYMTbsi8g00uBYs=
X-Google-Smtp-Source: ALg8bN7VvRoFW57tr6btqodyBEA4TJtL75tnXXM3H0y3rVs2nDWaHYGyznMT2Nhif9HC/A/48vVtsw==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr10518438wmf.144.1546891914072;
        Mon, 07 Jan 2019 12:11:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 129sm9772333wmd.18.2019.01.07.12.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:11:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
References: <20181122044841.20993-1-newren@gmail.com>
        <20181211161139.31686-1-newren@gmail.com>
        <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
        <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 07 Jan 2019 12:11:51 -0800
In-Reply-To: <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Jan 2019 11:46:23 -0800")
Message-ID: <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
>>>
>>> This series continues the work of making rebase more self-consistent
>>> by removing inconsistencies between different backends.  In
>>> particular, this series focuses on making the merge machinery behave
>>> like the interactive machinery (though a few differences between the am
>>> and interactive backends are also fixed along the way), and ultimately
>>> removes the merge backend in favor of reimplementing the relevant
>>> options on top of the interactive machinery.
>>
>> Friendly ping...let me know if you want me to simply resend v4.
>>
>
> If you have anything newer than 90673135 ("rebase: Implement --merge
> via the interactive machinery", 2018-12-11), then yeah, I haven't
> seen it.
>
> Thanks.
>
> P.S. even if that one is latest, I would need to downcase Implement
> before it hits 'next' ;-)

Ah, one thing I forgot to mention.  Some of the tests updated in
this series are unhappy with Dscho's "drive 'am' directly from the
built-in code, bypassing git-rebase--am.sh scriptlet" topic.


