From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 06/11] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 29 Jul 2015 23:24:49 +0530
Message-ID: <CAOLa=ZSKxw2yA1MWh+AL=rHT8unvZsGUuELWeaCp=vvXUN8S+Q@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-6-git-send-email-Karthik.188@gmail.com>
 <vpqlhe0xwpv.fsf@anie.imag.fr> <CAOLa=ZR4DSzdnR8+3eiVTCX92aeFu2o6=iDm7QpdOewizSuxng@mail.gmail.com>
 <vpqwpxjmgnc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:55:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVZe-0000A5-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbbG2RzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:55:21 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35219 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbbG2RzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:55:20 -0400
Received: by oihq81 with SMTP id q81so9272438oih.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uQf5GTnRPZDPHmRNGPWjAn2o6yn4YExIIap+VHlTPrY=;
        b=R/axVi5mJKH6EYPyQZ+I1/59t9Tf6tY/YraNkv6a/R3tPWTLscrKxNoJ4zxVP8Qn4y
         9n1aEuYGKtGdvwSr+Mupz6nZvopqTj3BaLLb9b8REZybCXJNkcxBeL0Ru9TL/AioGR7G
         Cj7QQVJvKSOk2WDfAYn6cQLHCehL6AmzE8PXlV8M97IqfPNiMJ85Z3nuWyZWo7+49UK8
         tAjbM7xRhbfCwGW1gAEvWjVfv8BQqhDWr0Ut392h+gkxMvIreFJi0hWvGcvvfAB0Npq8
         ZAPVn/oI0Yy66CAynN6c/oZNn6GQatPq2u3fAcsP8NH4adB7seeYOfwbUEQkEWchv2sc
         HUQw==
X-Received: by 10.202.186.132 with SMTP id k126mr40220038oif.60.1438192519438;
 Wed, 29 Jul 2015 10:55:19 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 10:54:49 -0700 (PDT)
In-Reply-To: <vpqwpxjmgnc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274926>

On Wed, Jul 29, 2015 at 3:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 6:31 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>>> -static void show_detached(struct ref_list *ref_list, int maxwidth)
>>>> -{
>>>> -     struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>>>> -
>>>> -     if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>>>
>>> I'm not sure what this if was doing, and why you can get rid of it. My
>>> understanding is that with_commit comes from --contains, and in the
>>> previous code the filtering was done at display time (detached HEAD was
>>> not shown if it was not contained in commits specified with --contains).
>>>
>>> Eventually, you'll use ref-filter to do this filtering so you won't need
>>> this check at display time.
>>>
>>> But am I correct that for a few commits, you ignore --contains on
>>> detached HEAD?
>>>
>>
>> No we don't ignore --contains on detached HEAD.
>>
>> Since detached HEAD now gets its data from append_ref(). The function
>> also checks for the --contains option.
>
> Ah, OK. Previously, detached HEAD and branches were completely
> different, each having its own if (is_descendant_of(...)), and you're
> now using only one in append_ref() before removing it completely in
> favor of ref-filter.
>
> That would deserve an explanation for other reviewers I think.
>

Will include a small explanation in the commit message :)

-- 
Regards,
Karthik Nayak
