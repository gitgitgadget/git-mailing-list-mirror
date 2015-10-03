From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sat, 3 Oct 2015 12:35:59 +0530
Message-ID: <CAOLa=ZQ31+gEktXh=QJJL+_McRMHhQynHAg__DpfuUsdc-5uWg@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-2-git-send-email-Karthik.188@gmail.com> <xmqqpp0x3spo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 09:07:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiGuJ-0006zf-Vk
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 09:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbbJCHGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 03:06:30 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34146 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbJCHG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 03:06:29 -0400
Received: by vkat63 with SMTP id t63so71824453vka.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HTjIuV6Gl8TUDn0358c75K3bxAN6V1CoYXm9mthCbxc=;
        b=wTjBvqkwRsEYUSl+5LmHZVmgvklIggc/fPf3+KVq7yq147/bq0GhNEL0ZzbtTtDcfu
         4O5bwE6WEe/VjsCJUeT+0eoYnnApv9pd52Fc2zJYzQU8bkDKMK3G9gyHoVqcP8soTiXF
         DyvUemd0uugh9OJi/L/iWkCrwGahDtA+hdF49RoTdKu+bg2lRT840fB84E3UfgGZosaX
         DjyTF5CyzIWUS1BF+e05PCUJqV45w/Rt0rPa6Qei+P9P4ozWVaPSf1Ylub1MGpYtKB1X
         dh6l9NDMDIS5/IwyaZvxxN8sQJJSORh3JB7/FJn8CwLj4AnCEHD0REBm05LF0tESrRIe
         UxeQ==
X-Received: by 10.31.173.136 with SMTP id w130mr10032414vke.72.1443855988913;
 Sat, 03 Oct 2015 00:06:28 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 3 Oct 2015 00:05:59 -0700 (PDT)
In-Reply-To: <xmqqpp0x3spo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278959>

On Sat, Oct 3, 2015 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static int is_empty(const char * s){
>> +     while (*s != '\0') {
>> +             if (!isspace(*s))
>> +                     return 0;
>> +             s++;
>> +     }
>> +     return 1;
>> +}
>
> My knee-jerk reaction was "why is space so special?", but if a
> caller really cared, it can do "%(if:not_equal=)%(something)%(then)"
> to unignore spaces in %(something), so it is not a huge deal.  It
> may be that ignoring spaces when checking if something is empty is
> so common that this default is useful---I cannot tell offhand.
>
>

My reason for doing this was the "HEAD" atom which prints "*" or " ",
hence I thought strings with only spaces in general shouldn't be accepted.

>> +if::
>> +     Used as %(if)..%(then)..(%end) or %(if)..%(then)..%(else)..%(end).
>> +     If there is an atom with value or string literal after the
>> +     %(if) then everything after the %(then) is printed, else if
>> +     the %(else) atom is used, then everything after %(else) is
>> +     printed.
>
> I notice that "we ignore space when evaluating the string before
> %(then)" is not mentioned here.  That fact, and an example or two
> that illustrates the situation where this "ignore spaces" behaviour
> is useful, would be a good thing to document here.
>

Oh Yes! Will do that :)

-- 
Regards,
Karthik Nayak
