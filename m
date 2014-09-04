From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Thu, 04 Sep 2014 10:21:50 -0700
Message-ID: <xmqqiol3uwr5.fsf@gitster.dls.corp.google.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	<xmqq38c8waub.fsf@gitster.dls.corp.google.com>
	<CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPajO-0001GN-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbaIDRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 13:21:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55910 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaIDRVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 13:21:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12A1037E64;
	Thu,  4 Sep 2014 13:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZ0WVNynrPLG6KopsC4VmXCJTK0=; b=adPmMM
	d6XUdMBBaHrKOAoDTfRAXd7P/KtVYCVhYoFrDFcdWo1n1z8Vk5eAAiEAsTTnfWDe
	9K8+PB21/8hUfc22x0v+EBftuQcmrWR6Yq3gbppwuQio9D6eF66TWKjLyG3nSH3c
	AwnoX9WpMAY4GJdGb0UD7132///mzWPcyO3Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jbc11K/FU7XG1NAmhxwKXKz1YJyhteSM
	T1pj0MX1IKyxcMj5Kuote019pwen74OpLtw+rAU5BnK7+mKapoH5tG7qnejfk8sg
	g0r5LHsWykqt3pvfWhAtTwT+IuznewyaKMGkAhoUFB+DkkbUwNQHekY89vuWPhQp
	+wSoKXcuARA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 053A937E63;
	Thu,  4 Sep 2014 13:21:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6EC8F37E62;
	Thu,  4 Sep 2014 13:21:52 -0400 (EDT)
In-Reply-To: <CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
	(Chris Packham's message of "Thu, 4 Sep 2014 12:46:43 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F628F8E4-3457-11E4-89AC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256452>

Chris Packham <judge.packham@gmail.com> writes:

> Another thing that I've since realised is that this 'gitk' format is
> also what you've get from git show or git log -p. So this is actually
> allowing (for better or worse) things like 'git show $sha1 | git am
> --patch-format=gitk'[*1*]. That may mean that we should call the
> format something else ("pretty" perhaps?) and note that this is what
> gitk, git show and some incantations of git log generate.

I would not call it "pretty", because "--pretty" is merely a
short-hand to "--pretty=<some format name>".

The output format indents the log message text by four spaces for
human reading to make it stand out from the patch text, and not
meant for machine consumption.  I doubt that a patchset that does
not update mailinfo and mailsplit to extract information and to undo
the indentation could be a right solution.  "am" itself should not
be mucking with the input files.
