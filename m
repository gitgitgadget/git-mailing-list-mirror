From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Thu, 6 Jun 2013 00:01:26 -0500
Message-ID: <CAMP44s3SxV-rjcjh+sbmjdu9sme8B=v5x2KbJ8T4oc1=1CZbFw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
	<7vbo7l93t6.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_Xr4bymmDezTF8BMiMKQZFpNuxXpFZd_TGJ3BkJWdGw@mail.gmail.com>
	<7vvc5t7mpm.fsf@alter.siamese.dyndns.org>
	<CAMP44s1X=M2sV9OiHS_ggVjmu6txBQVSdK+aK6PnQm5-9EpQgw@mail.gmail.com>
	<7vsj0w1l4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 07:01:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkSKK-000546-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 07:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab3FFFB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 01:01:28 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58440 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3FFFB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 01:01:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so297400lbi.25
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tpojceoOnjawm1kHpnqmgOxnU4fmnOPHkblWFi0YsdE=;
        b=1IJPywjpXJRb6+Zfeg8uk9gQosI/E7MeOWqGuuq+5V214VSOTYkrzTWZzziR8UpaqQ
         4CrkJKOWT/N9LqK9mrztuK13n99P0vVJ+5cCNj5EtPS6/WGhxLJB9tZSyktAi4QM3Tzz
         T+bOoiA8fyfyh+zArFpmqlzj1PxmMfKFjDalVGAHUgGzQGo6sSVrelQikKEn5+7zLeVU
         BjVNN2yn5SDGWyhnOsEt6OQ+FhwmJZ1MAhQHtp+zqNCE30vrmAsi/ttfoxHZsKZyr33b
         91ibbdAs3f43yiBq+qfqZTaZhwT0WEwsmowvvV4cQ4ImoXhmihJMsGZv1pnKvoyCPxvY
         nOrQ==
X-Received: by 10.112.133.129 with SMTP id pc1mr13523505lbb.49.1370494886448;
 Wed, 05 Jun 2013 22:01:26 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 22:01:26 -0700 (PDT)
In-Reply-To: <7vsj0w1l4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226478>

On Wed, Jun 5, 2013 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Jun 4, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> You didn't answer, what happens when you run --skip-empty and --allow-empty?
>>>
>>> I'll answer to a slightly different question: What should happen?
>>>
>>> I think it should error out, because --allow-empty is about
>>> "allowing empty commits to be preserved", and --skip-empty is about
>>> "skipping empty commits (as it says on the package)".
>>
>> Exactly, so they are related after all. However, --allow-empty says this:
>>
>> "By default, cherry-picking an empty commit will fail,"
>
> OK, that is a very good point.  Especially because by the time
> reader reaches this new description, --allow-empty has already
> mentioned this, we can just be brief and it is sufficient to say
> "Instead of failing," upfront.
>
>> In fact, it might make sense to change the default in v2.0 to
>> --empty-commits=skip. If it makes sense in 'git rebase', why doesn't
>> it in 'git cherry-pick'?
>
> I think the primary reason behind the "Why are you picking a no-op?
> Let me stop to make sure you didn't make a mistake." is because
> cherry-pick and revert have long been operations for a single commit
> explicitly given by the user, not bunch of commits in a range.

Yeah, but this has changed already.

> These two operating modes are conceptually very different, even when
> we consider scripted use.  A script that feeds one commit at a time
> has a chance to do patch equivalence or user-interactive filtering
> on its own, and would be helped by the "are you sure you meant to
> record that no-op?" check if it filtered in a wrong way (e.g. the
> user specified an empty commit by mistake).  One that feeds a range,
> on the other hand, relies on or at least expects cherry-pick to have
> such smart, and a smarter cherry-pick could select what to pick from
> the given range.

How would a script know that a single pick ends up as a no-op? It
can't know what is the reason the cherry-pick failed. The only way to
know for sure is to check the last commit, and for that we don't need
the last cherry-pick to fail.

> In the longer term, especially if we envision to move large part of
> logic to prepare the sequencer insn list from rebase to cherry-pick,
> a ranged cherry-pick should learn a way to filter the range with
> patch equivalence, for example.  Once that happens, the behaviour
> would become inconsistent at the end-user level if we stopped at a
> commit only because it was not exactly patch equivalent to another
> one that is already on the branch we are cherry-picking to, but
> ended up to be a no-op, while we did not stop at another commit
> because patch equivalence filtered it out beforehand to skip it.
> Skipping a no-op by default would remove that inconsistency.
>
> So in that sense, one could argue that it may be a bugfix to skip
> commits that become no-op when replayed, when picking a range of
> commits (but not a single one).  And I do not think you would need
> to wait until 2.0 for such a change.

Right. But first we need to agree that failing an empty cherry-pick
serves no purpose.

-- 
Felipe Contreras
