From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-core: conflictstyle=diff3 doesn't actually use diff3
 compatible format
Date: Fri, 05 Mar 2010 14:31:02 -0800
Message-ID: <7vpr3itn89.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 23:31:25 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nng3E-0000WO-E5
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 23:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab0CEWbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Mar 2010 17:31:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab0CEWbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Mar 2010 17:31:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CAD9FF2B;
	Fri,  5 Mar 2010 17:31:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fiImR5sAlZVd
	4MqpWO25SYyrWhg=; b=TWtU3hKcq9iC8SBY4hpsvDV0MmPb80yrf7lAT8byuxqe
	SpNnMfL+C4um5CbTMLAiiXoct9c6lhDzLcB5QGN51+gD+dpWVLlFzJOhQvN+BFh2
	2+UJiawzpGYoVMCG45V9+W1Yv2kfk0vCQvVEVANHYHrjGX2MYHB8hkC/S+O5Og8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MC21hW
	K4a5fp0Dyr7xvbJ0Et603Ie+84IEnIetxOdMmIixs+Fdi9dBCNEONPBoRJuVimsx
	gQ0oq2D94Mnb24725Wy+Mj56ztwDrqIigtXqQQWpp6coqFxcU3nh00NsB8f2bVhw
	mj7MMgdzS1LAdXM/JG1ff51C/6h+U8NxgL2bA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43FDF9FF2A;
	Fri,  5 Mar 2010 17:31:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 922449FF28; Fri,  5 Mar
 2010 17:31:03 -0500 (EST)
In-Reply-To: <20100305221950.GB5083@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 5 Mar 2010 16\:19\:50 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA8F88D6-28A6-11DF-8D9D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141600>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I can't live without conflictstyle=3Ddiff3m and I'm very happy it ex=
ists.
>> But it has a little problem: it uses "|||||||\n" as a separator for =
the
>> ancestor version of the text, whereas diff3 uses "||||||| <ancestorn=
ame>\n".
>> The difference is harmless for a human (tho the <ancestorname> can s=
ometimes
>> be useful, assuming it's meaningful), but it makes some tools fail t=
o
>> recognize the conflict markers properly.
>> So please add a " BASE" or " ANCESTOR" after the "|||||||".
>
> No opinion on this myself.  I=E2=80=99d be interested to hear from xd=
iff people
> whether it should be easy to add the ancestor name to the output.

I don't think there was any xdiff people involved in this area.

I suspect that our tools actually rely on the common ancestor markers n=
ot
having any extra cruft after them, so it would be introducing a bug if =
you
change this output without changing the places that read them (I know
about "rerere", but there may be others).
