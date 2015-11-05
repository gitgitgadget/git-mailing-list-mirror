From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: accept death by SIGPIPE as a valid failure mode
Date: Thu, 05 Nov 2015 08:21:53 -0800
Message-ID: <xmqqvb9g76xq.fsf@gitster.mtv.corp.google.com>
References: <9A3BCDA2-5915-4287-A385-95A3ACCBB850@gmail.com>
	<CABA5-z=1N5=8huSr=BLmjj_KHLbMMiXdo0qok7Mc_ZOeB=J9jA@mail.gmail.com>
	<CFEB6E3F-48A0-41D8-A8FD-D48B806461DB@gmail.com>
	<xmqq8u6qluh2.fsf@gitster.mtv.corp.google.com>
	<xmqqvb9ojcmf.fsf@gitster.mtv.corp.google.com>
	<xmqqr3kcjbll.fsf_-_@gitster.mtv.corp.google.com>
	<20151105074730.GA6819@sigill.intra.peff.net>
	<457EAFF7-C649-4DEB-BB9E-E82851DC7F8A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	Fredrik Medley <fredrik.medley@gmail.com>,
	patrick.reynolds@github.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 17:22:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuNIZ-0001Bu-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 17:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161977AbbKEQV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 11:21:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756289AbbKEQV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 11:21:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F87F26AA3;
	Thu,  5 Nov 2015 11:21:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8T1LpERtZFWOwF/fOVEi8fuJ/xc=; b=uRJ+Qy
	YBdAubH7Z+6e/DyegVqceg1uicKvohsNC81tzZowuo7ubQ7/WlmmJLfmeRK4UuNx
	GMUiayGhroB6oCvyS8LMgL7Ndx6s9h2c+TSZ3ehVrmEunfoxTj7WZB/tZsRvevkY
	+Uv5DHKXD2NEm5IrpzbJhjw4GGU9J0d92yzgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PJXnonn998QuEuVlGyUq/O9UJngXs0ZB
	JWzSY7Th5YWJGegMYEG4UuAXvuamhqcuFNCvHVXIxLiew5tZgKiwrC39ZLcEoVc5
	zKvd9iW/qeAkhTM+aO50YnLwFF1vg1MrMYsjfPBBm3U2Vtk+FZq0xRjDGqpkbIZ7
	E27G0wHxVrs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24F6826AA2;
	Thu,  5 Nov 2015 11:21:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4FD1326A9F;
	Thu,  5 Nov 2015 11:21:55 -0500 (EST)
In-Reply-To: <457EAFF7-C649-4DEB-BB9E-E82851DC7F8A@gmail.com> (Lars
	Schneider's message of "Thu, 5 Nov 2015 10:34:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 547F14EC-83D9-11E5-B041-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280923>

Lars Schneider <larsxschneider@gmail.com> writes:

> Oh, I missed this email thread. I am still working on a stable
> Travis-CI integration and I ran into this issue a few times. I
> fixed it in my (not yet published) patch with an additional
> function "test_must_fail_or_sigpipe" that I've used for all tests
> affected by this issue. Modifying the "test_must_fail" function
> seemed too risky for me as I don't understand all possible
> implications. However, if you don't see a problem then this is
> fine with me.

It's not that I don't see a problem at all.  You constructed a good
summary of the issues in three bullet points, that lead me to think
that it is the right approach to tweak the way the tests evaluate
the outcome, but then nothing came out of the discussion, so I sent
out a "how about doing it this way" to make sure this topic will not
be forgotten.  There is nothing more to it, and "how about..." is in
no way final.

There obviously are pros and cons between introducing your new
helper to mark the ones that are allowed to catch SIGPIPE and
changing all occurrences of test_must_fail.  I do not have a strong
opinion yet, but it needs to be discussed and decided.
