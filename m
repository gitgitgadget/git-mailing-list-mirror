From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Wed, 30 May 2012 16:45:33 -0700
Message-ID: <7vehq18c82.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Thu May 31 01:45:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZsaM-0002pI-2B
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2E3Xph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 19:45:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2E3Xpg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 19:45:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC9979A8C;
	Wed, 30 May 2012 19:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=52ayC9Xlq5K/
	V1Jd6B4P5+rt4FM=; b=kw+4agfaG2EnQmPBR/M+R48JxUtRC88ME9yvdNrnZY6/
	77Mx4oc0SmnTXZte4QYkPHC+aeWIQiinQW2jH/2CXoC6ChYQzw/Z2liBqNPZW4gn
	YHUDnx3UFxxZAUsM6U2MwiXX/t5agclBYtMCLxWnzls66YuRH2cQ1mhpL3Luq5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZvkHZX
	Pi4fRbOfQIfbDQX/Jw3uJOdvFt4OquUqVvjfb5chHpwVknA1ijUJDqsvMvwCb3xa
	OjfF4/fkNqExuqLBfnkNPJQd3hkyWEiXSWV4KWyMbu7CsNGjQt4UQQvJ73Jx8h++
	n5D1Vf5MjK7YKWwkWkX5SwmwmK/20dxOgSNEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E68A9A8A;
	Wed, 30 May 2012 19:45:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DCE29A89; Wed, 30 May 2012
 19:45:35 -0400 (EDT)
In-Reply-To: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> (Lanny
 Ripple's message of "Wed, 30 May 2012 17:16:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D1E3328-AAB1-11E1-B59E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198852>

Lanny Ripple <lanny@spotinfluence.com> writes:

>   lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC sed -ne 's/=
=2E*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>   GIT_AUTHOR_NAME=3D'R'=C3=A9mi Leblond

So in C locale where each byte is supposed to be a single character,
that implementation of "sed" refuses to match a byte with high-bit
set when given a pattern '.'?

That is a surprising breakage, I would have to say.

Can anybody with a more vanilla BSD try the above out and report
what happens?  I am mostly interested to see if this was inherited
from BSD or something MacOS introduced.
