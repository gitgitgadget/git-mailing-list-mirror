From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] convert.c clean-up
Date: Tue, 10 May 2011 19:59:29 +0700
Message-ID: <BANLkTi=fjLkqWB2MTGtKE93qSjXU76cpvA@mail.gmail.com>
References: <20110508101925.GA19525@do> <1304978701-19310-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:00:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJmXo-0006gh-S2
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 15:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab1EJNAB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 09:00:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48707 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1EJNAA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 09:00:00 -0400
Received: by fxm17 with SMTP id 17so4281691fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=vDM421g0R6dcZQIzP8/TN1VbS0beccbZcS1AJjWV0Vo=;
        b=G2/LXg2f411DjfG43rMdWxDvknBteQS+gNeNCvfR3kbocbj4iv1I9HmJxPgrlYKvuC
         khLzRjEe9g/6UtsxZDHEWnKRoP49B7Xq0hvlHhdbF5lhZDZ6n0pgdNyiaUQFQtA/qDFw
         bfP2WTxkxom8lUb5CGpIKpW/GpMl7dTwWUgA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wnQe6DdFWZHVQEdRyjfcBIwz7snF0aPNdlLLo1NGBEsp3knLQ5ea8sv9FXBUK9ksGF
         6rou9/hFF/yfXRkEvr5uyCIenEgBFyHMvMzYLr1h2nu/I0jmuh5rEl0Mz8EuiASVOS63
         Y2fdkC4TZDJZ2vCZwHklGyLnGr+n5FLaADGUE=
Received: by 10.223.159.14 with SMTP id h14mr1118210fax.20.1305032399199; Tue,
 10 May 2011 05:59:59 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Tue, 10 May 2011 05:59:29 -0700 (PDT)
In-Reply-To: <1304978701-19310-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173333>

On Tue, May 10, 2011 at 5:04 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Yeah, I think that would probably make more sense. If a file is small
> enough, it is more sensible to send it to a loose object just like an=
y
> other files. We do not want to invite users to make a mistake of mark=
ing
> it as bigdata and send it straight to a packfile. Having one less kno=
b to
> tweak is always a good thing to do.
>
> However, while reviewing your patch, I noticed that convert.c was lit=
tered
> with misnamed types, variables and functions to the point to make it
> almost unreadble as the result of its evolution. =C2=A0I originally w=
rote this
> series so that I can add "bigdata" sensibly, and it turns out that th=
ere
> is no benefit to do so for now, but the clean-up by itself would be w=
orth
> it.

I still don't like "bigdata" attribute. It sounds overlapping with
bigFileThreshold we already have. Maybe "inPack", "packed" or
"noLoose" a better name? It makes it quite clear that this attribute
sends objects to a pack. If they want to process tiny files this way
by setting inPack/noLoose, I don't care. But files larger than
core.bigFileThreshold should be automatically marked "inPack/noLoose".

> So there...

Yeah, I wish you did this before I touched convert.c. Anyway it looks
better from now on.
--=20
Duy
