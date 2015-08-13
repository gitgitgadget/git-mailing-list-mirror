From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Fri, 14 Aug 2015 02:25:44 +0530
Message-ID: <CAOLa=ZSZyfrHOe1Gjw457mbJCP5yW1uesDAW8zuv8DqoE+yuJQ@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-5-git-send-email-Karthik.188@gmail.com> <CAPig+cS+rS=xKX-LrJSTqFgaopuLzbh3hqURFWXfzMXH=XUk2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPzY1-0000QV-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 22:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbbHMU4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 16:56:15 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33359 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbbHMU4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 16:56:14 -0400
Received: by oio137 with SMTP id 137so33835014oio.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=73yTHcSW36I6lC/e2WnqdI45JoC0gRGclt2hbD10njE=;
        b=Qldilondmy4qmvAg3gT7QmoFGcfYyXn1XCM7AdPbdQcCu2WUzHHLj4IB+ibvEs/qUK
         b8v0Yb+XzxTgd0b27CaA3M6dRIUUIOHSfCh5Wf35VihTWTcawUe1s/Ucv92RGJR3YFhL
         UQgpV478tQzVi2juQjqxYFzlNZg4Vqb7C50hMtme9lCkGZ/sbsWrTq61VuVAhVMdawLd
         XHYqGoZjVsyfn7UZEkn5W2FOUctzyT2vZhCqiLYJqNJQ5R4TDQZXIADUNhlfK1NnkHHQ
         hnzj5NKbPLQEZ6l/9WHoYBq9sZ/p9GiNP/Cjs0SLLinlTEK8J7mj414nGxkiqcypkZdC
         /0+A==
X-Received: by 10.202.200.75 with SMTP id y72mr35296053oif.111.1439499373470;
 Thu, 13 Aug 2015 13:56:13 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 13:55:44 -0700 (PDT)
In-Reply-To: <CAPig+cS+rS=xKX-LrJSTqFgaopuLzbh3hqURFWXfzMXH=XUk2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275894>

On Fri, Aug 14, 2015 at 12:38 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 9, 2015 at 10:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add strbuf_utf8_align() which will align a given string into a strbuf
>> as per given align_type and width. If the width is greater than the
>> string length then no alignment is performed.
>
> In addition to Junio's valuable comments...
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/utf8.h b/utf8.h
>> index 5a9e94b..db8ca63 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -55,4 +55,17 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
>>   */
>>  int is_hfs_dotgit(const char *path);
>>
>> +typedef enum {
>> +       ALIGN_LEFT,
>> +       ALIGN_MIDDLE,
>> +       ALIGN_RIGHT
>> +} align_type;
>> +
>> +/*
>> + * Align the string given and store it into a strbuf as per the type
>> + * and width.
>> + */
>
> Please extend this documentation to state explicitly that this
> function preserves (does not truncate) the input string if it is wider
> than 'width'. That's quite important information for the caller to
> know.
>
> (Aside: I could easily see this function being extended to support
> optional truncation, but that's a separate topic, and something that
> can be done by someone else when the feature is actually needed; it's
> not your responsibility.)
>
>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>> +                      const char *s);
>> +
>>  #endif

Yeah will do :)

-- 
Regards,
Karthik Nayak
