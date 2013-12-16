From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 11:37:06 -0800
Message-ID: <xmqqsitsoae5.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
	<20131128092935.GC11444@sigill.intra.peff.net>
	<CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
	<20131204200850.GB16603@sigill.intra.peff.net>
	<CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
	<20131205160418.GA27869@sigill.intra.peff.net>
	<20131205202807.GA19042@sigill.intra.peff.net>
	<52AEAEB2.6060203@alum.mit.edu>
	<20131216190445.GB29324@sigill.intra.peff.net>
	<20131216191933.GE2311@google.com>
	<20131216192830.GA30238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:37:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsdyh-0004qZ-55
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab3LPThN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:37:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787Ab3LPThL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:37:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217685BBD3;
	Mon, 16 Dec 2013 14:37:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MiaurPbKIDu5KzX3xfYdIo7pexI=; b=fwZgZT
	waYdcQ2+43fEAWqOE2WAAXnnrjFdKl6QY6Co9pCTYn13f3Xh6einq9DViYRwKcCl
	ksfcsV+uUBJ+4Ki0s7bkkopXbXi2oNu0oz0BO5TaRs/EdvCPXgXuvvml0TnKKJqB
	nVMJYCQseWpyzaBtSefbpylDZTxUH2mUcdQ/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XcUdrXMXoizl8khFB/EMOFh0fxfnFoir
	t0SYOEZh8xIUXb528yNjD7a+NvnBSiiTYavgc5W0gIhwMvp1vTzsjYFbKFB+uarn
	sU0Xwe87kIc394d7Ts2lWCFpr+UDiI46/UDPY2/JGhhUJwwQYGm378IEemh/O+zg
	E7/t9B0hpnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F805BBD2;
	Mon, 16 Dec 2013 14:37:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E69BD5BBD1;
	Mon, 16 Dec 2013 14:37:09 -0500 (EST)
In-Reply-To: <20131216192830.GA30238@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 16 Dec 2013 14:28:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 745549C2-6689-11E3-9DAA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239356>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 16, 2013 at 11:19:33AM -0800, Jonathan Nieder wrote:
>
>> >              I was tempted to explicitly say something like "this is
>> > opaque and meaningless to you, don't rely on it", but I don't know that
>> > there is any need.
>> [...]
>> > On top of jk/name-pack-after-byte-representations, naturally.
>> 
>> I think there is --- if someone starts caring about the SHA-1 used,
>> they won't be able to act on old packfiles that were created before
>> this change.  How about something like the following instead?
>
> Right, my point was that I do not think anybody has ever cared, and I do
> not see them starting now. But that is just my intuition.
>
>> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
>> index d94edcd..cdab9ed 100644
>> --- a/Documentation/git-pack-objects.txt
>> +++ b/Documentation/git-pack-objects.txt
>> @@ -51,8 +51,7 @@ base-name::
>>  	<base-name> to determine the name of the created file.
>>  	When this option is used, the two files are written in
>>  	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
>> -	of the sorted object names to make the resulting filename
>> -	based on the pack content, and written to the standard
>> +	based on the pack content and is written to the standard
>
> I'm fine with that. I was worried it would get clunky, but the way you
> have worded it is good.

Our mails crossed; I think the above is good.

Thanks.
