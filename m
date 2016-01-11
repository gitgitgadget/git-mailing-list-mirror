From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Mon, 11 Jan 2016 08:50:24 -0800
Message-ID: <xmqqy4bwxdpr.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
	<xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
	<20160108214939.GA22801@glandium.org>
	<xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
	<20160109002510.GA30050@glandium.org>
	<xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
	<181337AE5CFC4AF09B82187B8E97095D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Mike Hommey" <mh@glandium.org>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:50:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIffy-0003Zl-5V
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934189AbcAKQub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:50:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933630AbcAKQu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:50:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7AF2383E3;
	Mon, 11 Jan 2016 11:50:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fmm565/Ae/mH7FKPvRJ3upCUVPQ=; b=qsJD3L
	xo1lHnSxUwGXqe13Po059lAnGvD2tzMRmFxaSFf/OCFdBkXj8dz2OL9XsnMiU6rg
	P+g6mjW0cp48CLTeXUPC1FnB301ZYgFAeE+AFAKg5eiGx62oLKZqlUMjshI8VvFB
	W3whAiWF91VWZDKcInsZhGP9ubckptQePTgiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEr0I379f0vKTR0NielkeKURvpTWN3Rz
	mgoAZpQnP+874vjE8ZMUiXI/M7cqiM6Zs24CwGjmsrRmJHuL6aH2YsqaPWrF1ncP
	IiZQ2KMDuiQJqAW+K9/C0omjF/eSD/SQUTOTLIw7eqgjqXYBVxXCb1ahRgXxT9F4
	ysnKZ2eidC4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE216383E2;
	Mon, 11 Jan 2016 11:50:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 474A1383E0;
	Mon, 11 Jan 2016 11:50:26 -0500 (EST)
In-Reply-To: <181337AE5CFC4AF09B82187B8E97095D@PhilipOakley> (Philip Oakley's
	message of "Sat, 9 Jan 2016 17:39:13 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69FC9720-B883-11E5-93C1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283669>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Saturday, January 09, 2016 1:04 AM
>> Mike Hommey <mh@glandium.org> writes:
>>
>>> So while `cat-file commit A` gives you what `cat-file commit Z` would,
>>> `notes show A` doesn't give you what `notes show Z` would. And that's
>>> this "inconsistency" that bothers me.
>>
>> In any case, 'notes' being a way to add extra information to an
>> existing object means that with your original "replace" that tells
>> Git to keep A in the history (and give Z's contents when contents of
>> A was asked),
>>     it is absolutely correct that notes for A is shown.
>
> This seems very wrong to me. Surely we have asked that _all_
> references to A be replaced by a reference to Z and thence onward to
> Z's contents.

You didn't ask any such thing.

I already said:

    The true source of your confusion, I think, is that there is a
    misunderstanding of what "replace A with Z" does.

    It is NOT "whenever somebody refers to A, pretend as if it is
    referring to Z".  If that _were_ the case, then I'd agree that
    "whenever somebody else asks notes attached to A, pretend as if
    notes attached to Z were asked" might make sense, but that does not
    match the reality.

but then didn't say what "the reality" is (because I already said it
elsewhere upthread).

What you asked is that whenever information in A is asked, a tweaked
version of the original information in A is returned.  The tweaked
version happens to match what is in Z, but after the replacement,
the object Z does not directly get into the picture---as you can see
in the result of log (or rev-list) from C that shows "C B A Y X" (in
tip-to-root order), the end user does not even have to be aware of
Z's existence.

Let's think about the example of grafting "old" history that starts
at X, resurrected from archive since the history of the current
project has already started at A and leading to C in real-world
terms.  A would be like Linus's v2.6.12-rc2 in the Linux kernel
project that does not have any parent.  Then you rebuild the "old"
history from the archive that ends at the same v2.6.12-rc2, so your
X Y Z history also ends with v2.6.12-rc2.  And you would "graft" it
behind the true history.

Commits A and Z would both have the same log message, record the
same tree, made by the same author and committer with same
timestamps.

Now, think which one of A and Z do you think people would want to
"survive" in the graft operation?  Everybody has built (and will
continue to build) on the history that started at A whose tip is
currently at C.

If you have a way to tell Git "Earlier A was recorded as having NO
parent, but I wish we had recorded Y as its parent.  So create a
fake reality where A's parent is Y.", then you can keep the
resulting world view consistent with the "recent-only" real history,
i.e. B's parent is still A.  Some might even have notes on A, or
commits made since A may reference the commit object A by name in
its log, or another superproject may bind A as its subproject, but
because we are not changing the identity/name of A with Z, all of
these "external" references survive the grafting/replacing.

Perhaps it would help if you stop thinking that you are somehow
losing "Z" and "Z" is somehow precious.  It is not, at least in the
"history grafting" context, at all precious.

When you have the true history starting from v2.6.12-rc2 (that is "A
B C"), the thing you REALLY want to do is to resurrect history that
ends at one commit before v2.6.12-rc2 (that is "Y" in the example),
and somehow tweak "A" so that its parent is "Y".  And the way you
tweak "A" to make that happen is to replace its contents with the
contents of a commit that records all the same information as "A"
except that it has a parent that is "Y".  We could do "cat-file
commit A" piped to sed to add a "parent Y" line to it and then
"hash-object" to come up with such a replacement commit, and replace
A with it, but "Z" happens to be such a commit already, so that is
why replacing A with Z would graft Y just behind A.  The resulting
history would show Y as the parent of A and Z won't even be in the
consciousness of the end users.  The "old history resurrection"
project does not even have to create "Z" in the first place.

If the contents of "Z" is different from contents of "A" in some
other way, other than their set of parents, or if "Z" has other
external references that are precious (e.g. a note may refer to it,
or a superproject may bind Z to its tree), then either replacing A
with Z or replacing Z with A would not be a good way to connect the
two histories.  As you would want to keep both, and the "external"
references, such as notes and submodule gitlink bindings, want to
keep refering to both.

In such a case, the best you can do is to tweak A to have Z (instead
of Y) as its fake parent, to make the resulting fake history read
like "C B A Z Y X" (in tip-to-root order), having two copies of
v2.6.12-rc2.  That way you would be able to see both notes for A and
Z, and can tell which note was attached to the true history and
which note was attached to the history resurrected from the archive.
