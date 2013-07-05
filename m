From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Fri, 05 Jul 2013 01:44:07 -0700
Message-ID: <7vsizt8kh4.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
	<7v61wpbj2y.fsf@alter.siamese.dyndns.org>
	<20130705081307.GC32072@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1cl-0001vb-Un
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182Ab3GEIoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:44:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167Ab3GEIoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:44:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F5362A5BD;
	Fri,  5 Jul 2013 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qjx1O0LcfXAg/i5BOaH6b+UhInc=; b=MF9W+7
	14/5lBjQ53bSpULV1rKHN1OO7ula6D0Zf8T/heO46zvA3GQnjxFJznK3DkEViq8U
	j/bYwLwGZFVo0DvaO8q6aC/+K+PqvpwHSDe+7x2gkSYlbE8T0ggVADbOnqktP5yr
	zncDAuWyNpRpu1tO0O6EzgATjeS4j2vMb0meg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCOk9/RgYeMDfSvLEAhUI0fle5s0CX29
	DWsaifCWpHuMkraMKt6mhnKrabUI6JXrh8/ETIaBof339mkRk6pL4UIcZIODLoLc
	rXRdXKJDhS9drwHrN0NGBDWao4d2F7lkmm2ZJPDhd8pUjaY0L+Gsxgw3iYWX+BA0
	Q95pPBN8jGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3334E2A5BC;
	Fri,  5 Jul 2013 08:44:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 913BF2A5BB;
	Fri,  5 Jul 2013 08:44:08 +0000 (UTC)
In-Reply-To: <20130705081307.GC32072@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Fri, 5 Jul 2013 12:13:07 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EAE87AC-E54F-11E2-B142-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229640>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> Perhaps like this.
>> 
>>     Function 'test_format' has become harder to read after its
>>     change in de6029a2 (pretty: Add failing tests: --format output
>>     should honor logOutputEncoding, 2013-06-26).  Simplify it by
>>     moving its "should we expect it to fail?" parameter to the end.
> I'm not sure whether this "last parameter" is needed in that code as far as we
> already removed expected to fail tests

Whatever.

The above is an example of justifying a more vague "simple" ("is
better" is implied) with a concrete point (i.e. By moving that to
the end, you removed the need to conditionally shift $@ in the
function to simplify the codepath), based on my _guess_ of what you
possibly meant to say, from reading your description that did not
give much clue for me to guess why you thought the result was "more
elegant".  If my guess missed what your true justification was,
please replace it with the more correct one ;-)

>> I cannot read why you think the updated commit_msg is "more pretty"
>> in the message or in the patch.
>> 
>> > -commit_msg () {
>> > -	# String "initial. initial" partly in German (translated with Google Translate),
>> > +commit_msg() {
>> 
>> Style.  Have SP on both sides of () in a shell function definition.
> Could you point me to the coding style guide, please?

Documentation/CodingGuidelines::

 - We prefer a space between the function name and the parentheses. The
   opening "{" should also be on the same line.
   E.g.: my_function () {
