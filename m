From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sun, 28 Feb 2016 11:39:22 -0800
Message-ID: <xmqqd1rgeiad.fsf@gitster.mtv.corp.google.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
	<CACRoPnT6Yc_vfrYvzKctL1dDkZCzme-4emLF0MysJq4f_H2OvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:39:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa7Bi-0007bf-9K
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 20:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbcB1Tj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 14:39:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754600AbcB1TjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 14:39:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2442C478AC;
	Sun, 28 Feb 2016 14:39:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GI+9nKAvIqgA4bsux8BrZScyOR8=; b=MolAoQ
	d9LLLp5IThxrvJ/K8ZzWX3EJlK+SxuCMEUUaK4QTJvwYyiQhI4Hg0J1+FhyGqvSw
	ipIe6rIGApCp9EeLr4BLMY/45RlRnCWgr5+FNCgdvVpZ9ERVu/5v3r7isGdOl4pB
	K440p7pvzIip0KLOLWUZDMgXcma3xw2laIyYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNKOWynj8dJ77EyAuhQFjrfA5fUIu4iY
	rggb97uobNw/osGSY3nVO0uOSNAdKHFJ9CD+KSSCKciP9/8/q5EqtIRMW/HOZLRP
	/HzjJ7AmnKMojjayO0xhejRp9VC7pixi8O8fl9jtMl7eOuDRnakaCps2ORNjgIQb
	Do8VB9g5MFs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BF20478AA;
	Sun, 28 Feb 2016 14:39:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93CD0478A6;
	Sun, 28 Feb 2016 14:39:23 -0500 (EST)
In-Reply-To: <CACRoPnT6Yc_vfrYvzKctL1dDkZCzme-4emLF0MysJq4f_H2OvQ@mail.gmail.com>
	(Paul Tan's message of "Sun, 28 Feb 2016 20:28:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8206B86-DE52-11E5-82F3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287787>

Paul Tan <pyokagan@gmail.com> writes:

> Ultimately, git-pull needs to be aware of whether autostash is active
> or not (and this means rebase.autostash needs to be looked at as well)
> because if autostash is disabled, git-pull needs to perform the
> "worktree is clean" check. And this "worktree is clean" check needs to
> be done *before* git-fetch and git-rebase is run.

Ahh, right. I forgot about that discussion.
