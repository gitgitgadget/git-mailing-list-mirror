From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 15:26:04 -0800
Message-ID: <xmqq60yp8837.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
	<xmqqio2p89mb.fsf@gitster.mtv.corp.google.com>
	<20160119230633.GA31142@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:26:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLffR-00039b-4H
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbcASX0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:26:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933258AbcASX0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:26:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 130893D980;
	Tue, 19 Jan 2016 18:26:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EGdHsgjdzBaDpODThDOc31lQAIY=; b=Xx/luq
	2vZ84DEcqK+YkxCsV9fmzppc0grY8jcppIVNhZtPmF6IdSHbNnC+0e0poUjcNAuD
	Kw9BWXqaGjVnl5DlPGcsxfcB9tU22ranEh7Oyn2I7cTORxXN/7HGoX/psCIuJeV8
	2a5weWB3BxhgVilUYF9aRIu45jGG1vgELg7IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vz43aOHjBI5PZFKsMQjfmNkbi+rLKSFp
	qACIM5BF2Du3sHhgW2nV8ruJZC/e3V8SagoODXRzI7n1rhSIzN8pl3ktLCZ8wUd5
	hi2AeltQ0ajvgf5p5JU32ACVN44PTfUMbQIiR/FWOHa3v1VmjS9De6q1Varlowpa
	Rc+IbjLTT/E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B1803D97F;
	Tue, 19 Jan 2016 18:26:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 859EC3D97E;
	Tue, 19 Jan 2016 18:26:05 -0500 (EST)
In-Reply-To: <20160119230633.GA31142@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 18:06:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02FD8A5C-BF04-11E5-A4BA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284395>

Jeff King <peff@peff.net> writes:

> You can also note that if we ever delete a test script, it will still be
> mentioned in prove's state file. I think prove is smart enough to
> realize it went away and not bother you.

The inverse might be more problematic.  When we add a new test
script (which we still do from time to time), does prove notice
that we asked it to run more tests than it already knows about?
