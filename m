From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 12:03:06 -0800
Message-ID: <CAGZ79kY8=HbKB-om+FynDPf0w4c=12PtJ_9CsUyBU21yyD4CXA@mail.gmail.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
	<1448415139-23675-6-git-send-email-sbeller@google.com>
	<5655F544.6050003@web.de>
	<CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
	<565610FD.9070303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gHX-0003J6-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbKYUDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:03:09 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36532 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbKYUDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:03:08 -0500
Received: by ykdr82 with SMTP id r82so67867210ykd.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8WypDl3tNDqbYf2VF9N+HS5MN959BE3HvIVWwU3EY3c=;
        b=O5oFHxvsRp1B1EuM62Yz+jlWLYYt3U6SBnLez5cvlTTolr5QxaHuSEWuu8BMau+Rjz
         NdOXGclKc1Su2Qmp8aZe7T2zyXwwnJruo2aF2tl8J+MgQbbgp40GopH/YYR70Iq930BN
         QsbkdR/iVcVvqT2rfhbjFDXQVnkvu8n8HM9XfYaZrTqErkKNHTzCTdAlrKeH2Xf8tVyL
         jAQvKfwhD3QXsnL77T928W0mEAHtSR/RUFkrAWnsbgpFYgwbSGXTkOmCxxsYmeMWg9kv
         H/cnRKMrD+cxMoKdDPD/z5nRwpt2YYhQAIvrzOvUKH44qOnDQRrP9WOSrFytVWvUWieJ
         CVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8WypDl3tNDqbYf2VF9N+HS5MN959BE3HvIVWwU3EY3c=;
        b=S6Ns2V+mQPpmpsvuiokGSXggAudL+/L7ofv/+27z2Gr/tJbeNKda9ca+DGDqtMAoai
         R4Wzildf8MZQNYeCDkrX4irbktwoyMC2862bz+sHYsQ9zNAOh14/NCMQbFpK2jr7vglg
         jticuXweh/XWh9/5lM/LwmS1wGxwhaDTy5AUOQotn++aGe6Z3Gshp+eNUIDbFWFWCC16
         DKLNT1q7cQgdcdVl4l/afQaa6eL4WTgH8UOX82d8jEaPVFgtF4+L8OU5zHMtaHLXdBBY
         pWvtDClhPU91ZC3DO5WDnDcgHJfFZgXSHESdqHim1j+qwtagLuUxtyDV8bzGybJMCF+S
         YEGQ==
X-Gm-Message-State: ALoCoQm66JGZlsLoTOfgdXg3xiDT5ZfFK34hEPALo5pcxFmv7lcWekfPI3QnGuFRhajZnNboBtBo
X-Received: by 10.13.214.19 with SMTP id y19mr34220810ywd.63.1448481786719;
 Wed, 25 Nov 2015 12:03:06 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 12:03:06 -0800 (PST)
In-Reply-To: <565610FD.9070303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281736>

On Wed, Nov 25, 2015 at 11:50 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
>> My thinking is that groups are implying recursive, whereas recursive
>> implies
>> "all groups", so a git clone --group <half-the-submodules> --recursive
>> makes not much sense to me as it begs the question, what does --recursive
>> mean?
>
>
> Groups are only about what submodules to update and have nothing to
> do with recursion. It might make sense to imply recursion, but that's
> just because that should have been the default for submodules from day
> one. Recursion and groups are orthogonal, the first is about what to
> do inside the submodules (carry on or not?) and the latter is about
> what to do in the superproject (shall I update this submodule?).

I see. So we would not want to mutually exclude recurse and groups,
but rather have groups implies --recurse, but you are allowed to give
--no-recurse if you explicitely do not want to recurse into the subsubmodules.

>
>> Probably recurse into all submodules which are implied by the group
>>
>> <half-the-submodules>.
>
>
> Yep. We also do not recurse into those submodules having set their
> update setting to "none", so we do not do that for submodules not
> in any chosen group either.
>
>> And then get all the nested submodules. But in case
>>
>> you use the grouping feature, you could just mark the nested submodules
>> with
>> groups, too?
>
>
> Not in the top superproject. In a submodule you can specify new groups
> for its sub-submodules, but these will in most cases be different from
> those of the superproject.
>
> Imagine I have this really cool Metaproject which contains the Android
> superproject as a submodule. Those two will define different groups,
> and when recursing into the android submodule I need to choose from the
> Android specific groups. So my Metaproject's .gitmodules could look like
> this:
>
> [submodule "android"]
>         path = android
>         url = git://...
>         groups = default,mobile
>         subgroups = devel
>
> "groups" tells git what superproject groups the android submodule
> belongs to, and "subgroups" tells git what android submodules are
> to be checked out when running recursively into it. If you do not
> configure "subgroups", the whole android submodule is updated when
> one of the groups "default" or "mobile" is chosen in the superproject.

I like the concept of subgroups as it allows to have some control over
subsubmodules you may want to aggregate from a third party via the
middleman submodule.

I'd prefer to delay that feature though by not giving a high priority.
Also would you go with subsubgroups, too? When does the recursion
end? In case we have more than the union of groups, but also prohibitive
terms available, could subgroups clash with the submodules groups spec?
