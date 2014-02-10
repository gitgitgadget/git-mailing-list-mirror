From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Mon, 10 Feb 2014 10:23:53 -0800
Message-ID: <xmqqwqh2su6e.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-3-git-send-email-pclouds@gmail.com>
	<20140206193533.GB14552@sigill.intra.peff.net>
	<20140207234727.GA17520@sigill.intra.peff.net>
	<CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
	<20140210143948.GA21242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:24:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvWV-00030d-T2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbaBJSX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 13:23:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbaBJSX6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 13:23:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7838569F2F;
	Mon, 10 Feb 2014 13:23:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=35dMrt/LGxD6
	hYDqjexTevNH86M=; b=qcgbAhyX7YeN65qN97H5T7RqGKllxzEvlNUGlXtPzPgM
	X2QPWi2hz2ZRKRai49aQa6X729mVeZIzCcPkZXuwZ9z0194zdb7gjKCOmDHuBvZ+
	lK2slMkv9hWOnxUwgSoOxmEm957k26HrNqYMOqSS1EYeW3s+3ePRcvl0uCXobjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CJLTvo
	rpSdDj9xYBIcexFy6CsW9xbcmz4Ig2p/E1P2zuR696jEW3gocGPbxicyT9SnMIBM
	GwOb4MbU1wTNBw4I70fAT5FEqMDcAF63c5IF50ZbuwBK5RVeVP3feZom59dyZggW
	d294AgvvZWGUZNNXw+f6/yDAQAB06DiJjhv+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6629069F2E;
	Mon, 10 Feb 2014 13:23:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 952AB69F28;
	Mon, 10 Feb 2014 13:23:55 -0500 (EST)
In-Reply-To: <20140210143948.GA21242@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Feb 2014 09:39:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 803D11F2-9280-11E3-B805-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241919>

Jeff King <peff@peff.net> writes:

> Here it is as a Real Patch=E2=84=A2. I just based it on master, so it=
 can
> replace your 5537/5538 fix in your series.

Thanks, looks good.  Will put this at the bottom and rebuild the
nd/http-fetch-shallow-fix series on top.

>   1. Is there anybody who has apache installed who would _not_ want t=
o
>      bring it up for the test?
>
>   2. Is there anybody for whom the failure mode of bringing up apache
>      would be unpleasant (e.g., if it hangs the tests or something)?
>
> For (1), we could perhaps have a GIT_NO_TEST_HTTPD to avoid it.
>
> For (2), I suspect we may need to make our error handling more robust=
,
> but getting people to run it is the first step to figuring out what t=
he
> problems are.
>
> If we go this route, we should probably do the same for
> GIT_TEST_GIT_DAEMON in t5570 (and for that matter, we should probably=
 do
> the same for the port numbers).

All good points.
