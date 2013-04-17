From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] pretty: add %C(auto) for auto-coloring
Date: Wed, 17 Apr 2013 08:28:54 -0700
Message-ID: <7v4nf5goqx.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-11-git-send-email-pclouds@gmail.com>
 <7vd2tujh3o.fsf@alter.siamese.dyndns.org>
 <CACsJy8DLj90aynu376O0LZKpQqvcmyoA_8gMNoek3WK6HTRtLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUIA-0003mv-6X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab3DQP26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:28:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab3DQP25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:28:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC5A9150AF;
	Wed, 17 Apr 2013 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qkI432LK2QScRdIQ3+V3yxkhEeE=; b=GZoX+T
	Lv74xQqxTlJ8zdWQAA1kukLGWQqhGJT+++Dn8jdeiseBdd/47zPHEq31u5d5psme
	0jcPUxaYDnF+q6akMajQJX3u6+om5tn8JP6kl0ZxP4AWtD3/xDXD/ewsQLOmX00Q
	2aY5gcpDUbeIPJ7lmUruqi6WHGL3FJpADLenk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LmUfQ8E6Df+215ZyS04VW3cKc85sHBn0
	EswGXqsubGvrq4Sv1JvRBkFv/6Ex7xDuSOCm2FE/1VVxxMYUoRphNy9mA2jon11S
	rwdPCwB/ejcAPuH+JVOxqcG5fRJDhAOMRFn2rQOo1PqvJ+h0EUKKrWQRfmlpOFgc
	ForHSzoqYno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4347150AE;
	Wed, 17 Apr 2013 15:28:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46466150AD; Wed, 17 Apr
 2013 15:28:56 +0000 (UTC)
In-Reply-To: <CACsJy8DLj90aynu376O0LZKpQqvcmyoA_8gMNoek3WK6HTRtLQ@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 17 Apr 2013 19:55:25 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84A45DB6-A773-11E2-A9CB-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221545>

Duy Nguyen <pclouds@gmail.com> writes:

>> This is to handle a corrupt input, e.g. "%C(auto)%Cbleu%H" where
>> (perhaps deprecated) "%Cblue" is misspelled, and parse_color()
>> returns 0 without consuming any byte.
>>
>> Does it make sense not to turn auto off in such a case?
>
> We don't have any mechanism to report invalid %C. Instead we let them
> through as literals. If they are literals, they should not have any
> side effects. So I think it makes sense not to turn off things.

Oh, you are right.  Thanks for a dose of sanity.
