From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
 user's git commands
Date: Fri, 26 Feb 2010 12:04:44 -0800
Message-ID: <7vmxyvsqzn.fsf@alter.siamese.dyndns.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
 <20100129151127.GA21821@spearce.org>
 <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
 <20100129175950.GE21821@spearce.org>
 <7vockciyb8.fsf@alter.siamese.dyndns.org> <20100129190642.GA31303@neumann>
 <7viqakireb.fsf@alter.siamese.dyndns.org> <20100226152710.GA17460@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:05:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6Qq-0001D9-Ef
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 21:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965966Ab0BZUE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 15:04:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965963Ab0BZUEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 15:04:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C44B9DD59;
	Fri, 26 Feb 2010 15:04:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=sG7DPmYeEtT6AX31ZUERnXgcg
	KU=; b=sdIiYIJYuYalZEgkwaK1spgxVx9KjsxWZXNRjN4hHppsfxilme1QEC5MR
	gPRFQ6MuXoYrciK71AaC2eO19e2ua7doyLHduq0yooTybhCbDKN+80KtpVIufud/
	JgBpLJvQUzpHUH2VUxeW4qStAKbv/HreTPkK22RmiKac/EnTSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=hZToBUhJX6TS8WQjOIE
	qJgudJI65geTbZXDUsCX9uIAoXl/EFvMgvpYI2MVk35EBBTsxB31xR0D5MaXMCJY
	rncRmiscC9sbJc2jZIrJvxiqxd91grk0Q6pb+pvccLDkKgPqukRKefoectZoevoU
	BH7uKQ5l3W/1HMi6iwbhAM5E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CFB9DD58;
	Fri, 26 Feb 2010 15:04:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73AE59DD54; Fri, 26 Feb
 2010 15:04:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3238D2F2-2312-11DF-B68A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141145>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> so in that sense, the patch is not introducing a new problem,
>> but making it a documented interface and casting it in stone will ma=
ke the
>> namespace contamination issue harder to rectify later.

I won't quote the first paragraph where you are repeating what I said,
while sounding as if you were disagreeing with me.

>> So if we were to ...
>> ... It is my understanding that the only published interface so
>> far is __git_ps1.
>
> I would say that __git_ps1() is the only interface that is advertised
> as being public.  ...
> ...  If we were to rename completion functions, these
> people's setup will break (although they will likely get merge
> conflicts caused by this patch anyway).  On the other hand: should we
> really care that much about such users, who use non-pulic interfaces
> from contrib/ ?

I see we are in agreement in the first half of your paragraph; my answe=
r
to the question in the latter half is:

 - we shouldn't care about people who already used unpublished interfac=
e
   in contrib/ so far; _but_

 - because we will be advertising it as a way to override and enhance
   completion to define your own shell functions, the naming _will_ bec=
ome
   part of published interface---what we decide _now_ will matter.

That is why I wanted people to at least think about renaming _git_frotz=
 to
something less generic.  The name tells us that it is a helper shell
function about the "git frotz" command, but it does not say what aspect=
 of
"git frotz" it is meant to help, i.e. completion.  _git_complete_frotz =
or
a variant of such would not have that problem, and will keep the door o=
pen
for future shell helpers that are about different aspect "xxx" that is
unrelated to completion---they can then name theirs _git_xxx_frotz.

> ...  BTW, Mercurial's
> completion script uses _hg_cmd_foo() for hg commands and
> _hg_ext_bar() for extensions, so we might as well be a bit consistent=
,
> and call our completion functions _git_cmd_foo().

In Hg's context it might make sense to name a function _hg_cmd_foo vs
_hg_ext_bar iff the end users need to be very aware of the distinction
between commands and extensions, but for us I think "git_cmd_foo" is
probably the most meaningless rename, as it doesn't add any extra
information (we know 'git foo' is a command already without 'cmd').
