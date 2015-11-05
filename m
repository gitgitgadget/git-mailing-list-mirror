From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] Move all the SHA1 implementations into one directory
Date: Thu, 05 Nov 2015 10:29:09 -0800
Message-ID: <xmqq8u6c711m.fsf@gitster.mtv.corp.google.com>
References: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
	<1446705523-30701-3-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 05 19:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuPHi-0007IT-EN
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbbKES3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:29:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965705AbbKES3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:29:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2C5428A82;
	Thu,  5 Nov 2015 13:29:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QmNCJJfIraD/ipa7N4+r7ezV7Mc=; b=ExMGas
	Eth7zF8k5B9Snkkc70qNsevKmILj4VUgRH1ZgGdcBpWxrtDC33GHW1jDhquPJUIb
	LTCH7xao7n0giGk0/4/05VI8AMww+xugZclTRiVfF2WUvjF5ZpD9boCDEhjyxgB6
	8Nth5g4ZpE0AC8QUzZL706bZV0d0qmEfpozFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1ewnV8Ofz9mZBURnG+s7RgXajB/Ni0h
	feRNhgiUC5+r79JygHhRDB69L90LYrxXG9oL9kfDGlx/bkElEYf1wO2w2UlD8vRV
	WdxROln0f+aKlIeBnxV3Ol5sk/z5o/DIhUY4IkGLEas63XmSOnV70l0AZq6iA35b
	85De/lcapF8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBB8928A80;
	Thu,  5 Nov 2015 13:29:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5714928A7F;
	Thu,  5 Nov 2015 13:29:11 -0500 (EST)
In-Reply-To: <1446705523-30701-3-git-send-email-apahlevan@ieee.org> (atousa
	p.'s message of "Wed, 4 Nov 2015 22:38:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BEC7964-83EB-11E5-ADBC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280931>

atousa.p@gmail.com writes:

> From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
>
> The various SHA1 implementations were spread around in 3 directories.
> This makes it easier to understand what implementations are
> available at a glance.
>
> Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> ---

I am not strongly opposed to moving block and ppc (I am not strongly
for the movement, either, though).

I however think the chunked one should not be mixed together with
them--it is not a full SHA-1 hash implementation but belongs to a
different layer of abstration (and that is the reason why we
introduced a new layer of indirection in 1/3).
