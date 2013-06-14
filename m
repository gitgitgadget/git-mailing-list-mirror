From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 09:31:47 -0700
Message-ID: <7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	<7v38sksq14.fsf@alter.siamese.dyndns.org>
	<CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWv2-00089S-5d
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3FNQcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:32:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab3FNQcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 12:32:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8880625507;
	Fri, 14 Jun 2013 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dpJMb58p5Jo6qIf0d9i02gDivRc=; b=aoHUGj
	EzaYXdRUjDOC4JcMA5cSEXv44sIFLFfgPBx3Egs9Br/oBW3bR5eRA6CbQQdk0dPd
	T5EPOCmzGfzdb9ZUR/BHuTB+t7U9NEfz7RHd91tW4qEX4fWRLfZ/2RMLbCio37vK
	/+sqRo5YnlU37yLP1DTXopNHVjDKCKlykilA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WpVJ/QiALP4N/bgEBye08OFspoAv8CHV
	X3FTAPUVhZDFeGJaKjDEkmtWpad2RDBi1ZYbdYqzYORxA4iTLvL1Xe24dO8ltDJt
	NPtPOlpSGKqcOHV0Hxh9r86YqX4A+VYJp99F+iT3o890EYEQamlkB4eHoIfRm7uf
	Z7AHLZAx+b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5C125506;
	Fri, 14 Jun 2013 16:32:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 367E125505;
	Fri, 14 Jun 2013 16:31:49 +0000 (UTC)
In-Reply-To: <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 20:38:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E971CB4C-D50F-11E2-A1A0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227896>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> As I said (twice), you can argue that that particular piece of
>> information is not useful (at least to you), but why it is not
>> useful has to be justified, against the justification given by
>> b397ea4863a1 (status: show more info than "currently not on any
>> branch", 2013-03-13) and people who have been using that information
>> in the status output, no?
>
> Yes, Junio.  I cannot justify that "detached HEAD from" is completely
> useless, because it is not.  I argued for a practical compromise, and
> have tried to show the huge negative impact against the marginal gain.

First of all, during a stopped "git rebase", I think "git status"
that says "# HEAD detached at" or "# HEAD detached from" is not
something we want in the end result anyway.  In either case, that
comes from the internal use of "git checkout" by the command to
switch out of a concrete branch, which is *not* user initiated.

If you first update "git checkout" so that it will pay attention to
a custom reflog-action exported by Porcelain scripts that may want
to internally use it to flip branches (and without a custom one, it
will still record "checkout: moving from A to B"), without exporting
custom reflog-action from "rebase" and other Porcelain scripts, that
would not affect any externally visible behaviour.

When you teach "git rebase" to pass custom reflog-action when it
detaches the HEAD at "$onto^0" (because that is not a user-initiated
action) as the next step, nth_prior_checkout and 1st_switch would
stop counting them as "checkout" events.  That fix will give you the
desired result of the topic of this series, i.e. "git checkout @{-1}"
ignores the internal "git checkout" done by "rebase".

That step may change the output from "git status" but I do not think
the output from "git status" in this sequence:

	git rebase ;# stops upon conflict
        git status

is anything sacred.  Tests modified by b397ea4863a1 (status: show
more info than "currently not on any branch", 2013-03-13) do change
the original "# Not currently on any branch" to "detached at", but I
do not think b397ea4863a1 _wanted_ to say where the $onto commit was
during the rebase (or was it?), so if they have to change to
"detached from", I do not think it is a problem at all.  I think it
is very sane to update these selected "detached at" to "detached
from" as needed.

That would be a sensible compromise, because we do not want to see
either "detached at" or "detached from" during "rebase" in the
longer term.  We would rather want to see the message start with
something like

	# Rebasing X on top of Y (23 commits remaining to be replayed)

which is under discussion in a separate thread lately.  The change
to expected output (i.e. "detached at" to "detached from") will have
to be changed again in that separate topic.

The very last test that the b397ea4863a1 added, which wants to see
"detached at atag", should be kept, and also there should be another
test added to reset one step back to make sure we see "detached
from" after it.  It tests what the user sees after a "git checkout"
initiated by the end-user.
