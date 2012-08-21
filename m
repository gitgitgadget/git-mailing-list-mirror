From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to request a fast-forward pull
Date: Tue, 21 Aug 2012 10:22:05 -0700
Message-ID: <7vwr0sdute.fsf@alter.siamese.dyndns.org>
References: <20120820202803.GA8378@windriver.com>
 <20120820204033.GA636@mannheim-rule.local>
 <20120821064138.GA3238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Bart Trojanowski <bart@jukie.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3s9g-0001EP-On
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab2HURWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:22:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758022Ab2HURWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B83E70B2;
	Tue, 21 Aug 2012 13:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IGTYQNcPg4sKgWE4Yh1/bjvVkvc=; b=onoUAr
	iQdqKEaxGprI49BGHRAKU8+Atko7kQNZUnWSwpYeh7PN+fVGaop/ZfOpicXFIZ0v
	LUHW7Gubz6pQyAPg+GcdoRlmMxVB3TERUxIuKa+3zguzd8POl7IJlctM3K1dF4nc
	RIZMlkZ5MpjkI0+1wF5TWnzwZjt7/9bXGz4LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TamUPbEiOP/zy/bJDhUIaVWJSMB3PQzg
	X7ayeLzW8LLPJBC6EWJT6lvHi/80Bke+9Rd193S4JHNhfy0YWFGqPpi7QJ9gKRWz
	SM6qZvOJ8gRzY+dYCh2oYx08TJSkPnooCAt4Ds+xMWk6f1yoIWJo3I6ZnuDMUHwY
	UuUfvqPqyf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1889C70B1;
	Tue, 21 Aug 2012 13:22:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68DFB70B0; Tue, 21 Aug 2012
 13:22:06 -0400 (EDT)
In-Reply-To: <20120821064138.GA3238@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Aug 2012 02:41:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB2C1714-EBB4-11E1-8ACD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203973>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 20, 2012 at 01:40:33PM -0700, Jonathan Nieder wrote:
>
>> > When you have a moment, would you please migrate this
>> > across to your main linux-stable repository?
>> >
>> > Both a branch and signed tag are present and pointing at
>> > the same commit, but "git request-pull" does favour output
>> > of the tag over the branch name.
>> >
>> > But merging the tag will want to create a merge commit.
>> >
>> > So, to avoid a merge commit in your repo, you can fetch
>> > (fast fwd) into your (local) branch from my branch at:
>> >
>> >  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y
>> >
>> > and then fetch the signed tag listed below after that.
>> 
>> Can this be made easier?  I could imagine request-pull learning
>> --ff-only that generates a message like
>> 
>> 	Greg,
>> 
>> 	Please pull --ff-only

Where did the "Greg,\n\n" come from?  Isn't it just the matter of
adding the "--ff-only" when that string is added?

>> 
>> 	 git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git linux-2.6.34.y
>> 
>> 	to get the following changes [...]
>> 
>> which could work ok if the recipient notices the --ff-only, but I
>> wonder if there is a simpler way.
>
> If it is something important for the sender to communicate to the
> recipient as part of the pull command-line, then I would think the
> natural place is on the line with the rest of it, like:
>
>   Please pull:
>
>     --ff-only <remote> <ref>
>
> It's maximally noticeable to the recipient, then, and anybody
> cutting-and-pasting the whole line would get it automagically. That is
> as close to machine-readable as pull-request emails get.
>
> However, I have to wonder if that is a good idea in general. Isn't the
> decision to --ff-only or not really the puller's business? In the
> general case, I would not expect senders of pull request to have advice
> in this area.

Yes, absolutely.  The advice of the sender that would be more
helpful is not "how", but "where"/"when".  Is the topic meant for
the maintenance track?  Why is it appropriate to pull this series at
this moment in the history of the overall project?

> This particular case seems to be caused by a policy mismatch between the
> project and request-pull. The latter's behavior to favor a matching tag
> is because tags carry more information. But in this case, it sounds like
> the project would rather avoid the extra merge commits, even if it means
> losing information.

That's a project decision and can be done by whoever is pulling, as
you mentioned earlier.

In any case, why is this even become an issue in the context of
linux-stable?  I thought people over there were working hard to
*increase* verifiability of the history by using signed merges,
while strongly discouraging to rebase history (which is wholly
incompatible with insisting on fast-forwardness).  I _think_ the
original submitter meant to say "the whole of my work is based on
your latest, so you _could_ fast forward", and did not even mean "I
do not want to see any merge commit (or I understand you do not want
to see one), and here is an instruction to work my pull request
around".  If the latter were the case (which I doubt is the case
here, as it is a stupid thing to say in the context of Linux kernel
project), your "mention the branch name instead" would make sense.
