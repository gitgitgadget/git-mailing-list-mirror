From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add --summary option to git-push and git-fetch
Date: Fri, 29 Jan 2010 17:17:06 -0800
Message-ID: <7vzl3w9yst.fsf@alter.siamese.dyndns.org>
References: <20090703044801.GA2072@cthulhu>
 <7viqiat965.fsf@alter.siamese.dyndns.org> <20090707015948.GA525@cthulhu>
 <h35bda$kgv$1@ger.gmane.org> <20090710022415.GA27274@cthulhu>
 <4A56EEBA.3070806@gmail.com> <20090711174156.GA17154@cthulhu>
 <7viqhzm454.fsf@alter.siamese.dyndns.org> <20100130005948.GA14938@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 02:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb21W-0003g2-HB
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0A3BRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925Ab0A3BRP
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:17:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab0A3BRO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:17:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 444D09597D;
	Fri, 29 Jan 2010 20:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sntSaiNlG5jr3IAD5s0/F4Y2Zs4=; b=sHUBuE
	GTvHpfpt/9jUyryPcmKbLgBaStLGMJK98BmYHS1CantT42kt917s9LdoaIBkos0R
	6x/HnffOh9QVNktp9Nm3Ds8VKzgXTqea9iVZC7EObASsIqkrbJ2X8F+uAQrGrTuv
	EI+7HSvTd7GSLsksEmXYoBbTPIKmHXFQvGHHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RkKusAuvwtpQGxuRuN13n4LBbYhej3BO
	irygOLhrYnDXH+HVLnRJWQ2uvgsAWBpoFJsFokH6oHcRJ2qWdKaLU6XT6FWkYSek
	scyYBf1AtoIc0l656XJcMkxW1V/wUETBWalzKDbX4mjBm5tikDWCUxmGM+M2EGhh
	bHIG0MYQS88=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 233489597C;
	Fri, 29 Jan 2010 20:17:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 529C19597B; Fri, 29 Jan
 2010 20:17:08 -0500 (EST)
In-Reply-To: <20100130005948.GA14938@cthulhu> (Larry D'Anna's message of
 "Fri\, 29 Jan 2010 19\:59\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3107B500-0D3D-11DF-B5DF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138418>

Larry D'Anna <larry@elder-gods.org> writes:

Please don't use M-F-T to deflect a direct response meant to you away from
you.  I also do not want people wasting _my_ time by following your M-F-T
and sending their comments meant to _you_ coming to me with my address on
To: line, as I prioritize incoming messages based on where my address is
in the header, and do not want you waste _other's_ time by making them
correct their "To:" like to avoid wasting my time.

>> > @@ -373,12 +379,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>> >  				fputc(url[i], fp);
>> >  		fputc('\n', fp);
>> >  
>> > -		if (ref)
>> > -			rc |= update_local_ref(ref, what, note);
>> > -		else
>> > +		if (ref) {
>> > +			*quickref = 0;
>> > +			rc |= update_local_ref(ref, what, note, quickref);
>> 
>> Makes me wonder why update_local_ref() does not put that NUL upon entry.
>
> I'm not sure what you mean.  Could you elaborate?

Why is it necessary for the caller to do "*quickref = '\0'" before calling
update_local_ref()?  Shouldn't your updated u-l-r be doing that clearing,
so that the callers don't have to worry about it?

>> > +	init_revisions(&rev, NULL);
>> > +	rev.prune = 0;
>> > +	assert(!handle_revision_arg(quickref, &rev, 0, 1));
>> > +	assert(!prepare_revision_walk(&rev));
>> > +
>> > +	while ((commit = get_revision(&rev)) != NULL) {
>> > +		struct strbuf buf = STRBUF_INIT;
>> > +		if (limit == 0) {
>> > +			fprintf(stderr, "    ...\n");
>> 
>> How would you know, when you asked 20 and you showed 20 here, that there
>> is no more to come?
>
> If there's more it will print the "...", if there isn't then it won't.

If your limit is 20 and if you unconditionally say "..." after pulling 20
from the pool, the consumer of your output would think "Ah, I see 20 but
that is only I asked for 20, and the ... means there are more".  But that
is incorrect because your 21st call to get_revision() might have yielded
NULL in which case you had only 20 after all.

You cannot do "..." correctly without pulling one more than the limit from
the pool.

>> > +test_expect_success 'fetch --summary forced update' '
>> > +	mk_empty &&
>> > +	(
>> > ...
>> > +	)
>> > +
>> > +'
>> 
>> There are at least two missing combinations. (1) "fetch --summary" to
>> fetch a new branch, and (2) "fetch --summary" does not try segfaulting by
>> accessing unavailable information after a failed fetch.
>> 
>> The same comment applies to the push side of the tests.
>
> What would be a good way to induce a failed fetch for this test?

Not having a valid ref or repo, perhaps.  I dunno---it's been quite a
while since I saw the patch.
