From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Tue, 23 Feb 2016 20:56:32 +0000
Message-ID: <871t83cfi7.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com> <87fuwnd4u7.fsf@freja.aidecoe.name> <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com> <877fhwd1g0.fsf@freja.aidecoe.name> <xmqqegc33oal.fsf@gitster.mtv.corp.google.com> <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMBs-0007bW-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbcBWXQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:16:21 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:50258 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcBWXQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:Cc:To:From; bh=hvBaGMu54if8g8rRxjhM8nIfSbRlVpQaM6gTAWjzep4=;
	b=N18+tRgLO+dwAiAU5T6biRL4gW7M0w9xP1kmYELK1fYnIDUGDAIoZLKXGBGfkHmU2B3R7PoJtnU4qnN6/MlTl1b/IYpw9scdfBKTMEc7VVUsZNFie7o5i25fXGRR6D8R2lYvquWDJEw3Ta4ACwWNNGXzYKclgw6IQtZmlwruWxmkqIwhd/n3x5QextklVXliPN7zDf5JgxjrTrGzk/DsI0aaV/1LNxrKxq8OCrB9HNDo0umpIXHQFgw1/NemWCpMWl5kIx/SOYPYDlrzrKxlF9PUe66AIxwPx5B1vu3EVYafSMn/jdldWc05kkdre/1PTpLsI6XkAIbhd3vMAn0fdg==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aYK0c-0001aj-0V; Tue, 23 Feb 2016 21:56:46 +0100
Cc: Git Users <git@vger.kernel.org>
In-Reply-To: <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287141>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luke,

Luke Diamand <luke@diamand.org> writes:
> I'm guessing that the reason for using a bare repo is so that changes
> can be pushed to it from several different git repos. This then saves
> doing the initial git-p4 clone multiple times.

I have created a Git repository acting as a bridge between Perforce and
pure Git repos. Changes pushed to master branch on this bridge repo get
submitted to Perforce repository (referenced via remote p4/master).


> If this had actually worked, I think the next thing I would want to do
> is to rebase one or more branches in the bare repo against p4/master.
> I don't think there's any way that git-p4 can work out which branches
> would be rebased, and nor should it.

It actually has all information needed. It submits commits from a given
branch to a branch specified with --branch option (or default p4
remote). When submitting from a non-bare repo git-p4 has the same set of
information: the current branch and a branch specified with --branch (or
default p4 remote).


> I think the approach of using a submitFromBare config variable to
> force the user to make a choice feels a bit bogus, since they clearly
> *want* to submit from this bare repo, as otherwise they wouldn't have
> done "git-p4 submit" in the first place.

I agree, a good point.


> It might make sense to have a command-line or config option
> ("--skip-rebase" ?) to tell "submit" to only do the submit part, and
> skip the rebase stage (and get the rebase stage to give a more useful
> error message on a bare repo when the option isn't used). That would
> then mean that git-p4 does not have to know if it's running in a bare
> repo or not, and the submit-without-rebase functionality is available
> to people doing other different things not involving bare repos (which
> we haven't though of yet) but still requiring submit without rebase.

While having additional --skip-rebase is a good idea, having git-p4
doing rebase would be more elegant for those who actually use GitP4 in
bare repository. In message 87fuwnd4u7.fsf@freja.aidecoe.name I have
described how state of branches changes during submit. It clearly shows
that in case of a bare repository it ends up in undesired state.

To simplify things, why not just update ref during submit from bare
repository? As you have pointed out, if user invokes submit in this
context he/she actually wants to submit from bare repo and probably
knows what he/she is doing - especially if he/she reads man page. (-:


Kind regards,

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJWzMeAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcEm3EP/2DmVcq2XtQLj+Jj47p4s79d
/MQa3LLz655vO1AjZH/hesnNCxWfrs/ks/SrudBnahOvUeI1njmjsG2UV3k5XLHv
h6whxnWh/uevK7P+De+J+leNQ+0b+fsWSwiGGVzwXWp+oluFrgSEiurvkWYxjpjq
AcjJCAi0+YJgXh2+WEpwg3bIz4iJpPNaBbSqsxB0NZiN6/Esk3p81wK4E2DzqWeX
OiR90EThs7OlB6wIlNZa4Jkk7ldlGO5bUYl1gMMDYZjSUIJnlyLHAj/j8Rchq/V6
ERLWH/tq8NDKezD/r11jL9FJbjHR29PrDaTDKX4KhXkr0c/ESml3ddIeuKMzpefu
LxJFDyEXqk1lUE5YaC9Cjo5+N9mXpGIxbFbeSgQl3IgKEoYm/s/DCWLbWBxuXOWP
3RzqGVPD/yYhg2r7WDpgpgOUIMVVQr7S9CdEQ9sJ76waf8ObBljMYlsJ1OryeNjD
SPEti7hLASifGJ7ABuiDo64itLa7zuhOZ2S9bwEIZdWMXzvvCPrYdcvgyWsE9dZe
XeaPELNYhYFLmLPhYktiES/MLnsjlvviWekRhlWuARJFGKlm1NFjrMguyrkBQdvJ
cJVKEGw2YYPMpZhsrQyU+F3IYYv/QTZrRbv3ZCXwotQOhDJrWZZS6KsvvdNaEDey
Ehx9PYV1APEr0aEFSosd
=gUDK
-----END PGP SIGNATURE-----
--=-=-=--
