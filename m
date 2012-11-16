From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Fri, 16 Nov 2012 13:23:38 -0800
Message-ID: <7vmwyhkzs5.fsf@alter.siamese.dyndns.org>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
 <vpq625547ne.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aske Olsson <askeolsson@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTOF-0001RI-HC
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab2KPVXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 16:23:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab2KPVXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 16:23:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1713AA04E;
	Fri, 16 Nov 2012 16:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q572y9E52OHmjrnusTLPARvTRKs=; b=jUMpI6
	vNLBWMKNigDngAJ+vprppD1mGVzrRy+qHyJfbFTkw2k1BQbSuREpv1wXUKzkopp4
	gESdl80YQXVxdF1RKXwnNZKn4+3VSQPpjfUUpLtCX0hBnsIXfYgU26kkAsqrVoV3
	moZgQDX21gn7Z7yzOnkA8tkOWPVjttyuuFxVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uYX2Y+KLwCz7CJ1qingCy9yFxa3cc4fP
	ZocmUYCuEXhaidrA9UUN3kjOQb/sXRfddX2+k0cbL6+2uvSTS1/KqW3ey+THuqu1
	GdQwl/kolS45L+aTU4CYXjrJ1bs3SdQWkiYlrcHGe4Z8lmaXRwLzB35fLdwDs9Qq
	/NvmxwWZvPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 055C2A04D;
	Fri, 16 Nov 2012 16:23:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74C7FA04C; Fri, 16 Nov 2012
 16:23:40 -0500 (EST)
In-Reply-To: <vpq625547ne.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Fri, 16 Nov 2012 21:25:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E437CB3A-3033-11E2-A577-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209915>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> +# hook that fails
>> +mk_hook_fail () {
>> +cat > "$HOOK" <<EOF
>> +#!/bin/sh
>> +exit 1
>> +EOF
>> +chmod +x "$HOOK"
>> +}
>
> I'd add a "touch hook-ran" in the script, a "rm -f hook-ran" before
> launching git-push, and test the file existance after the hook to make
> sure it was ran.

And if you create that "evidence that it did ran" file without using
"touch", it would be perfect.  Unless you are updating the timestamp
of an existing file while preserving the contents of it, it is
misleading to use "touch".

All other points in your review are good.  Thanks.
