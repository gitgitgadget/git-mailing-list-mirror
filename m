From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/15] remote-testgit: get rid of non-local
 functionality
Date: Wed, 21 Nov 2012 10:26:42 -0800
Message-ID: <7v624y3h0q.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlG-0004bT-4b
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab2KUTOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab2KUTOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3669653;
	Wed, 21 Nov 2012 14:14:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=cKbhFNvR0vtfGFz62utl8PbfiBU=; b=kWtjX7fQLr+fI0vD9URi
	Ash5++mrnC4duqIMeeyvRcOaJIwLq412Szs73op4+duuAYpa8aCBceTr+7AZRCOQ
	CRxX89PaGqfTTGfptrH0g9YkNq2acwzSaL8C3RIP+db1qTpySBGdEV1fkEyfRyGJ
	b7FMe7aAKmaVyzCOm9w05cU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=au1tR9PmVf+9PasVSYAIMAZXYzTWNTy3EDPyDcUUV+hZur
	t8/9h3V+zmoT3HH4IM2ow1rH523dRzFX7O9j0CuQ+OkXBghNaAsEU4NndmOZ2FyF
	mxWMLhjZ/4bjjTTdFFfWqMLzDgQdIenNgz3NAC5gH4HDtGFLtlUjoG21zEze4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1509652;
	Wed, 21 Nov 2012 14:14:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52FA3964F; Wed, 21 Nov 2012
 14:14:30 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACDBF942-340F-11E2-BD09-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210158>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This only makes sense for the python remote helpers framework.

A better explanation is sorely needed for this.  If the test were
feeding python snippet to be sourced by python remote helper to be
tested, the new remote-testgit.bash would not have any hope (nor
need) to grok it, and "this only makes sense for python" makes
perfect sense and clear enough, but that is not the case.

If the justification were like this:

    remote-testgit: remove non-local tests
    
    The simplified remote-testgit does not talk with any remote
    repository and incapable of running non-local tests.  Remove
    them.

I would understand it, and I wouldn't say it is a regression in the
test not to test "non-local", as that is not essential aspect of
these tests (we are only interested in testing the object/ref
transfer over remote-helper interface and do not care what the
"other side" really is).

But I am not quite sure what you really mean by "non-local"
functionality in the first place.  The original test weren't opening
network port to emulate multi-host remote transfer, were it?

Thanks.
