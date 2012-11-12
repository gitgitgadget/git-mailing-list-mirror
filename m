From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Mon, 12 Nov 2012 09:45:12 -0800
Message-ID: <7vwqxqiul3.fsf@alter.siamese.dyndns.org>
References: <5093DC0C.5000603@drmicha.warpmail.net>
 <20121108200919.GP15560@sigill.intra.peff.net>
 <509CCCBC.8010102@drmicha.warpmail.net>
 <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
 <509E8EB2.7040509@drmicha.warpmail.net>
 <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
 <509EAA45.8020005@gmail.com>
 <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
 <509FD9BC.7050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 12 18:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy4j-0006FI-0k
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab2KLRpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:45:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRpP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:45:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C83895B7;
	Mon, 12 Nov 2012 12:45:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AwS31jrOjSSLOzJu60i/nUMT57k=; b=qzHUpR5yC5L7w2g1qZy1
	+xSny2CHrEB+E4KzfcLFWlGykqZstDapQh/0IWqvMiPjNujuQ1VD+iEIoNkZWaKj
	8ihWEZtchuWUMqKMjNxN+LCTeTn1P9o19NFwt9XnU6XO9+xgkf9wj5i299BAAyzr
	enm1tDksGpCHLHkFkz9Nn/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jfiAUit/rJLD9JAmjdmvg+WcfXiCnXAiA44mdCWHqo/3nR
	u6M3gx9jRcqEx/0HC8McSfFalPC3emGQiW2kOghzIFtePcdiRwGQQYryiBfFWFIV
	zpKi3IsYPjPIwNJiURuGBXMISJ5qvliMz/j4fK5cs+anp0ONcHMInhX6btyO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29F5995B3;
	Mon, 12 Nov 2012 12:45:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 602AD95A5; Mon, 12 Nov 2012
 12:45:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6BB01CC-2CF0-11E2-9FD1-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209501>

A Large Angry SCM <gitzilla@gmail.com> writes:

> On 11/11/2012 07:41 AM, Felipe Contreras wrote:
>> On Sat, Nov 10, 2012 at 8:25 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>>> On 11/10/2012 01:43 PM, Felipe Contreras wrote:
>>
>>>> So, the options are:
>>>>
>>>> a) Leave the name conversion to the export tools, and when they miss
>>>> some weird corner case, like 'Author<email', let the user face the
>>>> consequences, perhaps after an hour of the process.
>>>>
>>>> We know there are sources of data that don't have git-formatted author
>>>> names, so we know every tool out there must do this checking.
>>>>
>>>> In addition to that, let the export tool decide what to do when one of
>>>> these bad names appear, which in many cases probably means do nothing,
>>>> so the user would not even see that such a bad name was there, which
>>>> might not be what they want.
>>>>
>>>> b) Do the name conversion in fast-import itself, perhaps optionally,
>>>> so if a tool missed some weird corner case, the user does not have to
>>>> face the consequences.
>>>>
>>>> The tool writers don't have to worry about this, so we would not have
>>>> tools out there doing a half-assed job of this.
>>>>
>>>> And what happens when such bad names end up being consistent: warning,
>>>> a scaffold mapping of bad names, etc.
>>>>
>>>>
>>>> One is bad for the users, and the tools writers, only disadvantages,
>>>> the other is good for the users and the tools writers, only
>>>> advantages.
>>>>
>>>
>>> c) Do the name conversion, and whatever other cleanup and manipulations
>>> you're interesting in, in a filter between the exporter and git-fast-import.
>>
>> Such a filter would probably be quite complicated, and would decrease
>> performance.
>>
>
> Really?
>
> The fast import stream protocol is pretty simple. All the filter
> really needs to do is pass through everything that isn't a 'commit'
> command. And for the 'commit' command, it only needs to do something
> with the 'author' and 'committer' lines; passing through everything
> else.
>
> I agree that an additional filter _may_ decrease performance somewhat
> if you are already CPU constrained. But I suspect that the effect
> would be negligible compared to the all of the SHA-1 calculations.

More importantly, which do users prefer: quickly produce an
incorrect result, or spend some more time to get it right?

Because the exporting tool has a lot more intimate knowledge about
how the names are represented in the history of the original SCM,
canonicalization of the names, if done at that point, would likely
to give us more useful results, than a canonicalization done at the
beginning of the importer, which lacks SCM specific details.  So in
that sense, (a) is more preferrable than (b).

On the other hand, we would want consistency across the converted
results no matter what SCM the history was originally in.  E.g. a
name without email that came from CVS or SVN would consistently want
to become "name <noname@noname>" or "name <name>" or whatever, and
letting exporting tools responsible for the canonicalization will
lead them to create their own garbage.  In that sense, (b) can be
better than (a).

I think (c) implements worst of both choices. It cannot exploit
knowledge specific to the original SCM like (a) would, and while it
can enforce consistency the same way as (b) would, it would be a
separate program, unlike (b).

So...
