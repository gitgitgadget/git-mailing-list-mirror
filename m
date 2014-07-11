From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Fri, 11 Jul 2014 18:29:03 -0400
Message-ID: <CAPig+cTHnhJjMimeHyJYm0vOb0PwNWtQArAcPZ3tPkvaGUyMzA@mail.gmail.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
	<20140711173544.GB7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jJX-0008LR-HL
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaGKW3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:29:07 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61070 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbaGKW3G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:29:06 -0400
Received: by mail-lb0-f171.google.com with SMTP id v6so1124522lbi.30
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o72WNXVQTf9s4iinzSpOnzYkzuLZWlNz1AdYPlVX9Lg=;
        b=0fiTTm7dLcAD2xjNhEIYxMFgPPrqCpUa23PocLPKVj4Au5wH/+rIwBcU7zdoPv/0k5
         16F+dFh5aM3Ln1p3pb0PQTgzD7z0VprXcZNRFkiMj/ibUhPJ2SylDJUlzzTv9aXgwEG3
         CijAzhNjWN0HpD6PsPhrbcfQZpNK1OldqV08P6I4IDCgFsmFKeKGN2vZvP4VCpTpl8ts
         TVKqZ2vevz547zxRAc7qiuiXU1OEnpjYODmLTjMGvAiPtEL2pGYkFh++710pe8qgY6Aa
         +M8pTku6k8TnVxIupK4KoWFscUpRO9o6Gh30VCAjidaT2OP2tGytewqelU8SPDeIvns0
         ttPg==
X-Received: by 10.112.125.102 with SMTP id mp6mr1460904lbb.12.1405117743667;
 Fri, 11 Jul 2014 15:29:03 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Fri, 11 Jul 2014 15:29:03 -0700 (PDT)
In-Reply-To: <20140711173544.GB7856@sigill.intra.peff.net>
X-Google-Sender-Auth: S6LpRbtDGsVi-uzCwfOHa_BLOE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253337>

On Fri, Jul 11, 2014 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 12, 2014 at 01:52:53AM +0900, Yi EungJun wrote:
>> Add an Accept-Language header which indicates the user's preferred
>> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
>>
>> Examples:
>>   LANGUAGE= -> ""
>>   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
>>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
>>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
>>
>> This gives git servers a chance to display remote error messages in
>> the user's preferred language.
>
> Thanks, this is looking much nicer. Most of my comments are on style:
>
>> +static const char* get_preferred_languages() {
>> +    const char* retval;
>
> A few style nits:

Also, this is C, not C++, so don't forget void:

    static const char *get_preferred_languages(void)
    {

>   1. We usually put a function's opening brace on a new line.
>
>   2. We usually put the asterisk in a pointer declaration with the
>      variable name ("const char *retval"). This one appears elsewhere in
>      the patch.
>
>   3. This line seems to be indented with spaces instead of tabs.
