From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] activate diff.renames by default
Date: Tue, 23 Feb 2016 11:17:12 -0800
Message-ID: <xmqqa8mr1bk7.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:17:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYISV-0001gm-B9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbcBWTRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:17:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcBWTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:17:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC5D844EB3;
	Tue, 23 Feb 2016 14:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bM3Bd2aItzM5jaXOb9YawF3PvTo=; b=b2U4Ws
	Zk2cpNoH2FLZTFOamTLIELUpE/f39SOrfSG8yAIbX2HAX+lhv7nSxAXhjVKOHD6d
	/tOH6SID9l7ELBP5nGBAdem7RABqa/BGhF/97C1o0plM69GJf/+1etsOQuEESuKz
	CrENJ6QrrZcP7jcF5/x6nuY9V61LaTDrMEug8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNJJjZ0RkUYbAZpo8gPzWaVs2yP1BRrG
	8ChF1/I2PUxlF20LtfQyw62EuPT+7ygyQdD9ma3+zO33mmVMh0Cr6JIxe2VCT4yF
	T+mQU6kl/jVdBcR2few9ucuwt0a5QrGCiSNMDsVTsB5jm6YNb2MPY9mT4ZpS+kCz
	t5gvuCjXOJs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3B1444EB2;
	Tue, 23 Feb 2016 14:17:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 49B9F44EB1;
	Tue, 23 Feb 2016 14:17:13 -0500 (EST)
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Tue, 23 Feb 2016 18:44:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B22D02E-DA62-11E5-BFDA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287104>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I have always wondered why diff.renames was not activated by default.
> I've had it to true in my configuration for 9 years, and I've been
> teaching newbies to set it for a while without issue. I think it's
> time to activate it by default, but please let me know if I missed a
> reason to keep it to false.
>
> In any case, the first 3 patches are useful cleanups.

It's a long time coming since I heard "I love how I can just say
'oh, keep in mind that we might want to..' and 24 hours later you
did it." [*1*]

I can hardly be an impartial judge for this series, though.

[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/3541/focus=3702

> Matthieu Moy (5):
>   Documentation/diff-config: fix description of diff.renames
>   t4001-diff-rename: wrap file creations in a test
>   t: add tests for diff.renames (true/false/unset)
>   log: introduce init_log_defaults()
>   diff: activate diff.renames by default
>
>  Documentation/diff-config.txt |  7 ++--
>  builtin/commit.c              |  1 +
>  builtin/diff.c                |  1 +
>  builtin/log.c                 | 16 ++++---
>  builtin/merge.c               |  1 +
>  diff.c                        |  5 +++
>  diff.h                        |  1 +
>  t/t4001-diff-rename.sh        | 97 +++++++++++++++++++++++++++++++++++--------
>  t/t4013-diff-various.sh       |  2 +
>  t/t4014-format-patch.sh       |  4 +-
>  t/t4047-diff-dirstat.sh       |  3 +-
>  t/t4202-log.sh                |  8 ++--
>  12 files changed, 114 insertions(+), 32 deletions(-)
