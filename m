Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6FC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 02:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbiBPCsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:48:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiBPCso (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 21:48:44 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0690CFBA71
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 18:48:34 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d84so601759qke.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 18:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0syWmH7e9XwQ64CbsdECMP030Bd/ovsLivX96Adx8A=;
        b=jzHgpcRwu0wNGlzTigoMJSSzBG+HUmE6EIvu6lEA+WGQvsk9YrcOCgFqTSomeJhdaf
         PmRK6lHkRza0diXJy7GmcCyNJ72AnOgadWNy7OToXE3yGZf/6NcUDk8H2WGW5Z8SkKWQ
         mGAvLsIS5sefp4JJI3Sp2THDQAcuob6L2R/jx5+vD/H3PpfBTVfQU0OTXP2LkSj4CvI7
         io1jGOj3I6YSv/fvQw33st2eCnZsx8w/aHqxGKkhg2/KEiNDXfcn3Bp01TmNx1EpPaxm
         joX51jbwJ7xizYbhMnwuIwz4jlKy6J8JMii3iGVEizZDVMkajO9OGwsBHsmL4dbzDXvH
         siUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0syWmH7e9XwQ64CbsdECMP030Bd/ovsLivX96Adx8A=;
        b=qbmUWVkZtPmIUiveIfAcgMOLtM/zrGAI5HoRhzmBC2jKOwHiFw6M9oKWxCiXHw9ojI
         j0TcjBNU7znHy8h5pfByAoGVx+m7RMkhgBvfh0ChMxwdXekO0QPTjB10TslnO3HKChK7
         9Hp6+3i5Ts/3KrCxGd5b9Dx1lO8bQYV+YYCtsBOSUvLG5Tv/mc3FJ3ipR4EVBzQrb6I4
         V0lhSCZ3jO89I5kkQGO0Pp5jIWlaIyH1ufQvhRVotJ1TJAgdxzITeK5MFNRcb3T9nVBi
         bVhkNHa2rcfFGwF6UdymLzluuT8nUUqjA8k7E88EkaLVE4QLVF6yfiAnhAqf2Vxy3nsM
         sKrg==
X-Gm-Message-State: AOAM533V/znw5uXsxAbPRqQaz8XKJQKNJa8HYY79ll4PUDso8XborWXn
        dWFFFwbYml84VIXXfF+BpGY=
X-Google-Smtp-Source: ABdhPJyQCLf6+TwCdyWw2Mr3WwLHecMKAnM3cgJtp+g04e9csrbu5m1qpicugWcawbSlTR53acXBTA==
X-Received: by 2002:a37:62cd:0:b0:47e:c51d:9035 with SMTP id w196-20020a3762cd000000b0047ec51d9035mr408256qkb.282.1644979713074;
        Tue, 15 Feb 2022 18:48:33 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id r2sm21291292qta.15.2022.02.15.18.48.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 18:48:32 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 4/4] cat-file: add --batch-command mode
Date:   Tue, 15 Feb 2022 21:48:31 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com>
In-Reply-To: <xmqqfsojy50b.fsf@gitster.g>
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
 <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
 <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
 <xmqqfsojy50b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15 Feb 2022, at 20:28, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +static void dispatch_calls(struct batch_options *opt,
>> +		struct strbuf *output,
>> +		struct expand_data *data,
>> +		struct queued_cmd *cmd,
>> +		size_t *nr)
>> +{
>> +	int i;
>> +
>> +	if (!opt->buffer_output)
>> +		die(_("flush is only for --buffer mode"));
>> +
>> +	for (i =3D 0; i < *nr; i++) {
>
> If you updated the max number of items *nr to size_t, don't you need
> to use 'i' with the same type to count up to it?
>
>> +		cmd[i].fn(opt, cmd[i].line, output, data);
>> +		free(cmd[i].line);
>> +	}
>> +
>> +	*nr =3D 0;
>> +	fflush(stdout);
>> +}
>
> Wouldn't it be easier to reason about what the caller/callee are
> responsible for, if the function signature looked more like:
>
>     static size_t dispatch_calls(struct batch_options *opt,
>     			     ...
>     			     struct queued_cmd cmd[], size_t nr)
>     {
>     	size_t i;
>
>     	for (i =3D 0; i < nr; i++)
>     		... do stuff ...;
>
>     	return updated_nr;
>     }
>
> and make the caller do
>
>     nr =3D dispatch_calls(opt, ..., nr);
>
> or if the function *never* leaves anything in the queue when it
> returns, then
>
>     static void dispatch_calls(struct batch_options *opt,
>     			     ...
>     			     struct queued_cmd cmd[], size_t nr)
>     {
>     	size_t i;
>
>     	for (i =3D 0; i < nr; i++)
>     		... do stuff ...;
>     }
>
> and make the caller do
>
>     dispatch_calls(opt, ..., nr);
>     nr =3D 0;
>
> instead of passing a pointer to nr like the posted patch?

Yeah, this is what I had before but there was discussion about separation=
 of concerns in [1]. But perhaps it's preferable compared to passing a po=
inter to nr.

1. https://lore.kernel.org/git/CAPig+cTwLhn1GZ_=3D6s0FXL0z=3DQ=3Dp1w9ZGK0=
hAV8wfK9RsQYjnA@mail.gmail.com/

