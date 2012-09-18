From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confused by git am error message.
Date: Tue, 18 Sep 2012 15:51:37 -0700
Message-ID: <7vr4pzj66e.fsf@alter.siamese.dyndns.org>
References: <747F66C694C844EAA56F4BB62C405F78@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE6e0-0007VB-DN
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 00:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab2IRWvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 18:51:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776Ab2IRWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 18:51:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B71C99256;
	Tue, 18 Sep 2012 18:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJaNQKUKKgQEvmxpfuoF3uQQy1Q=; b=OgOxYq
	ZfSWDtAUtt8Uie5u0H7RwhYaPw8ueN6SUG98YcWkWqF2dnok4uRAFOuU0RbOWIMn
	FNo7jee1N7eg/HpB7NZE1m0C1GUv86rpza6WAvQOF0ug+ZrCIEWkYdLs9JH7pp37
	Zmz2eDsHD+BreTdenwgqKwacEU1sP7vxu0DEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDiQtNBF2MPrH1p5W/4MyklA5txYf8Sl
	Og95aThvEkpOulb+ZmA1qND+47YTuGlPsZ7NR9e4GPLd0GGkXQLeYhMJNsGt+pz2
	BiJg9Oc2P+OlqSftYbCJaaQT9YVSjzrvLL3T63CRdMmqlbHZbFWmxW/SmDbVI2Ch
	iQmd/az/R7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A43459254;
	Tue, 18 Sep 2012 18:51:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 214159253; Tue, 18 Sep 2012
 18:51:39 -0400 (EDT)
In-Reply-To: <747F66C694C844EAA56F4BB62C405F78@PhilipOakley> (Philip Oakley's
 message of "Tue, 18 Sep 2012 22:51:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 682BB598-01E3-11E2-B12E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205883>

"Philip Oakley" <philipoakley@iee.org> writes:

> [a user confusion report]
> I was updating my patch series manually aand made a mistake, so the
> series didn't apply properly. However the error message confused me.
>
>    ...
>    Applying: Doc clean: add See Also links
>    fatal: corrupt patch at line 17
>    Patch failed at 0008 Doc clean: add See Also links
>    When you have resolved this problem run "git am --resolved".
>    ...
>
> In my case I resolved the _patch_ error, and then expected that doing
> the 'git am --resolved' would try to re-apply the patch and continue
> happily - I had checked that the status was clean - but it didn't.

I recall we went back and forth before settling to the current
wording.  The "have resolved this problem" in that sentence wants to
say "The underlying 'apply --index' did not manage to update the
working tree and the index to the state a perfect patch would have
updated, so please help me by doing so yourself".

When it did not apply (i.e. not "conflicted when run as 'am -3'"),
an alternative is to edit $GIT_DIR/rebase-apply/patch to make it
applicable, and say "git am" again _without_ "--resolved".  But that
is not what the message is suggesting.
