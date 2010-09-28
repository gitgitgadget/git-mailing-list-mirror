From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 08:33:42 -0700
Message-ID: <7vpqvxubl5.fsf@alter.siamese.dyndns.org>
References: <4CA1E10F.4080906@op5.se>
 <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:34:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cC0-0005Rv-9y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0I1Pd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:33:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0I1Pd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 11:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB3A9DA291;
	Tue, 28 Sep 2010 11:33:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cPSG18sHe4pnR54G+A27gK3YpC8=; b=gy28RC
	N5ivSfd2NxhXlScg2gh9kX0v1jMK6cM3fg7LAMxeqCfjX7G4qHOL3TfNXMEZGeH2
	XRuO5jjNkLgl0egvYbVqZ+txihJI2PEr6qbqCXOhqlDs/H4efk0zkA4BPK7ZRfYN
	YmEdXD/uSuX7jzey+C0awrWhMjSZcVApQ1iy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xlIz+0sOt2m/lkn0o9lv31dV5+uzwgqp
	tx3aQj9cQOuUYUjr+vuGhGhAvDBYezmsGgYRnQbLRoHACK4h2QptBm14xnKOQw0S
	mhL+cVhV+fqILCQCYOJX9fhxscAPTObIqR2Psva1VH5uYOAPs68LUDFMdqWY28GV
	hHV28lmEx18=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C1EDA28D;
	Tue, 28 Sep 2010 11:33:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99712DA284; Tue, 28 Sep
 2010 11:33:44 -0400 (EDT)
In-Reply-To: <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 28 Sep 2010 16\:44\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB0EA640-CB15-11DF-8AEE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157434>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> How's this for a version without maintenance issues?

Something along these lines would be closer to what I had in mind,
actually.

Traditionally a multi-line sed command embed in Makefile has been
portability nightmare, which is a bit worrysome.

Isn't there a "makedoc" ala "perldoc" or "javadoc", by the way?

> ...
> +#H# Show help for main make targets
> +help:
> +	@sed -n  -e '/^#H#/ {N'\
> +		-e 's/^#H# \(.*\)\n\([a-z0-9_-]*\):.*/\2 \1/p'\
> +		-e '}' <Makefile | sort --key=2 | while read target txt;\
> +	do \
> +		printf "%-20s: %s\n" "$$target" "$$txt"; \
> +	done
> -- 
> 1.7.3.98.g5ad7d
