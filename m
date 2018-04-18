Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCAE1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDRVYq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:24:46 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:40079 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeDRVYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:24:43 -0400
Received: by mail-wr0-f180.google.com with SMTP id v60-v6so8502079wrc.7
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RuEm+P8utd/Zq2Rkp7YI5A38n6gFS3jzEqQPSBszFes=;
        b=ZSL9d/hKcbcuogQNVPjRCZd3kNacfAMDn69Zs7k1LkjiXpUKfET+MjUIc41MrDwo33
         b1kNYrPN91aCBCxlcfdjYjrOYmcQ2A1S3ed+5gWoa+ZNT9sR8b/S77bLXvkqfkLmHtlY
         R+7EuZgXuCC1dZkQ0vuv8EewEJ1sjLrRAsZmqJrWNbAVZvGR5vZ+mAcauNZ6FvvC0J2V
         qTIWkCrxro8RsFXvLkrqGgtm9uHHDOWD7z+JrK6d+cgTS18PusVJ/oMmfZ0H0FgZ5MbX
         Ka8lOB8Ue350MYBjN/+Bw4a1WpmlXApAzf+AcAXaJAzKWm90WotW+Hd/VivVxUho3EwD
         he2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RuEm+P8utd/Zq2Rkp7YI5A38n6gFS3jzEqQPSBszFes=;
        b=QeMnTTzW5EvDhL+BAkzkexrw5/dkMCyNpxZ+PLDeIlNS8Peg0P/5nKuniEkUnCWcin
         53OLpNV9+vdnvPph+SHArNEEQ9jGdzZKzW0YmNE347Eh5pZyyFptDIbe1GboV0Ar6jMv
         dcYuMJz22r/yUnkEImXMGW5iiB9+WX0q0MHe8eE3gWhnXbOuaIDiu5ROa6vYG1F8wyJd
         vM3YZlrZkzyRWm5QFohyOl3fh08/RzH4E+asJKM/Q3CMCbqt3xvIANHgOHm8IpZVGznu
         EXl8gS78jKz5oGVcuMcRehRZy7cyqn0Upo0uoql7uQ5apufgVYv/Mlm7Tf7GQ4YFGc9B
         dhAg==
X-Gm-Message-State: ALQs6tDFqkaZC+4mRqFAZqqAGvHKxZesTdeuV9XQYcDgUBKD5ywePEec
        wBPh4WX5AyhQp335yYN0ea8=
X-Google-Smtp-Source: AIpwx4+suE2EPEmZ81jwMHHWzd8dtTTG0ytaSlUTQtiAVG7F1r/0ALglRxz0LklJivgyekUEE+Jx5Q==
X-Received: by 2002:adf:8f25:: with SMTP id p34-v6mr2679743wrb.193.1524086682056;
        Wed, 18 Apr 2018 14:24:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m20sm2492220wmd.7.2018.04.18.14.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:24:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] submodule--helper: don't print null in 'submodule status'
References: <20180418145337.7591-1-pclouds@gmail.com>
        <CAGZ79ka=z82u_wByO++Ds4uLWi1TB2=Etzbhb3vev8qpYzBMeg@mail.gmail.com>
Date:   Thu, 19 Apr 2018 06:24:41 +0900
In-Reply-To: <CAGZ79ka=z82u_wByO++Ds4uLWi1TB2=Etzbhb3vev8qpYzBMeg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 18 Apr 2018 10:34:46 -0700")
Message-ID: <xmqqmuy0gqcm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Hi Nguyễn,
>
> On Wed, Apr 18, 2018 at 7:53 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> The function compute_rev_name() can return NULL sometimes (e.g. right
>> after 'submodule init'). The current code makes 'submodule status'
>> print this:
>>
>>  19d97bf5af05312267c2e874ee6bcf584d9e9681 sha1collisiondetection ((null))
>>
>> This ugly 'null' adds no value to the user using this command. More
>> importantly printf() on some platform can't handle NULL as a string
>> and will crash instead of printing '(null)'.
>>
>> Check for this and skip printing this part (the alternative is
>> printing '(n/a)' or something but I think that is just noise).
>
> This patch restores the behavior from before a9f8a37584 (submodule:
> port submodule subcommand 'status' from shell to C, 2017-10-06),
> so this is the right way to go instead of the alternatives you considered.
>
> Thanks!
>
> Reviewed-by: Stefan Beller <sbeller@google.com>

Excellent.  Thanks, both.

Will queue.

>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index a404df3ea4..4dc7d7d29f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -596,8 +596,12 @@ static void print_status(unsigned int flags, char state, const char *path,
>>
>>         printf("%c%s %s", state, oid_to_hex(oid), displaypath);
>>
>> -       if (state == ' ' || state == '+')
>> -               printf(" (%s)", compute_rev_name(path, oid_to_hex(oid)));
>> +       if (state == ' ' || state == '+') {
>> +               const char *name = compute_rev_name(path, oid_to_hex(oid));
>> +
>> +               if (name)
>> +                       printf(" (%s)", name);
>> +       }
>>
>>         printf("\n");
>>  }
>> --
>> 2.17.0.367.g5dd2e386c3
>>
