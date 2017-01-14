Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F15E2079E
	for <e@80x24.org>; Sat, 14 Jan 2017 10:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdANKC3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 05:02:29 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34199 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdANKC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 05:02:28 -0500
Received: by mail-yw0-f194.google.com with SMTP id a10so5378636ywa.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OinjvktF2p2SiA3R/irlj36gYjxMlWg6+K3DlJ93ksE=;
        b=tCDaaNncQaIld0bg+JsA3LCocwYNZwc2o1U1S8Hd38f8LEQEb8QDGKXvn06ORW3MN7
         t3zkeCZby2T1t0BCnAS/xaMSSVoP2zBgRo0rxkomu31uENGr3gVjw+B+OHyNRf3REMS7
         IEwLzgcVpVmypsGzFAoSrb7b6laofTn4EkpRqjIof76/Rn0o1v9aQ4Ov0AQQ2JC53lpE
         MIa2Z+8y81Q1XOzGVxXWUoyyK+u0uYGeBnW77sNU71ABRmeauy3GsQFI+yCzKl86kJUa
         KYv/AKBZ1PDWNQ4QqSKB5q2OECDZW5GvYvIHfKs9AnGAxdqdAFQnzfJFGPj0FFsr186N
         XNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OinjvktF2p2SiA3R/irlj36gYjxMlWg6+K3DlJ93ksE=;
        b=sDtx6yVFSSyllXWn2LsdlCRp6IJ9diDgX6cztU4USh6EMsGw9/Eo76Wd4BC+6fWYP8
         tiZRPl0Y1aXWdgu7mSuy69VX4LmS/qQCRgzYnl4VY2a2HMpmybXAWA0l4m2L07193bLU
         OU2ojv7l8Qb96gyK1MdGweVD0exCFtEHdAQ2ER1CvBPJAe3QTEuHxoFkkiG8VJTGsW1B
         gXDwuHbrRxPXVrZsmqXEU2005flmLCbb/NxNsAKxYplVq1Cd3QL3j2zMmNFDB8c1CqfK
         adhAAC9KhJwLSjfaB3dHRkupLDCAf3bNEzPklgfa0kXP2ztrjeIuBSUrNGGmGjQHUWi6
         DWIA==
X-Gm-Message-State: AIkVDXJDQ4slpi2CnA2N1RJz6FUgnYoXoXU3EmXv5g3mmJ07ON+CfyIo2QMDFfK3faFs9IK4rbzsp6YWr0HeJQ==
X-Received: by 10.129.85.68 with SMTP id j65mr17969185ywb.123.1484388147602;
 Sat, 14 Jan 2017 02:02:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Sat, 14 Jan 2017 02:01:57 -0800 (PST)
In-Reply-To: <CA+P7+xqV+CJwP-0_27V26UZbkDzBqbdstGw_Rq=8c3SkjAq2bA@mail.gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com> <20170110084953.15890-20-Karthik.188@gmail.com>
 <CA+P7+xqV+CJwP-0_27V26UZbkDzBqbdstGw_Rq=8c3SkjAq2bA@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 14 Jan 2017 15:31:57 +0530
Message-ID: <CAOLa=ZQR9ksPtRw_9FneN26Mjq1TVYx7o=YOM4cDNgrDbuQtXg@mail.gmail.com>
Subject: Re: [PATCH v10 19/20] branch: use ref-filter printing APIs
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jan 12, 2017 at 5:17 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Jan 10, 2017 at 12:49 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 34cd61cd9..f293ee5b0 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -37,11 +37,11 @@ static unsigned char head_sha1[20];
>>  static int branch_use_color = -1;
>>  static char branch_colors[][COLOR_MAXLEN] = {
>>         GIT_COLOR_RESET,
>> -       GIT_COLOR_NORMAL,       /* PLAIN */
>> -       GIT_COLOR_RED,          /* REMOTE */
>> -       GIT_COLOR_NORMAL,       /* LOCAL */
>> -       GIT_COLOR_GREEN,        /* CURRENT */
>> -       GIT_COLOR_BLUE,         /* UPSTREAM */
>> +       GIT_COLOR_NORMAL,       /* PLAIN */
>> +       GIT_COLOR_RED,          /* REMOTE */
>> +       GIT_COLOR_NORMAL,       /* LOCAL */
>> +       GIT_COLOR_GREEN,        /* CURRENT */
>> +       GIT_COLOR_BLUE,         /* UPSTREAM */
>>  };
>
>
> What's... actually changing here? It looks like just white space? Is
> there a strong reason for why this is changing?
>
> Thanks,
> Jake

None, I'm not sure how this ended up being added too.

-- 
Regards,
Karthik Nayak
