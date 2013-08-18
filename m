From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add command `git bisect state` that checks if the current bisection process has reached the first bad commit.
Date: Sun, 18 Aug 2013 14:39:03 -0700
Message-ID: <7vmwoen0g8.fsf@alter.siamese.dyndns.org>
References: <1376606112-1712-1-git-send-email-maandree@operamail.com>
	<CAPig+cTfdnMRT61NQoHcF9-tt-wHABKPHi8HBXijQeB-jb1VyQ@mail.gmail.com>
	<20130816065410.56665c03.maandree@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Mattias =?utf-8?Q?Andr=C3=A9e?= <maandree@member.fsf.org>
X-From: git-owner@vger.kernel.org Sun Aug 18 23:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBAgt-0002zF-Ti
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 23:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab3HRVjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 17:39:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab3HRVjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Aug 2013 17:39:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D79B63ADFF;
	Sun, 18 Aug 2013 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IFIbuSNkPlNB
	A2SItk8SE2GGiHU=; b=Qwl4vBnKTVKso+UDpjG29nr61JeKKeivPUsrc+6E9YXr
	xK4U9XFOTsQCcmOtfTDydt6prp1f52rGWMAc239Zrhw56PQ+Soz0Pqpj6o/voXrR
	AJAyGpKpSN0LesMOR16cLxfbnGlUUaOmIYt6d+XPRFhjVQBfAbPFmYY/w9Z9JC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S1enY8
	qoLYUDZjPzyWa6wwTtOFfWnclCTK4r/V6NnEMssGHsYUNAbrsTiSsJb674h3lEJh
	/ljtm8TwAcNS++gGvyHb/TrLNPGHfDBlYdd2eKqe5uoJeKKToLmvS7b322JzsgfQ
	enb8dLfPdT+BXwROwFkgcj1Mx8baxCGaUpnEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA30A3ADFE;
	Sun, 18 Aug 2013 21:39:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29A113ADFC;
	Sun, 18 Aug 2013 21:39:05 +0000 (UTC)
In-Reply-To: <20130816065410.56665c03.maandree@kth.se> ("Mattias
 =?utf-8?Q?Andr=C3=A9e=22's?=
	message of "Fri, 16 Aug 2013 06:54:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AF9DF64-084E-11E3-938B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232521>

Mattias Andr=C3=A9e <maandree@member.fsf.org> writes:

> This patch allows you to an automated by section
> by just like if it was a manual, i.e. stating
> with `git bisect start && git bisect bad &&
> git bisect good <commit>` but then type:
>
> while ! git bisect state; do
> <test command> && git bisect good || git bisect bad
> done

Hmph, so this is "git bisect run" turned inside out?
