From: Jed Brown <jed@59A2.org>
Subject: Re: Rationale behind 'extern' on protypes in .h files
Date: Sun, 22 Dec 2013 11:26:52 -0700
Message-ID: <87eh54spw3.fsf@jedbrown.org>
References: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com> <52B71D24.4000207@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: Stefan Beller <stefanbeller@googlemail.com>,
	Ravi Shekhar Jethani <rsjethani@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 22 19:35:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VunsD-0003kP-KE
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 19:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab3LVSfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 13:35:16 -0500
Received: from jedbrown.org ([198.199.121.66]:59811 "EHLO jedbrown.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab3LVSfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 13:35:15 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2013 13:35:15 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by jedbrown.org (Postfix) with ESMTPSA id 934C380E68;
	Sun, 22 Dec 2013 18:26:57 +0000 (UTC)
In-Reply-To: <52B71D24.4000207@googlemail.com>
User-Agent: Notmuch/0.17~rc2+3~g5fa88cb (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239646>

--=-=-=
Content-Type: text/plain

Stefan Beller <stefanbeller@googlemail.com> writes:
> From my understanding there is no
> difference for functions declarations being set to extern or not,
> because extern is the default on functions.

There is a difference for shared libraries if you would like to control
which symbols are exported.  With gcc, for example, you might compile
using -fvisibility=hidden.  Any functions explicitly declared with
extern, bearing __attribute__((visibility("default")), or using
visibility pragmas will be exported (similar to __declspec(dllexport) on
Windows).  Other functions will be internal to the shared library so you
don't have to worry about callers depending on those symbols and
performance can be a bit better by skipping the PLT and avoiding symbol
relocations at load time.  See Drepper's guide for more.

http://www.akkadia.org/drepper/dsohowto.pdf

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSty7wAAoJEM+2iNHeMalN0GUP/RbHYiLURj3obpnCJBQEpTxI
t+P17LI1BkbSCkeeM8e6O1aCok/KuoicwtJwBl5f4ZHIdwMnDq31Jm/KGK1h4hOl
f5X8qvqoSK1bCkLTmmygk1otJ8SzOgL5JJpPnbFUiyi7PoJvgImSxF+pTKvPzctE
Wa7AIuhg/bn656F0FhgmlimD/UrPUzgnV2zjk+UF1xsK8JuvyGofVIHoK6HqFUV1
48fhNI0jU0B6I7TozU+1NwQWEqY8rmCXcXP3sAowCLonF+exMYVXGBbQ9cdlhAQl
MF/rvsXv5gL7OK5kHdTLrbzf2j0Pa5OHmvKKAwZENkFXTMs8l19EmtdWi6ytOhmV
EYhg6+1cPj2ohXg+EDFPCA0eJQ50XcWBOirSbVyFxdzMHhK4gGshj8gjIUnKFu5N
n2WV7gx1V1MLxtBJmAwXPf0NX7zYFMOewhCfh000PXiNF0vDU5mABbW4yQgBemGN
1xtvkcKsMmVw7O7YA17V1llTBZvK62Br1hUJyqaKC7X3/htWOe0wNebK3r9zMZ2B
ZiRFbhHWoLogeokAKcKygobMDIaoxVrDzVM2mYjHB6HlgpVAyd11mfZH8iVZxeep
ab054HTJRScVYXTKKXa8NT6RUZnNa2OazwCtBl+WgFynWydXsw5rCcARCRKqWOny
3Jzg0/eLOIqWT31A/bRj
=pwW5
-----END PGP SIGNATURE-----
--=-=-=--
