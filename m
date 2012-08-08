From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 08 Aug 2012 15:47:07 -0700
Message-ID: <7v628tq9w4.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <7vehnjzzfd.fsf@alter.siamese.dyndns.org> <87393yz64x.fsf@thomas.inf.ethz.ch>
 <7vboimuvur.fsf@alter.siamese.dyndns.org> <87628tsqeu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <robin.rosenberg@dewire.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzF2A-00031G-Rd
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 00:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab2HHWrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 18:47:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570Ab2HHWrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 18:47:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDEA67B8B;
	Wed,  8 Aug 2012 18:47:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOo06YWv5wCAstdH7BXZbfyaEYk=; b=N4vYRT
	yVVejX9GJOYTXIEeltXep5pa/ymAKpVetIiIJdoZLMHx0jtxu33qSrAib/di0M4z
	lJ6Xv4WrMU9JEVqlVCKnXibki+KsKSs3kAOLYlUrkYwjpcBMV6HyO+W4hswfH7dd
	JLUapdlKo3D7TrXPQW/RJNZL7AeHxK5yFzNMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=liwnobIjB8BLHTCzIGH3faBqAVmUDMuZ
	Ko1WFY/wWbaLYXDBevjJZgUaD/bLN+V4k/2SKGcUKSWlwpeFqqDIyyO+VXDaa8Rj
	S4KL5BsM4gQKqDXHJCeTb5LlSXNowftoo9sbK3Gc9QZ1n4z0ZDFryvDfmhy2kahe
	80juCfJML1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBB7A7B8A;
	Wed,  8 Aug 2012 18:47:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 271837B89; Wed,  8 Aug 2012
 18:47:09 -0400 (EDT)
In-Reply-To: <87628tsqeu.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 8 Aug 2012 11:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC511762-E1AA-11E1-BAA9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203140>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> I like the general idea, too, but I think there is a long way ahead, and
>>> we shouldn't hold up v5 on this.
>>
>> We shouldn't rush, only to keep some deadline, and regret it later
>> that we butchered the index format without thinking things through.
>> When this was added to the GSoC idea page, I already said upfront
>> that this was way too big a topic to be a GSoC project, didn't I?
>
> Let me spell out my concern.  There are two v5s here:
>
> * The extent of the GSoC task.
>
> * The eventual implementation of index-v5 that goes into Git mainline.
>
> IMHO this thread is mixing up the two.  There indeed must not be any
> rush in the final implementation of index-v5.  However, the GSoC ends in
> less than two weeks, and I have to evaluate Thomas on whatever is
> finished until then.

This is the primary reason why I have recused myself from the Mentor
pool.  My involvement in this thread is mostly about the latter.  It
is not like "I do not really care about GSoC", but the maintainer
works for what is best for the project, not for GSoC schedule.

> AFAIK Thomas is now cleaning up the existing code to be in readable
> shape, using your feedback, which is great.  However, the above
> suggestion is such a fuzzily-specified task that there is no way to even
> find out what needs to be done within the next two weeks.

Yes, it is the mentor's job to (1) keep an eye on the progress of
the student, (2) avoid giving a task that is too big to chew within
the given timeframe, and (3) help the student learn the skill to
break down large tasks to manageable pieces.

> Perhaps it
> makes sense, at this point, to wrap anything that ended up having _v[25]
> suffixes in an index_ops like Duy did.

Yes, I think that suggestion was a welcome input for the mentor and
the student (item (3) above).

> That's a long way from actually
> following through on the idea, though.

I think that is perfectly fine, both from the point of view of the
project maintainer (who officially does not give a whit about GSoC
schedule) and from the point of view of somebody who cares about the
health of the development community (and as one part of it, cares
about the GSoC student project).

If Git GSoC admins initially picked a project that is too large by
mistake, finishing a subpart of it that is of reasonable size and
polishing the result into a nice shape would be the best the student
can do, and the grading should be done on the quality of that
subtask alone.  It may not directly help the project without the
remainder, but that is not the student's fault.  But as I am not
part of the Mentor pool, what I wrote in this paragraph is just my
opinion.

> I think the part you snipped
>
>>> the loops that iterate over the index [...] either
>>> skip unmerged entries or specifically look for them.  There are subtle
>>> differences between the loops on many points: what do they do when they
>>> hit an unmerged entry?  Or a CE_REMOVED or CE_VALID one?
>
> is a symptom of the same general problem: the data structures are sound,
> but they are leaking all over the code and now we have lots of
> complexity to do even simple operations like "for each unmerged entry".

I do not think I was arguing against an updated cleaner API, so we
are in agreement.  In fact, I was saying that the calling code
should be ported to such a cleaner API and in-core data structure
first, and only then an optimal on-disk representation of the
in-core data structure can be designed.

The mistaken title of this GSoC topic was one of the root cause of
the issues, I think, you are seeing.  It said "faster file format",
but file format is a result of a design of the code that uses the
data, not the other way around.

That, and also the project scope is too large for a summer student
project as I said in the very beginning.
