From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 06/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Mon, 17 Aug 2015 01:14:51 -0400
Message-ID: <CAPig+cQjtFHZgUvCVxTcXRCPykFN=RG5=bvkqF04h1MupPJV5g@mail.gmail.com>
References: <1439661643-16094-7-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTZvSW8ZRLFLhmQTYBwotVjMWANZy0OAZHpA79vW8GfGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRClT-0005UQ-Md
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 07:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbbHQFOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 01:14:53 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:32769 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbHQFOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 01:14:52 -0400
Received: by ykll84 with SMTP id l84so53252900ykl.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8PPSQfa+w0bhQcywfoZrR9ESwiTMXm5bq+pa23LDccw=;
        b=K+5aGtlmrw1+bpOtJc8wojVcu1SSxNaWnd1D/VodUksCQC0tVd6B42kCvoFYVJz7kI
         R++byeS033Ihrvhfd9dCLmDtNuet4T+aIbVcdsN3RXk9WFb5A6/5nZ3pTg9wJTcbLONk
         c0JDzB26P/CK9d3hA7epfe/IEU6GZNUbLoylYYv4FapN/Klc+KnqBT1G54xcoUAGxRd2
         BlF/7dtkKWZKXt1XIQ9DWxv999oZIs5LL8g+InyGEVzpo96YJdQVi8ChAFccnOEaVqyZ
         20+yXa3aHG9E+o4vtUIw/BENUVqPkai3i5sT9H+I6rlveFilPeX4C1ToCEEzmHocnh1R
         YB5w==
X-Received: by 10.13.220.132 with SMTP id f126mr57384512ywe.39.1439788491854;
 Sun, 16 Aug 2015 22:14:51 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 22:14:51 -0700 (PDT)
In-Reply-To: <CAPig+cTZvSW8ZRLFLhmQTYBwotVjMWANZy0OAZHpA79vW8GfGQ@mail.gmail.com>
X-Google-Sender-Auth: jrcMQmUV2HmeL5vLLw6y9q7o84w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276032>

On Mon, Aug 17, 2015 at 12:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> -       if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
>> -               ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
>> -       else if (type & FILTER_REFS_ALL)
>> -               ret = for_each_ref(ref_filter_handler, &ref_cbdata);
>> -       else if (type)
>> +       if (type & FILTER_REFS_INCLUDE_BROKEN) {
>> +               type -= FILTER_REFS_INCLUDE_BROKEN;
>
> The above is a somewhat unusual way to say the more idiomatic:
>
>     type &= ~FILTER_REFS_INCLUDE_BROKEN;
>
> when dealing with bit flags. Is there precedence elsewhere in the
> project for choosing '-' over '~'?

s/precedence/precedent/
