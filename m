From: Junio C Hamano <gitster@pobox.com>
Subject: Re: panic recovery
Date: Mon, 17 Jan 2011 10:42:38 -0800
Message-ID: <7v62tnmkwx.fsf@alter.siamese.dyndns.org>
References: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Eda Ercan <edaercan@gmail.com>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 19:43:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Peu2d-0004Gx-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 19:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab1AQSmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 13:42:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1AQSmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 13:42:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57CCE3124;
	Mon, 17 Jan 2011 13:43:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=np/6p8jRR9CfkccxAcvVpa7oNao=; b=hFRulU
	joW+qZ+0BWnosti5PGoIQAq4HL0nTYsmPP5vMXfvavtZ5bqOtmSxHenrBQUPrcot
	v0K+cYoAE/anI31fl5AfkhgjB/SNY0cL3lx4fhP86Uh81WlIXlU4xXh+2ufOB8+s
	NpoEIUZYZGEM4PEPoM+0s5cg0rtJImJTuTxX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ft60v060QZOrhvwMILQXxgUJj6Etcyzg
	bquVdY9Klu38n6aZ2+KEF2c2hMzdgisd2QIMFD8IPMadqX5zGgvd9GkqT9gqmXPY
	kbfv+yQh9crK3Rv5Y4AXEzoGv1HRzev0luaR0YiHgXcf2r24ejq5ya1sBBNp/9TG
	LgaepIaPjvY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 286603120;
	Mon, 17 Jan 2011 13:43:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0FA70311F; Mon, 17 Jan 2011
 13:43:24 -0500 (EST)
In-Reply-To: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
 (Levend Sayar's message of "Sun\, 16 Jan 2011 14\:33\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD0C07B8-2269-11E0-B3EE-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165177>

Levend Sayar <levendsayar@gmail.com> writes:

> Yesterday one of my colleague tried to commit her two weeks of work.
> Nearly 10 source code files.

Ok.

> After an unsuccessful am and apply commands, she tried rebase. And git
> bothered something like you have to finish your am first.

I do not get this for two reasons.

What does "am" and "apply" have anything to do with committing her own
work in her own working tree to begin with? And even if "am" and/or
"apply" were the right tools for committing hear work, that would mean she
had the changes to be committed neatly made into patch form suitable to be
fed to these commands, so I would imagine that the recovery is just the
matter of "reset --hard" followed by attempts to apply those patches again
and fixing rejects more carefully than the first failed attempt?

A practical suggestion, without knowing what really went wrong, that would
be valuable, especially for git beginners but applicable also to git
experts, is this. First commit your own work proper before doing anything
that may cause conflicts such as merging other's possibly unrelated work
(e.g. merge, am, ...). Then do such mergy operation to make separate
commits. You can do fancy things like combining changes into a single
commit _after_ doing so, and it will be much safer because at the worst
case you will be unable to achieve the fanciness (e.g. combining the
changes) but will have the working results (i.e. a commit with your own
changes, and separate commits recording others changes).
