From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update diff-highlight
Date: Sun, 21 Feb 2016 23:50:50 -0800
Message-ID: <xmqqh9h189ph.fsf@gitster.mtv.corp.google.com>
References: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Dave Hello <hsu@peterdavehello.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:50:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXlGk-0006jV-N5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcBVHuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 02:50:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753706AbcBVHux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 02:50:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E27842E03;
	Mon, 22 Feb 2016 02:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OFLzYTwMNGwReQuXaQzHSFUsTno=; b=QDrN7r
	csuU7XLuLhR144HU8yP0lF8YTldwKSxZBXtggMSSFrPDrHs/z8MOn02MsgwLlJOx
	Y14RnCMZ5HQfOTYvCaeG018mc0LiP66zL0fIXL2dUBT9SPULg3zdzMcjjxmoa7tL
	DWM3y2njCS4K7qnRLBGXpeUkCEcic/pCs/CNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ql+CbLGi3r1eTeqnkz9YWMXdsGsbVKSh
	2RaBVTq3Moqs9R6SkSpWjLui6CNFjXLVdHB+xJfI18II9+wTeFfzHBSoY0FUmlgU
	VrAQxHm8QFjf/urqLF6F57wWjnqheq0BO1UV2LUE81LBCso3gfwqXg6wxDq1giwX
	AUtgXkQai6w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8499C42E02;
	Mon, 22 Feb 2016 02:50:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0291242E01;
	Mon, 22 Feb 2016 02:50:51 -0500 (EST)
In-Reply-To: <00000153072f5465-fd36f07c-e5e6-4a0f-8cf1-77be99424892-000000@eu-west-1.amazonses.com>
	(Peter Dave Hello's message of "Mon, 22 Feb 2016 04:14:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FEC28C90-D938-11E5-B066-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286891>

Peter Dave Hello <hsu@peterdavehello.org> writes:

> From: Peter Dave Hello <peterdavehello@users.noreply.github.com>
>
> Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`

Even though there are existing examples in contrib/ parts that use
this pattern, we try to avoid use of #!/usr/bin/env in more serious
parts of our system.  This is to control the exact interpreter used
to run our scripts at the build time, and to avoid interference by
end users' $PATH environment.  So adding more use of #!/usr/bin/env
is not quite a welcome move, even if it is to contrib/ part.

Perhaps you can instead mimick the way how contrib/subtree uses the
same SHELL_PATH used in the primary Makefile (and config.mak) to
turn git-subtree.sh into git-subtree command.  Rename the source to
diff-highlight.perl, and use PERL_PATH when build procedure turns it
into diff-highlight?

I think that is more in line with the rest of the system.
