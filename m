From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 17:55:54 -0700
Message-ID: <7vpqys5het.fsf@alter.siamese.dyndns.org>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
 <7vocec6xlt.fsf@alter.siamese.dyndns.org>
 <7viq4k6xea.fsf@alter.siamese.dyndns.org>
 <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com>
 <7vy6dg5hwl.fsf@alter.siamese.dyndns.org>
 <AANLkTilnl5sw4M5p8AdO_Z73zBWzlwcZ8hIcdGDXf6de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Pickens\, James E" <james.e.pickens@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTnC-0005wd-W3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab0GMA4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 20:56:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab0GMA4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 20:56:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CA25C4D24;
	Mon, 12 Jul 2010 20:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BxmTFzCji0h7
	fo6a3J8r0at1U0Y=; b=Ej4MVnQWo9Owd8dJft28IoIhSeqNPurph5EJXdy0Fx/C
	XFMKnwKzg5lNKhp0soBDAChxt3s2BuF/L9DoJ4m35O1oW7DVerxBDm0TzWasPSOZ
	kq5WebUQty6DKaRTRNQOh42Y05J+W9WDyVVob2RXZJzfyTI4DSfQd1a4Bc1Luqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p+hzV1
	kFNto5oj3z02TtseYJzV8SP2n7F9Ncezud06q7j0vrFTqEthpAzNJyOgKZh/Ed2Y
	xu8mvTONbdHbWGOmz/hv+CUnEQtu18T3jPQEiQkhjj4FHnt9xYLA+7BzEsv7sC78
	K+2K63vknyz9GmFqYQkIFhNE6SBPpUvtDQW6I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFE4C4D23;
	Mon, 12 Jul 2010 20:56:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBCCFC4D22; Mon, 12 Jul
 2010 20:55:55 -0400 (EDT)
In-Reply-To: <AANLkTilnl5sw4M5p8AdO_Z73zBWzlwcZ8hIcdGDXf6de@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 12 Jul 2010 19\:49\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67A87330-8E19-11DF-8CB8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150863>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Jul 12, 2010 at 19:45, Junio C Hamano <gitster@pobox.com> wro=
te:
>> This will trigger only when you did something random like this.
>>
>> =C2=A0 =C2=A0$ git diff ^maint master ^next ^pu sr/frotz..
>>
>> What else would you say against such an input?
>
> Something like "too many arguments, please specify at most two commit=
s
> to diff against"?

The first part is correct, but the advice is not quite, as you are
forbidding the combined diff to emulate "git show --cc pu" to view a
merge at the tip of "pu" with

    git diff --cc pu pu~1 pu~2

which obviously has to allow three commits.
