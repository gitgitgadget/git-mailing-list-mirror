From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add a range option to -L
Date: Sun, 02 May 2010 08:23:35 -0700
Message-ID: <7vvdb6uy2w.fsf@alter.siamese.dyndns.org>
References: <1272662989-563-1-git-send-email-wfp5p@virginia.edu>
 <20100502091433.GA1854@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Pemberton <wfp5p@virginia.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 17:23:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8b1K-0002St-6U
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab0EBPXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 11:23:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab0EBPXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 11:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDC2B0789;
	Sun,  2 May 2010 11:23:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6MiCJ9u6sTVw
	jsES2gLvX3oU1eg=; b=n2w+ehSS5ocHDpNHHgoRT32+1tmre86lTO0ldKnc9IYS
	mfjdI4MKhL32n3h1l25ed7OfhwSg1wX7YYls5Go0/OWpyIOwIa+SqLthKyWhiKfd
	2vJsruE1Tq/wAPEx92Vl07AstwJMGXa2VnTxxi6zQrp7KEqyl299IdEa/x8Zgkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o7v9gf
	zigYNnZxacBJpPxb9BrGBVDj8e9vAAq8XmyJbOS6XhHBtQ/2T7cvtbWE2gfeEVQT
	+yGpcSZ+f16KyTTN9SDzv4KpXOmP6rQXQH4/fI+oiVxM5WIephyaRlpVRDZb5eDo
	4zMM79s/r3rpwbKFFUmqgnhEyCocbDo2dw8ic=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C743B0788;
	Sun,  2 May 2010 11:23:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55876B0783; Sun,  2 May
 2010 11:23:36 -0400 (EDT)
In-Reply-To: <20100502091433.GA1854@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 2 May 2010 04\:14\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF940FC2-55FE-11DF-B553-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146184>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Bill Pemberton wrote:
>
>> In addition to + and - you can now use r to specify how many lines
>> around <start> that you want to see.  For example: -L 20,r5 would sh=
ow
>> lines 15 through 25
>
>>From too much exposure to subversion, the r suggests =E2=80=9Crevisio=
n=E2=80=9D.
> But =C2=B1 is too hard to type, so I guess r will have to do.

I am not interested in this patch very much myself, and after thinking
about it, I think my dislike largely comes from this syntax, and not fr=
om
the feature itself.  Any non-punctuation letter there looks like a sore
thumb.  Either "-L 20=C2=B15" or even "-L 20+/-5" would have looked a _=
lot_
saner.

>> +++ b/Documentation/blame-options.txt
>> @@ -32,6 +32,12 @@ This is only valid for <end> and will specify a n=
umber
>>  of lines before or after the line given by <start>.
>>  +
>> =20
>> +- rrange
>
> Maybe -rradius?  =E2=80=9Crange=E2=80=9D sounds like an interval with=
 specified endpoints.

Yes, radius sounds more sensible.  Another alternative would be to call=
 it
"context", as in "grep -C <n>".
