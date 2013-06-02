From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Sun, 02 Jun 2013 15:24:09 -0700
Message-ID: <7va9n8m9rq.fsf@alter.siamese.dyndns.org>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
	<vpqtxlko1vn.fsf@anie.imag.fr>
	<CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
	<vpqhahko0ub.fsf@anie.imag.fr>
	<CALkWK0ns3iVATnPwZ4OFJUxefyE6j-ayV3-iwh3Wr9FBZJyt1g@mail.gmail.com>
	<20130530171431.GF17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Campbell <michael.campbell@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:24:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGhT-0006Ns-Er
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab3FBWYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 18:24:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab3FBWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 18:24:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F3424150;
	Sun,  2 Jun 2013 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CxxeY4iBgyLNLS6lg3fyQDounxw=; b=W4XdbN
	7ysA7ISnR6JFdDOGu1vhPzOdtFnBoJtQwQIxc2SzZqoOp067s5FolTKn3HN+vv2d
	S6MLtDoHjHfeX2fKJqJm/Lx5NTJTTIm4+sElsM8d5Ygs2F0m11TRbhXA6boMI9Xx
	eA//lpB6nHenJ66C6Ig28f4RaaAZVjUWapr10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ACuAYZHuiPfIIxVOZ/aobIE3NWFFmYov
	U0cQiz7ZBHBCCSjyR0z07VrXWYsdi9vEJ1US4F/eNFjDCeyAychRqoIskhzqxaTF
	JSXNm44qTiqJVg1LGKPelpmOKTkKRKAYeIy3Bms0pkn0nXy/IysCLDry1r8vtKgg
	h0UalV5/yxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366312414F;
	Sun,  2 Jun 2013 22:24:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CE1124147;
	Sun,  2 Jun 2013 22:24:11 +0000 (UTC)
In-Reply-To: <20130530171431.GF17475@serenity.lan> (John Keeping's message of
	"Thu, 30 May 2013 18:14:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 265061F4-CBD3-11E2-B591-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226187>

John Keeping <john@keeping.me.uk> writes:

> On Thu, May 30, 2013 at 10:38:59PM +0530, Ramkumar Ramachandra wrote:
>> Matthieu Moy wrote:
>> > I find it a bit weird that Git sets the configuration for external
>> > commands, but it may make sense. No strong opinion here.
>> 
>> I don't mean a setenv() kind of thing: how would we unset it after
>> that?  Perhaps something like execvpe(), passing in the environment as
>> an argument?

Running "man" is the last thing we do before exitting "git help" and
exec_man_man() does seem to do execlp(), so I do not see it as an
issue.

> Overriding PAGER might make sense, but I'd be quite annoyed if Git
> decided to override MANPAGER without providing some way to override it.

Hmm, see below.

> If a user sets MANPAGER then it's because they want a specific pager
> when reading man pages - invoking man through "git help" shouldn't cause
> it to behave differently in this case.

True, and for that matter, if the user sets PAGER to use with
non-Git (including manual pages) and also sets GIT_PAGER to use
specifically with Git, the user would be annoyed if we passed
formatted manual pages to GIT_PAGER by exporting PAGER (or driving
"man" with its "-P" option).
