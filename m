From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: Better error message on invalid branch name
Date: Mon, 21 Jun 2010 13:58:53 -0700
Message-ID: <7vd3vkgl0y.fsf@alter.siamese.dyndns.org>
References: <1277146419-19507-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 22:59:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQo5V-00089c-Mw
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 22:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab0FUU7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 16:59:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758597Ab0FUU7C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 16:59:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF01BD021;
	Mon, 21 Jun 2010 16:59:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qwtGtoJnimwZ
	HRN+B7RHzh0EEAA=; b=P+iKCb/ixG1EdIIZxKYilBhGBwbBJgJ+spzXQ+vWCs2G
	hdBXzqVbP+qSzaCVMcgPWH5Zc6tWI9nNfleDz8u/LUiXNuZlyfZpRlC8zyijHKHI
	vKHme/f3zfOSnaae5fd8mJxk/PM/g5ArBTPE7r1+JXd+qsotim6KUXAH0fpFS3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=htU/fF
	6JS5s4KuKfn+ooj9o4O2JO0IIgSQC5uIXB/mhkXSvPXBCWlGnCwEBg/4nCEO/JgD
	gV5noAnvPmm9G4CCccVUJkPy3oPjD+otR+NBssUsL3Zti+IHKN09EH3LMFlPbjOB
	O6gQ6pvkE9mLCfaPF4yDRwfLPZVtqrzqbZAuY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AEF0BD019;
	Mon, 21 Jun 2010 16:58:58 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 921EBBD017; Mon, 21 Jun
 2010 16:58:55 -0400 (EDT)
In-Reply-To: <1277146419-19507-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 21 Jun
 2010 18\:53\:39 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFA5C8C8-7D77-11DF-AAE2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149438>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the error message for `git checkout -b "I LOVE YOU"' and other
> invalid branch names to say what branch names are invalid, rather tha=
n
> just saying we don't like it.
>
> Before:
>
>     $ git checkout -b "I LOVE YOU"
>     fatal: git checkout: we do not like 'I LOVE YOU' as a branch name=
=2E
>
> After:
>
>     $ git checkout -b "I LOVE YOU"
>     fatal: git checkout: The name "I LOVE YOU" is not a valid Git bra=
nch name.
>     A branch name can not:
>         - Have a path component that begins with "."
>         - Have a double dot ".."
>         - Have an ASCII control character, "~", "^", ":" or SP, anywh=
ere
>         - End with a "/"
>         - End with ".lock"
>         - Contain a "\" (backslash

Cluttering the output without protecting it with "advice" does not look
like a "fix" nor improvement.
