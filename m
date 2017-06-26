Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEF6207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdFZR22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:28:28 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34118 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdFZR20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:28:26 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so3313478pgb.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=72BTgIhPOLGlEykChbEXZRTSX7DeCtTLwvuZjoSt59k=;
        b=qDbN4Y3Vp9UkjctiPHPkPfNxLEIQZtIRdniTznNDXaWsUhco7hb/soGt/7X3uoVmPg
         D4Ub7L1/5EHKFCNg+fgPEIvcx2y0baAoo5BkhCHqaT+oPDPP63CFPJGJHJD4Yfz2spSG
         8ewkQQRcUYx1OCqMfY/WnQ9dFNfaWzv+GrPfTi+6LZpN0x1IbBo3wCL1SJnlrcrr580p
         9zdH6b5kPRGFLAOg+3gY2yLc+ADbeQYg8dv59u5t383+yLMTOUKiD4JqwiTp6VE+y/Ce
         J7zajVtaEjgMSKP2GBda+s6v7wJe5mHQuLkZGXGapsP04qBoqxQxXu3fzad/4C94bgkH
         j4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=72BTgIhPOLGlEykChbEXZRTSX7DeCtTLwvuZjoSt59k=;
        b=Kh0F1XqY3LbcBj5+xMxzfZ1sbCf0qWSd+2gYDAu1y4jbCzEX19NejJ8Wkj+ka5fE+n
         CGRDX+3Z+J4V4kPLfS813dW6xontH92I0Ks3LK+CecJx4Dtj26oHpwy5qLJmPhnc+9B0
         hqLsEcb//Nh6LpyctyP8no2jOaSh+PY+Om/D4P4Y8MiUwdqFpzUSwPPy1vagiDu1V1aH
         TN744lBvHt8r/QVVkflEowLDMN8J9HmSV0w0SaDIGHy1fLN4BRKRb6JvyR/m2Qsjiubd
         +Ra7WwxCTOhiTJGP627HSIdhY0t1XThClzBUlNLhvrEffUAVAxyfJTqd+qmvsQsVd24y
         xlnQ==
X-Gm-Message-State: AKS2vOzU3bChKwZYZGMAMne7tdbYfkG5TyVTgLZX/r/7tykEAj8lJkxC
        krhMagZ1Ylx8Ze0rwI8=
X-Received: by 10.98.224.11 with SMTP id f11mr1209353pfh.118.1498498105707;
        Mon, 26 Jun 2017 10:28:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id u78sm1197609pfd.109.2017.06.26.10.28.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 10:28:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
        <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>
        <CAGf8dgJ8C0chOxZo5CPt56225XGBgrjaGy8HDAST+0-USfW6mA@mail.gmail.com>
Date:   Mon, 26 Jun 2017 10:28:24 -0700
In-Reply-To: <CAGf8dgJ8C0chOxZo5CPt56225XGBgrjaGy8HDAST+0-USfW6mA@mail.gmail.com>
        (Jonathan Tan's message of "Mon, 26 Jun 2017 09:45:52 -0700")
Message-ID: <xmqqzicu64lj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Sat, Jun 24, 2017 at 5:45 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Jun 19, 2017 at 06:03:13PM -0700, Jonathan Tan wrote:
>>
>>> Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
>>> Improve sha1_object_info_extended() by supporting additional flags. This
>>> allows has_sha1_file_with_flags() to be modified to use
>>> sha1_object_info_extended() in a subsequent patch.
>>
>> A minor nit, but try to avoid vague words like "improve" in your subject
>> lines. Something like:
>>
>>   sha1_file: teach sha1_object_info_extended more flags
>>
>> That's not too specific either, but I think in --oneline output it gives
>> you a much better clue about what part of the function it touches.
>>
>>> ---
>>>  cache.h     |  4 ++++
>>>  sha1_file.c | 43 ++++++++++++++++++++++++-------------------
>>>  2 files changed, 28 insertions(+), 19 deletions(-)
>>
>> The patch itself looks good.
>
> Thanks. I did try, but all my attempts exceeded 50 characters. Maybe
> "sha1_file: support more flags in object info query" is good enough.

Between the two, I personally find that Peff's is more descriptive,
so unless there are other changes planned, let me "rebase -i" to
retitle the commit.

Thanks.
