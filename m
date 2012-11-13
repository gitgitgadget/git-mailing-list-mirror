From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit message problem of reverting multiple commits
Date: Tue, 13 Nov 2012 08:34:49 -0800
Message-ID: <7vd2zhfoly.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6Qn68TFVnd_8LSf6OMqHZduAFgk0Hd46E3vKgFHCjpksQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJS7-0005pD-4X
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab2KMQex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 11:34:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab2KMQew convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 11:34:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1438FA858;
	Tue, 13 Nov 2012 11:34:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KMrL4JIhYghP
	M69b1hp3DhnoErI=; b=OtKAWg5EMQlzkZJXbDtNhQQOgd5HQjpSav48xZHpBulz
	oBbM2O0VkdqEvCgI/wqq3knA6GO1V/K7JEEovZgzHNJ1/mORMvijV6GEzTOarFHF
	E8P0UMzfhAy33yTPB3Pi92hbYGE6L9UVR9aR2s16n/quc7pD517B+qZmShFB+is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VjU0SF
	iqnLl09NGal2wXKdT8Seli4BhYsS9++Nl9FBnnej1jfh3C1DA9hq4O4IeAzgRxab
	PMA95fCGvCoEsZeUxV+Dz0NUYZl4Ucexoi1VgWCRVKmKcHoTfb4XySKtAhMXwsZS
	/RNrCG2yvU4SD0WZKFFtPRjioYkb0nFlzdq0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000FCA856;
	Tue, 13 Nov 2012 11:34:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 551FCA854; Tue, 13 Nov 2012
 11:34:51 -0500 (EST)
In-Reply-To: <CAHtLG6Qn68TFVnd_8LSf6OMqHZduAFgk0Hd46E3vKgFHCjpksQ@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Tue, 13 Nov 2012 23:15:59
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C032514-2DB0-11E2-912A-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209630>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> I ran git 1.8.0 command line
>
> git revert --no-commit rev1 rev2
>
> I see a prepared commit message like
>
> Revert "<description from one commit>"
> This reverts commit <SHA1 of one commit>.
>
>
> The actual revert content is correct - it is all the relevant commits
> that were selected. I expect the message to reflect this:
>
> Revert "<description from commit1>", "<description from commit2>"
> This reverts commits <SHA1 of commit1>, <SHA1 of commit2>.

Hrmph.  I actually think the revert-content is not correct.

I think the command should not take more than one commit on the
command line when --no-commit is in use in the first place (the same
thing can be said for cherry-pick).  After all, "git revert rev1
rev2" is to revert rev1 and then rev2 independently, so unless that
option is spelled "--squash", the resulting history should have two
commits that reverts rev1 and rev2 independently.
