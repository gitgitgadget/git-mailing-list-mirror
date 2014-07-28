From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 08:35:52 -0700
Message-ID: <xmqqy4vd4ht3.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net> <20140728104409.GC10737@peff.net>
	<CAGyf7-GVz8ME0Mq_DyHCSFCx5KN6qLGEgtgMSv2NkKb9AGEGdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 17:36:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBmy9-0005lv-QA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 17:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbaG1PgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 11:36:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54259 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbaG1PgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 11:36:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42C952B23D;
	Mon, 28 Jul 2014 11:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VAQGDe2KKM2yUjjjOeDyK8MccNc=; b=SQTbJq
	MUkYAC9zkCs5Cv4DmFD/fuEvHXBPu00lywXNwLrPN5dJ1+/ICBRTpsiCTYwM2w8U
	qMAOg7zIz+6CiehCGpEd/T+201JTZdsmLEkmqwPU8ONk0a1b9FuMYq5HI5PqmhPm
	X9xQjGgvNUqJ/EThqsPVLz5XePpyoRXmhA1OY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0/x91K8d+zmBsfCAcMZTLZurDaUOnAy
	ykh6hEK1PzYFqCAyt5ZlWC290oVZeiLo53An6+FVlnN/HMkaSQNZp8ws6hjY6y8K
	gByvQ14jvfGU/0bJXM8F7ONHmoKkhUf99coszqXG6O4DbqusgsYJs1opF9GxqBkQ
	qvFZMCmUXac=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09D7E2B23A;
	Mon, 28 Jul 2014 11:36:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C748A2B22E;
	Mon, 28 Jul 2014 11:35:53 -0400 (EDT)
In-Reply-To: <CAGyf7-GVz8ME0Mq_DyHCSFCx5KN6qLGEgtgMSv2NkKb9AGEGdg@mail.gmail.com>
	(Bryan Turner's message of "Mon, 28 Jul 2014 22:08:20 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC6B6A4E-166C-11E4-947D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254325>

Bryan Turner <bturner@atlassian.com> writes:

> It looks like refs ending in a dot are now legal in 2.1.0? Is that
> intentional? A quick git bisect is fingering:
> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
> 745224e04a03e4544c58d5d38d3c54f67100f8eb is the first bad commit
> commit 745224e04a03e4544c58d5d38d3c54f67100f8eb
> Author: David Turner <dturner@twopensource.com>
> Date:   Wed Jun 18 01:54:42 2014 -0400

Thanks for a report.

I am tempted to revert that series; it already caused "oops, this
needs a further fix" before it hit 'master' at least once, and we do
not want any more headaches at this point in the release cycle.
