From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Tue, 27 Jan 2015 11:30:46 -0800
Message-ID: <xmqqvbjskom1.fsf@gitster.dls.corp.google.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Prem <prem.muthedath@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 20:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGBqr-0001WR-3j
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 20:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758980AbbA0Ta7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 14:30:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751662AbbA0Ta6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 14:30:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CF383102E;
	Tue, 27 Jan 2015 14:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEDZAWu6bmZmO7Mpz++q/h67S8E=; b=KABK9a
	hoyKdEH6GjyXtLgN+aIZpvTwd8WMs+M6zQdTBrYq6Pq6p79XCUyT8jfgrc/wA7Vu
	nWjmivckyYwGdW7Qmi+GrCZUuKfxkTrmjygnqdXDAruEej8YUN4A7gKaX2P5pcFf
	m1MsftL4OMfswV07FtFEtTG1/vRczEvchgHCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vc/S+nluEmNPSwsaMi2YXcOdo2Y0PyFB
	w3IZE5ANbeGNqEl2LofaaYNd4LNhTM4bXlwA0gf6JB4pdEehxwz/i30TfUxRzMsk
	br07H16ABRiHCcQzirTx3OQlLdPBxd8jVedTA9nk0bT4zgjwL48/aBqL6FiAk52n
	sPLqOV3l2hA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 698943102D;
	Tue, 27 Jan 2015 14:30:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3E063102C;
	Tue, 27 Jan 2015 14:30:48 -0500 (EST)
In-Reply-To: <d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 27 Jan 2015 13:35:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF52A562-A65A-11E4-877A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263083>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As per the code, the --repo <repo> option is equivalent to the <repo>
> argument to 'git push'. [It exists for historical reasons, back from the time
> when options had to come before arguments.]
>
> Say so. [But not that.]
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Thanks for digging up the thread, Junio. I never would have thought that
> I had been with the Git community for that long already...

;-)

I think this update will do for now, but in the medium term (read:
by the end of this year, or earlier if somebody is motivated
enough), we might want to:

 * deprecate --repo=<repository> as it is very much no-op these
   days (that is, strike "But not that" part above);

 * dig deeper what Prem wanted out of their imagined semantics of
   the --repo=<repository> option.  I suspect that it has something
   to do with support of triangular workflow, and

   - it might turn out that there is a better way to do what Prem
     wanted to do without that option but using other existing
     mechanisms [*1*], in which case we can stop there on the code
     side, and clarify how to use those other existing mechanisms in
     the tutorial.

   - or it may be that we do not have a good way to achieve what
     Prem wanted to do, and that a *new* option to specify the
     target URL from the command line, like Prem used the --repo
     option may turn out to be the best way forward [*2*], in which
     case a code update may become necessary.

Thanks.



[Footnotes]

 *1* For example, in 1.8.3 we saw some changes around triangular
     "pull from one place, push to another place" workflow with
     remote.pushdefault configuration, and branch.*.pushremote lets
     the users control this even at a branch level.

 *2* I say "may turn out to be" because we cannot tell if that is
     the best solution until we know what was really what Prem
     wanted to do---we may be looking at an XY problem after all.
