From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout -t -B
Date: Sun, 26 Aug 2012 11:38:45 -0700
Message-ID: <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hkG-0000sc-8g
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab2HZSit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Aug 2012 14:38:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2HZSis convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 14:38:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8538A8EF3;
	Sun, 26 Aug 2012 14:38:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/JxmdS3fZOB2
	ptZ4gy3BoPALpLE=; b=g/8P8z/UplXvfwcJXOJvFN2SiMzmSo8TuV9cxtJxVG0G
	SC70cfujbWyy56U+0R8XMZBu14kNl4gxORPP+g4E5zSVFcT/B+eKfs/ufynxAnub
	/symqhh6PlkKwu+ONQV//Kb6aTJMOaug0nDMnHMFO70skbUVkSypR+8BgIENGL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uakbDU
	/104rT33S/hQOL3C0QHLPvc1T079Iodo8gedVk8xxqAF7HQuvzPXUtGnk/fspT+J
	rmyYDb6qvE1U4kbu36YQqq8IqVrUtsEJX4wLyj4RQaqNNLh13drWRhwFjHLQz5iS
	Z6RkqUvD6L/9tgQc6wLtdYkrDQCgL7oWB2IRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72A688EF2;
	Sun, 26 Aug 2012 14:38:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB94A8EF1; Sun, 26 Aug 2012
 14:38:46 -0400 (EDT)
In-Reply-To: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sun, 26 Aug 2012 15:27:26
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4545DCAE-EFAD-11E1-B758-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204307>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> git checkout -t -B origin/abcde
> works
>
> but
> git checkout -B -t origin/abcde
> does not.
>
> Could you document the order of parameters or fix the behaviour?

It is crystal clear that -b/-B/--orphan must be followed by the name
of the branch you are creating from the SYNOPSIS section of the
documentation.

    NAME
    ----
    git-checkout - Checkout a branch or paths to the working tree

    SYNOPSIS
    --------
    [verse]
    ...
    'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<st.=
=2E
    ...

However, the option description can use some improvement.  It
currently reads:

    -b::
            Create a new branch named <new_branch> and start it at
            <start_point>; see linkgit:git-branch[1] for details.

as if it and <new_branch> are freestanding arguments.

I think we should describe the option like this:

    -b <new_branch>::
            Create a new branch named <new_branch> and start it at
            <start_point>; see linkgit:git-branch[1] for details.

The description for "-B" and "--orphan" options share the same
issue.

I suspect that documentation for other commands may share this
issue.  It would be good if somebody can check the option
description section and make sure there is no discrepancy like this
by comparing it to the SYNOPSIS section (or "git cmd -h") for all
manual pages.

I'll patch only "git-checkout.txt" myself for now; hint, hint.

Thanks.
