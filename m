From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sun, 23 Nov 2014 10:10:47 -0800
Message-ID: <xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>
References: <546F5CC7.8060904@drmicha.warpmail.net>
	<b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
	<20141121180105.GB26650@peff.net> <5470A4C0.3070501@web.de>
	<20141122191932.GA13340@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:11:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsbcq-0002zs-RD
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 19:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaKWSK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 13:10:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbaKWSK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 13:10:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EF2418515;
	Sun, 23 Nov 2014 13:10:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k6OghUEbW/AXP1v4IzU/cECrjrg=; b=ZPgtqY
	Tlpdkgsl8YeWO+XSTP7PMlN/1lBYbiw97GCV2GZw91P1+QpiAFpar57lA39IKAZt
	YuP62Tc3iXDz9E8j1srLj3EtvOElQB7KTz6DWgD08hpKpOeUi4Bin70/L6MT3tUJ
	QNXeYxzNe9Ns74qf4/dTYpSfU/w+Xpp9bhi0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VCXSkHs9STY6X6TjTz6TU4yjSN0voOY8
	FsjG1jQDwSCNrGQlBTNRUHvxoBfYShOF+5ycLCjUaLdiY5S6v4zFb7VX+jxizyqF
	JD7pqCUXg7u1Ioi/0SF6di2ZYkRADu+PKoakfLFLKq/0Nn2DxGlu9oD7uNLnvnaZ
	dN2OdrrNud8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8415418514;
	Sun, 23 Nov 2014 13:10:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D2C018513;
	Sun, 23 Nov 2014 13:10:48 -0500 (EST)
In-Reply-To: <20141122191932.GA13340@peff.net> (Jeff King's message of "Sat,
	22 Nov 2014 14:19:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D90FA72-733C-11E4-817F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260092>

Jeff King <peff@peff.net> writes:

> ... Possibly because I do not know that those instructions
> are written down anywhere. We usually catch such things in review these
> days, but there are many inconsistent spots in the existing suite.

t/README has this

    Don't:

     - use '! git cmd' when you want to make sure the git command exits
       with failure in a controlled way by calling "die()".  Instead,
       use 'test_must_fail git cmd'.  This will signal a failure if git
       dies in an unexpected way (e.g. segfault).

       On the other hand, don't use test_must_fail for running regular
       platform commands; just use '! cmd'.

Though it can be improved by justifying "just use '! cmd'" further
with a bit of rationale (e.g. "We are not in the business of
verifying that world given to us sanely works."), I think the
current text is sufficient.

Do we refer to t/README from CodingGuidelines where we tell the
developers to always write tests to prevent other people from
breaking tomorrow what you did today?  If not, perhaps that is what
needs to be added.
