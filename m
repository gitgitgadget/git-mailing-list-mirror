Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E559F20259
	for <e@80x24.org>; Wed,  7 Dec 2016 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbcLGXVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:21:32 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:33812 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbcLGXVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:21:31 -0500
Received: by mail-io0-f170.google.com with SMTP id c21so682058065ioj.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LngaNTrreTh49FcW7suVTLKsjxiIbz2ab/9nKNBrI3w=;
        b=MMSm3JMNKjXtXk4I1PjFjHhaDXiaV4Ybjj26dH/dxB4jqnSLnPRR5g5+NoOvRHuj5k
         WLYPvVYemsBdfGB1xWhllhkQPdmJF7DIDJsor47RuPW2b2r0Z43owSjagSJ9REW990/n
         g0a5Pf6w7xVAF8kb4Uz4o8DT18+U8vs+4zbHJzWB79SdTATmAidcUw6HoMh4m0Bq1/Nu
         SA8Kk6uFdwq/pEWbL1D83IB207G7pYlD5+O1bsZLXB/nPAg27DNeprbDeWVNxYwYG/mj
         qfLaA64shoufSKDix1mwMDVGMnu2in3L55pl5ByyCxdKvgUGiUuwC7f2oCVW0FS4ya6g
         XAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LngaNTrreTh49FcW7suVTLKsjxiIbz2ab/9nKNBrI3w=;
        b=S0qlmSpvRxWYkvdlDC8xCThDe/L/vXSCnb8UCasLtU9dZv7OpfuNCOnq0MXIMYaz1g
         /G8ieeb1hPml7/EE5V+qG3nZdFSeFHdb8bzsMSaz1o76+A8EHiZaKVWCJzVc6ZynDE30
         azM5R+rlbwGw8ZHo/ZG9xZcgCDe/HVtv5/15xtLFhSACFsay7LOrNaF21jAwtm0Oejhg
         lfGO8Y0rU6dl5TUWD6V1CFUNHxjJwa26pCyEQcrB9Pg1DoQtlii74Zvv0z+bjwqC1uet
         LRL69k1DzaOh1lurhS//CDnf9/HOradfQ5ms7p9LT+nPSaaGorVbKDagTr3j36QKv2ud
         xqXQ==
X-Gm-Message-State: AKaTC01vtfo3xMq258LGne8tq6cdGbkjxrAW+QKgFGydCQBB9W7Daea5AnpM6+paxA3EsuPAKEHyuuBvafFK1g==
X-Received: by 10.107.59.9 with SMTP id i9mr62652479ioa.176.1481152891169;
 Wed, 07 Dec 2016 15:21:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 15:21:00 -0800 (PST)
In-Reply-To: <8d32c645-e850-5e7c-b01c-6e4d81e2d672@gmx.net>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com> <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com> <8d32c645-e850-5e7c-b01c-6e4d81e2d672@gmx.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 06:21:00 +0700
Message-ID: <CACsJy8AP-N4BDyaXszvbh2k8fr7jO+YhVj=_0o0x1ooWrqkR4A@mail.gmail.com>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 3:35 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 12/07/2016 09:04 PM, Junio C Hamano wrote:
>> Stephan Beyer <s-beyer@gmx.net> writes:
>>
>>> [1] By the way: git cherry-pick --quit, git rebase --forget ...
>>> different wording for the same thing makes things unintuitive.
>>
>> It is not too late to STOP "--forget" from getting added to "rebase"
>> and give it a better name.

Sorry I didn't know about --quit (and it has been there since 2011, I
guess I'm just not big sequencer user).

> Oh. ;) I am not sure. I personally think that --forget is a better name

Yeah, I was stuck with the name --destroy for many months and was very
happy the day I found --forget, which does not imply any destructive
side effects and is distinct enough from --abort to not confuse
people.

> than --quit because when I hear --quit I tend to look into the manual
> page first to check if there are weird side effects (and then the manual
> page says that it "forgets" ;D).
> So I'd rather favor adding --forget to cherry-pick/revert instead... or
> this:
-- 
Duy
