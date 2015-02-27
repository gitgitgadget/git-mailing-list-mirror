From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-rename: avoid processing duplicate destinations
Date: Fri, 27 Feb 2015 13:48:11 -0800
Message-ID: <xmqqr3tbhvqc.fsf@gitster.dls.corp.google.com>
References: <20150227013847.GA2983@peff.net> <20150227014227.GB3210@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRSlo-0000G9-H4
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbbB0VsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 16:48:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755007AbbB0VsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 16:48:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2D73BB36;
	Fri, 27 Feb 2015 16:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sbxPRf3iMjYxo4ct4JfwHWSNaRE=; b=SbI/p5
	GjRoiWnKrlqnvYdlZ9o3tnKfiH+WACehENWjGjNBMdnX78qYYMv8B6qjiprR3p5D
	a94yMZ4iwztlNQLXxiYHuXZ3XPHaHvudbtBP5jTrW1lcsMVvFfGlhKXHZy5MD6pb
	0xP0OJbhLbX56IlguNsMCuNVrOH5Y06m1zoqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoyVuZW0cO+ShgrdBEqAtjoaBvTau1Pf
	FG15W7bhpYQCsfSIQYxgLgWzCFbgYbSjWfNNq+59E8Q2mwggRCcL/7ViiGLrtOlM
	iOTVMKnM0xiosPOVtiHH8+27KEOZgLvv+co6MOjPBj/4l3q7+mUOGK/SZXQgewdF
	yZ7cef2CQnU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C29983BB35;
	Fri, 27 Feb 2015 16:48:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 634533BB21;
	Fri, 27 Feb 2015 16:48:15 -0500 (EST)
In-Reply-To: <20150227014227.GB3210@peff.net> (Jeff King's message of "Thu, 26
	Feb 2015 20:42:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5572A9C4-BECA-11E4-84CD-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264509>

Jeff King <peff@peff.net> writes:

> Like I mentioned before, I'm OK with not checking the actual diff output
> in the test. It's not like it was planned, and is just what diff_tree()
> happens to produce.  It does make sense, though....

When the topic is on processing broken input, I do not think "It
does make sense, though." is a primary point, unless the result
expected by these tests is the only possibly sane outcome
(otherwise, another equally-sensible output will be rejected as a
test failure).  So I agree that there is a possibility that we might
regret having the diff output tested here in the future when
somebody further works in the area.

But let's not worry too much about it for now.

Thanks; the solution seems reasonable.
