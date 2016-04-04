From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of stored object
Date: Mon, 04 Apr 2016 11:04:26 -0700
Message-ID: <xmqqzit945ed.fsf@gitster.mtv.corp.google.com>
References: <56FE48C6.9050306@gmail.com>
	<xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
	<CAHGBnuPkPqJprOxR4zBuWitXqXt9XtpnjGPQWEv+-pYovh1b+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:04:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8ra-0004Ae-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 20:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbcDDSEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 14:04:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697AbcDDSE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 14:04:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A81544FE46;
	Mon,  4 Apr 2016 14:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVe+MdzPvcC2KIOPYokuhK85NxI=; b=WXINbR
	xeSlUrWciyOpYssp0me8nRm+8LkC5rSN0LwMFDmr+1iudonsxJw30tkdsZI/CZlg
	GpTWZlC8cES/WIarh8YO3P41ptvuTuEohuC+y0GdaxCtpQ1hGAJK8gxINLcVO4N3
	JP1hr2lHdzDMAQf3UuwI5/Auay/hb5PXZ4h1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fm9rF8BKlm/IPgXPlYAYe+bYBbEmiHOA
	KGrXQ3aTvgIOZlsumVXBIWKT2riNEGSAt3N2h7bXsa4wB6JjrL/VKWv9nsjvOu/G
	EV9y1tEFfPv3cp+cf/B4f2Smsom8Ho1l6GofMuHeIZgmYWQnKZOuDZXI6HDbjk7a
	S2nLm9/02X4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9602A4FE45;
	Mon,  4 Apr 2016 14:04:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B6C54FE41;
	Mon,  4 Apr 2016 14:04:28 -0400 (EDT)
In-Reply-To: <CAHGBnuPkPqJprOxR4zBuWitXqXt9XtpnjGPQWEv+-pYovh1b+A@mail.gmail.com>
	(Sebastian Schuberth's message of "Mon, 4 Apr 2016 10:10:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC377D1E-FA8F-11E5-9E4F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290712>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>>> -It is also permitted for a notes ref to point directly to a tree
>>> -object, in which case the history of the notes can be read with
>>> +It is also permitted for a notes ref to point to any other object in
>>> +the object store besides commit objects, that is annotated tags, blobs
>>> +or trees. For the latter, the history of the notes can be read with
>>>  `git log -p -g <refname>`.
>>
>> I do not think this is correct place to patch.  The original is not
>> talking about what objects can have notes attached at all.  What it
>> explains is this.
>
> Thanks for the explanation, I was indeed misreading this. I'll try to
> clarify this section then, too. In order to do so, I think we should
> mention how to actually create a <refname> that directly points to a
> tree instead of a commit for the history of notes. Would you have an
> example how to do that?

Interesting.  This came from 9eb3f816 (Documentation/notes: document
format of notes trees, 2010-05-08):

    Documentation/notes: document format of notes trees

    Separate the specification of the notes format exposed in
    git-config.1 from the description of the option; or in other
    words, move the explanation for what to expect to find at
    refs/notes/commits from git-config.1 to git-notes.1.

    Suggested-by: Thomas Rast <trast@student.ethz.ch>
    Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

but I do not find a corresponding sentence that says a notes ref can
point at a tree in the text before the patch.

I highly suspect that "git notes add" and other Porcelain level
commands that manipulate an existing notes tree would be unhappy if
a notes ref is not a commit, as it is clear from the paragraph
before the one under discussion, i.e.

    Every notes change creates a new commit at the specified notes ref.
    You can therefore inspect the history of the notes by invoking, e.g.,
    `git log -p notes/commits`.  Currently the commit message only records
    which operation triggered the update, and the commit authorship is
    determined according to the usual rules (see linkgit:git-commit[1]).
    These details may change in the future.

that in order to create a "new" commit, setting the current one as
its parent, would require that the current one to be a commit and
not a bare tree.  "git notes list" and others that merely read from
the notes tree would probably work.
