From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: make 'git clone -c remote.origin.fetch=<refspec>' work
Date: Sun, 06 Mar 2016 17:36:04 -0800
Message-ID: <xmqqfuw3rrwb.fsf@gitster.mtv.corp.google.com>
References: <1457313062-10073-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 02:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ack5r-0002qI-LW
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 02:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbcCGBgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2016 20:36:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751358AbcCGBgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2016 20:36:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 589CD4A847;
	Sun,  6 Mar 2016 20:36:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/TgNjSJpfCyN
	Acj0PDIviPtugZ0=; b=nOxNk+ya/xeooK8oy1aezbr4lqR55AbLvrbO0+grmO+G
	hoBZxUfMzfiPhUTQ7tnbusx6WBfzLNdnxiUkW+BxoJkL9im5S5EhQ3cpgx+UQATR
	vnkindJ/E0vX6DBT7aXJ3hXT3g3VJGVCxBt4rh+bznHUwwvY4jITd6riupCg8Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U259oG
	SuNCvi9C10Q+QBBBZBHtArE9/K95x7hgYvdzeYjaIjgSzrKOVyuc3uyoqmAJMiB7
	iCNEu44cwO8MyubN0z3c1P95P/+k4Y3No5jkna8TV1MRLpwh3IXF/iZrN0aaCSqF
	QGX7Ojq+3BUY90vnxklKrjp9EFEFjhwsMUrI8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 512004A846;
	Sun,  6 Mar 2016 20:36:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF7F54A845;
	Sun,  6 Mar 2016 20:36:05 -0500 (EST)
In-Reply-To: <1457313062-10073-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 7 Mar 2016 02:11:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F5BFBD8A-E404-11E5-B1E8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288378>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Check whether there are any relevant configured fetch refspecs and
> take those into account during the initial fetch, unless running 'git
> clone --single-branch'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---

Even though I think the original description did not mean to include
the fetch refspecs when it talked about configuration taking effect,=20
I think what this change wants to do probably makes sense.
>
> I'm unsure what to do with the '-c <fetch-refspec> --single-branch'
> combination: it doesn't really make sense to me and can't imagaine a
> use case where it would be useful...  but perhaps I just lack
> imagination on this Sunday night.  Hence the RFC.

My knee-jerk reaction is to change the last paragraph of your log
message to read more like

	Always read the fetch refspecs from the newly created config
	file, and use that for the initial fetching.

and do so even when running with "--single-branch".
