Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8056A2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 22:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdBWWaF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 17:30:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36496 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdBWWaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 17:30:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id c193so123958pfb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hIr49bE2qzaueIBJ/+5ITcDTZdu6u06Vnc/YraZ/KSw=;
        b=CBmyPuyzu5wpne/U705+Kq1m77SMNjwvEWM778un7qANarW3QcpaKA8tgjaZ5bSsIR
         8c3Q50I1uPaJ+J87wCgxxo5aoRhJxNveVwdNjJGXbG5whyXUcWXtTyWvT7cdZQBw0aZ0
         JMBOpDoKDGPR/TUjGz+TQW5fYkVVZKlzXChNpH1wxmNfKvIiwpAiVGCQQvUEILw7ktEe
         XJfDgeiiQrGhN8JvRc3Xb6S7heqWopeeFEgXokBZoShIHWEjeZkURBzT+fKsf/JDiS1X
         UG40se5Rlk4SkHLp+xYfwM/5KE8XgPPXdzG3ZSUu1aVyA80hFHlxr+DSF4XvMbCOESHS
         2cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hIr49bE2qzaueIBJ/+5ITcDTZdu6u06Vnc/YraZ/KSw=;
        b=n9QYPxgZuFR7uRpiIE0iC3KVLFDVZ3B9h+GobkbeUBthk7l553Qn+ceMEcD4TCBwFZ
         2S3hfiPtRMAU8MoteaCb7xhB3N/Y5Kcrm6Mv9fLVyQcoTeH9nhJWhQMmCWpWhL6qV9S1
         xvf1HmSZzDu02S6lLEpOFNTMWTdqrR5qYhBHKmGqJEgOKVNtZk/ggwAkQfVWybcV3hcl
         gkEub6LyltQQwmW5WrE/jH0bDd4Y22p+C4dGJPFT1YZFxHKQkba6mVDQH9F0yz/5YgsU
         xx+1gqSTFl5cMUSTXAlCtvQ73sEgLAYhX4efPqdCaNBGMepMokj1157WEDvW/JFZcJFs
         AUiA==
X-Gm-Message-State: AMke39kq0+0AhDCBgSMwEy1H4m+UQnxlAy6dfe01VFbUIhKiW8AalLcRXygMhuZ7cj02gQ==
X-Received: by 10.84.233.194 with SMTP id m2mr58491132pln.126.1487888993144;
        Thu, 23 Feb 2017 14:29:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id h17sm11550565pfh.62.2017.02.23.14.29.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:29:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] delete_ref: accept a reflog message argument
References: <20170217035800.13214-1-kyle@kyleam.com>
        <20170221011035.847-1-kyle@kyleam.com>
        <20170221011035.847-2-kyle@kyleam.com>
        <CACsJy8BJgL1i85nZ9CpAXCKaG+PQQkjRKLFPWzbsMF8WN8TEjQ@mail.gmail.com>
Date:   Thu, 23 Feb 2017 14:29:51 -0800
In-Reply-To: <CACsJy8BJgL1i85nZ9CpAXCKaG+PQQkjRKLFPWzbsMF8WN8TEjQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 23 Feb 2017 16:33:25 +0700")
Message-ID: <xmqq37f47d7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 21, 2017 at 8:10 AM, Kyle Meyer <kyle@kyleam.com> wrote:
>> diff --git a/refs.h b/refs.h
>> index 9fbff90e7..5880886a7 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -276,8 +276,8 @@ int reflog_exists(const char *refname);
>>   * exists, regardless of its old value. It is an error for old_sha1 to
>>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>>   */
>> -int delete_ref(const char *refname, const unsigned char *old_sha1,
>> -              unsigned int flags);
>> +int delete_ref(const char *msg, const char *refname,
>> +              const unsigned char *old_sha1, unsigned int flags);
>
> Is it just me who thinks it's weird that msg comes in front here?

You and anybody who didn't read what was discussed earlier, methinks
;-)  cf. <20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net>

> ... You'll
> probably want to update the comment block above if msg can be
> NULL.

Good suggestion.

Thanks for taking a look at this topic.  IIRC a recent update to one
of your topics introduced a new conflicts with this one.

