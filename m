From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sat, 09 Feb 2013 15:35:35 -0800
Message-ID: <7vy5ext60o.fsf@alter.siamese.dyndns.org>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net> <7v8v6xw3wf.fsf@alter.siamese.dyndns.org> <20130209232455.GA31027@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JzM-0003SK-8y
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760877Ab3BIXfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:35:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760874Ab3BIXfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:35:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C391B764;
	Sat,  9 Feb 2013 18:35:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ww9u8ZU3F+AIY3vqwWGpIFUbn40=; b=R32TMB
	WbSZ2KpfMg+4ryQW4rhufnE/ebq6ze0tAilC3PdLxm56bYZwQ20AKiS6rCghE1vr
	EWpySc2CzZOSuGMhCe+IiWmqZjIdxz9Hwpz/ke0FlTiFwEj9+deAot1eEwyAwGju
	eUPq2tzQ0Lfn6biiBTRVu/kBSzWRCfIhmpUPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ABKqCR7aYtlqH8Q2cZOyd4FArLa3YBJq
	a5QRIrTIWJAXH1XLAWBrKhhYFJNcLFxbjYYXorLpQgajNeAix6l/8WN3Q7AvrZxf
	R0VySLTCjYYLLzaXHjFU7pcuxVOsTTukwrk9r2lowt2HAaGUDZBMuABDP9zJ4z+p
	zDr+G889UDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4093DB762;
	Sat,  9 Feb 2013 18:35:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FDF9B760; Sat,  9 Feb 2013
 18:35:36 -0500 (EST)
In-Reply-To: <20130209232455.GA31027@rhlx01.hs-esslingen.de> (Andreas Mohr's
 message of "Sun, 10 Feb 2013 00:24:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67BD36D2-7311-11E2-A30D-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215884>

Andreas Mohr <andi@lisas.de> writes:

> On Sat, Feb 09, 2013 at 01:53:04PM -0800, Junio C Hamano wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> >  After a bisect session, to clean up the bisection state and return to
>> > -the original HEAD, issue the following command:
>> > +the original HEAD (i.e., to finish bisect), issue the following command:
>> 
>> Makes sense.
>
> Doesn't ;)
>
> [aww, very sorry for this blunt reply]
>
> The main point of my mail was to stretch the (whether actually intended)
> *perceived* start <-> stop symmetry

Actually, in that sense, I do no think finish is exactly a good
wording.  The majority of use case would be to finish up after you
found the sole culprit, so in that sense "finish" is not too bad,
but in general, when you "reset", there is not necessarily any
symmmetry with "start".  We should definitely not be giving you an
illusion that there is one by using "stop" [*1*].

It is more like "abort".

I may be done with bisection after running the bisection to the very
end, of I may have realized that the problem is not bisectable due
to many reasons (e.g. the sympotom may be intermittent, or it has
already become apparent that there are more than one cause of the
observed breakage) way before we found "the first bad commit".

And "reset" cleans the bisectoin state and returns to the original
HEAD, regardless of the reason why you are cleaning up.  If we were
to add any explanation to the sentence, I think "finish" makes a lot
more sense than "stop".


[Footnote]

*1* another reason to avoid "stop" is that it could mean "I stop
here for now, to later come back and start digging again from
there", which is not "reset" is about at all.
