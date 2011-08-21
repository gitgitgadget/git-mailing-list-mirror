From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Sun, 21 Aug 2011 15:29:38 -0700
Message-ID: <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org> <20110817231922.GA28966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 00:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvGXA-000331-E9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 00:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1HUWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 18:30:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34917 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1HUWaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 18:30:18 -0400
Received: by pzk37 with SMTP id 37so7746720pzk.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=axkGmS5PUz8X5r9mddXw4UdH+YcwSjCsKm3rjnmArsM=;
        b=wZFB+0OvUveHO1ivkd7acB/8jVKHmx/2+dfHpI5QsCtw4kz8/FmBGohxjf+z2mEn4v
         PsJfSj6xTWUSKlF9nXy+BAnsN/L29PR5Fz7FIKHMQxdOYBW0Y1AK9rbIgsbyy4RaSHOd
         FltNNzqC8AKwMhldSO/3LRRdOP5xdLgbryPCU=
Received: by 10.142.52.4 with SMTP id z4mr1164767wfz.437.1313965818301; Sun,
 21 Aug 2011 15:30:18 -0700 (PDT)
Received: by 10.68.55.170 with HTTP; Sun, 21 Aug 2011 15:29:38 -0700 (PDT)
In-Reply-To: <20110817231922.GA28966@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179821>

Heya,

On Wed, Aug 17, 2011 at 16:19, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 17, 2011 at 03:30:14PM -0700, Junio C Hamano wrote:
>
>> You can think of "fast-export" an off-line "push" command [*1*]; instead
>> of giving a random commit object, e.g. "git fast-export HEAD~1", that can
>> not be used as a ref, you can use the refspec notation to tell where the
>> result should go, e.g. "git fast-export HEAD~1:refs/heads/a-bit-older",
>> from the command line of fast-export.
>>
>> I suspect that also may clarify what Sverre was trying to do in his recent
>> series. The root cause of both this and the issue Sverre wanted to fix is
>> the design mistake of fast-export that tries to reuse the notation of
>> object range specification for a different purpose of telling which "ref"
>> to update, I think.
>
> Yes, this was the conclusion I came to when I looked at this a month or
> so ago. You really need to give fast-export a mapping of objects to
> refnames, and it should output ref names _only_ for the mapping. That
> would handle this "not a ref" case, but would also let you push
> "refs/heads/foo" when it is equivalent to "refs/heads/master", without
> fast-export mentioning "refs/heads/master" at all.

Does this bring any new insights into how the problem I was pointing
out (trying to push next if master points at the same commit does
nothing) could/should be solved?

-- 
Cheers,

Sverre Rabbelier
