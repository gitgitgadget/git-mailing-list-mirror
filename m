From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 08:06:00 -0500
Message-ID: <CAMP44s2p1udJ=YuXBoYJ42iMiB68nU8t_GBGMdsMjTOEsjrZuQ@mail.gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
	<1366243524-18202-2-git-send-email-felipe.contreras@gmail.com>
	<87li8gxpq2.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0c-c3pPW8t9p9qabjv46gSeE6y4p6STPeV+kqB77xOJA@mail.gmail.com>
	<87ppxsvwq7.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 18 15:06:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USoXQ-0003ty-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 15:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934125Ab3DRNGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 09:06:03 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:65056 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab3DRNGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 09:06:01 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so1429615lab.35
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=z4Wu0iWiilRsXVPwWjp8Az91vf8LxByBRYt2Fgfu48k=;
        b=JRXH6FDwdg2wZRAKMHKuQPs7QpitrpdxlXtMFRMAWpGQwaIJeFbys0HPyYDpGtt10B
         DBlc96OMYwyl3HV3zQm+8PAWoReN6LIOi0G42jqAXG4Ih4HG0bCfI+M/YYLkd7JnQfF2
         3C2m4i0Et98ANIuIU/NJd1cfIp7zFr1Nx/pJaaJymgfGPXHlY3wtpHrArYjrlNKleS7v
         w2lTIDwOlPA+8MKza21x+20WHUwonscVBe0jqRDH7MVvLLTdei2iYkgWeVKSgBWmRTfX
         Fz6M8ikB2TYKcVmRtug+Gy9dNxJNzOrfd3J/8Ff8xAQaac9bJo6+CP0eRJYga2bF1EzO
         +EAw==
X-Received: by 10.112.154.98 with SMTP id vn2mr4423935lbb.8.1366290360364;
 Thu, 18 Apr 2013 06:06:00 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 06:06:00 -0700 (PDT)
In-Reply-To: <87ppxsvwq7.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221657>

On Thu, Apr 18, 2013 at 7:39 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 18, 2013 at 2:28 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> The *:* refspec doesn't work, and never has, clarify the code and
>>>> documentation to reflect that. This in effect reverts commit 9e7673e
>>>> (gitremote-helpers(1): clarify refspec behaviour).
>>> [...]
>>>> -test_expect_success 'pulling with straight refspec' '
>>>> -     (cd local2 &&
>>>> -     GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
>>>> -     compare_refs local2 HEAD server HEAD
>>>> -'
>>>> -
>>>> -test_expect_failure 'pushing with straight refspec' '
>>>> -     test_when_finished "(cd local2 && git reset --hard origin)" &&
>>>> -     (cd local2 &&
>>>> -     echo content >>file &&
>>>> -     git commit -a -m eleven &&
>>>> -     GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
>>>> -     compare_refs local2 HEAD server HEAD
>>>> -'
>>>
>>> So what's wrong with the tests?  Do they fail to test what they claim
>>> (how?), test something that wasn't reasonable to begin with, or
>>> something entirely different?
>>
>> Look at the code comment, and look at the now updated documentation
>> that assumes that *:* was reasonable. Given the available information,
>> it would be reasonable to assume that *:* did work, but it didn't
>> work, and it's not really possible to fix it, even if we wanted to, it
>> would be a hack. It's better to accept that fact and stop worrying too
>> much about what would be the best way to do the wrong thing.
>
> Ok, you say that the *failing* test set an expectation that is
> unrealistic, so let's drop it.
>
> But then what about the successful test?  Does it actually work (and by
> removing the test, you are saying that we don't care if we subsequently
> break that (mis)feature)?  Or did it test the wrong thing?

Yeah, it works, in the sense that peeing in a bottle is a solution; it
might work, but it's not recommendable. So, if suddenly working,
frankly I don't care. I added those tests, and I don't think they are
needed. In a not too distant future it should not be permitted to
"work"; we don't want developers to shoot themselves in the foot, and
heir users too.

-- 
Felipe Contreras
