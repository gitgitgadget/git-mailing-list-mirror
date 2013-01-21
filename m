From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Mon, 21 Jan 2013 15:53:26 -0800
Message-ID: <7vtxqadrex.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
 <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
 <20130118010638.GA29453@sigill.intra.peff.net>
 <CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
 <20130121234002.GE17156@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxRBY-00073o-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3AUXxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:53:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab3AUXx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:53:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBFC8CB3A;
	Mon, 21 Jan 2013 18:53:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lunS3B7yJOmdm3ayFPnRo9nalZg=; b=NiYl8w
	4bC1ae9kVrADn4M4vjCpHHDiRZemQTsW3jvy0BcUW1cpVQKUv/kiNL0fDCP4ycju
	aioGuFhWvc2S1lUcdKL9XGu09lQMSZsDYdYGllu80PbELEOWRZH+wY9ILjrCqi7h
	q8dg9EX71bzFP+ABiFTdkxHRuJS9t/P/zwIaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oHe2MuqRFqOOv3AtnvAcR4EQWKSzzgDT
	s+/WwbCShCasUKcvt/0+IKKnXgVcweyvMAuZCripczRFymKSnNU+7EBT8jixvr4O
	+DmPnARTg2gpl/nuUXAwI/jLnH2Ey786ou64uDDFdncF9kBvfq4GMMvaYtVurssO
	ohrA5xO3vGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF587CB39;
	Mon, 21 Jan 2013 18:53:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 555FECB33; Mon, 21 Jan 2013
 18:53:28 -0500 (EST)
In-Reply-To: <20130121234002.GE17156@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Jan 2013 18:40:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0B00940-6425-11E2-897D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214179>

Jeff King <peff@peff.net> writes:

> ... The problem there is not "already exists" but rather
> "a blob is not something that can fast-forward". Using the existing
> REJECT_NONFASTFORWARD is insufficient (because later code will recommend
> pull-then-push, which is wrong). So I'd be in favor of creating a new
> error status for it.

Very well said.

Please make it so ;-) or should I?
