From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/24] Index-v5
Date: Sat, 24 Aug 2013 20:07:02 -0700
Message-ID: <xmqq61uuo4dl.fsf@gitster.dls.corp.google.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<CACsJy8AkvUiJhjYVCuMrNwZPR7AiO-CZFazvOG-mVO=+Qq9O3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQfh-0005AZ-OK
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3HYDHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:07:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150Ab3HYDHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:07:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A86C62ABBA;
	Sun, 25 Aug 2013 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFE/BPmMjznorzRbSU3CBrfFvsE=; b=nr62rN
	jBIxeKNcsmvttLNMZzwzKDS8cmkbCkUjUAccNrZM3MG24WnxeyRyVUPwJVQwkRo4
	EO7h0meisRlcB80MrpLXor40uBuhhHZHEbqX43DISNeL4GEfpCAiuDzdYa0fdCZB
	SXB60pCSZhP8Np0Lj53guZ8XyyrVBfwkiV1Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qD1hAVMR74SqVr7/QCCHVvzsRkL09FG2
	saUUt17CY6muRZP9bf7pq73B+/Vney7tuEo/Z+W9groUtrfb3QxzrB4JWLP1LnWe
	+Ba3gD61ZDxxPqFysR1RmtPHarwNu97KlDEJBQEz5qoSGpSzuDlFfRsJAORjmmMZ
	+FSlM49h6To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BEF52ABB8;
	Sun, 25 Aug 2013 03:07:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7B882ABB7;
	Sun, 25 Aug 2013 03:07:04 +0000 (UTC)
In-Reply-To: <CACsJy8AkvUiJhjYVCuMrNwZPR7AiO-CZFazvOG-mVO=+Qq9O3Q@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 24 Aug 2013 11:16:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B916258-0D33-11E3-8FAE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232895>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 19, 2013 at 2:41 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> I'm done reviewing this version (I neglected the extension writing
> patches because after spending hours on the main write patch I don't
> want to look at them anymore :p). Now that rc period is over, with a
> partial write proof-of-concept, I think it's enough to call Junio's
> attention on the series, see if we have any chance of merging it. The
> partial write POC is needed to make sure we don't overlook anything,
> just support update-index is enough.

I've been following the review comment threads after looking at the
patches myself when they were posted. I was hoping to see some API
improvement over the current "we (have to) have everything available
in-core in a flat array" model, which gives a lot of convenience and
IO overhead at the same time, that would make me say "yes, this
operation, that we need to do very often, will certainly be helped
by this new API, and in order to support that style of API better,
the current file format is inadequate and we do need to go to the
proposed tree like on-disk format" for at least one, but
unfortunately I haven't found any (yet).

So...
