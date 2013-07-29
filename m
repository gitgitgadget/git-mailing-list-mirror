From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Mon, 29 Jul 2013 09:01:12 -0700
Message-ID: <7va9l51hkn.fsf@alter.siamese.dyndns.org>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com>
	<20130705104557.GL9161@serenity.lan>
	<CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com>
	<vpqbo6hw8e9.fsf@anie.imag.fr> <kstfht$p0e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Mon Jul 29 18:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3psu-0004IH-7c
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 18:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab3G2QBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 12:01:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab3G2QBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 12:01:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A00CF3474B;
	Mon, 29 Jul 2013 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7XlPlYLeKntFy390lREg4CbsbY=; b=RazbTS
	O+cR9g7y8ND/sDMInobzvWUHNNCPxQB1ceEnAT1o/c6pdsgKJXRco423C8XnAwDh
	ztXpDapDqPFlJrCO3lWhaA5hDn9UFWf4O+mQr4DHnZC/mDBBM7tjxIMMpavPV1dB
	l0thOU8NLFf4DUeJNYII3uEdX63wsWfI4Nt5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UOLvKcAj4Bxi6kpg/P99c55B0yvc6qlR
	Ek91dFY/DALw2Mw3FmFjqPUS1+gMTMtofE23+1GrEcLwE3sPBHwpRystfIahTXo9
	m8TA5PVrpIcFz2bTGnyrIQraD52GQIsj9V9zZGl5mzBSGE23LLlc2UyJ5xk1G2Zz
	fmHiTSzJK/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96EAD3474A;
	Mon, 29 Jul 2013 16:01:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 054C834749;
	Mon, 29 Jul 2013 16:01:13 +0000 (UTC)
In-Reply-To: <kstfht$p0e$1@ger.gmane.org> (Colin Guthrie's message of "Fri, 26
	Jul 2013 10:29:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 182B3862-F868-11E2-BE3D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231296>

Colin Guthrie <gmane@colin.guthr.ie> writes:

> For what it's worth, after upgrading here, I got this error at the
> server side:
>
> Jul 26 10:15:41 foo.example.com postfix/smtpd[7736]: warning: TLS
> library problem: 7736:error:14094418:SSL routines:SSL3_READ_BYTES:tlsv1
> alert unknown ca:s3_pkt.c:1256:SSL alert number 48:
>
>
> This is because my postfix doesn't have a ca bundle configured but all
> other mail clients have been fine before.
>
> With the original patch here I could continue.
>
> I'd really love to see an option to set this to none in the .gitconfig,

Isn't that what the final patch committed under Ram's name
implements?

    sendemail.smtpsslcertpath::
           Path to ca-certificates (either a directory or a single file).
           Set it to an empty string to disable certificate verification.

or have we missed your use case?

> but agree with the principle that it should be one by default and the
> setting should over ride that.
