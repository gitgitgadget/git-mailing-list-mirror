From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 16:24:26 -0700
Message-ID: <7vty1guslx.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org> <4F6B84DF.8040806@in.waw.pl>
 <20120322230056.GC14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:24:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArMx-0003uE-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760156Ab2CVXYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 19:24:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab2CVXY3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 19:24:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF65D6414;
	Thu, 22 Mar 2012 19:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3YuFER7p4A5v
	NE5er4P/03cHCmk=; b=THzlp4FpLG4tsImbr0WG0jbryqonMxVlWk2/J3MGubkv
	Tm02KFETGWT/rxlcamIhG8NQfVuClGld1gHixbFgyg7A9ikXpOCmQGVQhrCopk+3
	Bh0fOW8g1w2mOBDbQs7WB/4DDNojjqkh2Vu6rSmctSggLuN9jrHeDZfyhu2jIgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LPvKG1
	InogUoHBUbc9MVzj5lgJWG7tCz1HP0F6O9UY5cEUM99TAPh6vfGc5l+O5VDIz8xK
	Ne7c3GxxRwWJlDogobWhMOmvp92sgtWsZ2rcW9khCMzBHfTAruD5jSya0EPxu40Z
	o1xrTg/+H3ASAGuybWi/EuRW34lvBojWlIb4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42476413;
	Thu, 22 Mar 2012 19:24:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2547B6412; Thu, 22 Mar 2012
 19:24:28 -0400 (EDT)
In-Reply-To: <20120322230056.GC14874@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 19:00:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B75A2BC-7476-11E1-8E5C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193731>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 22, 2012 at 09:00:31PM +0100, Zbigniew J=C4=99drzejewski-=
Szmek wrote:
>
>> Maybe:
>> --- 8< ---
>> When set, case-insensitive comparisons will be used when internally
>> comparing file names.
>>=20
>> The default is false, but when a new repository is created by
>> git-clone[1] or git-init[1], git will probe the filesystem and set i=
t
>> to `true` if the filesystem is case-insensitive.
>>=20
>> On case-insensitive filesystems like FAT, NTFS and HSF+, names that
>> differ only in capitalization, like "Makefile" and "makefile", refer
>> to the same file. While such filesystems usually preserve the
>> capitalization used during file creation, tools designed for such
>> filesystems will often modify capitalization when saving files and
>> when displaying filenames. Enabling core.ignorecase causes git to
>> ignore case-only differences in file names.
>>=20
>> Enabling core.ignorecase on a case insensitive filesystem does
>> not make sense, because filenames with different capitalization will
>> still be treated as different by the filesystem.
>> --- >8 ---
>
> From his response, I guess Junio does not agree, but this is my favor=
ite
> of the texts proposed so far.

I do not care too deeply, as long as we do not paint ourselves in a cor=
ner
by saying things that we do not have to say and end up sounding as if w=
e
are defining what the undefined behaviour should be.

If the change of the presentation order seen above is reverted (in othe=
r
words, drop the first paragraph, move the second paragraph to the very
end), I wouldn't mind the above too much.

> PS If we do use it, it needs s/HSF/HFS/.

That too.
