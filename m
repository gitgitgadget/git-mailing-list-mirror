From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t7508-status: test all modes with color
Date: Tue, 08 Dec 2009 21:32:35 -0800
Message-ID: <7vzl5sww3w.fsf@alter.siamese.dyndns.org>
References: <cover.1260266027.git.git@drmicha.warpmail.net>
 <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net> <hflc82$sf8$1@ger.gmane.org> <4B1E798C.5050204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 06:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIFAS-0002lD-F1
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 06:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbZLIFcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 00:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbZLIFcj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 00:32:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbZLIFci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 00:32:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7750A5D40;
	Wed,  9 Dec 2009 00:32:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5EkMUU6hzdvxgfqK+liopMAZK4=; b=BMNcK+
	T3ELJlgX9IG2VZ6xwszwXOfyW4QSDvfByiiGSM0PwANQTooOQXggMj+3uEEwPDCa
	eNSLfWBkIccHw6syrjWvOkeIt2wv1dJmTcyBNb/O4oe0u7sI4h75KZHT7jnIan1f
	DHt8bnpUVPd3xsVi4jffJVlxP7zFxkHsDGDBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J5Mq8BUM1+o+Dx1afEP8dgvb3/tgiLNe
	fh/7VHiuntOnprkv16mHRCI18FiKTqXjWp5D+QuQHzhOXn3ENCXA+b9E7mdUAFMH
	WY8zaOgOYcOGN3JyigmMEfhTmddO9AuIPELfldAuabJnD8X8qIl5g/oxYlxbYPTl
	o7wZMqrngFk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9680EA5D3F;
	Wed,  9 Dec 2009 00:32:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21C3AA5D3E; Wed,  9 Dec 2009
 00:32:36 -0500 (EST)
In-Reply-To: <4B1E798C.5050204@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue\, 08 Dec 2009 17\:06\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45361896-E484-11DE-8160-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134938>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jakub Narebski venit, vidit, dixit 08.12.2009 12:10:
>> Michael J Gruber wrote:
>> 
>>> +decrypt_color () {
>>> +       sed \
>>> +               -e 's/.\[1m/<WHITE>/g' \
>>> +               -e 's/.\[31m/<RED>/g' \
>>> +               -e 's/.\[32m/<GREEN>/g' \
>>> +               -e 's/.\[34m/<BLUE>/g' \
>>> +               -e 's/.\[m/<RESET>/g'
>>> +}
>> 
>> Shouldn't this be better in test-lib.sh, or some common lib 
>> (lib-color.sh or color-lib.sh; we are unfortunately a bit inconsistent
>> in naming here)?
>
> Well, so far it's used in two places (and somewhat differently). I would
> say test-libification starts at 3 :)

That is a pretty lame excuse and is a bad way to keep things maintainable.

Having two copies now means that you will *double* the chance for the next
person to copy and paste one of the existing copies that are found in the
non-library-ish part of the test script set to create the third duplicate,
without even realizing that there already are two copies that should have
been consolidated in the first place.  The worst part is that once that
duplication is pointed out, s/he will use the existing two copies as an
excuse for copy and paste.

Please don't.
