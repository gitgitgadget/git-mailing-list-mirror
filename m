From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Sat, 22 Sep 2012 13:23:56 -0700
Message-ID: <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
References: <505C7C80.3000700@workspacewhiz.com>
 <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
 <20120921233723.GA29433@sigill.intra.peff.net>
 <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
 <505DE30B.2000805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFWFI-0003mV-G1
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 22:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab2IVUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 16:23:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab2IVUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 16:23:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C2D845F;
	Sat, 22 Sep 2012 16:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UgFNKJK3EpwtbLBfXftarU4O5yc=; b=EvVSOH
	T47TeMyXkUTodz3xWkJkN66ra57/AHdsljKDW2bmOT5CSFrm5GGO0WtzhpVeJjer
	wGc2Klhu0Fihe94iQFpx0aiAOLKdonYYVjbDb6KUeqfpp+IyLaK+qKz1fFxgPdhl
	k+mWdByldIxH2mM5eKs6vp7ZDfV318y69JRNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KIIXXG8xJ4WJAsi0qnL0aAKD1lahLO1N
	TCSKb61Zw6eZhfOs715RKh9NoELQLZ3qqAXie+qKtLqB2dynGaINrkdXF0wjUVDc
	B3aDC0bCDszvqHTze4R9C6aCgQcRgc+i7AufzasOcE2Afyr3Iv5NXk9ociw0lTM4
	ikZWfBsI4rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC57845E;
	Sat, 22 Sep 2012 16:23:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7D18454; Sat, 22 Sep 2012
 16:23:57 -0400 (EDT)
In-Reply-To: <505DE30B.2000805@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sat, 22 Sep 2012 18:10:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70000914-04F3-11E2-8EE9-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206212>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> On my mental scratch pad (yeah, that's where the bald spots are) I have
> the following more general idea to enhance the revision parser:
>
> --limit-run=<script>::
> --run=<script>:::
> These options run the script `<script>` on each revision that is walked.
> The script is run in an environment which has the variables
> `GIT_<SPECIFIER>` exported, where `<SPECIFIER>` is any of the specifiers
> for the `--format` option in the long format (the same as for 'git
> for-each-ref').
>
> In the case of `--limit-run`, the return code of `<script>` decides
> whether the commit is processed further (i.e. shown using the format in
> effect) or ignored.

You could argue that the above is not an inpractical solution as
long as the user of --run, which spawns a new process every time we
need to check if a commit is worth showing in the log/rev-list
stream, knows what she is doing and promises not to complain that it
is no more performant than an external script that reads from
rev-list output and does the equivalent filtering.

I personally am not very enthused.

If we linked with an embeddable scripting language interpreter
(e.g. lua, tcl, guile, ...), it may be a more practical enhancement,
though.
