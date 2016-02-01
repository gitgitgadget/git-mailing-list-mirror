From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Mon, 01 Feb 2016 10:17:24 -0800
Message-ID: <xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
	<20160127151602.GA1690@ecki.hitronhub.home>
	<xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
	<xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
	<20160128070959.GA6815@ecki.hitronhub.home>
	<xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
	<20160130081306.GA2931@ecki.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJ2e-0007gu-W5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 19:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbcBASRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 13:17:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751289AbcBASRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 13:17:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26F863F7D8;
	Mon,  1 Feb 2016 13:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3VRbsx6cPoR95EsRbz6GP8whagI=; b=uA4us/
	8ZStMC36K/CUOBYfYQje2XQS8m3dCsPupujKQobxyyCPMYaFNe9T12ahNZSms3rK
	RL6FfcXvV+ItdGLFMH5EVYw6LAKxZeH1hkTk6mglmWI0ncyjhA3KGPgcfiY+GqsS
	XB88FkGR8B4rW+jDMyx8EvOsh28H67Ng3soPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lrWyVpbuxKs3/4C4/CsmRssl79uuCvjE
	k9S6SXGt+lKN82kWs/9cJKbXM7eGk8aE4A4YoHa/6yJVviyf+JvpT6mp3ywio35Z
	IguM3TMiU+UXKhTchhamVjDa1mb9z4gwLWTXtlHaQvAoKq+aT9CK/H55juOxy3T3
	+RInChuNCB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B5713F7D6;
	Mon,  1 Feb 2016 13:17:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B0363F7D5;
	Mon,  1 Feb 2016 13:17:25 -0500 (EST)
In-Reply-To: <20160130081306.GA2931@ecki.hitronhub.home> (Clemens Buchacher's
	message of "Sat, 30 Jan 2016 09:13:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B8E5B5E-C910-11E5-B0A5-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285204>

Clemens Buchacher <drizzd@aon.at> writes:

> Ok, then let's take a step back. I do not actually care if git diff and
> friends say the worktree is clean or not.

You may not, but many existing scripts people have do.

> But I know that I did not make
> any modifications to the worktree, because I just did git reset --hard.
> And now I want to use commands like cherry-pick and checkout without
> failure. But they can fail, because they essentially use git diff to
> check if there are worktree changes, and if so refuse to overwrite them.

Yes, exactly.

> So, if the check "Am I allowed to modify the worktree file?", would go
> the extra mile to also check if the worktree is clean in the sense that
> convert_to_worktree(index state) matches the worktree. If this is the
> case, then it is safe to modify the file because it is the committed
> state, and can be recovered.

So in essense, the proposed "fix" is "let's fix it in the right
way"?

The way we defined "would we lose some changes that are only in the
working tree?", aka "is the working tree dirty wrt the index?", has
been to check if "git add -u" would change the states in the index.
And for scripted Porcelains and end-user scripts, "git diff-files",
aka "what change would 'git add -u' make to the states in the
index?", has been the command to do the same check.

Your proposal is to redefine "is the working tree dirty?"; it would
check if "git checkout -f" would change what is in the working tree.

I agree that indeed is "would we lose some changes that are only in
the working tree", and I think we can do that transparently for
"internal" commands, i.e. without any end-user impact, as the new
check would behave identically when they have sane contents--the
difference between the current check and the new check only exists
when the contents in the index contradicts what the user specifies
for to-git conversion via eol or clean filter.

We would need a way for our scripted Porcelains and end-user scripts
to ask that new question, though, but I think that is not something
insurmountable.  A new option to "diff-files" or something, perhaps,
would be workable, but having a new "git require-clean-work-tree"
plumbing, which would replace require_clean_work_tree shell helper
in git-sh-setup, may be conceptually much cleaner, because the new
definition of "working tree being clean" is no longer tied to what
"diff" should say.

I like that as a general direction.

> Regarding performance impact: We only need to do this extra check if the
> usual check convert_to_git(work tree) against index state fails, and
> conversion is in effect.

How would you detect the failure, though?  Having contents in the
index that contradicts the attributes and eol settings affects the
cleanliness both ways.  Running the working tree contents via to-git
conversion and hashing may match the blob in the index, declaring
that the index entry is "clean", but passing the blob to to-worktree
conversion may produce result different from what is in the
worktree, which is "falsely clean".  That is an equally important
case that is opposite from what we have been primarily discussing,
which is "falsely dirty".

>> Besides, I do not think the above approach really solves the issue,
>> either.  After "git reset --hard" to have the contents in the index
>> dumped to the working tree, if your core.autocrlf is flipped,
>
> Indeed, if the user configuration changes, then we cannot always detect
> this (at least if the filter is an external program, and the behavior of
> that changes). But the user is in control of that, and we can document
> this limitation.

That argument does not result in a very useful result, though.
Because the user is in control of what attributes and eol settings
are in effect in her repository, we can just document that the
current check will give unspecified result if the indexed contents
contradict with that setting, e.g. when you have CRLF encoded data
in the index but the eol conversion assumes LF in the repository.
But this discussion is an attempt to do better than that, no?

> On the other hand, a user who simply follows an upstream repository by
> doing git pull all the time, and who does not make changes to their
> configuration, can still run into this issue, because upstream could
> change .gitattributes. This part we could actually detect by hashing the
> attributes for each index entry, and if that changes we re-evaluate the
> file state.

If this has to bloat each index entry, I do not think solving the
problem is worth that cost of that overhead.  I'd rather just say
"if you have inconsistent data, here is a workaround using 'reset'
and then 'reset --hard'" and be done with it.

> This is also an issue only if a smudge filter is in place. The eol
> conversion which only acts in the convert_to_git direction is not
> affected.

IIRC, autocrlf=true would strip CR at the end of line in to-git
conversion, and would add CR in to-worktree conversion.  So some eol
conversion may only act in to-git, but some others do affect both,
and without needing you to touch attributes.
