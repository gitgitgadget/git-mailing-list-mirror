From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Wed, 18 Feb 2015 09:07:22 -0800
Message-ID: <xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
	<CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
	<54E46635.4060009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Julien Cretel <j.cretel@umail.ucc.ie>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO86D-0007Jv-71
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbBRRHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 12:07:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666AbbBRRHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 12:07:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EECE38404;
	Wed, 18 Feb 2015 12:07:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S1Drrue/G5ADGRW3qJkOpS46AKg=; b=cIEKROtkuOBg6vp+Gp3O
	G1exvkRRamBm/VGQsODWpY7LXELU6vLoMtJoUjg6PAI/98+T50HnnpWtz/j3o/n8
	LipTLMYGLgruXSIVagagsULjWRx0uT3ZmN+Ed/C0R36tInGdcmGoiUpngZ1IE7tm
	jvItoCWa7/gVGjSR8gWzems=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DVlsBdskarhCUNSP0D12YY6b0ezy1QIqqccZwV0Eue3auG
	DxSPbXusM0+IVFcmlxG07AMQNJwhh3UYLsWqrEr1BJnF8JJeUdRcDeJMM4ELsRHK
	Kt5C+39DBqA+06kj9B7+aXB9LWe9ttUXEaooi9TrH/OM1gi88cNgDAgkoV3/E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 757B638403;
	Wed, 18 Feb 2015 12:07:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E945F38401;
	Wed, 18 Feb 2015 12:07:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B7AC4D8-B790-11E4-AA2F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264030>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git branch" will tell you your branches and which one is checked out
> (or HEAD); "git status" will tell you the latter.
>
> "git log" is about the DAG which has absolutely nothing to do with what
> you have currently checked out.

Yeah, that summarizes my reaction, too.  More importantly, "log" is
about showing commits and "--decorate" is a way to enrich the
presentation of commits---it talks about commits in terms of refs;
the command and the option is not about describing refs and their
relationships.

I do not terribly mind showing the fact that HEAD points at a branch
when --decorate talks about HEAD, partly because we will be showing
both HEAD and the branch name _anyway_ in the output.  But I am not
sure if the extra bit of information is more helpful to the readers
or being distracting.

Julien's "HEAD=master, other" vs "HEAD, master, other" may be
subdued enough to be undistracting, I would guess.  I do not think
the distinction between "HEAD = master" and "HEAD -> master" would
be useful, on the other hand.  We already know that the names listed
all refer to the same commit, which means that we do not have to say
"HEAD is detached" explicitly as long as we have a way to say "HEAD
points at this branch".  If HEAD is listed and is not marked to
point at another branch that is shown, by definition it is detached,
no?
