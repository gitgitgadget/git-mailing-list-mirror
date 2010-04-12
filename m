From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 17:07:25 +0100
Message-ID: <m2jfbd9d3991004120907k66951cf0y149097153fe3229a@mail.gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
	 <4BC2D61B.7050902@drmicha.warpmail.net>
	 <7vk4sdm5kw.fsf@alter.siamese.dyndns.org>
	 <r2vfbd9d3991004120143td6f90410j60c7c002b15d5db6@mail.gmail.com>
	 <7vtyrgllje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MAg-0006Ti-MG
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab0DLQH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 12:07:27 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:39186 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab0DLQH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 12:07:26 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2063698qwh.37
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OhTq3fx6ezegYKkyoqarLgUK801pOmCqsvFDCUh5SWk=;
        b=O2YfZqNvalX2vuKllE6dbmEl3KENtdNkQ/MM+svUXjocaLtqI51L3WixMcKOJ+ah/u
         c5+MjudDQVQ7M+HlZrCzAaQqbKy95rAvuW4ZNeAEgpHjwoSv3cKjuWBSZ88K0VFC1pkF
         3Asrsb9gWSZOAZ6WSQ688evr0PsH3I9YAYK6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fcpMpyxVWbrOlb1XycpvffDF8weXvhUKU9X2Ta+e6XriRpM0HINxdKJdnTEzkHkz9w
         +qmoMDcXOo0dlwcRLFQDJSLKwPLIduA+IVuGLq9BeF9vvvEUD5MRJ0MmoLXKgc2SEdFW
         xQNsIsLR1G7mJAd4uSEGt/mrHdcwSoRapB1jA=
Received: by 10.229.223.196 with HTTP; Mon, 12 Apr 2010 09:07:25 -0700 (PDT)
In-Reply-To: <7vtyrgllje.fsf@alter.siamese.dyndns.org>
Received: by 10.229.242.3 with SMTP id lg3mr6086262qcb.102.1271088445667; Mon, 
	12 Apr 2010 09:07:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144747>

On Mon, Apr 12, 2010 at 4:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
>> That would work but introduces a special case for smtpuser. =A0Do yo=
u
>> think users may wish to unset override other options too?
>
> I would indeed agree "users may _wish_ to", but that does not matter =
as
> much as "users _need_ to, otherwise they cannot do X and Y and Z".
>
> You seem to think from the beginning of this thread that "empty means=
 I
> don't want it" is a hacky special case that is limited to this smtpus=
er
> variable, but I do not share that view. =A0Not at all.

> There are two rather big reasons we would want to stick to the curren=
t
> format without introducing "unset". =A0At least we would want to try =
to
> until we find real need that justifies such a change.
>
> =A0- We could introduce a backward incompatible change to the configu=
ration
> =A0 file format to say "This variable is not set at all", but once so=
mebody
> =A0 starts using the syntax in his .git/config (or worse $HOME/.gitco=
nfig),
> =A0 that repository cannot be used by older version of git anymore.
>
> =A0- Also internally our variables are never "unset". =A0Behaviour of=
 a
> =A0 plumbing or Porcelain command implemented in C is controlled by
> =A0 variables in C, and the contents of the configuration files overw=
rite
> =A0 these variables as they are parsed from the least specific (syste=
m) to
> =A0 the most specific. =A0The best you can do is "reset to default" (=
not
> =A0 "unset"), and even that involves fair amount of change.

Knowing that variables are never unset internally gives me a different
perspective.  Thanks for the explanation.

Stefan
