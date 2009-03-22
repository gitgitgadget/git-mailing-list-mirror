From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH] git-shortlog: respect i18n.logOutputEncoding
	config setting
Date: Sun, 22 Mar 2009 20:47:08 +0100
Message-ID: <20090322194708.GP27459@genesis.frugalware.org>
References: <1235092358-6895-1-git-send-email-vmiklos@frugalware.org> <20090322113438.GK27459@genesis.frugalware.org> <7v7i2h5pfh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlTf6-0007NS-Nm
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 20:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbZCVTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbZCVTrM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 15:47:12 -0400
Received: from virgo.iok.hu ([212.40.97.103]:40495 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451AbZCVTrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 15:47:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BE995580E6;
	Sun, 22 Mar 2009 20:47:08 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AD0E944783;
	Sun, 22 Mar 2009 20:47:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 826FA11B80AE; Sun, 22 Mar 2009 20:47:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7i2h5pfh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114169>


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2009 at 12:26:58PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> It is unclear what you want to say in these for lines.  Do you mean "when
> used to generate logs by itself this patch improves the behaviour by
> making the output consistent with what "git log" does, but it does the
> same mangling when used as a filter without knowing the log encoding and
> potentially screw people over who have been depending on it not to convert
> the encoding"?  Or something else?

Not exactly - let me rephrase:

Normally we can do a reencode_string() because we know the encoding of
the commit and we know the wished output encoding.  Given that
git-shortlog can be a filter as well, we don't know the encoding of the
input, but we know the wished output encoding. So what we can do is to
_try_ to encode from utf8 to the wished encoding, and if that fails,
just don't convert anything. The result is correct, because:

1) If git-shortlog is a filter, then git-log already does the encoding,
the encoding will fail in git-shortlog so the original input will be
shown.

2) In the other case git-shoftlog can just do the converion.

At least I tested the case with utf8 author names and a latin2 terminal
and both the 'git log rev.. | git shortlog' and the 'git shortlog rev..'
output was correct, while git.git's master shows the correct output only
in the first case.

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknGlbwACgkQe81tAgORUJbZZwCdEZuU16CIyl3mPJonmvVHW2qn
mosAn15UU/72a9bPYIId0k309m6LDOqo
=B/fF
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--
