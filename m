From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 1/2] compat: add a mkstemps() compatibility function
Date: Wed, 3 Jun 2009 16:33:36 -0700
Message-ID: <20090603233335.GB8362@gmail.com>
References: <1243503831-17993-1-git-send-email-davvid@gmail.com> <e6cd6cf90906020535m24d588eau40b800555c9e906f@mail.gmail.com> <4A252381.9000103@viscovery.net> <e6cd6cf90906030859m2725856cl77e210d87e261df0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com,
	git@vger.kernel.org, markus.heidelberg@web.de, jnareb@gmail.com
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 01:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzxt-0007W1-J5
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 01:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbZFCXdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbZFCXdl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 19:33:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:50327 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZFCXdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 19:33:40 -0400
Received: by rv-out-0506.google.com with SMTP id f9so139449rvb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FqMSr2iYPmbGnabUvajA0NvNOlKLe2W/zWjSrCBUSUk=;
        b=KQhhNQ9cFi2QLjgWM6yYrcsx+BR5l37tPL2g8RA/tJaXFRosZs1MeNprXlcuS5aUuE
         6hyMAxcFWlUE/1w3MPiH5rFXR56sriXEZZg35vwUkpfD8jOQSK7ONTi6DU7Q6TYYMjTH
         SfGTKpohiI4N0PDu7p9pz9dKKWAXx5zjoRLNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cvXpE79b0KEnn9284N6TsXk/h/FnS7EQSqKHp84LAgdpRZCSmTXOO8+E2AMiE4OrkV
         isrW9M4XxNMJ/DEfzC5dJVf6Oio3qYQGlq8JuPf/c1Z/VNbc359afI4LuZMkawl50Sod
         +ZlvnZ/c24oQGz4VNqxNDw9QRdLoWuA5FvRRQ=
Received: by 10.141.186.1 with SMTP id n1mr1362295rvp.241.1244072022160;
        Wed, 03 Jun 2009 16:33:42 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id f42sm726540rvb.51.2009.06.03.16.33.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 16:33:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e6cd6cf90906030859m2725856cl77e210d87e261df0@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120664>

On Wed, Jun 03, 2009 at 09:29:06PM +0530, Antriksh Pany wrote:
> Oh ok, didn't realize the sixth division was not used. In which case,
> we needn't have the sixth division.
>=20
> Also, 62^5 compared to 2^32 still gives a ~ 21% probability of the
> fifth division becoming zero, fairly high perhaps.
>=20
> The suggestion to change the code to
>    ((uint64_t) tv.tv_usec) << 16)
> might help here. This would still leave about a 1.4% chance of v
> becoming zero, higher than (being pedantic!) what perfect randomness
> would require. Livable. But (just curious), do we see any loss in
> shifting a few more positions?
>=20
> - Antriksh


Just a small note -- our mkstemps was adapted from
libiberty's mkstemps.c (gcc-4.something), so if there is
indeed something to fix here then we should let them know.

I looked in libiberty since I assumed that the code in there
was battle-tested and stable.

I feel okay with it as-is, but that's just me.



> On Tue, Jun 2, 2009 at 6:35 PM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> > Antriksh Pany schrieb:
> >> 2. tv_usec has a decimal value range of 0-999999 =A0(10^6 usec mak=
e 1
> >> sec). Which means that tv_usec fits completely in 20 bits (or less=
).
> >> (tv_usec << 16) yields a number that fits completely in 36 bits (o=
r
> >> less). Max value of this number is 999999 * 2^16, or for convenien=
ce,
> >> about M =3D 10^6 * 2^16. This number (in the range of 0 to M) goes=
 on to
> >> be divided by D=3D62^6. Also, M > D. Thus, there is about a =A0D /=
 M * 100
> >> ~ 87 % probability of the division M / D working out to be zero. i=
=2Ee,
> >> in 87% cases, the last division (v/=3D num_letters) will cause 'v'=
 to
> >> become 0.
> >
> > But this value (after the 6th division, mind you) is not used. v is=
 used
> > the last time after the 5th division; at this time it still carries=
 enough
> > randomness: 62^5 < 2^32.
> >
> > -- Hannes
> >
> >

--=20
		David
