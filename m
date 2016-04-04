From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 2/2] http.c: implements the GIT_CURL_DEBUG environment variable
Date: Mon, 4 Apr 2016 14:41:27 +0200
Message-ID: <CA+EOSBkSG6SLOgQeFuBSupYW1nc6UcHd=iCFcGhs265NBd77vw@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<1459507482-36678-2-git-send-email-gitter.spiros@gmail.com>
	<56FE8DC3.5080304@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 14:41:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an3oz-00035J-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 14:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbcDDMl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 08:41:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35138 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcDDMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 08:41:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so20310635vkb.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NZPql/QuPmZHW4EVR9znFlkxseW3+fxEX5WOIhnVHrU=;
        b=q7A4TjGjBq0MaVpVoXHl9fBdHIkjyEVkjLayC3F0Di7+vkGn1e1X3ISMJBiAFpK/Ro
         NReCPCtqDHJY3k8+MMqmOdPPqZPA9kVG0NNBDmM+/DdSaTXbd89vNMR9Q+IJa6Y+Hv+a
         GbCmLv+LjxO3XkkEj0ht1ck6JovSPyPkTMFv4wyM4hN6Y2aXLLTLxmSjshL6vaN+ab79
         TUwn3s/+6Qw2AabVf3KuJa4/KVHfQBpUfMnRmfsDReMm5uVUq8c7oTtUJnZegOYsutD9
         bnhIPdqVpOW0P+2w7F9rRe8SmjDTcYpJM2gI+Y8VoMqhjF9XcdQlRtao6HJ+0V9580cD
         kPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NZPql/QuPmZHW4EVR9znFlkxseW3+fxEX5WOIhnVHrU=;
        b=VBpPfBHDFjSWpbZGmkcX270sTtg096hmoQpWDm9tKsrZsl8PCEZjEJQpL1ix1453JV
         Sln/Tz4qWRX3yNls9pMs7Vua9hfkWkX/+H/wxpm0oNsqXcnKlC0a2nX2xJI9H7eVhJkI
         F3TOzzBffsuYMgjAa2OcTpFY6fFGDkunulI+a0W3tfKTRX1iZb4npuVOEBJXYqok/Cqo
         5MrPO0cL3kCNBeMfw7o4hHOu05g3GUOVspsfAkmC+I3Frusg8k6lE3umfFaGcQhVQO2g
         qWXlO1i72ypZF/T8Nwg7NjQnF1PCB+a20ldchBc7VlU4fwd1QQ7tG4jfOmQV263rG+kx
         K9Fw==
X-Gm-Message-State: AD7BkJKUNjPi7zq4JFRwa/T+LxWj8Bb9pZlHWdDej+tFVe6gBIpPp35IrdxEbL5iJPQ+c85jul2eCBPxnJozBw==
X-Received: by 10.31.52.147 with SMTP id b141mr7106076vka.82.1459773687363;
 Mon, 04 Apr 2016 05:41:27 -0700 (PDT)
Received: by 10.31.56.10 with HTTP; Mon, 4 Apr 2016 05:41:27 -0700 (PDT)
In-Reply-To: <56FE8DC3.5080304@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290687>

2016-04-01 17:03 GMT+02:00 Ramsay Jones <ramsay@ramsayjones.plus.com>:
>
>
> On 01/04/16 11:44, Elia Pinto wrote:
>> Implements the GIT_CURL_DEBUG environment variable to allow a greater
>> degree of detail of GIT_CURL_VERBOSE, in particular the complete
>> transport header and all the data payload exchanged.
>> It might be useful if a particular situation could require a more
>> thorough debugging analysis.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>>  http.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/http.c b/http.c
>> index dfc53c1..079779d 100644
>> --- a/http.c
>> +++ b/http.c
> [snip]
>
>> @@ -532,7 +623,11 @@ static CURL *get_curl_handle(void)
>>                       "your curl version is too old (>= 7.19.4)");
>>  #endif
>>
>> -     if (getenv("GIT_CURL_VERBOSE"))
>> +     if (getenv("GIT_CURL_DEBUG")) {
>> +             curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
>> +             curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
>> +             curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
>> +     } else if (getenv("GIT_CURL_VERBOSE"))
>>               curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
>>
>>       curl_easy_setopt(result, CURLOPT_USERAGENT,
>>
>
> Again, maybe something like:
>
> if (getenv("GIT_CURL_VERBOSE")) {
>         curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
>         if (getenv("GIT_CURL_DEBUG"))
>                 curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
> }
>
> Although that does make GIT_CURL_DEBUG subordinate to GIT_CURL_VERBOSE.
> So, that may not be desired ...

Thank you. But actually it is not a desirable change, for me almost, I
prefer that the two definitions are independent. And it is true the
opposite: if it is defined the curl DEBUG flag then it is implicitly
defined the curl VERBOSE flag, because it is a prerequisite of the
DEBUG functionality.

Thanks in any case for the review.

Best
>
> ATB,
> Ramsay Jones
>
>
