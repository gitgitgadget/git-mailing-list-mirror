From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: coding style: #ifdef blocks and real C blocks
Date: Sun, 1 Mar 2009 17:27:25 +0800
Message-ID: <be6fef0d0903010127q7b1491d6o8cdb48acdc674603@mail.gmail.com>
References: <be6fef0d0903010052t50551f3w74352b69afdee620@mail.gmail.com>
	 <7vbpsl8v7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 10:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldhym-00057n-HN
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 10:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZCAJ1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbZCAJ1b
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 04:27:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:61189 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZCAJ12 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 04:27:28 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1828749rvb.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i4nJK0StjxiZAy3sYXfl1SFTEyzH3ao/Fl2/UqZBdbc=;
        b=gO1j4nGWDaPJy5n2izn2kaSdduohf7cvC+6lRMPsr94S6BayeR9mxGkQvIX4nnnG0Q
         Qw2sX0bs6wxZKcMXXV0vzKlWpiVB/K244T3B4g8uLDQIx3rNwqM9/bd4ox2Ff3Ce8G7A
         plOCmj9H7o6zUlpHtT3TktmKmLi+qR973QZfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qDwk7lXTs+WvlU7OWK8u+N6U9X18sho7IhvRdiDV3KI+OpKul6cHgb05yDqU93yaXw
         pOTjW7yrxO1x5fo5MTU0ZUXrcIADR8ZsywyQKd9NDlt61yklfIxWwI/asL+1y80E5zkO
         4MD4XiR/JaFg9F5+bO7GlsXXJ7Y13GIXwXK8o=
Received: by 10.114.144.1 with SMTP id r1mr2077547wad.2.1235899645214; Sun, 01 
	Mar 2009 01:27:25 -0800 (PST)
In-Reply-To: <7vbpsl8v7r.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111831>

Hi,

On Sun, Mar 1, 2009 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> How about doing something like this:
>
> =A0 =A0#ifdef USE_CURL_MULTI
> =A0 =A0#define active_slot_get get_active_multi_slot
> =A0 =A0#else
> =A0 =A0#define active_slot_get get_active_slot
> =A0 =A0#endif
>

Nice.

> Similarly, with something like this:
>
> =A0 =A0#ifdef USE_CURL_MULTI
> =A0 =A0slot active_persistent_slot() {
> =A0 =A0 =A0 =A0 =A0 =A0return persistent_connection ? get_active_slot=
() : get_active_multi_slot();
> =A0 =A0}
> =A0 =A0#else
> =A0 =A0slot active_persistent_slot() {
> =A0 =A0 =A0 =A0 =A0 =A0return get_active_slot();
> =A0 =A0}
> =A0 =A0#endif
>
> the call site can be #ifdef free, no?
>

Hmm, so I just do "slot =3D active_persistent_slot()" ?

--=20
Cheers,
Ray Chuan
