From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 13:12:33 -0700
Message-ID: <7vzkxarqry.fsf@alter.siamese.dyndns.org>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
 <20100729021946.GG25268@spearce.org>
 <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
 <C77AA970-4288-487F-9568-E86CF776FCED@gmail.com>
 <AANLkTikpLHdMzbpix8jnyS6YwSkgie=Ts44AJP5dA4=T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 22:12:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeZTL-0006pz-1o
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab0G2UMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 16:12:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0G2UMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 16:12:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F602C9F65;
	Thu, 29 Jul 2010 16:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TR3hHA306d82
	6NOZyK+vdvHxrl4=; b=DoP+dngmn16b93qKkgpPz5Ay7427IDGIWCcHbSklvzS5
	l/UEQpW/RlAP5kFGL/bFx4c5/+wZnqcOZb5ojxWauxZJAipq3O9bA9MeatvOvGRT
	KP+tl3+tqPOqrFz/hsOXpcwRqwD2cJ5eqh2zQr9NTjpfmcAvlWTZqKDFo9XQJcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WKqsKC
	nYOEKC9KHY1uXEZELqWB5EQunutqQDx76Iph3dQ9XzuYn/eBbp8DMLr82MwN+VgI
	g4SZHRF1HQwZbQbTakpax0B96UYKN9Csf14bZ26X8zUZHEugX3TKTnieb1FBEfGc
	okweRSI1af/HkcYRwcttyeyvnA209YYkT3vYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8EC8C9F5C;
	Thu, 29 Jul 2010 16:12:41 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77679C9F5B; Thu, 29 Jul
 2010 16:12:35 -0400 (EDT)
In-Reply-To: <AANLkTikpLHdMzbpix8jnyS6YwSkgie=Ts44AJP5dA4=T@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 29 Jul 2010 13\:22\:01 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A45AE81C-9B4D-11DF-9627-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152195>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Thu, Jul 29, 2010 at 13:10, Joshua Juran <jjuran@gmail.com> wrote:
>> How about if you had two (or more) components with a shared protocol=
, and
>> you updated each to speak a new (and incompatible) protocol. =C2=A0T=
he changes to
>> each component might be done in separate topic branches, but you'd w=
ant to
>> merge them all at once.
>>
>> $ git checkout master
>> $ git merge client-v2 server-v2
>
> Very nice example, but do we have it _documented_ anywhere? If not, i=
t
> would be great if you could add that somewhere :)

Please don't.

I actually do not think the "client-server" is a good example from
software engineering point-of-view, as it means that everybody talks
version 1 before that merge and everybody talks version 2 after that
merge, i.e. you have a flag day event.

Think for 5 seconds how one would have tested client-v2 topic alone in
isolation.

The only transition plan that works in real life is for the updated cli=
ent
to talk fine with a server without version 2 support, while being prepa=
red
to talk the newer protocol if the server supports it.  The server side
needs to be arranged in a similar way.

If that is how these topics were developed, you should be able to merge
client-v2 topic and then server-v2 topic, or in the other order, withou=
t
breaking anything on the master branch.

The original idea of Octopus was that, when

 (1) you have many topics that are not inter-related; _and_

 (2) merging all of them in any random order wouldn't have made any
     difference in the resulting history, either in the end result nor =
in
     any of the intermediate steps,

it is not worth to serialize the merge order and create extra merge
commits.

I think we tend to discourage the use of Octopus these days, as people =
are
fallible.  When topics that they originally thought are independent tur=
n
out to have funny interactions among each other, having an Octopus merg=
e
across them tends to make bisection much less efficient in order to fin=
d
the real culprit in the history when you find something is broken.

Compared to that downside, it is not worth to use an Octopus, only to h=
ave
a smaller number of merge commits and a cool-looking lantern-shaped mer=
ge
commit in the history.
