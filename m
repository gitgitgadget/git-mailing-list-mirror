From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Thu, 23 Jul 2015 23:07:58 -0700
Message-ID: <CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 08:08:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIW9h-000380-0m
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 08:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbGXGIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 02:08:20 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36389 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbGXGIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 02:08:18 -0400
Received: by iehx8 with SMTP id x8so11102482ieh.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VL3jrA3AfLJhXMSMN2htmZ6OTeY+G/GXz0CdGvL3vuc=;
        b=j0PbkM/TB/mmrs38VKVWmtVPOdEoi4IiS2/zkyu6n/q8ciHO1PGuR0jNtnPQWzEE9X
         pEkAAPzyOJH+wm4azSqYfm8h/9fmB89VnS0L5+jio2yEDPJCm7d0NWHsJaUMc198LBfH
         tM+KADrj6pOvo7bOGyEtMb2U5KOc5Yohgpjmxafnd4XBNbecY6VKtFd7nR9cr7JVVe29
         yb3Cgr/dxjeICpgaDchiXzDYSg5XZ5615ENA1K9onuOulzu3ZcE5CdVFIAqc8YmVGYnX
         SyFe6x2Pb3OwbWnnSObat6IAe3AZ3CfuhwpjODPCYHUTYPnqv8J+FLXl/btIE7Xu1KTJ
         ccmQ==
X-Received: by 10.50.23.98 with SMTP id l2mr2943001igf.25.1437718097995; Thu,
 23 Jul 2015 23:08:17 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 23:07:58 -0700 (PDT)
In-Reply-To: <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274554>

On Thu, Jul 23, 2015 at 3:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But other projects prefer to keep the messy history intact.
>> For one thing, it makes collaboration on a topic easier, as
>> developers can simply pull from each other during the messy
>> development. And two, that history may later be useful when
>> tracking down a bug, because it gives more insight into the
>> actual thought process of the developer.
>>
>> But in this latter case you want _two_ views of history. You
>> may want to see the "simple" version in which a series of
>> fully-formed topics hit the branch (and you would like to
>> see the diff of their final form). Or you may want to see
>> the messy details, because you are digging into a bug
>> related to the topic.
>
> While I can see the reasoning behind the above [*1*], I am not sure
> if the output with "--first-parent" would always be a good match for
> the "simple" version.  Wouldn't the people who keep these messy
> histories also those who merge project trunk into a random topic and
> push the result back as the updated project trunk?  Admittedly, that
> merely is saying that "--first-parent" is not a solution to such a
> project, and does not say much about the usefulness of the new
> configuration, so I'd queue it as-is.
>
> [Footnote]
>
> *1* I do not necessarily agree, though.  The history being messy is
>     a sign that "the actual thought process of the developer" was
>     not clearly expressed in the work, and it is not likely that you
>     have more insight by looking at it---you will see more mess, for
>     certain, though.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Based on the work I've done with people who don't mind "messy"
history, I find that they tend to break the first-parent rule fairly
often, and I don't personally find much value in the "mess" of their
history. However, I think the ability for git-am to see a patch series
cover-letter and include a merge message would be valuable, as there
is often information lost in the cover letter when you apply a series.
I'm not sure how much work this would take in practice though.

I think some projects definitely benefit from the first-parent setup,
and it could be valuable, but I do tend to agree with Junio here that
the mess is always helpful. If may be helpful if people's commit
messages on that mess are good, but generally those that don't take
the time to rebase local work and re-express the commit messages are
not going to leave insightful messages the first time. However, have
the ability to view history this way is still possibly valuable.

Regards,
Jake
