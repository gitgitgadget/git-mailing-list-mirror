From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon, 04 Oct 2010 01:00:09 -0700
Message-ID: <7vpqvq8k1i.fsf@alter.siamese.dyndns.org>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
 <1286175924-15761-1-git-send-email-bebarino@gmail.com>
 <AANLkTimuP8Myj-PAU76hjtWdOkbzg2WrZwaFNOxRqfsM@mail.gmail.com>
 <AANLkTinnd-ZTqfKvEaDQ6o-gR2oAmvEChSpDps5T0Xsu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>, git@vger.kernel.org,
	Joe Perches <joe@perches.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 10:00:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fyG-0002ub-Kk
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 10:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab0JDIAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 04:00:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab0JDIAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 04:00:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6E07DBE95;
	Mon,  4 Oct 2010 04:00:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8nVhasTXYrhM
	C4PLP5fP22citB0=; b=IPEsamAYg/F0q9o6OiwQkVENzfeYHzKzTX9s0UQ+bftj
	KvCIvdMBo2nWDN9ALZ6WJ97cfno/oIYILw+zr9nWNoFtTbbY9vOUcHfroNk7A4J2
	EZ2f9QhJPaJyIVPb3fu5sef8E1hxJfiRXJhJ58trfIzqHW8bQFTdwYvQ58yrAZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oX8kYI
	C/Mm9cA9r9pdYQrxL8nvrB0QkiSeE/a2RzCw+eTKwPpFRZz++Cm2Yz3pM8cR6YAO
	YzKtNHCjJ08keoEG4LpY7d3VjDitdAiPkAK4PlL/SVBpzORMbE5PJnZpo3yjzwlD
	cTjCDsUHhayq+VBxEHpNV+zzTKtvS4bIGHDAs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62726DBE94;
	Mon,  4 Oct 2010 04:00:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72EAEDBE90; Mon,  4 Oct
 2010 04:00:11 -0400 (EDT)
In-Reply-To: <AANLkTinnd-ZTqfKvEaDQ6o-gR2oAmvEChSpDps5T0Xsu@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 4 Oct
 2010 07\:25\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D3211AC-CF8D-11DF-9941-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158008>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That's a much better solution IMO than the C-like usage of two
> variables. Lexical shadowing is exactly for this sort of thing.

Lexical scoping, yes, shadowing a variable of the same name in the oute=
r
scope, no.  The latter is a readability nightmare in the longer term.

IOW, I would prefer to keep @initial_to and @initial_cc as "these apply
globally to the whole command invocation", copied to separate @to and @=
cc
that are primed by the former and tweaked per message.
