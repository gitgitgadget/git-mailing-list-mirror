From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] Add treap implementation
Date: Thu, 12 Aug 2010 10:22:49 -0700
Message-ID: <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino> <20100809215719.GA4203@burratino>
 <20100809221734.GE4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbUn-0001BN-E0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0HLRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:23:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0HLRXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:23:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44813CDA2B;
	Thu, 12 Aug 2010 13:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SotQZ8U1uZxzBNF0STuhJMcsIeU=; b=kfqFjzephy03VozoztIKo0d
	wYb+gAcuD6KFRyh5TPKpVycSat83KJNlETec71WzdD0+ll9QQyWnHeD+bA4kFS19
	cTuYsFWgflqCZHt326zBiuWfrA+t9WEI7dB5ELucQmmQlY6SnTTX4ohn66VeyUTM
	GpyOa+VhvmTQQF3UCnas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cb8qi1bBMcKO1jXtpWeVOoHkW2jjtNzTKqTpShs5w9aKYd3kT
	92ANrQgigFeZCk1HraNB8lQESY+RHSxLGjGbDY6pX4wNE7qfqjjlXAffZL6T8hFY
	1unwwAi5rbE2zQRv+PA9Mwgv6s6rPqw3G1RF3F/UX3yCQEVFJxgyIzxWEs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E899DCDA29;
	Thu, 12 Aug 2010 13:22:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0287CDA26; Thu, 12 Aug
 2010 13:22:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 402854EE-A636-11DF-A846-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153390>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +/* Left accessors. */
> +#define trp_left_get(a_base, a_field, a_node) \
> +	(trpn_pointer(a_base, a_node)->a_field.trpn_left)
> +#define trp_left_set(a_base, a_field, a_node, a_left) \
> +	do { \
> +		trpn_modify(a_base, a_node); \
> +		trp_left_get(a_base, a_field, a_node) = (a_left); \
> +	} while(0)

Need SP after "while" (there are other occurrences).
> +a_attr a_type MAYBE_UNUSED *a_pre##search(struct trp_root *treap, a_type *key) \
> +{ \
> +	int cmp; \
> +	uint32_t ret = treap->trp_root; \
> +	while (~ret && (cmp = (a_cmp)(key, trpn_pointer(a_base,ret)))) { \

SP after "," (same for nsearch)
