Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FA31F453
	for <e@80x24.org>; Thu, 25 Oct 2018 03:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYLt3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:49:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeJYLt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 07:49:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so3257976wru.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ep1MP6FUZ5wnz8Zj6Qhvnf8mPXBqkRbco6uksG3tA1g=;
        b=BVd0XgdWMQT1uOqrV9GcIpa1NJXUKLqM4wBM8V5pamEkISjKEa03I89VffC3jsOavh
         Ba0efeNelSy/R6oBYcI0gRUnMtRzUhHfAZZuP8uKZ7Xh7p59gN8Mw3FnIYX499eufse8
         cNdsRXLmRhjl52OcktuTY4NmBayzeZxPM+0pq1SpSKrYFk11GAUF6jLrroahe2b5Dj09
         aI5Qjf6t2WB2SqDK5HKCVhJyOClWBlrQLAexD2lwtROLqG+kBE+SPawijN5nNe57xvNA
         XowqecI2TGRl5kksE5WNyBqnCuwfTESNETDMqZJ9jsj3U/CwK6IVBLZpybLHn2X8dfot
         DPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ep1MP6FUZ5wnz8Zj6Qhvnf8mPXBqkRbco6uksG3tA1g=;
        b=cI0kQKyKEbEFbK8U87o9v+K8zIjdKbKKzYV1usDuWLhv3/NqNXciy3TgnUNsthemm3
         w446CJpxlF0Vp8ywqU9ZywFDDGtknU0H16LKJLE1mqPLyFtdHDbSrOjK6F1Te6T3Ab9h
         SS87KA3/w+pseRCalAEw1WYSecmIhkpus2OIbWw1lXHO+8atCDjZy+LiTG8w0yZXaxBy
         JbKD7yfZbZ/6PkIdGbcZ+Juide4LHfg9RiyhFH7Yqjm//jsAQSemf6K3p9gREhMcsON4
         o0z4p0OqnbygOAwPKmusT0pXjdEbIJYyjdme5pIySWDXmljXnnL3R1JceC1mnoigg4SR
         WIcA==
X-Gm-Message-State: AGRZ1gJqqwqLcWMH3eB0MjUt02KnoGNnYhNVp2soMhihs4BnYzARNdyT
        v2eK7pL2OkJCtswWWW0dskc=
X-Google-Smtp-Source: AJdET5cQJufsMkrOk35rVFyNsxx4QpF0XteD3niMdr03QY0/REN9UtNuyN6z2HrsMwwVrSJQQTkOCA==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr2213198wrr.306.1540437519529;
        Wed, 24 Oct 2018 20:18:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q77-v6sm7907282wmd.33.2018.10.24.20.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 20:18:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        github@brendanforster.com
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks in cURL
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
Date:   Thu, 25 Oct 2018 12:18:37 +0900
In-Reply-To: <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 15 Oct 2018 10:10:32 -0400")
Message-ID: <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Oct 15, 2018 at 6:14 AM Brendan Forster via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> This config value is only used if http.sslBackend is set to "schannel",
>> which forces cURL to use the Windows Certificate Store when validating
>> server certificates associated with a remote server.
>>
>> This is only supported in cURL 7.44 or later.
>> [...]
>> Signed-off-by: Brendan Forster <github@brendanforster.com>
>> ---
>> diff --git a/http.c b/http.c
>> @@ -811,6 +818,16 @@ static CURL *get_curl_handle(void)
>> +       if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
>> +           !http_schannel_check_revoke) {
>> +#if LIBCURL_VERSION_NUM >= 0x072c00
>> +               curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
>> +#else
>> +               warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
>> +                       "your curl version is too old (>= 7.44.0)");
>
> This message is confusing. If your curl is too old, shouldn't the ">=" be a "<"?

I do not think I saw any update to correct this, and worse yet I do
not offhand recall if there was any other issue raised on the
series.

So assuming that this is the only remaining one, I'll squash the
following to step 2/3 of this three-patch series and plan to merge
it down to 'next' in the coming few days.

I have a clean-up suggestion related to this but is orthogonal to
this three-patch series (after the fix-up is applied, anyway), which
I'll be sending out separately.

Thanks.

 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 0ebf8f77a6..43e75ac583 100644
--- a/http.c
+++ b/http.c
@@ -835,7 +835,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
 #else
 		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
-			"your curl version is too old (>= 7.44.0)");
+			"your curl version is too old (< 7.44.0)");
 #endif
 	}
 
-- 
2.19.1-542-gc4df23f792

