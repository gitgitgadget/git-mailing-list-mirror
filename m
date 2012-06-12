From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] Warnings before amending published history
Date: Tue, 12 Jun 2012 08:22:59 -0700
Message-ID: <7vzk88367g.fsf@alter.siamese.dyndns.org>
References: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339451781-29324-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpqvcixyoed.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSw1-0003Kr-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab2FLPXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 11:23:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab2FLPXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 11:23:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 682AE9C23;
	Tue, 12 Jun 2012 11:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bNBiwe83qvXOCU/yl2JxehsL7gE=; b=FN/KUJ
	uEKKRRS+ES4XT8f/0R/G1hrlQ8bBp0puaprIkRgek/2G52Z2AxTSow3qgqzUFBXH
	0DmaLh1MVXDHLWV47N1MlfjIRA+FZCiKMR967SdnfSDaEfMdrHEebjPpv5iDKe1M
	RL/BziLz/g2JQRAXs0831vdZkGYOcJA7bNnik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IVaiGWcB4gmxPcldouy7A4NVP9w9g3vj
	RUizvTpI7hCYRFP1AHwILPRpWjiygdJZY47t7k7irEwXY47ux0QDBXKQ5zyWo06q
	IvfsvWNNmgCUbPHsn52M3UFlRoyyQ/hFiT5/gFFIo64qlThnVmPIfq/pUn2SXT5n
	/IBJmjoEZQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF069C22;
	Tue, 12 Jun 2012 11:23:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC0989C1F; Tue, 12 Jun 2012
 11:23:00 -0400 (EDT)
In-Reply-To: <vpqvcixyoed.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 12 Jun 2012 09:34:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F126B3C-B4A2-11E1-95A0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199803>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:
>
>>  builtin/commit.c              |   82 ++++++++++++++++++++++++++
>>  sha1_name.c                   |   95 +++++++-----------------------
>>  sha1_name.h                   |  130 +++++++++++++++++++++++++++++++++++++++++
>
> I'm surprised that you need such a big patch. Basically, you're making
> all static functions in sha1_name.c public. If you really need such
> intrusive change, then you should at least explain why in the commit
> message, and most preferably split the patch into one refactoring patch
> to expose the functions and one to use them.
>
> But I suspect what you're looking for is already in cache.h.

I do not think I am going to take this nor the rebase patch that
bases its decision on the hardcoded "Does the commit appear in the
history of refs/remotes/*anything*?" logic.

At least, there should be "Here is a list of the branches I promised
others that I am not to going to rewind." even if you are going to
make its default value to be "for-each-ref refs/remotes/".  It is
too inflexible to be useful otherwise.  Not only in the contributor
and integrator workflow, but a simple "Alice asks Bob to pull from
her Github repository" will be hurt on the "I fixed up the issues
you raised. Could you please take another look" round.  Besides, I
won't be able to amend things outside 'next' but are in 'pu' ;-).

The logic in the patch in this thread to check each ref~$n is not
even worth commenting on, but as to the logic in the other "rebase"
one, I think it is wasteful to ask "what are the refs that can reach
this commit?" when what you really want to know is "is there any ref
among this set that can reach this commit?" (the former needs to
keep a lot more state).  It should be something like looking at the
output of:

	git rev-list <list commits you are going to touch here> \
		--not <list tips of refs you have published>

and make sure all the commits you are going to touch appear in the
result.  Any missing one is reachable from the refs you have
published and you may not want to rebase.

It may be an interesting thought experiment to see if you can take
advantage of the inherent ancestry relationship among the list of
commits you are going to touch. The later commits that will be
replayed in a rebase are very likely to be children of earlier one,
so in theory, if you can identify the set of topologically earliest
commits that will be replayed, you only need to check them, and if
you can cheaply come up with that set of earliest commits, the above
rev-list may become cheaper.
