From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to prevent empty git commit --amend
Date: Wed, 14 Jan 2015 09:27:11 -0800
Message-ID: <xmqqfvbdb7dc.fsf@gitster.dls.corp.google.com>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	<vpqzj9lfzqg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Anjo <ivo.anjo@ist.utl.pt>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRj0-0003GR-0P
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbANR1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:27:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbbANR1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:27:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD66B2B89D;
	Wed, 14 Jan 2015 12:27:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rk3uHr/3Nh2PFDUFBDSCKD1iWFM=; b=IKgt28
	zNRzAYzA3lCCRNecOmhdp94uLIEnFCrjlM9nxZVXeOhvlGooQsUSgvnq5P7rSIPI
	XG3ksiG7MyHZCDrvXqg3ZdzWzAOVIDgdCymNnwFhBPNFp3N0Nxib/QsKX4o2zY8Q
	Qb2Ip4FnvrZSezjMG/g3wZmGksKFXAKJRsmMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qszT+oJRioj4azhDKfe4/aNT8Hxrs1W/
	yioos5OaLwsBVkOzEKyjAn78srdjTnDvwnn/9WWRlUIX9YcRF35OvJzsMsDwOHQX
	V9cko7jQUkSXNXXXnMjrNKy+QRic89jltPQjGRbEVC9SMiSScU0qnfzhVt7Ac0qG
	fVHLF9rSBdA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D26922B89C;
	Wed, 14 Jan 2015 12:27:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F8432B899;
	Wed, 14 Jan 2015 12:27:13 -0500 (EST)
In-Reply-To: <vpqzj9lfzqg.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	14 Jan 2015 11:00:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93D3ECEE-9C12-11E4-B171-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262394>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ivo Anjo <ivo.anjo@ist.utl.pt> writes:
>
>> Is there a way to prevent a *git commit --amend** with nothing to
>> commit from working?
>> If not, I would like to suggest that this feature would be very helpful :)
>
> I don't know any way to let Git do the check for you, but 
>
> git diff --staged --quiet || git commit --amend
>
> should do it. You can alias it like
>
> [alias]
> 	amend = !git diff --staged --quiet || git commit --amend
>
> and then use "git amend".

That would not let you say "git amend Makefile", no?

	!sh -c 'git diff --cached --quiet "$@" || git commit --amend "$@"' -

or something, perhaps?
