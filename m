From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Tue, 03 Sep 2013 10:06:19 -0700
Message-ID: <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
References: <20130826165747.GA30788@redhat.com>
	<20130831192250.GA3823@redhat.com>
	<20130903063535.GA3608@sigill.intra.peff.net>
	<20130903084454.GC18901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu3f-0005S1-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab3ICRGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:06:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3ICRGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:06:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E773F4B0;
	Tue,  3 Sep 2013 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fe6tU74oDjnK69Q8o74J6mpaLyo=; b=GlQNu3
	XOr5gzuW6MKF4x0ployU6dqx8dRm5iM57EOtM+l+Cs2Wk0PJitxhNvcfiMYFPieX
	ITXH6CPdDVKJ/jP0dqpr9YqK5RCwLNo8CLs+L0gF++cVnmQj9qMxIRassJrC6t93
	eKx+zmoqKDuroosAB0FCLBROaJ2Nsc4ckUiz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MEh8AwEUB+wBPQOALPh0mDCa0j7zhVVC
	mTMSKTvA9RhmMhtwmoUL3LQZ/CpotqbZpBCdv6R2P2xkjqgBTOaG148dcFrG+Kng
	zOsTeVgM7V/JsXyQX6t0bRu6LM3Ao5SLh2nxkMZgHdinw7WW8MpcAYbpfOfdrde4
	Qibs/8vvGAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66F5B3F4AC;
	Tue,  3 Sep 2013 17:06:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C0953F4A0;
	Tue,  3 Sep 2013 17:06:21 +0000 (UTC)
In-Reply-To: <20130903084454.GC18901@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 3 Sep 2013 11:44:54 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 280736FE-14BB-11E3-8146-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233739>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Sep 03, 2013 at 02:35:35AM -0400, Jeff King wrote:
>> On Sat, Aug 31, 2013 at 10:22:50PM +0300, Michael S. Tsirkin wrote:
>> 
>> > On Mon, Aug 26, 2013 at 07:57:47PM +0300, Michael S. Tsirkin wrote:
>> > > Consider [anything]-by: a valid signature.
>> > > This includes Tested-by: Acked-by: Reviewed-by: etc.
>> > > 
>> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > 
>> > Ping.
>> > Any opinion on whether this change is acceptable?
>> 
>> I was left confused by your commit message, as it wasn't clear to me
>> what a "signature" is. But the point of it seems to be that people
>> mention others in commit messages using "X-by:" pseudo-headers besides
>> "signed-off-by", and you want to cc them along with the usual S-O-B.
>> 
>> That seems like a reasonable goal, but I have two concerns.
>> 
>> One, I would think the utility of this would be per-project, depending
>> on what sorts of things people in a particular project put in
>> pseudo-headers.  Grepping the kernel history shows that most X-by
>> headers have a person on the right-hand side, though quite often it is
>> not a valid email address (on the other hand, quite a few s-o-b lines in
>> the kernel do not have a valid email).
>> 
>> And two, the existing options for enabling/disabling this code all
>> explicitly mention signed-off-by, which becomes awkward. You did not
>> update the documentation in your patch, but I think you would end up
>> having to explain that "--supress-cc=sob" and "--signed-off-by-cc"
>> really mean "all pseudo-header lines ending in -by".
>> 
>> So I think it might be a nicer approach to introduce a new "suppress-cc"
>> class that means "all pseudo-header tokens ending in -by" or similar.
>> We might even want the new behavior on by default, but it would at least
>> give the user an escape hatch if their project generates a lot of false
>> positives.
>> 
>> -Peff
>
> I guess there's always cccmd, no?

I am having a hard time deciphering what this response means.  Are
you suggesting that people can use cccmd to do what your patch
wants to do, so the patch is not needed?

I tend to agree with Peff that it is a reasonable goal to allow more
than just the fixed set of trailers to be used as a source to decide
whom to Cc, and if it can be generic enough, it would make sense to
supply users such support so that various projects do not have to
invent their own.

The question of course is the first point Peff raised.  I am not
sure offhand what the right per-project customization interface
would be.  A starting point might be something like:

	--cc-trailer=signed-off-by,acked-by,reviewed-by

or even

	--cc-trailer='*-by'

and an obvious configuration variable that gives the default for it.
That would eventually allow us not to special case any fixed set of
trailers like S-o-b like the current code does, which would be a big
plus.
