From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Wed, 29 May 2013 09:52:56 -0700
Message-ID: <7vr4gpvic7.fsf@alter.siamese.dyndns.org>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
	<1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
	<7vvc6311dr.fsf@alter.siamese.dyndns.org>
	<51a56a31947d6_807b33e1899765@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 18:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhjcX-0004ji-LA
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119Ab3E2QxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:53:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757827Ab3E2Qw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 109B322FE5;
	Wed, 29 May 2013 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0sKzE4493rNpRqkxa1Rp+Z+8qzc=; b=iZQE4x
	xZQnmoGOwe9e1p9rtZPdub+vJimtugU+o4MY6E50AcGcnERifm1xfqry+3zGdaJk
	tcQlVYd4rh4H1FyuphXxsmsJKMNVGktiXwmmx3oKqSFYPb5ikySup/wwz0Sx+gOK
	Wm0QtM/detj0yrNCwbOmBeDkLR9iRC30p7NXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orTd/1bZnDgprlrShoGHCOjBTFBummgO
	hSqpsIUAAhPk+9cqLwC+IQRKzSI8SCR5s0W8ikkuJBqOx+ort/16hnyPxYnzh5qV
	eXrMpT5+QxrZVxIwuq5eOEnzIMHpXa+yFQI7/EKMt30bp8NnIH5a1crk3hnPVyYO
	hAprKw/AL1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0267A22FE4;
	Wed, 29 May 2013 16:52:59 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BA8122FE3;
	Wed, 29 May 2013 16:52:58 +0000 (UTC)
In-Reply-To: <51a56a31947d6_807b33e1899765@nysa.mail> (Felipe Contreras's
	message of "Tue, 28 May 2013 21:38:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 374FB03C-C880-11E2-B8BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225841>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Let's show the output so it's clear why it failed.
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > ---
>> >  t/t3400-rebase.sh | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> > index b58fa1a..fb39531 100755
>> > --- a/t/t3400-rebase.sh
>> > +++ b/t/t3400-rebase.sh
>> > @@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
>> >  test_expect_success 'rebase -q is quiet' '
>> >  	git checkout -b quiet topic &&
>> >  	git rebase -q master >output.out 2>&1 &&
>> > +	cat output.out &&
>> >  	test ! -s output.out
>> >  '
>> 
>> It is one thing to avoid squelching output that naturally comes out
>> of command being tested unnecessarily, so that "./txxxx-*.sh -v"
>> output can be used for debugging.  I however am not sure if adding
>> "cat" to random places like this is a productive direction for us to
>> go in.
>> 
>> A more preferrable alternative may be adding something like this to
>> test-lib.sh and call it from here and elsewhere (there are about 50
>> places that do "test ! -s <filename>"), perhaps?
>> 
>>         test_must_be_an_empty_file () {
>>                 if test -s "$1"
>>                 then
>>                         cat "$1"
>>                         false
>>                 fi
>>         }
>
> Perhaps, but I'm not interested. I'm tired of obvious fixes getting rejected
> for hypothetical "ideal" situations that we'll never reach.

That's too bad.  Addition of "cat" where there does not need one is
clearly not an obvious fix anyway.
