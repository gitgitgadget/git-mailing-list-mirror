From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Fri, 17 May 2013 12:51:47 -0700
Message-ID: <7va9ntxu3w.fsf@alter.siamese.dyndns.org>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<51968311.1020107@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Fri May 17 21:51:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdQh2-0000e1-AS
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 21:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307Ab3EQTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 15:51:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab3EQTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 15:51:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97EE11BF09;
	Fri, 17 May 2013 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HyY4A7YNrp+S6ds0ni+2bLD2ZcM=; b=ETtH3b
	O24C+oXH/r/xGJmCebduL03qGQK9WFVq1OOcrulAYs0jeFFC8rnsiYALQlUkGqYW
	F28Lx3bTyVAaa+2tFg4k0pJcCvx7ZYEhjSl9ryoCx6J9qVxSco+xHW3o2RSYU8k9
	H1ZQKSA2UPojRfspOVPxHUUT1+VG9jlF1/0dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKiRenkS3PuIaPOFGml8sV9ZXCESInhi
	KpQ3LnbPOaglF3l8TwHYyJYuZN51YHhcwZZav8I8I4ZNF6lBI4OScHY0oyi4FHrN
	6VRksC6nLpjtJDf1LcC6BVzDhHwEK7wXP/Gl6D+ElyzergZup60+UIeDv94A7oLg
	kUe1w1PlQoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A5AF1BF08;
	Fri, 17 May 2013 19:51:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E96491BF07;
	Fri, 17 May 2013 19:51:49 +0000 (UTC)
In-Reply-To: <51968311.1020107@bracey.fi> (Kevin Bracey's message of "Fri, 17
	May 2013 22:20:49 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36DF4148-BF2B-11E2-8A14-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224733>

Kevin Bracey <kevin@bracey.fi> writes:

> On 15/05/2013 23:34, Felipe Contreras wrote:
>>   I think I'm using 'upstream' for something it was not intended to,
>> and
>> I think the current 'upstream' behavior should be split into
>> 'upstream' and 'base'.
>>
> I found myself thinking the same thing. It's really convenient being
> able to set your topic branch's upstream to another local branch, so

What is that "another local branch"?

Is the use case "master forks from origin/master and has its own
changes on top, and then topic builds on my master but the range of
commits origin/master..topic includes both changes, that is
inconvenient to when rebuilding topic on top of my master"?

I'd assume that it is the case, and the answer to the previous
question is 'master' in the example.

> git rebase works without parameters. But then I can't use upstream to
> point to a remote version of that topic branch. I want my topic branch
> to know both that it's based on master (or origin/master), and that
> it's upstream is origin/topic.

If we do s/and that it's upstream is/and that it is pushed to/, then
I think I am in general agreement (I wrote about it earlier in a
separate message).

> So, yes, here's a vote in favour of the general concept.

Yes, you should be able to treat what you build on top (upstream)
and where you publish the result (we are still looking for a better
name in the other thread) as two distinct things in a triangular
workflow.  I agree that it is an issue we need to address.

We have solved a half ("push goes to a different repository") but
not the other half ("updates a branch whose name is different from
the upstream") in the upcoming 1.8.3 release.

The latest round of design from Felipe calls it branch.$name.push,
if I am not mistaken.

I think it is somewhat an overkill, though.

It is normal for upstream's name not to match the topic's name
(i.e. your 'topic' may branch off of a generic 'master', but would
be named after a more specific purpose of the branch and is unlikely
to be named 'master'.  In other words, branch.$name.merge that
points at an upstream that has a name that is totally different from
$name is not an exception.  So branch.$name.merge that you have to
set for each branch is a necessity.

However, if you were to push out 'topic' directly (as opposed to
pushing out a result of integrating it and other topic branches to
your 'master') to your own publishing point, it is likely you would
push it out to the same name (i.e. 'topic' will be pushed out as
'topic', not as 'master').  And if that is your workflow, setting
push.default to "current" (and setting remote.pushdefault to your
publishing repository) should be a sufficient interim solution, and
you do not need to set branch.$name.push to each and every branch
you intend to push out, I think.
