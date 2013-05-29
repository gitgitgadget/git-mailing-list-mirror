From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 11:37:28 -0700
Message-ID: <7va9ndtyxj.fsf@alter.siamese.dyndns.org>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr>
	<CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com>
	<51A5FC17.8000608@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?utf-8?Q?=C3=81kos=2C_Tajti?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:37:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlFf-0005ik-AL
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965618Ab3E2Shc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 14:37:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965534Ab3E2Sha convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 14:37:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 486EB22614;
	Wed, 29 May 2013 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ImLpzGDUy3WB
	NorMWLOFmtkmjPE=; b=A39RiN6L5g3qWveocNeOtgycWv+IBCbswb4z04ryD9U1
	5I3oQs+2XSKGZAg9AaoczQ3N2UiVucHc3ill9BnNX6Y2jJ0qf9Iuy99/qySg50GN
	mIsex5eLyOJ5lW6RsE81TagC6UMzxU21S7gbfn65dv9hC21jhkubhsvkGowHu7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GwOSj0
	MR1VjI6kucDSGAxmWMsP1BGabe1n83TthUhZCns2ieiezmqyqqJpgaVp0RLxhSlF
	DitPQYd1V4NEW7Go8hmFNM9Tf+ZXqSm5nPlEntStbHTaZX5hDXJnEr3uUzwElh0+
	2aNeJcK5s6u6kQzjuXFQ1CsIKPeMPGQJfePbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D96B22613;
	Wed, 29 May 2013 18:37:30 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95CC92260F;
	Wed, 29 May 2013 18:37:29 +0000 (UTC)
In-Reply-To: <51A5FC17.8000608@intland.com> (=?utf-8?Q?=22=C3=81kos=2C?=
 Tajti"'s message of "Wed,
	29 May 2013 15:01:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1429C5A-C88E-11E2-AD29-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225863>

"=C3=81kos, Tajti" <akos.tajti@intland.com> writes:

> Thanks for clarifying this thing for me! I don't really insist on
> having a master branch it's just that I tried to pull from a
> repository bundle and I got this error message:
>
> "Cannot merge multiple branches into empty head"
>
> The command was:
>
> git pull ../dump.dmp refs/heads/*:refs/heads/*
>
> Is this a better way of doing this?

You are not trying to merge all branches contained in the dump, so
"pull" is a wrong thing to use here.

    $ git fetch --update-head-ok ../dump.dmp refs/heads/*:refs/heads/*

would be one way.  Or you could just use the dumpfile as if it were
a normal remote and say (without running "git init")

    $ git clone dump.dmp undump

to extract it in a new directory "undump" (this may require your
dumpfile created with HEAD, though).
