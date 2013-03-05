From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Tue, 05 Mar 2013 16:42:52 +0100
Message-ID: <5136127C.2090402@viscovery.net>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCu1a-0001S6-8x
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578Ab3CEPnD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 10:43:03 -0500
Received: from so.liwest.at ([212.33.55.24]:39067 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015Ab3CEPnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 10:43:02 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UCu0z-0002JM-G6; Tue, 05 Mar 2013 16:42:53 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3BE971660F;
	Tue,  5 Mar 2013 16:42:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1362494681-11419-1-git-send-email-avarab@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217453>

Am 3/5/2013 15:44, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the semantics of "git <alias> --help" to show the help for the
> command <alias> is aliased to, instead of just saying:
>=20
>     `git <alias>' is aliased to `<whatever>'
>=20
> E.g. if you have "checkout" aliased to "co" you won't get:
>=20
>     $ git co --help
>     `git co' is aliased to `checkout'
>=20
> But will instead get the manpage for git-checkout.
=2E..
>  	alias =3D alias_lookup(argv[0]);
>  	if (alias && !is_git_command(argv[0])) {
> -		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
> -		return 0;
> +		show_help_for =3D alias;
> +	} else {
> +		show_help_for =3D argv[0];
>  	}

This needs a lot more scrutiny. The alias can be more than just a singl=
e
word, and it can even be a shell scriptlet, i.e., not a git command at =
all.

It may make sense to show the help of the aliased-to command if the ali=
as
resolves to just a single word.

-- Hannes
