From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Thu, 15 Nov 2012 02:41:50 +0100
Message-ID: <CAMP44s3vYP6zR6sKxgVSoZUySxcAuR7MioMeT1WDAnU0PtZKGA@mail.gmail.com>
References: <20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
	<CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
	<20121113074720.GA18746@sigill.intra.peff.net>
	<CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
	<20121113164845.GD20361@sigill.intra.peff.net>
	<CAMP44s3sBj0iYsCLUpiouUB8PXRwLORDEyD_+dWKrSsMP+TOaw@mail.gmail.com>
	<20121115000726.GA16910@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:42:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoTF-00011m-0y
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992608Ab2KOBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:41:53 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45647 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992603Ab2KOBlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:41:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so1182781obb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sN85Jrjh0pRZMast0QZmZOyeKMl2fHyZNpwhTuA+dPM=;
        b=VG1HrNX/O021Bo+k0+4OVcDmYcex2MbPVc2A1k/lT5UMLa+U674WO8s82PAp2/GW1R
         wCpovsd7iRvBPK5OmbhBYGIR9NEzj7sX15/jmOrXcBw7BJreCYk711ruKdKODI3JAeap
         SHzlPCVaH6B10TU4SjWRZRF3gCYIKFdjc+k1L5LPrn9hHnc4qLYsiLu2AZtebJWMbmac
         z9S4gzirhHUQJq2BNPbGgljFSgQsGy1rJA4ZbFhEzlJnN6DTbF4vTwbsS4qkmYn2ShI4
         ToyjYU6TToJBVknwkVddVvTyJXqfgZxnUIVo8K1Mu68qwVieuEM2QQDUktyMgZtlhup8
         DnBw==
Received: by 10.60.26.234 with SMTP id o10mr21517401oeg.85.1352943710940; Wed,
 14 Nov 2012 17:41:50 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Wed, 14 Nov 2012 17:41:50 -0800 (PST)
In-Reply-To: <20121115000726.GA16910@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209785>

On Thu, Nov 15, 2012 at 1:07 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 09:35:18PM +0100, Felipe Contreras wrote:
>
>> > Yes, dying would be a regression, in that you would have to configure
>> > your name via the environment and re-run rather than type it at the
>> > prompt. You raise a good point that for people who _could_ take the
>> > implicit default, hitting "enter" is working fine now, and we would lose
>> > that.  I'd be fine with also just continuing to prompt in the implicit
>> > case.
>> >
>> > But that is a much smaller issue to me than having send-email fail to
>> > respect environment variables and silently use user.*, which is what
>> > started this whole discussion. And I agree it is worth considering as a
>> > regression we should avoid.
>>
>> It might be smaller, I don't think so. A hypothetical user that was
>> relying on GIT_AUTHOR for whatever reason can switch to 'git
>> send-email --from' (which is much easier) when they notice the
>> failure, the same way somebody relying on fqdn would. The difference
>> is that people with fqdn do exist, and they might be relying on this.
>>
>> Both are small issues, that I agree with.
>>
>> But the point is that you seem to be very adamant about _my_
>> regressions, and not pay much attention about yours.
>
> Really? I mentioned initially the possibility of dying instead of
> prompting. You raised the point that it would regress a certain use
> case. And then what happened? I said above "you raise a good point[...].
> I'd be fine with also just continuing to prompt[...]. I agree it is
> worth considering as a regression we should avoid". And then I sent out
> a patch series which does not have the regression.
>
> In other words, my suggestion was a bad one, and once it was pointed
> out, I did not pursue it.  If you want to call that "not paying much
> attention", feel free. But I'd much rather you point out problems in my
> actual patch series.

But that I meant that when I introduce a regression it's like I'm
killing all that is good and sacred about git, and when you do it's
everything but that.

Yes, you sent a new patch. So did I.

>> The second patch doesn't have this issue. It does change the behavior
>> of 'git commit', yeah, but I think that's a benefit.
>
> Changing "git commit" is even something I would entertain. It would be a
> regression for some people, but at least it buys us something (increased
> safety against people making bogus commits and failing to notice the
> warning). I'm undecided on whether that is worth it or not.
>
> But when you presented it, as far as I could tell the change in behavior
> to "git commit" was accidental (which is why I pointed it out in
> response).

How could it be accidental if I said this: "Not only will this fix
'git send-email', but it will also fix 'git
commit'".

> And as it was in the middle of a discussion about whether
> regressions matter,

That was not the discussion at all.

You can't say that all regressions are the same, and if I say
"regression X doesn't matter", that means ALL regressions don't
matter. That's a hasty generalization.

> If you want to seriously propose changing the behavior of "git commit",
> I think the best thing would be to make a real patch, laying out the
> pros and cons in the commit message, and post it. I would not be
> surprised if the other list participants have stopped reading our thread
> at this point, and the idea is going otherwise unnoticed.

I would, if I saw any chance in it actually going through.

>> Or:
>>
>> 4. Just stop prompting
>>
>> I already sent a patch for 4. with all the details of why nobody (or
>> very few, if any) would be affected negatively.
>
> If doing (2) were really hard, that might be worth considering. But it's
> not. I already did it. So I don't see how this is an attractive option,
> unless my series is so unpalatable that we would rather accept a
> regression.

A matter of opinion. I think that series introduces way too much code
for a very very small gain that eventually would probably disappear.

>> >   [1/6]: ident: make user_ident_explicitly_given private
>> >   [2/6]: ident: keep separate "explicit" flags for author and committer
>> >   [3/6]: var: accept multiple variables on the command line
>> >   [4/6]: var: provide explicit/implicit ident information
>> >   [5/6]: Git.pm: teach "ident" to query explicitness
>> >   [6/6]: send-email: do not prompt for explicit repo ident
>>
>> I think this adds a lot of code that nobody would use.
>
> A lot of code? It is mostly refactoring,

Patch #1 and #3 are refactoring, the rest are not.

> which IMHO makes the resulting
> code cleaner, and it increases the utility of "git var", and our test
> coverage. If you have review comments, then by all means, respond to the
> series.

I don't have any comments, except  that I don't think all that code is
needed. And why would I bother commenting there, if my opinion will be
ignored?

>> > I do not necessarily agree on "git commit". Moreover, I feel like it is
>> > a separate issue. My series above _just_ implements the "do not prompt
>> > when explicit" behavior. It does not deal with git-commit at all, nor
>> > does it address the author/committer fallback questions. Those can
>> > easily go on top.
>>
>> Yes, at the cost of adding a lot of code. If we end up agreeing that
>> the changes to 'git commit' are desirable (which I hope at some point
>> we will), then this code would be all for nothing.
>
> If we are going to change "git commit" immediately, then I agree there
> is not much point merging my series. But even if we do change it, will
> we do so immediately? Will there be a deprecation period? If so, then my
> series helps send-email in the meantime. And it's already written, so
> you do not even have to do anything.

Yes, but it still adds a lot of code.

>> I want clarify that this is merely a disagreement to at which level
>> should we worry about regressions. On one side of the spectrum you
>> have projects like GNOME, who don't have any problem breaking the
>> user-experience from one release to the next, I'm not proposing
>> anything like that. On the other side I think it's you, because I
>> don't recall encountering anybody with such an extreme position of
>> never introducing a regression ever if there's absolutely no evidence
>> that anybody is using certain feature.
>
> I don't think that's a fair characterization of my position. I am fine
> with introducing a regression if there is a large benefit to it, and
> especially if the regression is mutually exclusive with the benefit. For
> example, look at IDENT_STRICT. We used to allow broken email addresses
> in commits, and it was _me_ who pushed forward the change to disallow
> it. That potentially regressed people who would rather have junk in the
> commit objects than configure their identity (e.g., because they are
> creating commits on the backend of some automated process). But we
> discussed it, and the breakage was worth the increased safety for normal
> users. We could not have it both ways, since the safety came at the
> expense of switching the default.
>
> But with this topic, we had a too-safe default (a safety prompt that was
> sometimes overkill). We can have our cake and eat it, too: drop the
> prompt for the overkill cases, but leave the other cases untouched. And
> that is what I tried to do in my series.  Note that this _still_
> regresses certain use cases. What if I have configured my user.email,
> but I am expecting send-email to prompt me so I can put in some other
> random value. But we can't improve the prompting and leave that case
> there; they are mutually exclusive. But IMHO, the benefit outweighs the
> possibility of breakage.

That's true, so we will be introducing a regression regardless.

Now, if we go with this patch:

http://article.gmane.org/gmane.comp.version-control.git/209660

Instead of your patch series, who will get hurt? Hint: I already
answered that question.

Cheers.

-- 
Felipe Contreras
