From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Fri, 1 Jun 2012 12:05:36 -0500
Message-ID: <0A6ABBD7-01D5-4A24-BF0F-78A7F2C46938@spotinfluence.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <7vtxyw6ypx.fsf@alter.siamese.dyndns.org> <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com> <7vd35k6w0i.fsf@alter.siamese.dyndns.org> <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com> <20120601093039.GD32340@sigill.intra.peff.net> <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_C281127A-518F-4AE5-AA03-6EFC272B1407"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 19:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaVIK-0008RG-Br
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 19:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759219Ab2FARFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 13:05:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46331 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191Ab2FARFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 13:05:43 -0400
Received: by yhmm54 with SMTP id m54so1818347yhm.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 10:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=9YRiwqtgPBgV4SX+cTQdWc0jHFSnK8o+8ylgwy9crXI=;
        b=W0tD/l2TvwlvbqY/B+xOODh/jQgc0YQeqnI7MqkTt/o6HD68w9oXmXYEVMhCuRI0wo
         xbB8T0GFKdKVdfoNdI/HzWy9sZz2WD0CaFBqhe+PFfIrJLbhK1PrCn1Uyl0dd6Aj5LOL
         vL01iQbf+OzRb3S06Ve8MqJVryL89eSBpGoEod1jtyF+npUnJjPzIrqFgIs/Ed/UI2Z0
         lli1psE8Vao85fcvF431UF4eclx01VH+VeWQjxx8DuneCiov+SSsPblvaeS+zuuPVsgx
         K/zU1mpSV7QK+R+zhnzfLtYDBq7BXoewvbrbelvfjX/ZNE2t8AayIn2+XnrzB+Mk/nRO
         Za3w==
Received: by 10.50.135.1 with SMTP id po1mr2326494igb.67.1338570341251;
        Fri, 01 Jun 2012 10:05:41 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id z7sm4666100igb.3.2012.06.01.10.05.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 10:05:40 -0700 (PDT)
In-Reply-To: <7vmx4n3sz5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQltG56z6uiJDJRfRcfj0OzQqm9QoOFAILPixheHUypcb6XmBv5p5KMApjSWDXqsOU96Im3J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199006>


--Apple-Mail=_C281127A-518F-4AE5-AA03-6EFC272B1407
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I still think the best solution is figuring out if the platform sed is =
sane at build time and using a full path (via config setup if being able =
to change the sed used is a priority).  Short of that something as =
simple as

(git-am:699+)

   if test -z "$GIT_AUTHOR_EMAIL"
   then
           # Can occur when sed in PATH will not handle UTF8 under =
LC_ALL=3DC.
           gettextln "Patch does not have a valid e-mail address."
           stop_here $this
   fi

would give folks trying to troubleshoot the problem a clue to what was =
going on.  =46rom the fink developers' list it seems Darwin and perhaps =
FreeBSD use US-ASCII for LC_ALL=3DC or POSIX which is why Gnu sed gets =
it wrong.

My problem is still fixed whatever is decided.  Enjoy,
  -ljr
=09
---
Lanny Ripple
lanny@spotinfluence.com


On Jun 1, 2012, at 11:19 AM, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>> [Please don't top-post.]
>> ...
>> But you have to keep in mind all of the people who will be led down =
the
>> wrong path by your breadcrumb when the failure is caused by a
>> _different_ problem. What is the probability that it is helpful =
versus
>> not helpful?  If you are going to give advice that sed might be =
broken,
>> you should at least test to see if it is broken and report it.
>=20
> Eek, do that at runtime in the error code path?
>=20
> Add something like
>=20
> 	suspected_sed_breakage () {
> 		xxxxx=3D$(printf "\370\235\204\236\n" | LC_CTYPE=3DC sed =
's/./x/g')
>                if test "x$xxxxx" !=3D "xxxxx"
>                then
> 			die "Your sed is broken; cannot run $1"
> 		fi
> 	}
>=20
> to git-sh-setup, and do something like:
>=20
> 	. "$dotest/author-script" || suspected_sed_breakage "$0"
>=20
> in git-am?
>=20
> The problem I see is that at that point where we have to suspect
> something fundamental as sed broken on the platform, we cannot even
> trust printf, test, or even the shell itself behaving sanely.
>=20
> So I would say, although it is a fun thought-experiment, such a test
> and breadcrumb is not really worth it.
>=20


--Apple-Mail=_C281127A-518F-4AE5-AA03-6EFC272B1407
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/I9mEACgkQ+owW65SoXfje2AD+OkKvypYIZdQri2KC0Jk9xoVp
zg7TnLeHEIc58+MvMF8BANr5TwggGOxtLOQH59POWVgwhmUoPwrzc/jW4Fc6jLpt
=Dy46
-----END PGP SIGNATURE-----

--Apple-Mail=_C281127A-518F-4AE5-AA03-6EFC272B1407--
