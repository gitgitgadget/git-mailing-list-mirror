From: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Sat, 20 Feb 2016 17:35:19 +0300
Message-ID: <CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
	<xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
	<20160205210623.GC7403@vauxhall.crustytoothpaste.net>
	<xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
	<CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 15:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX8d4-0006TO-4U
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 15:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbcBTOfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 09:35:22 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36487 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbcBTOfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 09:35:20 -0500
Received: by mail-ob0-f172.google.com with SMTP id gc3so130878640obb.3
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 06:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ygHFIQMYcGAThhMoMuZLLf6fL39nCdsglVs5Pk4pkLc=;
        b=rzm9fvGjZ7fcGrLIzJQwMNIH4NePjYg8U8VCjRA4vX63d4M5BIXHbi7BJFE0W4DDu5
         Ejv6rpxqFEPcPla8poM5QT2aoiaS+ORaEjTEX8+lmfeS8/VEUVulJ3R+6alfn3aR31Ye
         15NV43WdIS7FMVxj/UI9H72QnHqdu60SXyNsw5Xh+Tf376nZbvzbJ3HMbYFYOMub7To6
         lRVDHwq0Cb/WJiPtBS+rfqoL51IYnR+JxY/50a74ygeNrvzxzRf+ygzJ0OHpb+1JOx+Z
         tKs7WdxYX9X/EkYjxJqXkKiSRkBNi1128ub5t1+HASk4uosaj35/0hUqfwdC6lhMXskx
         TpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ygHFIQMYcGAThhMoMuZLLf6fL39nCdsglVs5Pk4pkLc=;
        b=UqeaXrWN5opOtsr7OpSoNhxj5uxpEMbE0NG0XfYCzNddqFVVY7tVjzvh/f0gDSEi5a
         I9pVGY8aHK4bOWg0OTU7o3vtlvVqO6eZppAhmXhEzD6OEazx4ZtMG3uz1bDHaO4j4jwS
         len4tYHqbUieF8ynhnh8k7H2HrCwLMgK45+lgbWV12vsvFFpbDNHwxc3eSxq626DOS79
         Iq7PMKgVyiTTvrVEhxPTtSa5VKX99tngAayNjtX1q8qy/3hngXmauOjRHN6uaMmAVph1
         B5abSdhrEhlEVKOQL8PmclbCsB12px0KFuL6wDAP/tdCbBtmoQwbMMtB4OMSAYuJBo2J
         SSFA==
X-Gm-Message-State: AG10YOSeTrXQ/yj01tHQtcqCswLccPc3p3Dkb2caRfjRuc0oodJWhU4z6vBdpjVmfCYF37+YOrLqC6pvWOH76g==
X-Received: by 10.60.96.74 with SMTP id dq10mr16652792oeb.78.1455978919627;
 Sat, 20 Feb 2016 06:35:19 -0800 (PST)
Received: by 10.76.130.36 with HTTP; Sat, 20 Feb 2016 06:35:19 -0800 (PST)
In-Reply-To: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
X-Google-Sender-Auth: fQ9XQXARUUvo1dioLlmQGRyfl2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286782>

Hi guys! Any luck with fixing this issue?

I would like to draw your attention to the fact that Git starting from
version 2.3.1 is unusable with servers that support GSS-Negotiation
(e.g. Microsoft TFS).

Sorry, english is not my native language and probably I was not clear
enough when described the problem at first time.

So, let me try again. Algorithm of fetching data through HTTP(S)
protocol is as follows:
1. Try to fetch data without any credentials.
2. If first step failed
  2.1. Disable GSS-Negotiation algorithm (this is the side effect
which is fixed by my patch).
  2.2. Read credentials from config files.
  2.3. If there is no credentials then ask user for it.
  2.4. Go to step one, but now try to fetch data with found/provided
credentials.

As you can see there is no other way to connect to server with
GSS-Negotiation auth than use URLs like
"https://:@my-gss-git-server.com" (because there is step zero where we
are parsing URL which can contain credentials that we can use in step
one).

Maybe you could accept my patch, so users would use
"credential.helper=store" to avoid using ":@" in remote URL? At least
for now, while there is no good solution to this issue? It would be
very helpful because now we have to have our own version of patched
Git :(

Thanks in advance.


2016-02-08 12:11 GMT+03:00 Dmitry Vilkov <dmitry.a.vilkov@gmail.com>:
> 2016-02-06 0:52 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> On Fri, Feb 05, 2016 at 01:02:58PM -0800, Junio C Hamano wrote:
>>>> Hmph, so documenting that <emptyname>:<emptypassword>@<repository>
>>>> as a supported way might be an ugly-looking solution to the original
>>>> problem.  A less ugly-looking solution might be a boolean that can
>>>> be set per URL (we already have urlmatch-config infrastructure to
>>>> help us do so) to tell us to pass the empty credential to lubCurl,
>>>> bypassing the step to ask the user for password that we do not use.
>>>>
>>>> The end-result of either of these solution would strictly be better
>>>> than the patch we discussed in that the end user will not have to
>>>> interact with the prompt at all, right?
>>>
>>> Yes, that's true.  I'll try to come up with a patch this weekend that
>>> implements that (maybe remote.forceAuth = true or somesuch).
>>
>> Thanks.
>>
>> I think the configuration should live inside http.* namespace, as
>> there are already things like http[.<url>].sslCert and friends.
>>
>> I do not have a good suggestion on the name of the leaf-level
>> variable.  ForceAuth sounds as if you are forcing authentication
>> even when the other side does not require it, though.
>
> That would be great! Definitely it will be much better solution than
> patch I've proposed.
