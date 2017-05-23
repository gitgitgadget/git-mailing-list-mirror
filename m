Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5B61FF30
	for <e@80x24.org>; Tue, 23 May 2017 07:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966211AbdEWHiK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 03:38:10 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32876 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964930AbdEWHiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 03:38:09 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so106442938pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7HcvrbKSa64oKPcbRQlJ8t7NzoG8CjWRo/dC6/UMP7A=;
        b=uAm2nn5fQ2gXLEMaV06CMVOjoBRN0Ouyv/Fg4fg4TpUzdKM4fdHcfkIfYRnleoWc2r
         cLvfE8iZqTtK/tZk46nwAI22/12FM1+Vtrsdgpr1/MXZcIwNvNMKGCooqjvMmGjzCvKi
         vw2y788cTUPPHUF3Kko1Dk/20gX9gMHjaC9DA/L7U9rS1+TqL6u5hX6qf4oeJGXjpPh+
         psk7/4HSW2cD/fop4Pl8Ue06efcUuiF881X4ZL4klOBM3OAtiXnM6pl41xCuWtKGycTI
         0dWDy2jJU5TJpW/L9FZ/P1ftwJnxzTibj/ZHi8JVPbuGvLO/fepTWseLU2lrcQDALQQC
         XZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7HcvrbKSa64oKPcbRQlJ8t7NzoG8CjWRo/dC6/UMP7A=;
        b=okNuhzSlyTn5Mr48Nchmn/Y+cUwK1D54bPP/wPX0oYZK6EmPHWhobHmu6dUFCgm82U
         tDTGwng4PKlgM5VNHUK/NYcGS6A4KgvMj7yAZeBhPDp0tgCwXzRhFx/z9cFQLx4lBKjg
         1gJ0zg7YQYAt82nPcGLpheT2iyMJ7O2f6Nm7Sx1js7xFLoVvOLW4N9ldCvblrpUm4teM
         DocnlDXtpwJhmcoNZRe9bj4cym9100F5tIhyjaS2RAarG577vmMlI8N3m1/TKqznr/Tm
         IKBtKEQ0Vgv0/4ybZDAS9zJyN+CDhL63DFXSMRkWVZt61tp0+C5OupOS6vuc/v3pMFCd
         vGpA==
X-Gm-Message-State: AODbwcBjsQpTdv0hXma4bOI2JFsE0JFMTng4Ddrd81H5JpTzJUPqvMgV
        xEoJwdLusD/xlw==
X-Received: by 10.98.93.217 with SMTP id n86mr30515332pfj.113.1495525088753;
        Tue, 23 May 2017 00:38:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id q28sm29997385pgc.0.2017.05.23.00.38.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 00:38:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
References: <20170515110557.11913-1-szeder.dev@gmail.com>
        <20170515110557.11913-5-szeder.dev@gmail.com>
        <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
Date:   Tue, 23 May 2017 16:38:07 +0900
In-Reply-To: <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 15 May 2017 13:29:07
 +0200")
Message-ID: <xmqqa864kops.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, May 15, 2017 at 1:05 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> From: Jeff King <peff@peff.net>
>>
>> Using free() on a refspec was always leaky, as its string
>> fields also need freed. But it became more so when ad00f128d
>> (clone: respect configured fetch respecs during initial
>> fetch, 2016-03-30) taught clone to create a list of
>> refspecs, each of which need to be freed.
>>
>> [sg: adjusted the function parameters.]
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>  builtin/clone.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 4144190da..4bf28d7f5 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -1120,6 +1120,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>         strbuf_release(&value);
>>         junk_mode = JUNK_LEAVE_ALL;
>>
>> -       free(refspec);
>> +       free_refspec(remote->fetch_refspec_nr + 1, remote->fetch);
>>         return err;
>>  }
>
> Erm...  I should have given a bit more thought to this last patch,
> shouldn't I?
>
> First, the unchanged commit message is now (i.e. by using the parsed
> refspecs returned by remote_get()) completely outdated.
> Second, while it properly frees those refspecs, i.e. the array and all
> its string fields, it will now leak the memory pointed by the
> 'refspec' variable.  However, why free just that one field of the
> 'struct *remote'?  Alas, we don't seem to have a free_remote()
> function...

I was sifting entries in the draft "What's cooking" report to find
topics to merge to 'next'.  I read the series over and as Peff said
in his <20170515224615.f6hnnfngwpierqk4@sigill.intra.peff.net>, I
think the series overall is good.

Do you want to update the proposed log message for this one before
the entire thing is merged to 'next'?
