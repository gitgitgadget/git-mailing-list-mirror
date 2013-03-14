From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Thu, 14 Mar 2013 16:36:26 +0100
Message-ID: <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBIW5Q6FAKGQEF3UTTLI@googlegroups.com Thu Mar 14 16:37:32 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBIW5Q6FAKGQEF3UTTLI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f184.google.com ([209.85.160.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIW5Q6FAKGQEF3UTTLI@googlegroups.com>)
	id 1UGADj-0004Ul-Jc
	for gcvm-msysgit@m.gmane.org; Thu, 14 Mar 2013 16:37:31 +0100
Received: by mail-gh0-f184.google.com with SMTP id f11sf924533ghb.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 14 Mar 2013 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=1RF+Yqb4rX1IpExcIW7pH8j64vGV+svokYNlgxxxJLw=;
        b=s0klXd4scgREx/AIhtYQTS4MjS1pHs08zEZogYT0mrmWdqu3CiyaTa5Zc/m1Vl7QHJ
         NwtAa6R15xEdWI1QHadBQwT/3ND22678rK9O7Q4JgSm35PdKNKsyjxYPXzCTGDgQR1pK
         Qim2OXJM73vrK9Dy1qd0/YKxDh1P5FPYxrbAn6gqmk+ICPHjdh64Ev7n+rdAMohvjQzH
         xrEz/i8eOBvy1vfQr0Ar8doqUyPtC/xSgSVMis9nqnd408BNbFcFeEk0xVaq6Upc74p0
         QUqmkjEi+jEpbk+6B0jWWm5cZ96oDlPLJTUTvHrVWU6 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=1RF+Yqb4rX1IpExcIW7pH8j64vGV+svokYNlgxxxJLw=;
        b=DSdl1WF/y6MLHpuH8P7hQ9KZTVcmnFsrJmUxj60PBIzzm/wdllboJtaXd52kbYgjjl
         EGIQdhP4mChGhEBOCH21ttoLO160+iIG3nq9GTqNxLA4KRLdFQ1Uze6vdhFMbTXis7fa
         8F8XoRjrKGDF9sUUleNUP+7jl5PUxVp7mMZzEnnoV1HtuVmQQ0eSXlfm/qZTnsNPnL4i
         O/OMc/XHtd7VldvG6xlrpRb7tQmfB5oET5+tEZwpWrIBAXk/xKAfxpAvieZXL8mp3M/U
         1UlNkJh5ZjaxwOuTAhSx07R6vBha6o4YKkt1gVbxJrrV9pZFRa 
X-Received: by 10.50.187.133 with SMTP id fs5mr432771igc.12.1363275428268;
        Thu, 14 Mar 2013 08:37:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.202.72 with SMTP id kg8ls3572784igc.24.canary; Thu, 14 Mar
 2013 08:37:06 -0700 (PDT)
X-Received: by 10.50.168.5 with SMTP id zs5mr2677723igb.2.1363275426618;
        Thu, 14 Mar 2013 08:37:06 -0700 (PDT)
Received: from mail-ia0-x229.google.com (mail-ia0-x229.google.com [2607:f8b0:4001:c02::229])
        by gmr-mx.google.com with ESMTPS id iw8si485933igc.1.2013.03.14.08.37.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 08:37:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c02::229 as permitted sender) client-ip=2607:f8b0:4001:c02::229;
Received: by mail-ia0-f169.google.com with SMTP id j5so2210673iaf.14
        for <msysgit@googlegroups.com>; Thu, 14 Mar 2013 08:37:06 -0700 (PDT)
X-Received: by 10.50.190.231 with SMTP id gt7mr20639168igc.85.1363275426463;
 Thu, 14 Mar 2013 08:37:06 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Thu, 14 Mar 2013 08:36:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c02::229
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218147>

On Thu, Mar 14, 2013 at 4:23 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Thu, 14 Mar 2013, Erik Faye-Lund wrote:
>
>> Since ancient times, we have been calling curl_global_init with the
>> CURL_GLOBAL_ALL-flag, which initializes SSL (and the Win32 socket
>> stack on Windows).
>>
>> Initializing SSL takes quite some time on Windows, so let's avoid
>> doing it when it's not needed.
>>
>> timing of echo "" | ./git-remote-http.exe origin http://localhost
>>
>> before
>>
>> best of 10 runs:
>> real    0m1.634s
>> user    0m0.015s
>> sys     0m0.000s
>>
>> worst of 10 runs:
>> real    0m2.701s
>> user    0m0.000s
>> sys     0m0.000s
>>
>> after
>>
>> best of 10 runs:
>> real    0m0.018s
>> user    0m0.000s
>> sys     0m0.000s
>>
>> worst of 10 runs:
>> real    0m0.024s
>> user    0m0.000s
>> sys     0m0.015s
>
> Good analysis!
>
>> diff --git a/http.c b/http.c
>> index 3b312a8..528a736 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -343,7 +343,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>>
>>       git_config(http_options, NULL);
>>
>> -     curl_global_init(CURL_GLOBAL_ALL);
>> +     curl_global_init(CURL_GLOBAL_WIN32 | (prefixcmp(url, "https:") ? 0 :
>> +         CURL_GLOBAL_SSL));
>>
>>       http_proactive_auth = proactive_auth;
>
> I wonder whether we want to have something like this instead:
>
>         flags = CURL_GLOBAL_ALL;
>         if (prefixcmp(url, "https:"))
>                 flags &= ^CURL_GLOBAL_SSL;
>         curl_global_init(flags);
>
> I do see that CURL_GLOBAL_ALL is #define'd as CURL_GLOBAL_WIN32 |
> CURL_GLOBAL_SSL in curl.h, but that might change in the future, no?
>

Good suggestion. But perhaps we'd want to use CURL_GLOBAL_DEFAULT
instead? I'm thinking that this define is probably what they'd include
any essential flags, but not non-essential flags. CURL_GLOBAL_ALL
might be extended to include initialization bits for other transports,
for instance... but this feels a bit hand-wavy. Simply masking out the
CURL_GLOBAL_SSL-flag would probably be the smallest logical change.

I don't have any strong feeling on this, really. I'd like to hear what
other people think, though.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
