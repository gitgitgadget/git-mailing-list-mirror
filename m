From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 17 Nov 2015 12:49:37 -0800
Message-ID: <CAGZ79kaiWSyXUG_mgUcqt6Mpuj_1EhNOTyG-7NL=28vvi770jA@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
	<CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
	<564A279C.6000802@web.de>
	<CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
	<564A4DB1.4070507@web.de>
	<CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
	<564B8406.9070706@web.de>
	<CAGZ79kZGdOCzJ5V-RZcBbZE09HsSUQrypHaFT-N8wks7NA=21Q@mail.gmail.com>
	<564B9091.7070902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 17 21:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZynCB-0006z0-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 21:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbbKQUti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 15:49:38 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33489 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbKQUti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 15:49:38 -0500
Received: by ykdv3 with SMTP id v3so28405043ykd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k+Pi2kECSjugEVmSoRoysqM91f2cm6zT71ddBPgoTzc=;
        b=mCcF5Gce91F80VqPB6hZjUh6I3IAHHbmH7MPyco9dr7xqp6Q/Y3GhzjMo6v9HH9kNA
         oTkLVZuPwiwYfXBBVp34qzffz40FYdMgTDt6q2vLLGry2TLMrMpMt6qqD9a1SsbXfoJS
         7KxmUktsssR4KnIxDTvtQfOHZFypmyoEdQ4dEst3wkpJrGGvzxcBsDmRjNYA1yjVZygj
         RhSkTUOPBIHgHzdOgARJ7eUkn4ro2BnA3hnRWtY8BQJn63IJ2tIXgvyBZN7ebsDVl1yP
         pIjqKi5Dmw1TOoIKflXphpXNfBKPhasMRoMQfgN1GNn50ApjEQY2cvRWMZnlVArR0gwL
         w8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=k+Pi2kECSjugEVmSoRoysqM91f2cm6zT71ddBPgoTzc=;
        b=TAnn2dLKmc2ZJX0pyz7g9EgwDcCtinbN69mt9uUA6PlKYZK0/5bRj9bfsMyUyqKpQ0
         cHdVWJV9U7UwQ4k+u/Ll3HxjvopZ/QtRNyQvEhgkNoeAO95A7dgnaxjHZQhqPkpK1W5/
         xP5DUSYFtK4Y47ZY0ZGxY1vOaMctwkGzP85jFqVwmCoHNP59jRnjbVfUq274otOgxa5w
         8HK++lXJEZVufLA8lQLoKw+AWD2SHge15aOtxOS5YAR2ndpr5Fc8FZ9UG0Uh9LVbru30
         0rmrpoEyaL2Uak3DrqHiS4/d0bLfDvpsbmAD73+Bkq3GSceNeSstedkzU1rnctKwyqCU
         lrGA==
X-Gm-Message-State: ALoCoQmFEa3qSwlLv4l5XPpMMCFR/0gXiX3mNA/nbg0lmO7Cnknumo78pOWhX27EBeOwJ8nbtPuO
X-Received: by 10.13.214.19 with SMTP id y19mr43711626ywd.63.1447793377255;
 Tue, 17 Nov 2015 12:49:37 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 17 Nov 2015 12:49:37 -0800 (PST)
In-Reply-To: <564B9091.7070902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281418>

On Tue, Nov 17, 2015 at 12:39 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 17.11.2015 um 21:04 schrieb Stefan Beller:
>>
>> On Tue, Nov 17, 2015 at 11:46 AM, Jens Lehmann <Jens.Lehmann@web.de>
>> wrote:
>>>
>>>
>>> But for quite some time you'll have older servers out there that
>>> don't support fetching a single sha1 or aren't configured to do so.
>>
>>
>> Only when talking about the open source side. If you have all the
>> submodules/superprojects on your companies mirror, you can control
>> the git installations there.
>
>
> Sure. But that doesn't mean we should make life harder for the open
> source side, no? We'll have to support both for quite some time.
>
>>> Wouldn't it be better to give the user an appropriate warning and
>>> fall back to cloning everything for those submodules while using the
>>> optimized new method for all others and the superproject? Otherwise
>>> you won't be able to limit the depth if only a single submodule
>>> server doesn't support fetching a single sha1.
>>>
>>
>> I think warnings are fine, but no fallbacks. The warning could look like:
>>
>>      Server for submodule <foo> doesn't support fetching by sha1.
>>      Fetch again without depth argument.
>>
>> and keep going with the other submodules. This would allow the user
>> to make an informed decision if they want to have the fallback solution
>> (which requires more band width, disk space)
>
>
> No, this is a regression. This worked before but now some submodules
> are missing from the clone. And if that happens inside a Jenkins
> script I doubt that Jenkins can make an informed decision, that job
> will simply fail.
>
>> On the other hand, that's what people do today, so it's not that bad
>> either,
>> so I guess falling bad would work too.
>
>
> Not that bad? I don't see any other sane way. Don't break formerly
> working use cases without a very good reason. Fall back to what we
> did before (even if it is suboptimal) and only then use the new
> optimized (and admittedly better) feature when it is available.

I assumed we'd have yet another flag to activate the new behavior,
but if you want to roll out that new feature as a default, I agree on
needing the fallback.
