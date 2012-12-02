From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 p2 1/2] fast-export: don't handle uninteresting refs
Date: Sat, 01 Dec 2012 18:07:38 -0800
Message-ID: <7vsj7pmck5.fsf@alter.siamese.dyndns.org>
References: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
 <1354141440-26534-2-git-send-email-felipe.contreras@gmail.com>
 <8FA492C2-71B0-44AB-B816-AFB6C91DC01C@quendi.de>
 <CAMP44s08Jfu08oeABHcy=xPtn=LZfKTdbaRZuDbf7g+RiP7xAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <postbox@quendi.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:08:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeyyS-0003m7-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab2LBCHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:07:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2LBCHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:07:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4516A4D5;
	Sat,  1 Dec 2012 21:07:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HitCDiCqIJ+Hx+q+Xr8vpcaij5c=; b=MXsrg7
	TygKXufyhMT7FVlZF7LstHM5qwiOBM0xi1+p64dA7b9qR2CkY6g00Dm7l6O+DTtC
	xfvPPxFJMduB3ntx1WkRY9LmB24boEt1ntjSJ7i1zrpTG4QbMXhxg7sv+zeH27Ci
	LXQYldQ6+h1qaD+928hV2qBPk8Wna5DDwbXTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ew8VJGdH4GXyi/vpwhnyAcDaz8YAbK0J
	siC2Xjo5t3FWzBGYUbLCzUgl7HrEY50QTvvIN/ZgtIXrUfW6Qz/Efc1YYlimghpr
	b4nYMF/+bioWaYJfD/PV5ORJIyWEqLgKI5RsNrZS831PunW2p+bpUe1mAV/Fq87m
	ApLBhvanQFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B31B4A4D4;
	Sat,  1 Dec 2012 21:07:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A20DA4D3; Sat,  1 Dec 2012
 21:07:40 -0500 (EST)
In-Reply-To: <CAMP44s08Jfu08oeABHcy=xPtn=LZfKTdbaRZuDbf7g+RiP7xAA@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 30 Nov 2012 06:57:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CD3378A-3C25-11E2-AFEF-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210989>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Nov 29, 2012 at 2:16 AM, Max Horn <postbox@quendi.de> wrote:
>>
>> On 28.11.2012, at 23:23, Felipe Contreras wrote:
>>
>>> They have been marked as UNINTERESTING for a reason, lets respect that.
>>>
>>> Currently the first ref is handled properly, but not the rest:
>>>
>>>  % git fast-export master ^uninteresting ^foo ^bar
>>
>> All these refs are assumed to point to the same object, right? I think it would be better if the commit message stated that explicitly. To make up for the lost space, you could then get rid of one of the four refs, I think three are sufficient to drive the message home ;-).
>
> Yeah, they point to the same object.

Do you want me to amend the log message of that commit to clarify
this?

>> <snip>
>>
> ...
> It's actually revs.cmdline, I typed the wrong one.
> ...
> So I think it's good.

Wait.

I at least read two points above you said what you wrote in the
commit was not corrrect and misleading to later readers.  And then I
hear "it's good".  Which one?

Are you merely saying that it is easily fixable to become good?  If
so, what do you want to do with these not-so-good part?

If you want to ask me to amend, that is fine, but do so in a more
explicit way, not in a message at the tail of long thread that is
not even CC'ed to me.

Of course, a proper re-roll like everybody else does is just fine.

Thanks.
