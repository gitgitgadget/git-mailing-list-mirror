From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] get_sha1: handle special case $commit^{/}
Date: Thu, 16 Dec 2010 07:23:13 +0700
Message-ID: <AANLkTim3Y5jqwc9=StOLgvJYPPJS7B84Otz0=v1dAbc1@mail.gmail.com>
References: <AANLkTimy5MVkxDzXqzA8T4DHJmzsSAvwqVVzRvWw5KA0@mail.gmail.com>
 <1292403774-361-1-git-send-email-pclouds@gmail.com> <7v8vzqppo3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 01:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT1dP-0000YV-RT
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 01:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab0LPAXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 19:23:47 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59366 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab0LPAXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 19:23:45 -0500
Received: by wyb28 with SMTP id 28so2018372wyb.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KJ4YOqSJVHLqfXodrDuxROUasaN6JKbqPi2++SktuvY=;
        b=v11nBoZwWsB3gJWQ3suNMWBT5N9DTQKI3cQqR+JPTLf2SnLNUmdUQAQj2y69kFNZ6m
         SxYL3q0TQxzaxzzp0aPR7yTbvxw1k4CG8ND6d5RELF/aSDSlP53QttpSR79ZkxZz9okQ
         B6k1nmkvVadNxXcCVtESUtAKjhYU56foAouZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sSJeMuHl/iy3O1VE4TOwxMToTFaOvS1ssb8vm/k+vKP9ZT5/4TxuxfhX8vT8P5OWuF
         xdAPBtnYzlyxU8Yg/4sqCNp8beZL+PSItZsSt9H4D+rpeqiakPe76WaefRmycjOvuL/K
         njWYClPgX38OvPQx9T9ajucBAVWomUHzgmFT0=
Received: by 10.216.30.144 with SMTP id k16mr1567792wea.19.1292459024086; Wed,
 15 Dec 2010 16:23:44 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 15 Dec 2010 16:23:13 -0800 (PST)
In-Reply-To: <7v8vzqppo3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163796>

2010/12/16 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Empty regex pattern should always match. But the exact behavior of
>> regexec() may vary. Because it always matches anyway, we can just
>> return 'matched' without calling regex machinery.
>
> Hmm, I just noticed that "git grep -e '' Makefile" fails on FBSD8 for
> the same reason.
>
> I'd prefer a solution that is not about "special case $commit^{/}" bu=
t is
> about "work around regcomp that cannot compile an empty regexp".

Hmm.. if there is no compilation phase, we can redefine a macro to
workaround. Perhaps prefer compat/regex to FBSD's implementation?
--=20
Duy
