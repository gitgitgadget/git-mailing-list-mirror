From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 09:16:28 -0700
Message-ID: <CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
	<xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
	<xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 18:16:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlgHL-00026n-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 18:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031414AbbDXQQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 12:16:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34267 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030956AbbDXQQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 12:16:29 -0400
Received: by iedfl3 with SMTP id fl3so98117477ied.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kOfVwYxTDYKyj94iqXOFchsOlsOZObUPYobDdZTkpXc=;
        b=PAchNozDWQxrHHJZHpWUzUCDUWa8TCstSmNMoWF9oP+AimFWdptDplkwDWb+e9Cd4Z
         eOIEuWXhOFAonZ1qlXi9hPVoHhS5jOpzrXlhoyXzQkwjAmxCDe5B2iZ9R6KnyEIzlP9Z
         RigIdjJs2kUYTYEC1/LCNn6h/JFzVAfmdAQPm7FYuwswPKZjQAK8QhZA0OnJzRbKgJOk
         pa8fCa39KcZYCDAmkz7U2j4TQ+EGenVQ6kAlmrs3qsX65djZGTAnoJRDfDb+/jWv+KVf
         sF+1nq5BMYnndOYDF12Ww2rAN0ic3vHVT1/LmAkofSjpFmlJtOoRQnTK4MVzYC2uhBix
         gL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kOfVwYxTDYKyj94iqXOFchsOlsOZObUPYobDdZTkpXc=;
        b=ZFEIZBHcGD6h+WcjuOyh6yutLHicq7JstAYaxv7Rkuf/A1W1ZTN6gCoG5gQzRPW/9v
         mI+J6t+2Cuqp5Nzb+8vr5itflL207gYmwVdr+V2hCqRm29qOvTffGkk05S1HOrq+dMwV
         F+jIpVB83abJK+zuP2toxP2cVUogJ8I1Nvwx23hpNMG5p1dtrhF0gfWjxoEclcuOzoGC
         CEgKgjKklql1aT53+yyxi4+9tUHKG5QEGQIa6HowD5qyv4zXQss+1kU5zJHBQZ/9FqXI
         PaDvKBQoFUIJ2IbjZXEUiBrhLLEtu1GmMS8HdQ57GWO+U5805HxT/0RXsejNdGanut85
         y94A==
X-Gm-Message-State: ALoCoQkEgUuZKPg/fnh20av1HXGPneH/7us+/naUhfQzVL+0gwx4Y6w1+sppcbZJMesYOK1lkII3
X-Received: by 10.107.170.135 with SMTP id g7mr12155674ioj.2.1429892188405;
 Fri, 24 Apr 2015 09:16:28 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 24 Apr 2015 09:16:28 -0700 (PDT)
In-Reply-To: <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267742>

On Thu, Apr 23, 2015 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Apr 23, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> +             int save_errno = errno;
>>>> +             error("Couldn't reopen %s", lock->lk->filename.buf);
>>>
>>> No need to change this line, but I noticed that we might want to do
>>> something about the first one of the following two:
>>
>> I personally like to have each error(...) to have a unique string, such
>> that when you run into trouble (most likely reported by a user),
>> you can easily pinpoint where the exact error is.
>
> I was hoping that the "grep" patterns were strong enough hint, but
> let me be explicit.  I was commenting on "Could" not being spelled
> as "could".
>
>>>     $ git grep -e '[    ]error(_*"[A-Z]' | wc -l
>>>     146
>>>     $ git grep -e '[    ]error(_*"[a-z]' | wc -l
>>>     390

I understood that you were talking about Could being capitalized.
Though it's distributed 30/70 which hints to me we do not care in
enough to explain the capitalized letters as slip-throughs on review
or such, but it looks like the authors choice to me.

I think it's a mistake to s/Could/could/g for all errors in the code base
as it reduces the information provided in the error messages.
Just 3 days ago ("Regular Rebase Failure"). I used different
capitalization to get a better understanding where the error may be.

So if we throw away that information, we should add new information
to make the spot of the error easily findable in the source.
That's why I proposed the idea of the version,filename,linenumber
as that is one of the strongest signals (most information in a short
amount of text) I can imagine.
