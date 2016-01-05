From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Tue, 05 Jan 2016 11:39:17 -0800
Message-ID: <xmqq37ubke8q.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
	<xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
	<20151221065944.GA3550@sigill.intra.peff.net>
	<xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1512301535550.14434@virtualbox>
	<xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601011604070.14434@virtualbox>
	<xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601051342050.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 20:39:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGXS1-0005pR-HB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 20:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbcAETjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 14:39:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752041AbcAETjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 14:39:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D504C38BEF;
	Tue,  5 Jan 2016 14:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qlw5P/7n/ShyyntvR+Y50mzt2HQ=; b=os5nmb
	QR1+omjHxWtcoIwsyigWc7DxsJiP4y6OQ6m7qZp7NMtJaogpb9t8yfhFPkCoin68
	HwE2HByJkYlLhLcKJLrHZgiZ8MaiT3ux3NnRo9zFCB6DzXuhcm7eIiFQJxk4vpbN
	KufcHHjqeBUfuZRF2wXvUNOxd/nDflvsseZX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hy1PfFO312q2fOPISUHXmkUHzpAph8XQ
	6sNsmMWtjBbgaaVyLyQfzAvFuycqShk9wD8cosFNkmtHd8iob9ed8okTnEqYmKJz
	t+hJK0cZbz5wOu+a3EVE79fd92cGCbl36pouuRh0Asd2mIMMl/kSqfFQUXPi4OOt
	x+AOxDo8tG0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCC1A38BEE;
	Tue,  5 Jan 2016 14:39:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4438C38BED;
	Tue,  5 Jan 2016 14:39:19 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601051342050.14434@virtualbox> (Johannes
	Schindelin's message of "Tue, 5 Jan 2016 13:52:06 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0347F216-B3E4-11E5-A803-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283395>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 4 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> I do not know fcreate_or_truncate() is a good name, though.
>> >
>> > So what would be a good name?
>> 
>> Have been thinking about it, but I did not come up with anything.  I
>> just know fcreate_or_truncate() is not a good name for multiple
>> reasons I already explained X-<.  sane_fopen_for_writing() perhaps?
>
> That implies that fopen() is insane, though ;-)

Well, sane_X() does not imply X() is "insane".  The reason why we
introduce sane_X() wrapper often is because X is inconvenient to use
sanely as-is.

Look at sane_istest(), sane_case(), etc.  We have one byte and want
to see if that is space, digit, etc., but we have to cast (possibly
signed) char to unsigned char and always doing so in the callers is
inconvenient.  Look at sane_grep.  We have a string and want to see
that appears in its input, but some implementations of "grep" can
be configured in an inconvenient/unsuitable way to be used in
scripts via environment variables, so we disable it not in the
callers but in a wrapper.

All we want to do here is to get a writable filehandle FILE * for a
path and store the contents we will generate without having to worry
about the possibility that the path is already there and we may have
to first unlink it to use fopen(3) to do so.

So in the sense, fopen(3) is inconvenient to use sanely as-is.  You
can call it insane, too ;-)

If we want to follow the X_or_Y() pattern, fopen_or_create() may
describe what it does better.  I do not have strong preference
either way, but again I am not good at naming things (and I suspect
you aren't either), so...
