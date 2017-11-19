Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B73E20437
	for <e@80x24.org>; Sun, 19 Nov 2017 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdKSNSd (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 08:18:33 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36864 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdKSNSc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 08:18:32 -0500
Received: by mail-oi0-f43.google.com with SMTP id y206so4564409oiy.4
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 05:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bacGeQc7/u74Ee5BbPIlT2Qyonve1xfzvnTq0uqMjCA=;
        b=MQaiA3BiuVb/RtaXbIXzDc7psGA+5T+mVW5wu5QBw10PVU91ZhFoSceaxeZj7pXjR4
         c2UuEoBC8l5sMRmz17bifAXKt8lU21G752j19EzJSGIaJky+uTnAFiuh1sZ0en+bSsmB
         l+TC2bQ1QeZVQW49NU5hTGOIvsaKX8PNu1DMugbjQTBTx0bQJyLcYlT0jwRpSxzKQsNo
         Yd4uaQUUQtHwSUm0SJXd/sdUDmHatGdlYiQD8jZfOvMksvyGVADxA5XXhJPYak7VLnMC
         FlAijZFvus7A2hnvwyAZDc+beSs/eYWD8qqhRlnzAKzLE9DO7Vuk5gQJo2TSjLCKzYYW
         xlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bacGeQc7/u74Ee5BbPIlT2Qyonve1xfzvnTq0uqMjCA=;
        b=GIXfV03G78T3BTlQCUwovZ6W1qKT6uguaWUlh52g5gRiBZ2rh/kuE0iYVAL75yNily
         8nmmYHXcOmpQv0O1mcPSVChbfCaDCJ87nOcXyuYIFWhesdI+yWeicOU8hsqYM1ebxggw
         5X1I9J0V5eiJKIgYsZL5xxVFkiBZAJ0aIadpnmfaU6Yi9/cU2LEpgE9AGriivlGrksnz
         xFnO2iLXo3hFu5oMr+iVq4HewZN46diklMqN542nQNC/U1lD6hszGoLtaQ4giVSQNOD1
         hor+eVbOIq8c+kgPqZiuOOVNOWymTB5sfxHbiqjkfrIyHsaLbTr19+ph9EHaWyuaZkZd
         H68g==
X-Gm-Message-State: AJaThX73+WEjLBe2BlRMHHhndR9yIJsTe3g+ugwgBtQoHvahBBOozuIi
        +3761+qUQZTmD55zv+JI3c96dD9xLp5/YegWJuk=
X-Google-Smtp-Source: AGs4zMY/MbEd8fQ44c68KFnsy3CRhZ9uOAcv14KZ5qrJFBIYKla6uphZAFaQ4+3w1ONBRBMD3CRc2xBqr3emSC3do5Q=
X-Received: by 10.202.86.76 with SMTP id k73mr5628022oib.289.1511097511656;
 Sun, 19 Nov 2017 05:18:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.1.137 with HTTP; Sun, 19 Nov 2017 05:18:31 -0800 (PST)
In-Reply-To: <d9076fef-c90c-63f2-5e0e-37293810e3d9@kdbg.org>
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
 <20171119004247.22792-1-gennady.kupava@gmail.com> <20171119004247.22792-2-gennady.kupava@gmail.com>
 <d9076fef-c90c-63f2-5e0e-37293810e3d9@kdbg.org>
From:   Gennady Kupava <gennady.kupava@gmail.com>
Date:   Sun, 19 Nov 2017 13:18:31 +0000
Message-ID: <CAPu-DQqO5gfr3H_vHu3JBeJrkCmh6qQ=vs=GOkLKjtE9=tDgcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Reduce performance cost of the trace if trace
 category is disabled
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right, this trace is actually not used anywhere, so only check was
compilation. Will fix that.

On 19 November 2017 at 08:27, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.11.2017 um 01:42 schrieb gennady.kupava@gmail.com:
>>
>> +#define trace_printf_key(key, ...)
>> \
>> +       do {
>> \
>> +               if (trace_pass_fl(key))
>> \
>> +                       trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,
>> \
>> +                                           __VA_ARGS__);
>> \
>> +       } while(0)
>> +
>> +#define trace_printf(...) trace_printf_key(&trace_default_key,
>> __VA_ARGS__);
>> +
>> +#define trace_argv_printf(argv, ...)
>> \
>> +       do {
>> \
>> +               if (trace_pass_fl(&trace_default_key))
>> \
>> +                      trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,
>> \
>> +                                           argv, __VA_ARGS__);
>> \
>> +       } while(0)
>> +
>> +#define trace_strbuf(key, data)
>> \
>> +       do {
>> \
>> +               if (trace_pass_fl(key))
>> \
>> +                       trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key,
>> data);\
>> +       } while(0)
>> +
>> +#define trace_performance(nanos, ...)
>> \
>> +       do {
>> \
>> +               if (trace_pass_fl(key))
>> \
>
>
> The token "key" here looks suspicious. Did you mean &trace_perf_key?
>
>> +                       trace_performance_fl(TRACE_CONTEXT, __LINE__,
>> nanos,\
>> +                                            __VA_ARGS__);
>> \
>> +       } while(0)
>> +
>> +#define trace_performance_since(start, ...)
>> \
>> +       do {
>> \
>> +               if (trace_pass_fl(&trace_perf_key))
>> \
>> +                       trace_performance_fl(TRACE_CONTEXT, __LINE__,
>> \
>> +                                            getnanotime() - (start),
>> \
>> +                                            __VA_ARGS__);
>> \
>> +       } while(0)
>>     /* backend functions, use non-*fl macros instead */
>>   __attribute__((format (printf, 4, 5)))
>
>
> -- Hannes
