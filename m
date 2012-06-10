From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 00:15:09 -0700
Message-ID: <7vr4tnab9e.fsf@alter.siamese.dyndns.org>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:16:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdcNQ-0008KE-3q
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 09:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab2FJHPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 03:15:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FJHPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 03:15:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 754A53BBA;
	Sun, 10 Jun 2012 03:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUQnUa4QmxtUGTEUKi7Q1TlrbB8=; b=T7YGcX
	e9mhT7qwdVfsW3dk7NbMM2K3Gwm23bYNVwGlD0TjD1oTBAzDX55BV+dDtUADkhxZ
	QQ/3MdxwgqWhD0QsvqgjLL4/ls6ZvgUsBhCPxRvGMBvPOH7djoREEmIS18qWwB8r
	dzwUwv2gLmgw+OXY2XvWQHmcczu1xCy681dkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2F59A2R/1mXoSKsXUQmqIgtghkbajXs
	0K8TEsMT+4gYc7QRtW8QFScPwaNuWP271EcNvIB5LnGc4i1hS8qAZfLsqczkFAFm
	d2J906S7TeIUk4691YTLPQGoPGseePeVKXArb5rolS6A2JagOd3g7TOpGBMP29KI
	XLFfFs41Gf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CC333BB8;
	Sun, 10 Jun 2012 03:15:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B2023BB7; Sun, 10 Jun 2012
 03:15:11 -0400 (EDT)
In-Reply-To: <1339270806-65013-1-git-send-email-muhtasib@gmail.com> (Leila
 Muhtasib's message of "Sat, 9 Jun 2012 15:40:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0458E97A-B2CC-11E1-93BE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199571>

Leila Muhtasib <muhtasib@gmail.com> writes:

> git-status now lists empty directories under the untracked header. Before this
> modification, git status did not list empty directories. The header changed
> from 'Untracked files' to instead display 'Untracked files and directories'.
> A helpful reminder is also added after empty directories indicating they cannot
> be added/staged if they are empty. git status -u is unchanged, and will still
> only show untracked files just as before. As a result, no need for
> documentation change.

Please do not write a thick wall of text like this.  State the
problem you are trying to solve first, by describing the current
behaviour you want to highlight, and explain why you think the
current behaviour is bad.  Then describe how you propose to solve
that issue in a separate paragraph.

For example:

> git-status now lists empty directories under the untracked header. Before this
> modification, git status did not list empty directories.

The above is backwards.

	"git status" lists untracked files and directories full of
	untracked files, but does not list empty directories.  This
	is bad for such and such reasons.

Then describe your solution (which should be a short two sentence in
this case, because in the problem description you would have justified
adding "empty directories" section).

	Show empty directories to the "Untracked" section as well.
	Because an empty directory by definition does not have
	anything that the user could add, suggest the user to create
	a file to be committed and then add it.

Having said all that, I personally doubt this is a useful change.  I
may thought of adding a README file to a relatively new project that
does not yet have one while in shower but I haven't even created the
file in the working tree.  And I forget about it once I get to the
office.  Should the system remind me to create README and then add?
Your patch would not give me such a reminder once the top-level
directory is populated (because it is no longer empty).  Even if I
were planning to add Documentation/README instead, I would get such
a reminder only if the Documentation directory is empty. Once the
directory is populated, I wouldn't get "create README and then add".
Why should an empty directory so special?
