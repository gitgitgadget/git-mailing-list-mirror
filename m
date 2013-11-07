From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Thu, 07 Nov 2013 10:14:10 -0800
Message-ID: <xmqqr4as5bbh.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
	<vpqtxfo8ow4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 07 19:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeU5y-0002qA-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 19:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3KGSOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 13:14:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3KGSOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 13:14:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE6644FB1B;
	Thu,  7 Nov 2013 13:14:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WF+BdtPCG2P864+NNoaowI3qBY0=; b=BtdHSA
	zaUIHi+s3c9VBizBNL40cAt8LZpOoBcwu4R6wZq+WKPyUYOUWJ5XgtsTbvztKnfS
	5hjlKguiKQghRy3rmD1YJdKpKvJiVcQDVRsVlwNgzxuFBK3VNk/5tmrz7YbcbOZW
	qocwlGlb37lUAmsFya2+AP+DxKuGxY6+jUW4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cwI5kfmg334H2fBQB2KnKizrx+CkHmXx
	J9Yhc+TC1h83Jzy3mBsCDF//SD9UE++oUwlIGOlcKijG2Ggd9vWoBbFffCbmLNbx
	GCjBSuA6LqTbjZdmcNH5oLNJ0d+OFzts7CTytZJmvXpUp4skKq+AYweVbGYamTPa
	s0fnwX8OGm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC58D4FB19;
	Thu,  7 Nov 2013 13:14:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 275234FB18;
	Thu,  7 Nov 2013 13:14:13 -0500 (EST)
In-Reply-To: <vpqtxfo8ow4.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 Nov 2013 11:52:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67D40FA0-47D8-11E3-9483-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237419>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> 	When push.default is set to 'matching', git will push local branches
>> 	to remote branches that already exist with the same (matching) name.
>
> Yes, that's better than the original patch (and remains two lines).
>
>>>>>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>>>>>> +   "branch to the same remote branch used by git pull.   A push will\n"
>>>>>> +   "only succeed if the remote and local branches have the same name.\n"
>>>>
>>>> while you can see that it is not telling a lie if you read it twice,
>>>> "will only succeed if" feels somewhat roundabout.
>>>>
>>>> 	... push only the current branch back to the branch of the
>>>> 	same name, but only if 'git pull' is set to pull from that
>>>> 	branch. Otherwise the push will fail.
>>>>
>>>> might be an improvement, but I dunno.
>>>
>>> I do not see much difference actually. I tend to prefer the original
>>> version: to me the expected behavior is to make push and pull
>>> essentially symetrical, and the fact that it fails if the branch is
>>> named differently is a safety feature comming on top of that.
>>
>> Perhaps:
>>
>> 	In Git 2.0 (or now, if push.default is set to 'simple'), git will behave
>> 	more conservatively by pushing only the current branch to the corresponding
>> 	remote branch used by "git pull", and only if the remote and local branches
>> 	have the same name.
>
> I prefered the original, as it had two sentences. Reading only the first
> one gave the important information.

Actually, to me, I found the "two sentences" the worst part in the
original.  It made it sound as if the default will be switching to
'upstream', and all readers need to read the second sentence that
clarifies that it is not the case, in a somewhat round-about
way---"will only succeed if" invites "and otherwise...?"

>> 	In Git 2.0, git will default to a more conservative 'simple' behavior
>> 	that only pushes the current branch.
>
> That's an option too, but I think mentionning "git pull" was a good
> idea.

Yes, mentioning "git pull" is a good idea throughout these
proposals.
