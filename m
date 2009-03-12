From: Steven Tweed <orthochronous@gmail.com>
Subject: Re: Generalised bisection
Date: Thu, 12 Mar 2009 18:02:37 +0000
Message-ID: <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhpGM-00011K-Al
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZCLSCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 14:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbZCLSCm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:02:42 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:46373 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZCLSCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 14:02:41 -0400
Received: by bwz26 with SMTP id 26so1771981bwz.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IeIdOTnvcZtnjrIkDQdAvbzWeKZPJsGI7OvGIQKbdVc=;
        b=cmuuURKbrfR3ZyiT57tlm/FHQ++XTaaD23ix5DKOpQR1pm0J3+7XpCfe7MYTaMaFQR
         X2IJQVKJCbdC80h4ScrhLbgHv9+75e0bgeP4REc+Wq0OYiZFd2CW6BsqbgNS+my00xm/
         H40A8vKp/L/P750oi3sQh7LWjSSbaHBZnjFmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VSuK75CB3lQIvAhHQvxtb+7/b91IlrMuQ77uVmoc0FC8y08K0xPaHNHR2kJ9nkmybp
         o0FX5+4QmW0Bx9PSqZoF/WV8oAJsCqWq97tz8Ht5Dw25w2WL+zDpcdTT+c1SKVCdCYnF
         8mRFsESzbjz0nDrKXvbsWD3SxMPBS1oFNOK4g=
Received: by 10.223.126.1 with SMTP id a1mr209171fas.52.1236880957951; Thu, 12 
	Mar 2009 11:02:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113098>

On Thu, Mar 12, 2009 at 10:55 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 12 Mar 2009, John Tapsell wrote:
> > 2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
> > > What I use is the multiprecision floating point number class. dou=
bles
> > > don't seem to be long enough.
> >
> > Hmm, really really? =A0Sometimes this sort of thing can be fixed by=
 just
> > readjusting the formulas. =A0What formulas are you using that requi=
re more
> > precision than doubles?
>
> Maybe you could post the formulae instead of forcing people to deduct=
 them
> from the source code?

I haven't even looked at the source code so a description of the
mathematical algorithm would help, but I'll just point out that
underflow (in the case of working with probabilities) and overflow
(when working with their negated logarithms) is inherent in most
multi-step Bayesian algorithms. The only solution is to rescale things
as you go so that things stay in a "computable" range. (You're almost
never interested in absolute probabilities anyway but rather relative
probabilities or, in extreme cases, just the biggest probability, so
rescaling isn't losing any useful information.)

cheers,
dave tweed
