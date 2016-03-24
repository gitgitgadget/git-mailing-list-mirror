From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Thu, 24 Mar 2016 12:54:05 -0700
Message-ID: <CAGZ79kZCHv6z6zT2Q2MzMNXfGWcqk9uxsqQ-uEjAPw3h+cSjsQ@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-6-git-send-email-sbeller@google.com>
	<xmqq37rif870.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaEmDFDf+1BZV1C5ETswbXmAUYk_OMsZf_ka6tJ=pfwcQ@mail.gmail.com>
	<xmqqlh58bun7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:54:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBKg-0004bp-UH
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbcCXTyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:54:10 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35966 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcCXTyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:54:06 -0400
Received: by mail-yw0-f170.google.com with SMTP id g3so72743783ywa.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HUa6CpWcXrWlRI96mjuT1vM/m/nBg1KGE8ikKo1tCfU=;
        b=N+Dztanb6Whvv4FT1p4gQaNB6hfOT8/oLsYBCPHe/Q22BB0YDQHuZcwtg/MqS60Z8f
         ATe7pXZLeHb3gztXd0nJZLjeQC2UgLyzR2jdu5A7KOOjGh9EW8k5fmqmCiv8Fx11M9aJ
         zzWjZ3DMwk6k3ufDRiV8uYl5ciCiN1343zuE+E0o1G/JGe5HmtJAhqMM9eaekDf/bS5P
         0I0lnC6toT6w66yiAesKMrl+gZpnHrhwCHo9bIjChCNLR+fcsmey/TswsMI2hDvKC/cb
         6ehG6ZgLZepFkzcqE+o0KLYdQ3xHF1IjzqRVVxxrK70He2d3JIACbhV1qF+5EbZY9jMU
         W+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HUa6CpWcXrWlRI96mjuT1vM/m/nBg1KGE8ikKo1tCfU=;
        b=Ow9zeGSCksncRz/dMGbYiSvNE25WW9+KwHVUvdPPXpvarWgW/cZVhkH8hEgElVmIFE
         ESVFVWH5nhqn6Yc2IJ++C08m+www1Ut0q8uzuwv6shX6l8LR2D2kmFvwUoRzRX9VQxsz
         8OBEHivXhRhUADysagt8oq4Jkee0ZOpPFXoUymLlVuDGL/nBNfzLtQfDNen7gS1dCOT1
         VhHwHE8He4McX1ZDaFvKgdp+yxuDjSoqMCEwjbIuvApeU8+HWX1jFDMCM3isMjdiZj9t
         FxIEx+Ntgn7LeBK7CzM2r88WEacnieJQWGepqAv7V3zTlFJTSYG7GwD0JzdZGBNgTl+k
         PQJw==
X-Gm-Message-State: AD7BkJJhdYvf8L4O+EduQkjO5oJZZbxL+wzGJyEljGz3j8e6STyijf6Jv5syl9pTy5OxES8z07eYrS/ZUaVTfeHL
X-Received: by 10.129.134.133 with SMTP id w127mr5314990ywf.252.1458849245371;
 Thu, 24 Mar 2016 12:54:05 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Thu, 24 Mar 2016 12:54:05 -0700 (PDT)
In-Reply-To: <xmqqlh58bun7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289790>

On Wed, Mar 23, 2016 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Mar 22, 2016 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> This change introduces the 'submodule.actionOnLabel' variable
>>>> in a repository configuration. Generally speaking 'submodule.actionOnLabel'
>>>> restricts the action of a command when no submodules are selected via the
>>>> command line explicitely to those submodules, which are selected by
>>>> 'submodule.actionOnLabel'. It can occur multiple times and can specify
>>>> the path, the name or one of the labels of a submodule to select that
>>>> submodule.
>>>>
>>>> The introduction of 'submodule.actionOnLabel' starts with
>>>> 'git submodule update' in this patch and other commands will follow
>>>> in later patches.
>>>>
>>>> 'submodule.actionOnLabel' implies '--init' in 'git submodule update'.
>>>>
>>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>>>
>>>> TODO: generic documentation for submodule.actionOnLabel
>>>> TODO: documentation for submodule update
>>>
>>> TODO: a name that matches the concept better.
>>
>> This is one of the hardest parts of the series so far. The last reviews
>> were mostly bike shedding about the name of the concept and I thought
>> we were settled to actionOnLabel as that fits best to what we want to do.
>>
>> So let's revisit that. My current understanding of the design:
>
> I am not questioning the name "label" to call the facility that
> allows projects to group submodules together, and that serves as one
> of the ways to choose what subset of submodules are worked on by
> default.  There is no need to revisit that part.
>
> What I am questioning is
>
>         action On Label
>
> because
>
>  (1) it sounds as if that configuration were a way to choose what
>      action is done to the chosen subset of submodules;
>
>  (2) it sounds as if the only way to choose a subset of submodules
>      to be operated on by default is via the "label" mechanism.
>
> And from your writing (omitted), I think we agree that we definitely
> want to avoid the misunderstanding that is (1).  This variable does
> not specify what is done--this specifies what subset of submodules
> are to be operated on.  Having "action" in the name of the variable
> is wrong.
>
> And from the proposed log message, it is clear that "label" is not
> the only way to specify the subset of submodules to be worked on,
> i.e. "... can specify the path, name or the labels".   Having
> "label" in the variable name is wrong.
>
> I am tempted to suggest submodule.defaultOperand and I am fairly
> sure "default" part of that name gets the concept much better than
> "actionOnLabel", but there probably are much better words than
> Operand.

I immediately thought of defaultActionset, because "default", as well as the
"actionset" conveys the concept of choosing a subset of submodules to operate
on. However You may mistake it as defaultActionSet, i.e. what action is set
by default.

Maybe we can revive the term "group" and call it submodule.defaultGroup.
The defaultGroup is defined by selection of names, paths and labels.
