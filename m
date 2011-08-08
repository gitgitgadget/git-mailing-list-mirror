From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 10:47:47 -0700
Message-ID: <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 08 19:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqTvh-0005Zg-6X
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 19:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1HHRry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 13:47:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab1HHRrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 13:47:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1A184778;
	Mon,  8 Aug 2011 13:47:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aAlqicyDmtPtlfQvKv1dyKfXFnk=; b=bOl9bd
	5qSf2zkgmVrJfcpLN6NqfhdogPqSrSL19vj9AYp0ZErVjab+t+fpGkWA9f9G0W/a
	KWVbnvQB65NN6dWq0IG9DjoEM10gD4VlyQUbW71d0OwCP4iFuVUinIhJdPa9yUgV
	5xDlGKpCUTdY2BlXMDWTg/HqGsIXzldTtyiPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLJfrmvOpM85G2r6D0m7eZywruMJG5+S
	Ip1U/U541Y5AMIUnXQjTzfgPKmC2xpYpH4+fETi69kGOlBx6oUK40ShXNMLENV4/
	jSTfkKu3PgSYB1Wh987dVNilDyxtg5OqfHV9E0XqmO93JqHWFRs6hU38JKf/ogkQ
	P0qZBcDelhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B1E4777;
	Mon,  8 Aug 2011 13:47:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E2874776; Mon,  8 Aug 2011
 13:47:49 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Mon, 8 Aug 2011 18:22:48 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 883B1B96-C1E6-11E0-82AF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178965>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 3 Aug 2011, Junio C Hamano wrote:
>
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> 
>> > On Sun, Jul 24, 2011 at 21:23, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> >>
>> >>>  void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
>> >>>  {
>> >>> -     add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
>> >>> +     add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
>> >>>  }
> ...
> If you do that, you're back to start. Since obj has not the faintest clue 
> whether the pending object was added from a negative or a positive ref.

But the point is that this codepath does not have a faintest clue whether
the "obj" parameter is something the end user actively asked for (which
might have been marked as uninteresting for other reasons, namely, because
it is reachable from other negative refs). So passing unconditional 0 is
just as bad.

>> Wouldn't it be wonderful if the revision machinery left richer clue in
>> each element of the pending object array while parsing, so that the caller
>> does not have to guess?
>
> That is what we are trying to solve, and rather than to reuse the "mode" I 
> thought that it'd be wiser to add new "flags".

I never thought about nor suggested touching "mode" ;-) It does not have
enough width for the necessary information.

> Many of the richer clues you refer to could be expressed as such flags, 
> including the problem I need to address.
>
>> In addition to a single "mode" integer, which says if it is supposed to 
>> be a tree or a blob, we could allocate a single structure that records... 
>
> Is this not a little bit of a big, huge, tremendous overkill?

As long as you can show your "flags" can (be extended to) express the same
richness to solve sample problems I mentioned in my response, as well as
your immediate issue, I wouldn't insist implementing a parsed struct/union
that may be a more (and unnecessarily) verbose way to say the same thing.

> Or in other words: I'd rather stay with a simple, elegant, minimal patch 
> that solves the problem at hand while not preventing future enhancements.

We are on the same page, but what I read from the patch didn't show a
clear way forward to extend the "flags" to allow the stuff I mentioned
(and the stuff I didn't but obviously fall into the same category of "we
wish revision parsing machinery left us richer information").

> Also remember that the pending objects array is used for the complete 
> object traversal.

My reading and rememberance of the code around add_parents_to_list() must
be quite different from yours. It is not 2006 anymore.

We didn't even have a separate pending object list type until 1f1e895 (Add
"named object array" concept, 2006-06-19) and used the same object_list,
whose element size _did_ matter as you mention. But that commit allowed us
to give elements on the pending list that came directly from the end user
richer semantics than those of the object_list that we discover during the
traversal, and that is why back at e5709a4 (add add_object_array_with_mode,
2007-04-22) we gave more information to it without having to fatten
object_list elements.

> The only way to convince me to do that complicated stuff is by 
> blackmailing me, stating that I cannot have a working remote-hg without 
> doing all this nested/union/self-referential struct work I don't need.

I would be reluctant to accept a myopic hack that is only good for one
caller and that needs to be ripped out and re-done, especially when we
already know other issues that can be solved cleanly if you go a little
further in the initial round.

As I said, I am not married to the verbose struct/union representation
(the only reason I showed that verbosity was because it allowed me to do
away without having to enumerate all the syntax sugars we already
support); if your "flags" can express the same thing (it may needs to
become a bitfield with enough width, but I highly suspect that you would
also need at least a component that says "this is the string the user gave
us --- the user said 'master', not 'master^0', for example) and is a lot
more compact, that is definitely we want to go with.

Thanks.
