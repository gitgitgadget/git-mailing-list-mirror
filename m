From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 23:29:38 -0800
Message-ID: <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:29:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdc5l-0005Au-2x
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab2K1H3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:29:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab2K1H3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:29:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDB60727B;
	Wed, 28 Nov 2012 02:29:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AVm04RYlYF/RXQaflg7uOr1SnRo=; b=E/zn37
	1JmT9K6MPHM1OWyd9PIg723nVwAZLJ7y8Zg085/wX+Bee9tUo937pq2m3H/bHyIP
	fYDYwqskNxcgVbGRYI0McxZVLaNpWJHsgD0ECPqXBUg8QsIYEOwoQ0D++86HNZSR
	y8p+p8yOAUhtWIs+nZ2LL1TlwjeaxolaI6jN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aOw6FkZiOcSHc8RwOywGnvwwlw9qU0ke
	fqABFhaLFwNqkDx43sRcpzlyTaUJbuI3GTLNQTbLTo+WfgFqDyUXt6tyqZC6BMwO
	lHoUaH1e09hbc7Wr1eQ6a31AuN+nHRdz+Oj4bFOxe7cUsktnbWSOgLWysVhMzJuL
	QeX2BLQcS4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9F7D727A;
	Wed, 28 Nov 2012 02:29:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C9BA7273; Wed, 28 Nov 2012
 02:29:39 -0500 (EST)
In-Reply-To: <20121128011750.GA23498@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Nov 2012 20:17:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EC748BA-392D-11E2-ACE2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210712>

Jeff King <peff@peff.net> writes:

> There is room for new headers, and older versions of git will ignore
> them. You could add a new "committer-timestamp" field that elaborates on
> the timestamp included on the committer line. Newer versions of git
> would respect it, and older versions would fall back to using the
> committer timestamp.
>
> But I really wonder if anybody actually cares about adding sub-second
> timestamp support, or if it is merely "because SVN has it".

Roundtrip conversions may benefit from sub-second timestamps, but
personally I think negative timestamps are more interesting and of
practical use.  Prehistoric projects need them even if they intend
to switch to Git, never to go back to their original tarballs and
collection of RCS ,v files.

And if we were to add "committer-timestamp" and friends to support
negative timestamps anyway (because older tools will not support
them), supporting sub-second part might be something we want to
think about at the same time.

We would however need to be extra careful.  How should we express
half-second past Tue Nov 27 23:24:16 2012 (US/Pacific)?  Would we
spell it 1354087456.5?  1354087456.500?  Would we require decimal
representation of floating point numbers to be normalized in some
way (e.g. minimum number of digits without losing precision)?  The
same timestamp needs to be expressed the same way, or we will end up
with different commit objects, which defeats the whole purpose of
introducing subsecond timestamps to support round-trip conversions.

If we were to use a separate "subsecond" fields, another thing we
need to be careful about is the order of these extra fields, exactly
for the same reason.
