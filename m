From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: show interesting ident information in
 summary
Date: Tue, 12 Jan 2010 22:57:03 -0800
Message-ID: <7v3a2asda8.fsf@alter.siamese.dyndns.org>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154631.GC24957@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUxAN-0001GS-5i
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0AMG5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972Ab0AMG5M
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:57:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0AMG5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:57:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3627F9003E;
	Wed, 13 Jan 2010 01:57:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+aoDNKU40/vWS869WYZ6B2+v82I=; b=aLsKRclPlk0J6P3fhIdShB6
	EcXRGyYnNEUnTxwbijFRlwEFldIUa08VVkxcjeQkr3+TmwF0FrHj/Gky+VvxyXA4
	y6cUnoo138MwXwahcYP7/W7WlKR+XqDxrrhX68N2EQtfN5vzOmGCFFHwFKdYbrwh
	2omiiBKB+6F76CT+btm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EQ4s7wwm8oAlHnoX11mGOgA1I0ls4AHpVFyX/xRnmUZbS+xB0
	5ataV02PAq0fVW9jMulw/8RekJ1sHvPwZ31xXJy4I2JNqwRnnwVMWsdxhlsTtTUl
	riAo6kk8LIkbuMuY/zS7m9GZSk/vljnDX+iNW8nT43BxsEyfcxRokjUaMs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 048DB9003C;
	Wed, 13 Jan 2010 01:57:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 491769003A; Wed, 13 Jan
 2010 01:57:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD7DFB8A-0010-11DF-B6C0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136784>

Jeff King <peff@peff.net> writes:

> +	if (strbuf_cmp(&author_ident, &committer_ident)) {
> +		strbuf_addstr(&format, "\n Author: ");
> +		strbuf_percentquote_buf(&format, &author_ident);
> +	}
> +	if (!user_ident_explicitly_given) {
> +		strbuf_addstr(&format, "\n Committer: ");
> +		strbuf_percentquote_buf(&format, &committer_ident);
> +	}

This is much better.

We might want an advice message inside the latter case, helping the user
learn how to spell his name correctly.  This is designed to trigger for
people/repositories that are not configured, and by definition the
majority of that target audience are new people.

The extra message will disappear once committer information is explicitly
given, there is no need to protect the advice message with the usual
"advice.*" configuration.

Thanks.
