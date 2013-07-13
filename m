From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sat, 13 Jul 2013 11:14:19 -0700
Message-ID: <7vwqougwec.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
	<7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jul 13 20:14:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy4L5-0004p4-0z
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 20:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178Ab3GMSOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 14:14:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758110Ab3GMSOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 14:14:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E4A30BDF;
	Sat, 13 Jul 2013 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TbCIL+SMs52PlwyT+EiFUF6/fCA=; b=oAXZds
	Owqm/VUIO44HXey7BsAjkwZYZb5pkV2iWYY11Uh6tWcrmrcb3pBGyE/AD58Uwl6N
	s4rWahGmozs6uhA5ZC4v6Jw2Qm6sli2cuTDiqN12BC7zar8LBb6s4F8zpK0H4Yg8
	1OarC2dbNwyXmYeeGKCZB4TLAHRgxyzcboFCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6+byK2SGgE2QN6bGXL4+mffCh07dkO2
	nSXvGS41ftcYmo+ppKq9O66BAyYjg8TnmvrpDo0AweihHkpcO2qOtnc124dZbyw4
	OBGO/cmaLSfGDugFp8zKA0MRUbYii01njCuQ0Bo2RzBng06BQxHomsJyS4Tj6Vfh
	4mJ1/kgt7lE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B1530BDE;
	Sat, 13 Jul 2013 18:14:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 059FC30BDD;
	Sat, 13 Jul 2013 18:14:20 +0000 (UTC)
In-Reply-To: <51E0F93A.8050201@kdbg.org> (Johannes Sixt's message of "Sat, 13
	Jul 2013 08:52:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A2F151C-EBE8-11E2-ACAC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230286>

Johannes Sixt <j6t@kdbg.org> writes:

> I am suggesting that +refspec would *not* override the match/mismatch
> safety, but --force would.

OK.

I earlier did not read from your message that you wanted to change
"+refspec" to mean "allow non-ff push", so the two entries in your
table:

>                        ff   noff     ff      noff
>                       match match mismatch mismatch
>
> --lockref +refspec     ok    ok    denied   denied
> --lockref  refspec     ok  denied  denied   denied

did not make sense to me.  If you are making "+refspec" to mean
"--allow-no-ff refspec", then above is at least internally
consistent.

>> Let's look at noff/match case.  That is the only interesting one.
>> 
>> This should fail:
>> 
>> 	git push topic
>> 
>> due to no-ff.
>
> Yes.
>
>> Your table above makes this fail:
>> 
>>         git push --lockref topic
>> 
>> and the user has to force it,
>
> Of course.
>
>> like this?
>> 
>> 	git push --lockref --force topic ;# or alternatively
>>         git push --lockref +topic
>> 
>> Why is it even necessary?

> Because it is no-ff. How do you achieve the push today (without
> --lockref)? You use one of these two options. It does not change with
> --lockref.

But by going that route, you are making --lockref _less_ useful, no?

"git push topic" in no-ff/match case fails as it should.  The whole
purpose of "--lockref" is to make this case easier and safer than
the today's system, where the anything-goes "--force" is the only
way to make this push.  We want to give a user who

 - rebased the topic, and

 - knows where the topic at the remote should be

a way to say "I know I am pushing a no-ff, and I want to make sure
the current value is this" in order to avoid losing somebody else's
work queued on top of the topic at the remote while he was rebasing.

You _CAN_ introduce a new --allow-no-ff at the same time and fail a
no-ff/match push:

	git push --lockref topic

and then allow it back with:

	git push --lockref --allow-no-ff topic
	git push --lockref +topic ;# +topic is now --allow-no-ff topic

but why _SHOULD_ we?  As soon as the user _says_ --lockref, the user
is telling us he is pushing a no-ff.  If that is not the case, the
user can push without --lockref in the first place.

The only potential thing you are gaining with such a change is that
you are allowing people to say "this will fast-forward _and_ the I
know the current value; if either of these two assumptions is
violated, please fail this push".

If "--lockref" automatically implies "--allow-no-ff" (the design in
the reposted patch), you cannot express that combination.  But once
you use "--lockref" in such a situation , for the push to succeed,
you know that the push replaces not just _any_ ancestor of what you
are pushing, but replaces the exact current value.  So I do not think
your implicit introduction of --allow-no-ff via redefining the
semantics of the plus prefix is not adding much value (if any),
while making the common case less easy to use.

> No; --lockref only adds the check that the destination is at the
> expected revision, but does *NOT* override the no-ff check.

You _could_ do it in that way, but that is less useful.
