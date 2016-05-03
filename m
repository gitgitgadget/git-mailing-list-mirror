From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 03 May 2016 14:01:47 -0700
Message-ID: <xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:02:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhSF-0000FY-2C
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbcECVB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:01:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756639AbcECVB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:01:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E88E21936C;
	Tue,  3 May 2016 17:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LnE8+JpyA2XSgkEKcwwxE04ILSY=; b=tTtLKr
	ybY70QDB6sGLXdYOfI+rBjmoueUYmnsFtlVojBn/q6Gy+87rqzw8cWMpwUsqf4+W
	NPlfAZEwNoRzBVejD71E7Ddlsa9ThraaQmCZMVb0DsAmDfb+lJXbVk82WKLcZod5
	O5wA3wRFjZ3uBWRZABUcKRJ9W0ujPzZ6HiK60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJpOVMlJkzmrIqwP24dn5sFpJ9TMnF51
	j5AXOQEqfTw2v7/OrkgcKyG5oVskWO1XcZGOSNg0VDhX/cfI7gh+HlKDyoBI2jT7
	vECpVzeH4/f7MFXLkmi0PzXWJOHglpeoRQVAefY3kyDMyL4af/b6/yw0QY+bQtYY
	Q8CvFA/Y36I=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E053A1936B;
	Tue,  3 May 2016 17:01:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4718D1936A;
	Tue,  3 May 2016 17:01:49 -0400 (EDT)
In-Reply-To: <CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 13:53:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40D58792-1172-11E6-BEFC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293454>

Stefan Beller <sbeller@google.com> writes:

> I have your patch here and have a "-a and pathspec are incompatible" fix
> build on top.
> * I do wonder if we want to have the shortform '-a' though.

I do not particularly care.  I was merely matching the other two
options there.

> * I think we want to head for consistency, eventually.
>    e.g. commands with no arguments such as tag, branch
>    give a list of their respective domain.

Isn't that a historical mistake we are regretting, though?  Only
after many other operation modes were invented and "create X" proves
not to be the only primary modes we had to invent "tag -l" and
"branch -l".  Aren't we better off not having "no option means list"
kind of default?

>    Subcommands do not give lists by default, e.g.
>    `git stash clear`, `git remote prune`
>    which are the moral equivalent to
>    `git submodule deinit` just work as they were told, no --switch needed.

I wouldn't say "git rm" should remove everything by extending that
logic, but I can certainly buy if somebody argues "git submodule
deinit" is not destructive enough to warrant extra safety.
