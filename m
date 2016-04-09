From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Fri, 08 Apr 2016 21:44:41 -0700
Message-ID: <xmqqr3eftmpy.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<xmqqlh4ovuqv.fsf@gitster.mtv.corp.google.com>
	<CABPp-BGpBDsn_ZZh8iot7qbgpWn0cUcdWTypRqKOKFMm9Y-E4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 06:44:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoklT-000547-8G
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 06:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbcDIEoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 00:44:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750776AbcDIEoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 00:44:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD97A5387E;
	Sat,  9 Apr 2016 00:44:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/WK1lKkRyzYvFwTkV/s8XHt2No=; b=eIluTU
	8QUuKTQcI6C/FdaXcc+68hpAugb+BugelkOZIids+rGwv7mgLMsaLvj7hJ/G3Ye9
	A7n4uxV7CV7SQkpQRWjQp5EE37kYhD5g52DnyjUPkMxOWEa3ZOLGck4U8dwJhiz2
	PSGLvmSxFqpXGF5Cb2A4aeIp/HnDwMIr8j+NM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AoMAPDchD6Desi9/1H2YIqZ/pJsUnPsG
	/3z2G/N9bVyOUZ8NgN3hZc+qsXU87EfS6cwR6dIaC8ywcdYlKBitV06PLlQ7Fy5W
	XhmW4G4JOLKUXhBD+hLsGVOvrgwUu0HwbRvDOqKWqG2THF/d7/QfuNi0rG3L6QLZ
	cXPj/WmH9b0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B47D45387D;
	Sat,  9 Apr 2016 00:44:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 36D405387C;
	Sat,  9 Apr 2016 00:44:42 -0400 (EDT)
In-Reply-To: <CABPp-BGpBDsn_ZZh8iot7qbgpWn0cUcdWTypRqKOKFMm9Y-E4w@mail.gmail.com>
	(Elijah Newren's message of "Fri, 8 Apr 2016 19:35:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C677232E-FE0D-11E5-87B8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291080>

Elijah Newren <newren@gmail.com> writes:

> On Fri, Apr 8, 2016 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>> The goal is stated rather vaguely--when you have a working tree and
>> perform this "in index" merge, you would obviously update the index
>> with the merge result and ...
>
> Yes, I think you hit the nail on the head with your suggestions
> elsewhere to (1) limit this to bare repository only, and/or (2) do the
> "git merge --into master en/topic"
>
> I'll fix this.
> ...
> The pointer is helpful, but I struggle a bit with the name '--cached'.
> The past tense in that word suggests to me that it should be a
> read-only operation on the cache (which works for grep), rather than a
> write operation (such as for merge or apply).  It could also be
> misconstrued in merge's case to think that the index is one of the
> things being merged (rather than erroring out if the index doesn't
> match HEAD).  I know apply already uses --cached, but if others don't
> mind, I personally would rather not use it here.  Is this something
> you feel strongly about, or are you okay with --index-only?

"cached" is not in past tense, but is used an adjective.  You can
update what is in the index and that is to update the "cached"
information.

But I do not think we need to discuss this, because we do not need
such an option, as I understand that your updated direction is to do
one or both of (1) do the "merge and update HEAD only when no manual
conflict resolution is needed" thing in a bare repository, (2) "git
merge --into=master en/topic" does the "merge master and en/topic
and update master only when no manual conflict resolution is needed
and do so without touching HEAD, index or the working tree".

Because the current "git merge" refuses to work without the working
tree, (1) can be done without adding any new option---if you are run
in a bare repository, by definition, you are being asked to do that
new thing, and because you will not do the new thing in a repository
with a working tree, there is no need for an option to tell the
command, "no, don't do the usual thing but do this new thing".  And
obviously (2) already has a new option --into and no other new option
is needed to tell the command that it needs to do that new thing.

>> I have a suspicion that this would become moot, as the conclusion
>> may become that "git merge" that works only in index does not make
>> sense unless you are in a bare repository---in which case, these
>> external merge drivers has to be given a temporary working tree
>> anyway, and they can keep writing their result out to what they
>> consider is the working tree (i.e. via GIT_WORK_TREE or something).
>> You read the result of them from that temporary working tree into
>> the index before cleaning the temporary working tree.  That way,
>> you do not have to touch them at all, no?  In fact, the temporary
>> working tree trick may be applicable even when you are working in a
>> repository with a tree working tree.
>
> I'm a little confused; you seem to be suggesting git-merge-one-file
> will always need to have a working tree of some sort, though I don't
> see why.

I was loosely referring to the working tree, which includes things
like having a place you can safely check out temporary files as if
they were one of the working tree files, i.e. the arrangement in
which "merge-one-file" is designed to operate.  Even if they are
"tmpname" generated files, you do not want to clobber your $GIT_DIR
with these random files when driving these blob level merge drivers
in a bare repository.
