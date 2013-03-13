From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 09:45:47 -0700
Message-ID: <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
References: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org> <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFook-0005Ik-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179Ab3CMQpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 12:45:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933151Ab3CMQpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:45:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF3DA924;
	Wed, 13 Mar 2013 12:45:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3S+x15agXOzSzi7t4sJQ4C5QdSk=; b=KSoP1c
	CGsChVBQuDB0TgO6iKqH1Kv2bKZmkbnYsPId0hA36AP40q9du/iVo4+X8vK0VEdb
	3Yqo7RMGCFSwECwDgZDQIIZtJCp+QblUW/LNCJCQiXU51g0C39xM2GorZ30M6IWR
	XBEHTngoPLbQHXWEuxE43Wo63Seu5k1IYIWMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Et8sjYQ+LFzkFDCeS6T2GkRrZshjA7Yv
	maE78vcSMcyN3G1xt6OpZlKoyn676l2lGzGv9oi2i7wWfc8ZHRZVu3MEQC3BAXOz
	YDrJ1kOE4mm+F8OzKo8gqJ3MNJMxmCZY9nOXtIsPYCTkmXMf/7NlksfgL0i1L579
	qSvLzO9QW50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31091A922;
	Wed, 13 Mar 2013 12:45:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FCDA91D; Wed, 13 Mar 2013
 12:45:49 -0400 (EDT)
In-Reply-To: <7vtxof48sg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 13 Mar 2013 08:30:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75E91FDC-8BFD-11E2-BC79-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218069>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>>> The implementation of Junio's suggestion is relatively straightforward
>>> (this is untested, although t7800 passes, and can probably be improved
>>> by someone better versed in Perl).  Does this work for your original
>>> scenario?
>>
>> This is a nice straightforward approach.
>>
>> As Junio mentioned, a good next step would be this patch in
>> combination with making the truly temporary files created by
>> dir-diff readonly.
>
> Even though I agree that the idea Matt McClure mentioned to run a
> three-way merge to take the modification back when the path checked
> out to the temporary tree as a temporary file (because it does not
> match the working tree version) gets edited by the user might be a
> better longer-term direction to go, marking the temporaries that the
> users should not modify clearly as such needs to be done in the
> shorter term.  This thread wouldn't have had to happen if we had
> such a safety measure in the first place.

One thing I forgot to add.  I suspect the patch in the thread will
not work if the path needs smudge filter and end-of-line conversion,
as it seems to just hash-object what is in the working tree (which
should be _after_ these transformations) and compare with the object
name.  The comparison should go the other way around.  Try to check
out the object with these transformations applied, and compare the
resulting file with what is in the working tree.

Does the temporary checkout correctly apply the smudge filter and
crlf conversion, by the way?  If not, regardless of the topic in
this thread, that may want to be fixed as well.  I didn't check.
