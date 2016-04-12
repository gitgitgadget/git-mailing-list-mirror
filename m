From: KellerFuchs <KellerFuchs@hashbang.sh>
Subject: Re: [PATCH] Documentation: clarify signature verification
Date: Tue, 12 Apr 2016 01:00:09 +0000
Message-ID: <20160412010009.GD9034@hashbang.sh>
References: <20160409200756.GA22694@hashbang.sh>
 <xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
 <20160411003242.GC9034@hashbang.sh>
 <xmqqtwj8rtcd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 03:00:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apmh4-0007Uf-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 03:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbcDLBAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2016 21:00:33 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:38734 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbcDLBAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 21:00:32 -0400
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 407323B94;
	Tue, 12 Apr 2016 01:00:29 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id 6DFDAE00BA; Tue, 12 Apr 2016 01:00:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqtwj8rtcd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291239>

On Mon, Apr 11, 2016 at 09:41:22AM -0700, Junio C Hamano wrote:
> KellerFuchs <KellerFuchs@hashbang.sh> writes:
> > The reason for the first edit is that =E2=80=9Ctrusted=E2=80=9D and=
 =E2=80=9Cvalid=E2=80=9D are OpenPGP
> >   concepts: a key is trusted if the user set a trust level for it,
> >   and a uid is valid if it has been signed by a trusted key [0].
>=20
> OK, so it is wrong to talk about "trusted" and/or "valid" "GPG
> signatures" like the original one.  We should say "... have GPG
> signatures that were signed by valid key" (not "trusted" key)?

Well, the GnuPG documentation also talks of valid signatures,
  and it is a convenient short-hand:

  https://www.gnupg.org/documentation/manuals/gpgme/Verify.html
 =20
On the other hand, being more explicit here cannot hurt.

> Thanks for clarification.  The distinction between trusted and valid
> should at least be in the log message and possibly (if we can find a
> good way to flow it into the description) added to the documentation.

Ok.  I will have a second go at the patch (with the split you requested=
,
  a more explicit description and an explanation in the commit msg).

What is the prefered way to send a second version of a patchset here?
Just git-email-ing it here In-Reply-To the first mail?

>     Verify that the tip commit of the side branch being merged is
>     signed with a valid key (i.e. a key that is signed by a key that
>     the user set the trust level as trusted), and abort the merge if
>     it is not.

I would rather see something like

>     Verify that the tip commit of the side branch being merged is
>     signed with a valid key, i.e. a key that has a valid uid: in the
>     default trust model, this means it has been signed by a trusted k=
ey.
>     If the tip commit of the side branch is not signed with a valid k=
ey,
>     the merge is aborted.

It's unfortunately more verbose, but I don't want to make promises
  about GnuPG's behaviour that depends on the user's configuration.


Best,

  kf
