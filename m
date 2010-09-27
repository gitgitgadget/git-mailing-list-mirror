From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add -F option that passes --no-reuse-delta to
 pack-objects
Date: Mon, 27 Sep 2010 09:50:36 -0700
Message-ID: <7vbp7j2krn.fsf@alter.siamese.dyndns.org>
References: <20100927133104.25ce5285@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Gui-00037o-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab0I0Quq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 12:50:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab0I0Quq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 12:50:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE73DAA63;
	Mon, 27 Sep 2010 12:50:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PJ2V+pwnN0Nn
	ZaY1wI0fNRcgwA4=; b=yE3QFxTrv3U6Om/bUv3nLXF7zaZcbRKzzAxmoCBsx3ji
	hE7kJKS4U/r1bhhFrNbBPr4dPKVJe0ODD8ipEkjV7A0gsQrMxL8hSziSAAFhexv0
	dq/56BNdSXCNGuwlAIbUUaNHuOs6fgirqZ4fCso7qSqTApGE56IIUetbD1tHaqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ak8n/p
	cq+8uX2GogWLNKyfPa1sNq7ljuNOUyiMl6TO+yDSGdqnU7kloOT4fdXSl/AOqzs/
	AQJZTCclEI5B6lUGUeyXBvxn3Ghg6zFz3HpM2sw/fwLYbFIGDiUM+sTkU1SqZWVP
	N/BYUd6MbEkMBnfuElVqL3uWlnuZ3YfWEGQ9g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB651DAA62;
	Mon, 27 Sep 2010 12:50:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2946BDAA60; Mon, 27 Sep
 2010 12:50:38 -0400 (EDT)
In-Reply-To: <20100927133104.25ce5285@jk.gs> ("Jan =?utf-8?Q?Kr=C3=BCger?=
 =?utf-8?Q?=22's?= message of "Mon\, 27 Sep 2010 13\:31\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D2E8514-CA57-11DF-B605-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157354>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Discussion point: it might make more sense to switch the meanings
> around, making -F do the 'bigger' routine and reverting -f to what it
> used to be. I don't feel strongly about that, however.

That sounds sensible.  reuse_object is used only to z-recompress and is
not involved in precomputed delta selection, and under normal
circumstances it should not have much effect on the outcome.

Please make it so.
