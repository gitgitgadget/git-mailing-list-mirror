From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 19:04:47 -0500
Message-ID: <CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 02:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud8AH-0002Kz-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 02:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab3EQAEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 20:04:49 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37502 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3EQAEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 20:04:49 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3643441lab.33
        for <git@vger.kernel.org>; Thu, 16 May 2013 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=el8kzqgSSdGbJljQEmE1lJOkINRlrcuhZijnHm8ClRQ=;
        b=qJKJabrZeJN4kOzsoEbAdSvSk9Uxkrbr4kgTe2oOUAHqcl7QJ5J7eKYw0K3vRGpzDn
         3LJr/u6GPuFw38k/8acX7uv9fQ4skmZ+XoZ5ee+6VBeN8xWMId/zzLud1/gmpV+AGqNh
         6514hquQ1KddI2+R5mR8LfW1zXkJklKxfwtYw15Ni1qHMQujIA3iv4fJhzG1X15L8lCO
         kN1XI8POLcc4uZSh4cKLG0JBdh5WDfgZm/BOE/Do/QSkGGujGMwXb2ydauS5rB02YZ0B
         ljNuH5S0P/vnamEJR3EHfMVjwAQzh53Of0UuwL7coqIyuq+Awc479FL4Q3ozxblwauFY
         uS5Q==
X-Received: by 10.112.172.40 with SMTP id az8mr10164207lbc.88.1368749087527;
 Thu, 16 May 2013 17:04:47 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 17:04:47 -0700 (PDT)
In-Reply-To: <7vk3my33vb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224642>

On Thu, May 16, 2013 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 16, 2013 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> If you come from "git pull" is "git fetch" + "git merge",
>>>>> and if your current branch is integrating with your local branch,
>>>>
>>>> How many times do I have to say that 'git pull' is not 'git fetch' +
>>>> 'git merge'?
>>>>
>>>> You must think everybody has 'merge.defaulttoupstream=true'.
>>>
>>> I am confused.  What does that have anything to do with this topic?
>>> It only affects what a lazy "git merge" (without any other parameter
>>> on the command line) does, doesn't it?
>>
>> And that's what we are talking about here; commands without any other
>> parameter in the command like.
>>
>> So "git pull $nothing" is *not* "git fetch $nothing" + "git merge $nothing".
>
> Of course not.  But what does it change the equation?
>
> Let's rephrase the above, then.
>
>         "git pull" with 0 or more arguments is to first
>
>         - make sure that necessary history is available in your
>           repository
>
>         - prepare FETCH_HEAD to record what is to be merged
>
>         which is done by running "git fetch" with appropriate
>         arguments against the repository of your upstream, and then
>         to
>
>         - merge the upstream history
>
>         which is done by running "git merge" with appropriate
>         arguments (which in turn is formulated by reading FETCH_HEAD
>         that is left by the previous "git fetch" step).
>
> So if your "upstream" happens to live in a local repository, it is
> very natural to run "git fetch" against repository "." (with
> appropriate arguments, like 'refs/heads/master' if you were on your
> mywork branch that was forked from your 'master' branch).  Running
> "git fetch ." is hardly "does not make any sense whatever" from that
> point of view.  It is just a natural consequence that our local
> repository is merely one of the repositories we could fetch/pull
> from.

This is irrelevant, it's an implementation detail of 'git pull'. *THE
USER* is not running 'git fetch .' (s)he is running 'git push .'. ONCE
AGAIN; I'm not talking about 'git pull .' I am talking about 'git
fetch .' (a *USER*-run 'git fetch .'), and a *USER*-run 'git fetch .'
does *not* make any sense whatsoever.

-- 
Felipe Contreras
