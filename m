From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 11:10:24 -0700
Message-ID: <CAGZ79kasg6zQjNLbESrP0vG5OpZ=yqMJhXqGUDtuEFdDS6=W-w@mail.gmail.com>
References: <20160517031353.23707-1-sbeller@google.com> <20160517031353.23707-5-sbeller@google.com>
 <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com> <CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
 <xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com> <CAGZ79kYbUTC7m-5kdTbvxmSkq__5BVz5x1UeieHhB4TVSqssHw@mail.gmail.com>
 <xmqqposkwofd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jRu-0000H9-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcEQSK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:10:26 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37054 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbcEQSK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:10:26 -0400
Received: by mail-ig0-f173.google.com with SMTP id s8so14362270ign.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JP6PG7F4veIrwdzEf6Il8IXA2Nh3fiYXaWWj2OuiW5k=;
        b=FeeVd/zWfeQdfb+EkBqfGzEpxIfPNVeevgr5r3dzkniYzSsIQMg56VLSmFt4mrUk5r
         ZLeUuAEPOyG4w7obX7luu1Phnd0fumWl4puF5PK2dnUVIbG7oGoJayRTdFROH0Lkqlqb
         9NlGgM6Gz/iydHgjQDJhiwld2bMA/s41T4c1YoczEJTXdtkAlWNy70LhsgmbGm3eXhrE
         kSHmrbEd3PO1YXGJmAKAQly/0ekJZjN4DHQe96pVGGLl8HiOwFvVMFu8BJbBkeEKf5Vv
         TApEV73LbP7AyiWuNh28nLicrJ10dyEkRodUfAyje4dcVcm9bWDGOUWJILpSTSwvpEen
         +Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JP6PG7F4veIrwdzEf6Il8IXA2Nh3fiYXaWWj2OuiW5k=;
        b=iHDGpfBlGr5AfTEa4HmzNxtbGkOmfm58Dhm/ys6hNNXe4+kJpHRhnACKUWgwQ3wSPX
         0p+O8XuTVPsjHY2CCU2gXKVHl70lnrRJltiHNhwkyo43TLYloXnWMEYe1rBj375KNThj
         yBLW1yHZggByIinWzuBHpMGAcsVL1bqzggPniE535B6v3qoxOk9aP3c9mNYA3T0cpUbq
         M5sBxI2U4+HIZZvljIjG5mG6e/qxeMedJeRtWl2nkw6/H2cQq2Gl7XrRJFgAtUqaRzuV
         vh+8823Uqhn6CdYeGv3B8nELXf8W09UeElOmnaDlzyQg1WN/EqA0wbBKnwTUPJ3g2cUe
         er6w==
X-Gm-Message-State: AOPr4FWFcdo5EZPuSHMazp3Oq7S1Pn1UgnDukmQls6+eVECx/YB6Qfd6Gx3JAYAIrSpk+T/qAKyxXqc1UZ/Icn4c
X-Received: by 10.50.29.45 with SMTP id g13mr14768104igh.93.1463508625120;
 Tue, 17 May 2016 11:10:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 11:10:24 -0700 (PDT)
In-Reply-To: <xmqqposkwofd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294889>

On Tue, May 17, 2016 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I am not talking about crazy stuff here, but consider our own
>> .gitattributes file:
>>
>>     * whitespace=!indent,trail,space
>>     *.[ch] whitespace=indent,trail,space
>>     *.sh whitespace=indent,trail,space
>>
>> Now I want to search for
>>
>>     "the whitespace attribute that is set to at least trail and space"
>
> With :(attr:VAR=VAL) syntax, you can only look for whitespace
> attribute exactly set to "!indent,trail,space", so you can't.  So
> you are talking about crazy stuff after all, aren't you?

I think that stuck mentally with me from the "label" series,
as then you had to have an exact specification of the value list.

We don't do that any more, so in a very first series I can omit the
value parsing at all.

> Are you
> now extending it to do "whitespace~=indent" or something like that?
>
> You do not even need VAR=VAL form for your main topic.  You only
> need group-doc group-code etc. to look for "set to TRUE", no?
>
> I do not want to see us wasting too much time over-engineering it
> without having a concrete and useful use case, and "find path to
> whom whitespace checks are set for 'trail' and 'space'" is not.
> These comma-separated tokens augment WS_DEFAULT_RULE which has
> 'trail' already, so you do not look for 'trail' in the first place.
>
> "I want submodules under subs/ that is in either group-doc or
> group-code" is more reasonable and realistic use case, but that does
> not need any crazy stuff.  Either two separate pathspec elements,
>
>         ":(attr:group-doc)subs/" ":(attr:group-code)/subs/"
>
> or if we are to do the "ORed collection of ANDed attrs", it would be
> something like:
>
>         ":(attr:group-doc):(attr:group-code)/subs/"
>
> no?

Thanks for bringing me back to realities. I'll just drop support for values
in the first series.
