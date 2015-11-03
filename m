From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Tue, 3 Nov 2015 11:41:52 -0800
Message-ID: <CAGZ79kbWbN_8XSMyYnkxstqV-+fHEixceeGaR4NYGqrvw0ZaUQ@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<56321CF4.60807@ramsayjones.plus.com>
	<CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
	<5632B0E1.8040309@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:42:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZthSw-0007y7-2g
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 20:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbbKCTly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 14:41:54 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36819 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbbKCTlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 14:41:53 -0500
Received: by ykba4 with SMTP id a4so34125734ykb.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pYsaV2uLhrvblz9MRzDA/++wZuO09ZvTd7pnPW0RibA=;
        b=IPmFow4iiJq41BsY+vfaOhuaV5lKx/MMOpxvrAm5/inW0rene7h4HfOwYxqPEAvMUi
         5gJza5KlZs//O68fcJqu4UXiVR+Q9CSkYLA8nh7fEpv67oB/7OAF+G+gkTp+YYC1JSjD
         AN4FKA1sCss0xPbWK5ko7h5eUXBifmPAkJebsAWXGpPiRuu2vlOkZXAo7A6/lDsrDhyX
         +5e39g1DeisDIpmDXKQIbbOSyqXqJ4fbOhQHDPneVA20LObKukU7QtZ+l4upn+Qkv8t+
         SIxG4ApuKqiuZCbIRcyANuUEkxxNLHhH6FxtVa9b4feYS/ZTa4wOw3Sch1rkS/WRVkhu
         EKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pYsaV2uLhrvblz9MRzDA/++wZuO09ZvTd7pnPW0RibA=;
        b=eFbjTr3+P48DoCBA0iGzqVy4Fp04HSGt0Cnoewv8lwoXP7fOLFAhHgo7jk6Ldg+ah0
         GJOZ9GhFzv0RENCzF6BDioRRUYcqQEFRfaIXMoz49UlwBA8Brlqd1b5LunEbvrtpOX3+
         BEmrl9JI+ar3ReJllveN/9d3SxnaC70xDD9d4jw5HUGkO1sRk7zF/XDIkg4LDWEmdHQM
         /Z5t2LotU2rPhEWVy4tm1tggY2TOf9kj1E6LroSjdHfFXmVQ0UCmZw5a29faDdXdMpB5
         Jh5ODffi8uGz5Jo3rLt6Bm6+554t0SMpzOYzdMv2S1RR1PcVr9zipmRGBC0yPgenAXyq
         qn1g==
X-Gm-Message-State: ALoCoQkAyACRJYd6WckjxRIrjfeN2mK+n+WHNbPp+331EnPS7N1eRO+4U6AZVTByv4dmyhJRI+3w
X-Received: by 10.13.230.194 with SMTP id p185mr24653497ywe.320.1446579712374;
 Tue, 03 Nov 2015 11:41:52 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Tue, 3 Nov 2015 11:41:52 -0800 (PST)
In-Reply-To: <5632B0E1.8040309@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280810>

On Thu, Oct 29, 2015 at 4:50 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 29/10/15 15:51, Stefan Beller wrote:
>> On Thu, Oct 29, 2015 at 6:19 AM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>
>>> Hmm, is there a way to _not_ fetch in parallel (override the
>>> config) from the command line for a given command?
>>>
>>> ATB,
>>> Ramsay Jones
>>
>> git config submodule.jobs 42
>> git <foo> --jobs 1 # should run just one task, despite having 42 configured
>
> Heh, yes ... I didn't pose the question quite right ...
>>
>> It does use the parallel processing machinery though, but with a maximum of
>> one subcommand being spawned. Is that what you're asking?
>
> ... but, despite that, you correctly inferred what I was really
> asking about! :)
>
> I was just wondering what overhead the parallel processing machinery
> adds to the original 'non-parallel' code path (for the j=1 case).
> I suspect the answer is 'not much', but that's just a guess.
> Have you measured it?

Totally unscientific:
 * Make a copy of my current gerrit repository and time the fetch.
 * That repo contains 5 submodules, one needs fetching

time git fetch --recurse-submodules=yes --jobs=1 # this series
real 0m7.150s
user 0m3.459s
sys 0m1.126s

time git fetch --recurse-submodules=yes # origin/master
real 0m7.667s
user 0m3.439s
sys 0m1.190s

Now let's test a few more times repeatedly to avoid cold caches or
network hiccups, (also there is nothing to fetch, so it's more like doing
6 ls-remotes in a row, one for gerrit and 5 submodules)

this series, best out of 5:
real 0m3.971s
user 0m2.447s
sys 0m0.452s

this series, worst out of 5:
real 0m4.229s
user 0m2.506s
sys 0m0.413s

origin/master, best out of 5:
real 0m3.968s
user 0m2.516s
sys 0m0.380s

origin/master, worst out of 5:
real 0m4.217s
user 0m2.472s
sys 0m0.408s

The ratio of real time taken longer is < 1 % in
both the best and worst case.

If you really care about 1 % of performance, you'd want to fetch in
parallel anyway?


> What happens if there is only a single
> submodule to fetch?

Ok let's see. I created https://github.com/stefanbeller/test-sub-1
to play around with it. However
time git fetch --recurse-submodules=yes
or
time git fetch --recurse-submodules=yes --jobs 100
seems to be lost in the noise.

So I am not sure what the question is w.r.t. having just one
submodule.


>
> ATB,
> Ramsay Jones
>
>
