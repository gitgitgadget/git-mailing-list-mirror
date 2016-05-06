From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 06 May 2016 13:09:55 -0700
Message-ID: <xmqqd1oz2bjg.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
	<CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
	<xmqqr3df2end.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaJYngaZfhx060C06J57aDqPJfdMD8xzK4dW4nvvktMLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: felix@debuggable.com, Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:10:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aym4Z-00033Y-I3
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 22:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbcEFUJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 16:09:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758265AbcEFUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 16:09:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F24A18963;
	Fri,  6 May 2016 16:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3+GSbyhbptxxdNqiJP5gGtSnzw=; b=fNw9h+
	pEE8MCLLTIaK4nwjpf6eF93BARPaq9SQ7wmyxiOKZYT/ofbHgesgLVz69UrG+WOy
	0SYFyMqsobdmUG+TqbTEvi4jTvwzL8lZ6HQjdKjHg2aUXrg0fdZtmh60h4cG0g43
	rmomhyKuXPxnTGv3SvaHOT0O3CTzFsIZhEsEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e0TjbQnlcRhKGZQ5pAsgY6NKmSSo3WeB
	9Kk+qguJJt4bEofxhNsZW0XwSERkHflRJki2s/AN72qYnRXv1y2Fmo/jn0fhpSYs
	ychENRwmhXfghPMRONSHkC0oQHuVMQ4zuthbqtCJo+conkUEnUG0Qk7XGh1+Cr8m
	Icq8Vgwbc3U=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8660018962;
	Fri,  6 May 2016 16:09:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0074918961;
	Fri,  6 May 2016 16:09:56 -0400 (EDT)
In-Reply-To: <CAGZ79kaJYngaZfhx060C06J57aDqPJfdMD8xzK4dW4nvvktMLQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 6 May 2016 12:18:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8100B58E-13C6-11E6-B480-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293856>

Stefan Beller <sbeller@google.com> writes:

> It was a bug, but now people in the outside world consider it a feature.
> Search for "Git fake submodules" and you'll find a few users who use this
> technique successfully.
>
> I do not think fixing this bug would do good. So maybe we just let it slip?

I am OK with leaving it unfixed, iow, we just say this:

    If deep/in is a different repository, whether it is a submodule,
    "git add deep/in/the/tree/is-a-leaf.txt" will give an undefined
    result.

But that is totally different from accepting it as a feature.  If we
were to accept it as a feature (and we will not), then

    I did "git add deep/in/the/tree/is-a-leaf.txt" and have kept the
    path tracked.  Today I did "git add deep/*" and then the path
    disappeared from my project--I now only have deep/in as a
    submodule, which is not what I want.

would become a valid bug report.  I do not want to see that happen.

I.e. I am *NOT* OK with polluting the codebase with a hack to
respond to such a bug report, e.g. by adding a rule that says "if a
file deep/in/the/tree/is-a-leaf.txt is tracked and deep/in is a
repository, 'git add deep/in' must fail".

The stance "It is a bug, but we do not fix it right now.  The
behaviour is undefined" also leaves the door open for a future
enhancement that allows 'git add deep/in/the/tree/is-a-leaf.txt' to
be an equivalent to 'git -C deep/in/the/tree add is-a-leaf.txt'.
