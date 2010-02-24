From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] bash: improve aliased command recognition
Date: Tue, 23 Feb 2010 18:56:12 -0800
Message-ID: <7vr5obpcj7.fsf@alter.siamese.dyndns.org>
References: <20100131191936.GA30466@neumann>
 <cover.1266958460.git.szeder@ira.uka.de>
 <90724961a941edd1317514dea0a1c64112dab61d.1266958460.git.szeder@ira.uka.de>
 <7v3a0rd2lz.fsf@alter.siamese.dyndns.org> <20100224010459.GP4431@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 03:56:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk7QY-0006iy-1I
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 03:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0BXC4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 21:56:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab0BXC4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 21:56:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AEB9C0C6;
	Tue, 23 Feb 2010 21:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AvWkufol7vYw
	Sb7WNZ2Ohc3hzkI=; b=M0oxsnzYyVn9lWZIePNlerpeNnV9aNFi7Ef48lPxXk+z
	GedC9zhZGwpxF7QRtWOPajgy+u++1s80oK4lPmljBSXT1DRNeI3bePu4/owIfZ0N
	XtceoZnqVzv9201RuZh4jqtsl2olQpg+Zj3IxwGT0QBIwn+C7wePOj8vnfrcLIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T8KUNG
	X+wF3ff86hoUBKev0LV4hRzQqvgDFWbEUIQtq+0nl4EG5s0VzyITss5g9dO20fM/
	XvuijVPITMeAqFZTJcWj8zUmL1hyKd+ccWsGjTaqkauZMdSzN9mo6nFEfC4r8FxY
	kpwVhEUEmv1LnHLCj9yuTf6v44vf4uXiJ5ikk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 671059C0C4;
	Tue, 23 Feb 2010 21:56:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 052979C0C3; Tue, 23 Feb
 2010 21:56:14 -0500 (EST)
In-Reply-To: <20100224010459.GP4431@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed\, 24 Feb 2010 02\:04\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30979E20-20F0-11DF-89D7-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140890>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Personally, I prefer the shell function approach.  It needs less 'git
> config' queries; actually, in this respect it is better than current
> master, because there is no 'git config' query at all for the git
> command case.  Furthermore, I don't really like the idea of putting
> completion related stuff into git configuration files, but this is, o=
f
> course, subjective.

Well, at least both of us seem to share the same subjective criteria ;-=
).
The custom shell function approach is the most straightforward.
