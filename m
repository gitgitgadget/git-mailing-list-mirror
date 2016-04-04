From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Mon, 4 Apr 2016 14:45:48 +0200
Message-ID: <CA+EOSBn6HT1AwqcTxW+8p31ZnUV_-1qjip_CnnFKCXwiSyUfiQ@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<56FE8C25.8020607@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 14:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an3tC-00059h-08
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 14:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbcDDMpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 08:45:50 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35640 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcDDMpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 08:45:49 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so20328893vkb.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vvDJ9FzEZJ5/5yqSrj+LwBjlYfhLZpxX2JJOUFzgP/I=;
        b=uX6uxGD6/ZE6Upw27cVMadDR1eDHVhw94PdZuz9E4nFMr6uOkijIVAH8PDiXllde39
         8Hqszeq/iF/3rNpu0t6bmEveGWntrP1FTm5B2275VuEWRPFL3RqiBsihK/Zx8iHOVPA+
         tAyp6JWfDnxZMjdd6y1kKn2cTraFvjHrGHjzRKim373oDgj7nja3lY9WLhFg7iOxs7is
         Xoli2XchZtl3oCw9U8LkLTLjGqhU27hKPmmMWtG0sL8LBZE/u/UonJopQaNSLkO/sekC
         onaa2qa/mzys9Yn0uXDvHbaYCJCYZ0BFYR2YiSTtaKA/GbVn8j7JtMtHnOVUsi30LQQ7
         bk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vvDJ9FzEZJ5/5yqSrj+LwBjlYfhLZpxX2JJOUFzgP/I=;
        b=WjpwG4TB3PgbupkJMgByO3nsrGSgLvDxifvUA95iY//3QuJz7ujfp+CCnuJQcgTcXz
         guBpwCmj2LI8GQdjYzpBigSZnwZGVoc6iSVEMuVD+fGEMyHxYLR3cvmaKXPqJVRLTlV8
         4C0bgqxVyxDj8OZjj45G5hCMZrxxyE+7vTEago909w5h0mxqswBCjNLLToeQEANK/Ybt
         glB7zCc8eSvms3Y/TeDtq11oz5xRELuC+P5MCh8oZhGucupHjXYny16bgNel3eqqAdte
         JjM2oh+4tLY+P59sRujT+Ipfi4DQ7VmaxUtyqOp8fBoUKoZ1dzU8gU8Fu3zmWM1FN/pO
         2v1g==
X-Gm-Message-State: AD7BkJLkJLuOA4jVXzuTb/FxhzGGhWrzH1C99249g04ViAcxWhDHoysV3lQyPbxi2o91JKNmG8CZXejdKJEGLg==
X-Received: by 10.31.8.210 with SMTP id 201mr9026553vki.90.1459773948735; Mon,
 04 Apr 2016 05:45:48 -0700 (PDT)
Received: by 10.31.56.10 with HTTP; Mon, 4 Apr 2016 05:45:48 -0700 (PDT)
In-Reply-To: <56FE8C25.8020607@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290689>

2016-04-01 16:56 GMT+02:00 Ramsay Jones <ramsay@ramsayjones.plus.com>:
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
>>  imap-send.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 97 insertions(+), 2 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 4d3b773..cf79e7f 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
> [snip]
>
>> @@ -1442,8 +1532,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>>
>>       curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>>
>> -     if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
>> -             curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
>> +     if (0 < verbosity )
It was already so in the previous code, I have not changed it. If it
is a desirable change it would take another patch
>
> previously it was sufficient to set GIT_CURL_VERBOSE, now I have to
> set verbosity too?

>
> [Does it matter that you change "1L" to "1" in the curl_easy_setopt()
> call? In http.c (line 567) it also uses "1", but ...]
>
>> +             if (getenv("GIT_CURL_DEBUG")) {
>> +                     curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
>> +                     curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
>> +             } else if (getenv("GIT_CURL_VERBOSE"))
>> +                     curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
>> +
OK.
>>
>>       return curl;
>>  }
>>
>
> I would have expected something like:
>
> if (0 < verbosity || getenv("GIT_CURL_VERBOSE")) {
>         curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
>         if (getenv("GIT_CURL_DEBUG"))
>                 curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
> }
>
No. Thank you. But actually it is not a desirable change
> Hope That Helps.
>
> ATB,
> Ramsay Jones
>
>
>
