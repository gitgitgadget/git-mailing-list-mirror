From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 18:24:34 +0530
Message-ID: <CAOLa=ZTJ0k9zbMK-L0sB49X2+DmnLSV-m+4MiPirTbU8r1iOqg@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
 <CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
 <CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
 <CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com>
 <CAPig+cT=uUp5T1W1-CBrx4ZMsTSdpoghg57affU3JZ3Uvq20Pw@mail.gmail.com>
 <CAOLa=ZQoHuE_NV1OMQrA7zoqYo6tUvXibURVz+3UknJsNLHV_w@mail.gmail.com> <CAPig+cRoryoJj44D0Q_m3fVAZeYrCc0OiNA7GJ3UtQK4XVOn9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 14:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOQ8V-00010m-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 14:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbbHIMzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 08:55:06 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35369 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbbHIMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 08:55:05 -0400
Received: by oihn130 with SMTP id n130so76451458oih.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7b1Wuo0EfjHVxb8RrQwdwKldnUyrlqkI/tIh4XI2RZQ=;
        b=cP2Sq5ju+gImouUGBomZal1m0gOngGYkm7yKTIFLbWD6SxOfphBIX9zrRooISbGIq4
         Bu+L4VjFmDGHW/3Eisbpa5vEClDZOkY+ZqxsAxn5UHOEzff70gRhepHrwZFKz0oNtLj/
         Dlz58iNIm+0PdwA6N9LOJEbfQsEtbaz2mR9XU3a+ojbP3pDa7qP4u0ZoDApDSiJJK8PD
         K5VTf/gv8tsbGSPlFnDF3LLNcN+1/css5GEb+2MXhQY9zUi2cbZ0QbMGxpKN+jlhbQZD
         AlpszryfNDfNNCH6wCucVAy2FMz//R3yHg1nXmO9M+MWuBBnbmqCRVevcgyJBIKKHu/b
         +uBg==
X-Received: by 10.202.186.132 with SMTP id k126mr14816324oif.60.1439124903676;
 Sun, 09 Aug 2015 05:55:03 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 9 Aug 2015 05:54:34 -0700 (PDT)
In-Reply-To: <CAPig+cRoryoJj44D0Q_m3fVAZeYrCc0OiNA7GJ3UtQK4XVOn9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275535>

On Sun, Aug 9, 2015 at 1:49 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 9, 2015 at 4:09 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Aug 9, 2015 at 1:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sun, Aug 9, 2015 at 2:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> On Sun, Aug 9, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> That raises another question. Why are 'struct ref_formatting_state',
>>>>> 'struct align', 'struct atom_value', etc. defined in ref-filter.h at
>>>>> all? Aren't those private implementation details of ref-filter.c, or
>>>>> do you expect other code to be using them?
>>>>
>>>> I guess struct ref_formatting_state and struct align could be moved to
>>>> ref-filter.c. About struct atom_value its referenced by ref_array_item()
>>>> so any reader reading about this, would find it easier if atom_value()
>>>> is at the same place.
>>>
>>> Do you expect callers ever to be manipulating or otherwise accessing
>>> the atom_value of ref_array_item? If callers have no business mucking
>>> with atom_value, then one option would be to simply forward declare
>>> atom_value in the header:
>>>
>>>     struct atom_value;
>>>
>>>     struct ref_array_item {
>>>         ...
>>>         struct atom_value *value;
>>>         ...
>>>     };
>>>
>>> which makes atom_value opaque to clients of ref-filter. The actual
>>> declaration of atom_value would then be moved to ref-filter.c, thus
>>> kept private.
>>
>> Also the code that this was done in has been excepted into `next`
>> so either I send a new series for the same, or write a patch just to
>> move this from ref-filter.h to ref-filter.c. So what would you suggest?
>
> To my eye, atom_value seems to encapsulate a bunch of state local to
> and only meaningful to ref-filter's internal workings, so it doesn't
> really belong in the public header. Assuming that you don't foresee
> any callers ever needing to access the properties of atom_value, then
> it might indeed be reasonable to introduce a patch which moves it from
> the .h file to the .c file (while leaving only a forward declaration
> in the .h file).

Thanks! will add it to the series.

-- 
Regards,
Karthik Nayak
