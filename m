From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why are submodules not automatically handled by default or at least configurable to do so?
Date: Mon, 26 Oct 2015 12:53:28 -0700
Message-ID: <xmqqoaflh0ef.fsf@gitster.mtv.corp.google.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
	<CAFOYHZAKvN8xMKePCNFgo_ySHr0dc0+ASY0ux7j0p8UF1fuWCQ@mail.gmail.com>
	<CAGZ79kb2kStk0+MqUXREH3g+rqbsXoNiTGj=4SxJ4vOR8TqEcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chris Packham <judge.packham@gmail.com>,
	John Smith <johsmi9933@inbox.com>, GIT <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqnpo-0001Bc-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbbJZTxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 15:53:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751603AbbJZTxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3BD826386;
	Mon, 26 Oct 2015 15:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bmpfHEU/FZCWXGuqUCqw9cOQ4dg=; b=TKfi2D
	ObeVvakKDYKUwKsOH+feZEgI7PSYLn8eN1NdbuLh/SOv81m5gcoI4XyEDE63SWEJ
	sYQcKZYACJMU+q+YOUxnI8K2oROWizdrMxjwV9WzeNJjdQcPm5pv/IirX2MMXAr2
	nhx2+Fd0gBtZNg3S9vyrdwVMZtebOrqD5S7QA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cx8OdfnGnGS1gC0qsYzKDYF2HH2x92TI
	BuG5cjmD8SyWF53Mel2AQqqrP2vuRS97PLXxF5RWo5Sl1V/mO7nlrZUpAaTwXV5N
	yB4SwwWcums67PlKASrG07Fs5755ChL80dS/T47TP0fM8VtEPKBs6YrliXzRpc93
	1iWKva9+oEA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BC9526385;
	Mon, 26 Oct 2015 15:53:30 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1489E26382;
	Mon, 26 Oct 2015 15:53:30 -0400 (EDT)
In-Reply-To: <CAGZ79kb2kStk0+MqUXREH3g+rqbsXoNiTGj=4SxJ4vOR8TqEcA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 26 Oct 2015 09:28:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B11B7FA-7C1B-11E5-A891-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280213>

Stefan Beller <sbeller@google.com> writes:

> IIUC at the time submodules were invented, there was need for lots of
> code to be written.
> Each command needed new code to deal with submodules. As there was not
> enough people/time
> to do it properly, the "do nothing" was the safest action which could
> be added fast.

That is quite different from how I remember.  Soon after Linus and I
added the Gitlink in early Apr 20007, an early subproject/gitlink
(thought) experiment was started with help from folks like Steven
Grimm, Jan Hudec, Petr Baudis, Alex Riesen etc.  The first principle
of the design throughout that era was "we admit that we do not know
all the use cases, so let's start small and solid and make sure that
small-and-solid thing can later be enhanced as people discover the
way how they want to work" (you can see me expressing that sentiment
in $gmane/48287, for example).

So it wasn't "not enough people to do it properly" at all.  It was
"we admit that we do not know what is proper, so we defer to actual
users to define what is proper for them".
