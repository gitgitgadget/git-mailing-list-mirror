From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Wed, 05 Jun 2013 11:13:20 -0700
Message-ID: <7vsj0w1l4v.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 20:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkIDB-0005J0-0F
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 20:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab3FESNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 14:13:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620Ab3FESNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 14:13:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66E07257B2;
	Wed,  5 Jun 2013 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WtoLudY9UojOt7uJMb53gPRqlA8=; b=DGAUzz
	oVXSSyJna8hY/hNlamyScD+K/4d05LLAsBs4xmcPdqptN8y9l/l5eiP86Yzq/tOZ
	gmTxpbP+fs5gEI+wGKDPNAtfW8VPo+/3hm4xnhO7L4vywnVVJ5nU3dOXaHegOku0
	3WVpuNu2hAp5+0SlJthWa2Y0raIIckVza+Wko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgZfzrJeYJ96wuLST/S+zXYdT6t5GFGJ
	G8zUYmzqPrO+dk2tXPlPbLrJ0N+PR56Q4zX516z5F34Dt88Jdk+CGgOWrR1x6Nv+
	9Ljl+LOa8Ajxks+XDCouyNP43MhexXChYsBR/1hOEUdFh56QDOXfJNsNUJYYXUVt
	OUOLhwiEhVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B84D257B1;
	Wed,  5 Jun 2013 18:13:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1F6A257AE;
	Wed,  5 Jun 2013 18:13:21 +0000 (UTC)
In-Reply-To: <CAMP44s1X=M2sV9OiHS_ggVjmu6txBQVSdK+aK6PnQm5-9EpQgw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 5 Jun 2013 09:52:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B1B15C6-CE0B-11E2-8F8B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226463>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Jun 4, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> You didn't answer, what happens when you run --skip-empty and --allow-empty?
>>
>> I'll answer to a slightly different question: What should happen?
>>
>> I think it should error out, because --allow-empty is about
>> "allowing empty commits to be preserved", and --skip-empty is about
>> "skipping empty commits (as it says on the package)".
>
> Exactly, so they are related after all. However, --allow-empty says this:
>
> "By default, cherry-picking an empty commit will fail,"

OK, that is a very good point.  Especially because by the time
reader reaches this new description, --allow-empty has already
mentioned this, we can just be brief and it is sufficient to say
"Instead of failing," upfront.

> In fact, it might make sense to change the default in v2.0 to
> --empty-commits=skip. If it makes sense in 'git rebase', why doesn't
> it in 'git cherry-pick'?

I think the primary reason behind the "Why are you picking a no-op?
Let me stop to make sure you didn't make a mistake." is because
cherry-pick and revert have long been operations for a single commit
explicitly given by the user, not bunch of commits in a range.

These two operating modes are conceptually very different, even when
we consider scripted use.  A script that feeds one commit at a time
has a chance to do patch equivalence or user-interactive filtering
on its own, and would be helped by the "are you sure you meant to
record that no-op?" check if it filtered in a wrong way (e.g. the
user specified an empty commit by mistake).  One that feeds a range,
on the other hand, relies on or at least expects cherry-pick to have
such smart, and a smarter cherry-pick could select what to pick from
the given range.

In the longer term, especially if we envision to move large part of
logic to prepare the sequencer insn list from rebase to cherry-pick,
a ranged cherry-pick should learn a way to filter the range with
patch equivalence, for example.  Once that happens, the behaviour
would become inconsistent at the end-user level if we stopped at a
commit only because it was not exactly patch equivalent to another
one that is already on the branch we are cherry-picking to, but
ended up to be a no-op, while we did not stop at another commit
because patch equivalence filtered it out beforehand to skip it.
Skipping a no-op by default would remove that inconsistency.

So in that sense, one could argue that it may be a bugfix to skip
commits that become no-op when replayed, when picking a range of
commits (but not a single one).  And I do not think you would need
to wait until 2.0 for such a change.
