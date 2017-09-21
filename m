Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65FE4202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 18:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdIUS53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 14:57:29 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43751 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdIUS52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 14:57:28 -0400
Received: by mail-qt0-f178.google.com with SMTP id i50so6928489qtf.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XzNdNrApQGqPw0t89KeUE4CiL91LyuyVO5SSdW6znnA=;
        b=E3VBmK60paTpjlYfDIktzbXtOhoWCGKXd5w/zrhODUL3yqgCCZRvvBAdo4oK8eZTfk
         3hqFTzTqcu8za3+qcnBArq0Y2smqKHa/VwVofd8+Q/6MPGuq3VVgKb48JvRVdxUHyedP
         MgrXaFU0mx0+HRTaLt0J9BxxeZRqY8t5oGqNzqS659sdNKpI5pZ2jCcGUI75TF0U3h+j
         Vigf4XgSXtTTWCK7fFYh4pMHqoiz/3qpMYNhkwsQnlYaib5HBNX5Cqr+SmhuLIz10xhE
         zAPSzA/HHAWn/KmgJFZ2mU91nXQ9+BH0mnkT6bvcMhuhK6RzGiIq3PY/utiy/LRtAhr0
         diAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XzNdNrApQGqPw0t89KeUE4CiL91LyuyVO5SSdW6znnA=;
        b=gBh7gy50xqCE1vYhoxaV28WBW2qWLvV2TG/IRq8/q5cMFwjg/5I/18hRSGyvxvUX5W
         YETc7TvCPLcazn8kAOAKJoRbXDVi+JWa5B8HXaagTqpZmZw5V4QcYigZJaLKbUHsMSwL
         y4lywV18oWsaeR9Ll6MIv5zxTmiMjGyQWeq5usQ4S3VlRN4WQdTKFh0gg6Up4gGdyqlf
         np6HIPMKZCP6zDRgOG3ETK9yntplK1umVJd8fzFze3117Sk/AkKBXC8iP3/6rSSchZhG
         iL6/BDnVQStvnwXCnzY6e2AffENRQPk8jj3K/540syrVSzzukuutv2+ylspKV2v0xdgS
         qChg==
X-Gm-Message-State: AHPjjUiXVsbKHJu/cvxNMnUOBMQZrV+ZDf3/mOOhS6qvooqxZg/u0B1d
        Ywf/A2nx0qyeIdMQfBzohm/toovbeXOF9AM5ItqtBw==
X-Google-Smtp-Source: AOwi7QB05HFnpaLbOUK0GtMLYmMK0KwbzXyhvqQpZUHksJqWYtlo0ltG4oM3pWQAGSNjSUcmhnoDLmxz8U60/iSp5Xc=
X-Received: by 10.200.28.123 with SMTP id j56mr4869589qtk.299.1506020247362;
 Thu, 21 Sep 2017 11:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Thu, 21 Sep 2017 11:57:26 -0700 (PDT)
In-Reply-To: <75416139-74c5-8a60-22e8-79c53dd062c1@web.de>
References: <15367a04-754c-f6b8-a89b-2c1ff65dedf5@ramsayjones.plus.com> <75416139-74c5-8a60-22e8-79c53dd062c1@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Sep 2017 11:57:26 -0700
Message-ID: <CAGZ79kYuGpO5Ji9vwqwy_2=ea2Vd9CG2ethzyhXUc709KQSSaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-compat-util.h: xsize_t() - avoid -Wsign-compare warnings
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 11:49 AM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> On 2017-09-21 18:46, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  git-compat-util.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 9bc15b036..cedad4d58 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -898,9 +898,11 @@ static inline char *xstrdup_or_null(const char *str=
)
>>
>>  static inline size_t xsize_t(off_t len)
>>  {
>> -     if (len > (size_t) len)
>> +     size_t size =3D (size_t) len;
>> +
>> +     if (len !=3D (off_t) size)
>>               die("Cannot handle files this big");
>> -     return (size_t)len;
>> +     return size;
>
> Hm, can someone help me out ?
> Why is the cast not needed ?

Because 'size' is already size_t,
(cast was done in first line of the function:
    size_t size =3D (size_t) len;
), previously we cast len multiple times,
now we cast it once and use size thereafter.

>
>>  }
>>
>>  __attribute__((format (printf, 3, 4)))
>>
>
