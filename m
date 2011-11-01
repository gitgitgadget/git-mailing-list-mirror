From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Tue, 1 Nov 2011 11:19:04 -0700
Message-ID: <20111101181904.GA10235@sigill.intra.peff.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
 <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 19:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLIvc-0002lX-3E
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 19:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab1KASTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 14:19:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59435
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab1KASTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 14:19:07 -0400
Received: (qmail 6259 invoked by uid 107); 1 Nov 2011 18:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Nov 2011 14:24:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2011 11:19:04 -0700
Content-Disposition: inline
In-Reply-To: <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184579>

On Tue, Nov 01, 2011 at 11:12:49AM -0700, Junio C Hamano wrote:

> Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:
>=20
> >>>  * HTTP transport did not use pushurl correctly, and also did not=
 tell
> >>>    what host it is trying to authenticate with when asking for
> >>>    credentials.
> >>>    (merge deba493 jk/http-auth later to maint).
> >>=20
> >> This seems to break pushing with https for me.
> >> It never uses values from my '~/.netrc'.
> >> I'll come up with a detailed scenario later.
> >
> > Update:
> >
> > git push prompts for the password but just pressing return succeeds=
=2E
> >
> > Weird...
>=20
> There are only handful of commits that even remotely touch http relat=
ed
> codepath between v1.7.7 and v1.7.8-rc0:
>=20
>   * deba493 http_init: accept separate URL parameter
>=20
>   This could change the URL string given to http_auth_init().
>=20
>   * 070b4dd http: use hostname in credential description
>=20
>   This only changes the prompt string; as far as I understand it, the
>   condition the password is prompted in the callsites of git_getpass(=
)
>   has not changed.
>=20
>   * 6cdf022 remote-curl: Fix warning after HTTP failure
>   * be22d92 http: avoid empty error messages for some curl errors
>   * 8abc508 http: remove extra newline in error message
>   * 8d677ed http: retry authentication failures for all http requests
>   * 28d0c10 remote-curl: don't retry auth failures with dumb protocol
>=20
>   These shouldn't affect anything wrt prompting, unless you are someh=
ow
>   internally reauthenticating.
>=20
> Could you try reverting deba493 and retest, and then if the behaviour=
 is
> the same "need ENTER", further revert 070b4dd and retest?

I don't use .netrc, but with all of my patches (most of which aren't
even in what you are running), I tried not to affect the netrc case. I
just checked a few things, and it seems to be working as I expect. Do w=
e
have a repeatable test?

-Peff
