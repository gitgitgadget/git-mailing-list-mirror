From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Fri, 3 Jul 2015 16:32:31 -0700
Message-ID: <CAKDoJU7om3DBVYMD_yYet_cGep12RCUePtvFS7=TdW_1rkuE+Q@mail.gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	<19801032cd7af95bc8030f54d740bf48@www.dscho.org>
	<20150630122323.GY18226@serenity.lan>
	<xmqqfv555es7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 01:32:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBARh-0006Lg-Dm
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 01:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbbGCXcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 19:32:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33672 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbbGCXcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 19:32:31 -0400
Received: by obpn3 with SMTP id n3so76497710obp.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=SxA8sT10xLEd8DnhlVeCSSJVMcAto3FHxVCVDoFgtDA=;
        b=pvkVm++d5gOb8HhZp7XZmcUl1Vn5UTaacBui+ZEehuGv1G4TeGTzrTq44DDQFOTdC3
         b9CI1SbmsZYq3YrN3kg/eKR2eKJVVtNsa8UYwx/XLDxX11i2gXmTsE35rS7hxVgf9pn8
         gYo3mAp/ALcFUixk0O9JFXeEpIK6UbJ1O/58m1k9gg2KQarZObDvOt1LUJKCrZgnN8Qh
         OCzUoWqjGfyM58SNf7MfLwvdJxdQXTi0nO5wW7JgMRePkZLyKgzZ15Eia0z0JLUv/Yyw
         kWkl9MQVs7PMuMn741ciFwYzQvdxoPSd9V6ht39wJ2IOPBFL9YiOz69Prmnn2Q2PnjDJ
         /Z/w==
X-Received: by 10.182.87.69 with SMTP id v5mr33753824obz.37.1435966351174;
 Fri, 03 Jul 2015 16:32:31 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Fri, 3 Jul 2015 16:32:31 -0700 (PDT)
In-Reply-To: <xmqqfv555es7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273313>

On Fri, Jul 3, 2015 at 10:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> On Tue, Jun 30, 2015 at 02:10:49PM +0200, Johannes Schindelin wrote:
>>> On 2015-06-29 18:46, Lawrence Siebert wrote:
>>>
>>> > I appreciate your help. Okay, That all makes sense.
>>> >
>>> > I would note that something like:
>>> >  git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc
>>> >
>>> > seems like it run much faster then:
>>> >
>>> >  git log --oneline "$FILENAME" | wc -l
>>>
>>> How does it compare to `git rev-list -- "$FILENAME" | wc -l`?
>>
>> Or even `git rev-list --count HEAD -- "$FILENAME"`.
>
> Ahh, OK.  I didn't know we already had "rev-list --count".
>
> Then please disregard the suggestion to add the option to "log"; it
> still holds true that the option does not belong to "shortlog", but
> I do think "how many changes were made to this path" statistics
> driven by a script should use "rev-list" plumbing, and if it already
> has "--count" option, that is perfect ;-)
>
> Thanks.
>
>
>
Junio,

I think, respectfully, there is still a benefit to adding it as a
feature to "log", in that more Git users know of and use "log" than
"rev-list". I hadn't heard of "rev-list" before joining this mailing
list.

That means "log --count" will get used more. That also means that more
eyeballs will hit --count with bug reports and better tests; I've
already seen 2-3 suggestions for "log --count" tests that "rev-list
--count" also doesn't have tests for.

I would like to keep working on implementing "log --count", sharing
code with rev-list where possible so they both are improved, unless
you are saying you won't merge.

Thanks,
Lawrence



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
