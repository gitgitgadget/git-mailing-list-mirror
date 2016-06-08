From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] send-email: shorten send-email's output
Date: Wed, 08 Jun 2016 10:37:40 -0700
Message-ID: <xmqqeg87mviz.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-4-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:41:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhQL-0004I7-PE
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbcFHRhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:37:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161123AbcFHRho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:37:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF71D1F0F1;
	Wed,  8 Jun 2016 13:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jZs1qvinscDYO3Z3kgvJdcw982I=; b=g4C9iZ
	TuJ4gIPM83KAf219JxbVaR41QviYRO7g2e2byv6Dbctr2rAWFxcBC31mrImNbhlf
	K0BwvNai1fL/bjg6uscr58ILsjo2HQBR8htpFmphgbduCPW90MisKzLKgmEBsrXu
	VYMqyku78Igwe3Phs7bv5cu1Jkc9DrioYM39U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vRNECzW083GSGFiTPjgUOVck6wikxrvE
	XgPhYF3VmDI1jpAz96jATQoiSUFP2iz1uQ0QlZpSR0syPqNzQHhD6Za75UJs2SMt
	uvuuXO4GXZjXSfc8PfF7pDZYUc9+n+y8woRpWmCsSd3BFt0q1ejhMA9m1tV78vGr
	JD3scjuj3D0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E76BB1F0F0;
	Wed,  8 Jun 2016 13:37:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 745591F0EF;
	Wed,  8 Jun 2016 13:37:42 -0400 (EDT)
In-Reply-To: <20160608130142.29879-4-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4125B6A-2D9F-11E6-BDAB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296816>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> +				printf("Adding cc: %s from From: header\n",
> +					$1) unless $quiet;

> +					printf("Adding to: %s from To: header\n",
> +						$addr) unless $quiet;

> +					printf("Adding cc: %s from Cc: header\n",
> +						$addr) unless $quiet;
>  					push @cc, $addr;

> +				printf("Adding cc: %s from Cc: header\n",
> +					$_) unless $quiet;

These make the end result prettier by not repeating the same address
twice, but is it just me who finds these inexplicable case
differences irritating?  Shouldn't these field references in the
result mirror the field references in the origin of the information?
