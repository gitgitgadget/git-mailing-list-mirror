From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] make askpass_prompt a global prompt method for
 asking users
Date: Tue, 27 Dec 2011 13:10:42 -0800
Message-ID: <7vd3b967ql.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 22:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfeIc-00070l-DO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 22:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab1L0VKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 16:10:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab1L0VKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 16:10:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F139A55DF;
	Tue, 27 Dec 2011 16:10:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ICQ/m3PGBtxHl3s44JsejOh7crM=; b=MlXO6V
	AdhDxBPYdlxMB6iFBOibMKx2rJ0s+ni4rlNB7D0S41+hr+SPUmXRfQSXuszOMrB5
	r471HW6sO2C8dy7LPhSiz+0JNPEJTH/wLlE1UEGg0enzYwARJpiYo+mMHDdEZrch
	mqwpxYVX5vxukUJTrsAdzq1+7JBv6vwOy4zwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dxFZ4HkAq08ymfX/U3CpzCDD/luW5qnf
	LhnGxBHRgorLGHM3vLF9Cy0LXaXuydpF9m4F5OHO+tUbD7LMeq7k3RN8btHIyzDe
	JPAXol0p64YsxqaYIhinffR9Z2d54V07bl3ECnI76tOL0g1g8gj3aFo2bET2Z8vT
	2jZevvoa9eU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E817655DD;
	Tue, 27 Dec 2011 16:10:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7710E55DB; Tue, 27 Dec 2011
 16:10:43 -0500 (EST)
In-Reply-To: <4EF9ED58.8080205@tu-clausthal.de> (Sven Strickroth's message of
 "Tue, 27 Dec 2011 17:07:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CD83A8C-30CF-11E1-8228-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187730>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

I think the end result of having a prompt function that can be used with
or without echoing like Peff's git_prompt() series does is a very good
thing. But then we just should introduce "prompt()" from day one of the
series, instead of introducing a half-featured one "askpass_prompt()" and
then later renaming the callers like this patch does.

It may a good idea to take the stepwise approach like this series does,
but in that case, the proposed log message must explain what the new
"prompt()" function is and does. It is derived from askpass_prompt() and
apparently it does more than its ancestor, but what are differences
between the two?

For example, it is totally unclear why these two are equivalent without
any explanation in the commit log message.

> -	$choice = Git->askpass_prompt("Certificate unknown. " . $options);
> -	if (!defined $choice) {
> -		print STDERR $options;
> -		STDERR->flush;
> -		$choice = lc(substr(<STDIN> || 'R', 0, 1));
> -	}
> +	$choice = substr(Git->prompt("Certificate unknown. " . $options) || 'R', 0, 1);

or this:

> -	my $filename = Git->askpass_prompt("Client certificate filename:");
> -	if (!defined $filename) {
> -		print STDERR "Client certificate filename: ";
> -		STDERR->flush;
> -		chomp($filename = <STDIN>);
> -	}
> -	$cred->cert_file($filename);
> +	$cred->cert_file(Git->prompt("Client certificate filename: "));

I *suspect* the difference is that you discarded that "return false at the
end to let the caller do whatever they want" found in patch 1/5 and have
the fallback inside the prompt() funtion now. And if that is the primary
difference between the old "askpass_prompt()" and the new "prompt()", I
tend to think that the series should be restructured to use the "prompt()"
semantics from the beginning. No reason to start with a known-to-be-wrong
way to do a thing and then fix it in a series that is new to the codebase.

Thanks.
