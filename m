From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem with BOINC repository and CR/LF
Date: Sat, 22 Dec 2012 11:17:25 -0800
Message-ID: <7vhandrj5m.fsf@alter.siamese.dyndns.org>
References: <50CEF289.4040503@gmx.de>
 <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
 <50CF41EB.1060402@gmx.de>
 <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
 <50D03D80.3090005@gmx.de> <50D05E62.7090605@web.de>
 <20121218164132.GC20122@sigill.intra.peff.net> <50D5A81B.1000306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 22 20:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmUeu-0008Rf-J4
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 20:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab2LVTRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 14:17:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab2LVTR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 14:17:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D8FAF60;
	Sat, 22 Dec 2012 14:17:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=iBXQbMQ/unJgZdDy3VmjWXbEz
	tU=; b=L/jOKXyWu5wSy+CcDHJTrBO1tv1iL5NDcG+rmJAkSYVnbPgNfTBpv1ZXX
	vlP6muJiDnl8l7i6EjUEYY15lE7ujOfkHNLiOl0OC0U7kyHHmgUDA3+mFAOVoJu4
	jbX2gOdIlcTp1XAkUgLZr9u4J/ahWkEBSUh8Q7ph6aHHFj0eoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=cw7X+RJ/+znpa+jSZ4c
	5FunZt8KrDeqDb3nHRI97jKU2TuJxpbeYDbidzrRg6ijJW15mUaX38yxAo8+OvL3
	50g67rSxITCfCZx6pnmGZ9/kF/QQ5DEj/lfsnBUZFnUTZFOoFEZFws+jf+9JKcQN
	n+CI4fTEfiufnQBMBnqqxwaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF64AF5F;
	Sat, 22 Dec 2012 14:17:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21EBAAF5E; Sat, 22 Dec 2012
 14:17:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39070578-4C6C-11E2-81F1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212068>

Toralf F=C3=B6rster <toralf.foerster@gmx.de> writes:

> On 12/18/2012 05:41 PM, Jeff King wrote:
>> I could reproduce it, too, on Linux.
>>=20
>> The reason it does not always happen is that git will not re-examine=
 the
>> file content unless the timestamp on the file is older than what's i=
n
>> the index. So it is a race condition for git to see whether the file=
 is
>> stat-dirty.
>
> /me still wonders whether this race condition is a feature or an issu=
e
> in GIT - b/c it means that 2 different people cloning the same
> repository get different results.

The primary point of Peff's demonstration was to show that you told
your repository to lie to Git, I think.  It promised that the
contents in the repository was with certain line endings when they
are not.  At that point Git can do whatever happens when it trusts
its behaviour on that broken promise.

When the timestamp is set one way, Git happened to be extra careful
for other reasons---Git is not in the business of suspecting that
the user lied and double checking by wasting cycles [*1*]---and that
extra check that does not have anything to do with the end-of-line
conversion found that it was lied and noticed differences.

That is neither a feature nor a bug.

[Footnote]

*1* This extra carefulness is to handle the case where *filesystems*
lie to Git.  The user cannot do anything to make the filesystem not
to lie, so we try to be extra careful and examine the contents even
when the stat information (incorrectly) says that the file is not
modified.  Also luckily this happens only to minority of the paths
(i.e. you do "git add" and then replace the file with different
contents of the same length within the same timestamp granularity,
or something like that), so we can afford to.
