From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 05 May 2016 15:20:23 -0700
Message-ID: <xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:20:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRdH-0005tH-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcEEWU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:20:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753003AbcEEWU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:20:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BC75419814;
	Thu,  5 May 2016 18:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=duJY1E/qPHIvUvbS2nZHFld0evs=; b=APhlFx
	ev+SKfofa1aOg5qSQ4dPSIHXiiREFPFIxx9deqYceqWjeOXIKcs6fbL+/A1DljBj
	IB0CZuB+LBviuPBw++K8KF2l8EDpM2hAfEyFX0u8JFqBBbpllZ3O9l7jGUaGfuEW
	bmnq7WlVQzYWcDp6ycfO2aVnKghl+zvdyfV84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avuA6dQNACPc5pUB7A/XJsNlobiuKfv3
	6R9rQxNXZ1lVwlSoHoKhjb3RNEjFiZf01UZFuI429z80tPseqjMr6fbqqBi5NJJ0
	6WEARXpCSmCLe6gK7wXXK4aOE/EamVChib7CBMfBCBuNV9VeT0P8wCzs9t/daz/Y
	H1vl/FuvXFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B477719813;
	Thu,  5 May 2016 18:20:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2800919812;
	Thu,  5 May 2016 18:20:25 -0400 (EDT)
In-Reply-To: <CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 14:02:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90934DF2-130F-11E6-84F6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293712>

Stefan Beller <sbeller@google.com> writes:

> The first option is giving nothing:
>
>      git config submodule.defaultGroup "*SomeLabel"
>      git -C submodule-not-labeled reset --hard HEAD^
>      git status
>      # all good, no report about  submodule-not-labeled
>      # because it is not in the default group.
>      # (This is implemented in the series)
>
> The "second option" is some sort of reporting. Either what I or you proposed.

OK, although I didn't propose anything ;-).

>
>>
>>>> If we want to go with the second option, the design described in 0/15
>>>> is broken. Going one step further:
>>>>
>>>> ...
>>>>     # But what about subC which is not in the default group? It was
>>>> changed as well.
>>
>> So why not show it?  Is there anything controversial?
>
> The user made clear to not be interested in subC by setting
> up the default group.

I wonder if that is a valid argument.  Git's position has always
been very clear after doing this:

    git add -f foo.bin && echo \*.bin >>.gitignore

What the user might have said in the "configuration" is the default
suggestion, that is much weaker than what has been done to the
repository data.  I think "the path is recorded in the index" in the
ignore/exclude situation is similar to "the submodule is initialized
in the working tree" in this context.

> Well it can get out of sync by not touching it as well, because others
> changed the submodule pointer who are interested in that though.

Which "others" are mucking with your working tree?  (don't respond:
I'll come to the answer a few lines below).

>
>     # in the superproject
>     git checkout new-version
>     git submodule update
>     # checks out submodules to their version
>
>     git checkout some-ancient-version
>     git submodule update
>     # this would only update the submodules in the defaultGroup,
>     # not those which are initialized but "uninteresting"
>     # the labeling may have changed between the different versions

I see.  I think that is where the conceptual bug lies.  Thanks for
an illustration.

If we take an approach similar to ignore/exclude, then yes the
"default" action should be done to "defaultGroup" specified plus
what the user instantiated in the working tree already.  And that
is not limited to "update" operation.

Just like "git diff" is not the only thing that would show
difference in foo.bin in the working tree even when *.bin is
ignored, but we consistently treat foo.bin as tracked.

> The state of a submodule (un-initialized, initialized, checked out)
> doesn't change the index or anything. Only the working tree is affected.
>
> And by flipping between the initialized and checked-out state we do not
> lose any information (such as user configured remote urls) nor does it
> affect the "state" (index, recorded tree, history) of the repository.

Users want to initialize a module and keep it checked out even if
they do intend to keep it pristine and not making any changes
themselves, only so that other parts of the tree that depends on the
module can be built.  So "removing a tracked and unmodified thing
from the working tree does not hurt users" is a nonsense argument,
isn't it?  I would be very unhappy if "git status" removed pristine
paths from the working tree and toggle assume-unchanged bit in my
index automatically.

I am afraid you are focused too much on "version control" and losing
sight of those who use the data stored in "version control", perhaps
because you worked in submodule area too long and too hard?  
