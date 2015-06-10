From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/4] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 17:47:13 +0200
Message-ID: <CAP8UFD0-R1UqSDbEeTKq_gX+uFw2egZetgziqaUiRqdivHvhPA@mail.gmail.com>
References: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq7frcast5.fsf@anie.imag.fr>
	<xmqqwpzbmvr3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iDy-0002Ot-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965834AbbFJPrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:47:21 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35464 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965103AbbFJPrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:47:16 -0400
Received: by wiga1 with SMTP id a1so52954158wig.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+HL5CzoWgE74JGZLt7wjiPhFDzawbPXcbedO7XR/jD4=;
        b=FKRaYUBduf19shBgIfWZeyAGkI2RSTnPzftLhXdTH0ZhFwpZMr6kcPrXeqfvQmfp1r
         Ctx2fzgGB0uyS37e5NeMYr7ZRGdn0Y0tCLnrBtYQW1SZFXxvJTuEtM2np6fxTl2mQ+dv
         /CchHfDzzIY20zgt9V39p0Q08afS3JSL/K4QarDck1EAEY20i/FNDrraJgWh1KlQBF8G
         BZ+w/VvFBQRQp02IS8PHzZre6aOgv5+RJqcn7uBw0qyD91FRrj7/mktPAwAp7REZ1fd9
         3g6TqSU3UYczLpbO25s0Hvzhzi5BNEOV9aSrv4Wf6Ml7XAvoPtplTg4FeuHMRvTvacMd
         44ZA==
X-Received: by 10.194.2.68 with SMTP id 4mr7253611wjs.82.1433951233949; Wed,
 10 Jun 2015 08:47:13 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Wed, 10 Jun 2015 08:47:13 -0700 (PDT)
In-Reply-To: <xmqqwpzbmvr3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271309>

On Wed, Jun 10, 2015 at 5:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "Somebody else did it like that" is not a good justification. Especially
>> when the previous code was not merged: the code wasn't finished.
>>
>> But I actually disagree with the fact that it was not the idea. The
>> point of having the terms in BISECT_TERMS was precisely to be generic
>> enough. Had the goal been just to distinguish good/bad and old/new, we
>> would have needed only one bit of information, and encoding it with the
>> existance/non-existance of a file would have been sufficient (as you
>> tried to do in addition to BISECT_TERMS).
>>
>>> For now we just rebased, corrected and finishing to implement
>>> functionalities.
>>
>> functionalities is one thing, but the code should be maintainable to be
>> merged in git.git. Git would not be where it is if Junio was merging
>> patches based on "it works, we'll see if the code is good enough later"
>> kinds of judgments ;-).
>>
>> Moving from "one hardcoded pair of terms" to "two hardcoded pairs of
>> terms" is a nice feature, but hardly a step in the right direction wrt
>> maintainability.
>
> Nicely put.  From that point of view, the variable names and the
> underlying machinery in general should call these two "new" vs
> "old".  I.e. name_new=bad name_old=good would be the default, not
> name_bad=bad name_good=good.

I don't think this would improve maintainability, at least not for me.
The doc currently uses "good/bad" everywhere.
For example the description is:

   This command uses git rev-list --bisect to help drive the binary search
   process to find which change introduced a bug, given an old "good" commit
   object name and a later "bad" commit object name.

And this is logical if the default is "good/bad". If we use name_new
and name_old in the code, we make it harder for us to see if the doc
matches the code.

And unless we rewrite a lot of them, the tests too will mostly be
still using "good/bad" so it will make it harder to maintain them too.
