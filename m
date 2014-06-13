From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 11:36:44 -0500
Message-ID: <20140613163644.GB85151@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
 <20140613065942.GB7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUTD-0000es-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 18:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaFMQgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 12:36:47 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:32800 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbaFMQgq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 12:36:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C79165FE;
	Fri, 13 Jun 2014 12:36:45 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 13 Jun 2014 12:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=H3RaA9KxkyJfSVo5TOzWrEcC
	F/0=; b=SEXi3OhG3XH6/O0GuL7BcuV7ndzRFKwwUDC/CVcutak9U2w0mNqVWzJ1
	sHZioaLOXeikGjPauVv5qrbcboMRjxYjfO1H4NhN5mGycC4JvgW1Ofxe9J3DwV4j
	GzaeR3vguuJdXXfnzOIkJ1hi5Ll/h826N9Ho/OspO27F0SDBYoc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=H3RaA9KxkyJfSVo5TOzWrEcCF/0=; b=QakSubqJZPrqK+n47X8d4TM9EdjC
	KKk0P0/Y6WzQ9uEJKLVo6iIFhZnpPgoXt6qttQYMW5fyGHR0Vf2P+3NgmrCqJfwT
	zEtdlYcIKjQU1OKGE0oGo6+i16ISkCeZnqQG83/kC9GjYZ2iH4NSv5R7hJSG5DjI
	nfpSMNTCN5IVKq0=
X-Sasl-enc: mXHZvLGp6dPELaSN1lQ6wPXVAPdQKt8JJ2awZFryOuAs 1402677405
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5C252680101;
	Fri, 13 Jun 2014 12:36:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140613065942.GB7908@sigill.intra.peff.net>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251610>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 02:59:42AM -0400, Jeff King wrote:
> On Thu, Jun 12, 2014 at 02:39:01PM -0500, Caleb Thompson wrote:
>
> > t/t7507-commit-verbose.sh was using a global test_set_editor call to
> > build its environment.
> >
> > Improve robustness against global state changes by having only tests
> > which intend to use the $EDITOR to check for presence of a diff in the
> > editor set up the test-editor to use check-for-diff rather than relying
> > upon the editor set once at script start.
>
> This implies to me that EDITOR is unset after leaving these tests. I
> don't think that is how it works, though.  The tests themselves run in
> the main environment of the test script. A call to test_set_editor from
> one of them will still affect the other tests[1].
>
> I think it works anyway because every subsequent test that cares
> actually sets the editor itself.
>
> Or did you just mean that the new rule is "every test sets the editor as
> they need", which means that we do not have to worry anymore about
> polluting the environment for other tests?

That's exactly what I meant. We can stop relying on the global state *as
it is initially set* and instead move the setup into the tests which
rely on it.

>
> -Peff
>
> [1] It might make sense for test_set_editor, when run from within a
>     test, to behave more like test_config, and do:
>
>       test_when_finished '
>         sane_unset FAKE_EDITOR &&
>         sane_unset EDITOR
>       '

It might, but it's a little out of scope in addition to your concern
about other test scripts.

>
>     I don't know if there would be fallouts with other test scripts,
>     though.

How is this for a reword of that commit description:

    t/t7507-commit-verbose.sh was using a global test_set_editor call to
    build its environment. The $EDITOR being used was not necessary for
    all tests, and was in fact circumvented using subshells in some
    cases.

    To improve robustness against global state changes and avoid the
    use of subshells to temporarily switch the editor, set the editor
    explicitly wherever it will be important.

    Specifically, in tests that need to check for the presence of a diff in the
    editor, make calls to set_test_editor to set $EDITOR to check-for-diff
    rather than relying on that editor being configured globally. This also
    helps readers grok the tests as the setup is closer to the verification.

Caleb Thompson

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmyicAAoJEBYhrcKgrOcK5YoIAJTkhO4zeawz6e/AIyMW8H+U
TAVFJoAFjOGZcaldF06VI+9rCd+/5uC07nc9SB1RuPELI1XaDj0FeDlulPuZW3ZW
gaGaeAKlsVY3nQ61xJNIXBLFEGrttHzJSTHzmNlBc2CUwAsPvCMuyLyV47jI/qvb
/rFm7MaEnX18/FCsIHavyuQN2b8hIMMJqZE+XnikDO8HMmWxSFDXav8H4rBQ076y
x7gnVsagFQcU1j0748KomdEt4Be1e9OsZX28exvEZXWD5/HzoRNWzlknJ+R1kmp2
QIFOTyWl+UHS3cwxWnFeZIv0k0PDLD2Mt5EsuzjeGKJQ9mWMyeGYuC8BT6g+RoY=
=Hngu
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
