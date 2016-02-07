From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sun, 7 Feb 2016 01:33:50 -0500
Message-ID: <CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 07:34:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSIvX-00029q-S6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 07:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbcBGGdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 01:33:52 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35804 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcBGGdv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 01:33:51 -0500
Received: by mail-vk0-f66.google.com with SMTP id e185so3667313vkb.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wpftd0lcG8M8VEelrxJ9NmKTEhvVfnWxZAHyfN2be/c=;
        b=iFEcycU51JlOWJfmgaRaZZZngBX9bynk9F5gLe0oy2tZLh3NnRzMXJh1cTdbp3BlNV
         x/J8mA/FyXeuAD16LKxZvPk0L2p6QnFPQ0Hjx9YLi6yr71co40G3duMExaJknjGFU8Gz
         Suvi0a9+2gddC9rXbV8ZqMY5sJ90o7XeV7a4DCN+xT/P/+0B/ltxNUJY1zNCf+XE309b
         AwM125RjjFs6+vKvWY2lWb5oTexDF+goK30HWUS9MgvAng+IIPHVInK0xmVsjojatfgJ
         huLdH5jfG1KxNsypxulEA4TkasVpzE0hRz1Dlse/lSYq3m40JhcdwGOwB74ZGMLvfRu7
         u15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wpftd0lcG8M8VEelrxJ9NmKTEhvVfnWxZAHyfN2be/c=;
        b=SGY8V12Z3bb3Xf4oy9EQbqzLB2PaIW0XbAKRuFske1pTvJTrzrb4Z6Np4FDgFBRIyJ
         +IgYnCh3uR6ns9CVDr8QaLI/RI0TbJZG1gPhXg/Ksr0BE5lTHT1uhiRsXZ21AgKqxXgu
         1QpaFXWOciKqgzLsOEyDfXlgruIospl6ZmZ0OXBbJGNFs9EN3h+T1VqgPU4PWzOmVNjn
         gskTU0EDb9AS0+eC+oMlB5SraRUZW6DCpDkpATDdxK6+hl6EFGZjC9O+RSQrK5+Sm/um
         auT35745novLTqRCC6Fby+0hsRmRwQIggGeAwqouGVBRDmmefaRt0GoOWs3gk3kqUB/X
         pDew==
X-Gm-Message-State: AG10YOTebF/m/sgf74M8gfjnu0RU5s/82fZ+vaOYyC5WVQddMU9NS41RfrIA3rxXgMFMTwQ8kuS4TKauL9Seww==
X-Received: by 10.31.164.78 with SMTP id n75mr15615005vke.14.1454826830770;
 Sat, 06 Feb 2016 22:33:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 6 Feb 2016 22:33:50 -0800 (PST)
In-Reply-To: <CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
X-Google-Sender-Auth: WL1b-pAcQSA-ImpF6l-RSUJ5zlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285713>

On Sat, Feb 6, 2016 at 10:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Jan 31, 2016 at 11:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>                  * shouldn't be used for checking against the valid_atom
>>                  * table.
>>                  */
>> -               const char *formatp = strchr(sp, ':');
>> -               if (!formatp || ep < formatp)
>> -                       formatp = ep;
>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>> +               arg = memchr(sp, ':', ep - sp);
>> +               if ((!arg || len == arg - sp) &&
>> +                   !memcmp(valid_atom[i].name, sp, len))
>>                         break;
>>         }
>
> Also having a look at this, this breaks the previous error checking we
> had at parse_ref_filter_atom().
> e.g: git for-each-ref --format="%(refnameboo)" would not throw an error.
>
> I think the code needs to be changed to:
>
> -               if ((!arg || len == arg - sp) &&
> +               if ((arg || len == ep - sp) &&
> +                   (!arg || len == arg - sp) &&

For completeness, for people reading the mailing list archive, a
couple alternate fixes were presented elsewhere[1], with a personal
bias toward:

    arg = memchr(...);
    if (!arg)
        arg = ep;
    if (len == arg - sp && !memcmp(...))
        ...

[1]: http://git.661346.n2.nabble.com/PATCH-ref-filter-c-don-t-stomp-on-memory-tp7647432p7647433.html
