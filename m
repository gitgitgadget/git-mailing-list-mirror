From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Thu, 24 Jul 2008 18:15:46 +0200
Message-ID: <4888AAB2.5050007@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3Um-0007Vb-U0
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbYGXQPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 12:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbYGXQPs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:15:48 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:34880 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbYGXQPs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:15:48 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 2110812B6C7;
	Thu, 24 Jul 2008 18:15:47 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CC08C12B6FF;
	Thu, 24 Jul 2008 18:15:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <1216849332-26813-7-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89899>

Michele Ballabio a =E9crit :
>=20
> +	const struct option options[] =3D {
> +		OPT_STRING(0, "template", &template_dir, "dir",
> +			   "directory from which templates will be used"),

Perhaps "path", "path to the template repository" to stay consistent wi=
th clone.

> +		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repo"),

s/set up/setup/ and s/repo/repository/?

> +		{ OPTION_CALLBACK, 0, "shared", &shared_repository,
> +		  "type", "type of shared repository",

What about "permissions", "setup a shared repository"?

> +		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },

Are you sure the default value is really used here?

Also, perhaps we can play it safer by avoiding changing "share_reposito=
ry"
directly.

$ git init -> shared_repository =3D=3D PERM_UMASK
$ git init --shared --no-shared -> shared_repository =3D=3D 0

It works because PERM_UMASK =3D=3D 0, but it is a side effect. Don't yo=
u think?

> +		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),

OPT__QUIET(&quiet),

if (quiet)
	flags |=3D INIT_DB_QUIET;

to use the same quiet option everywhere?

Just my opinion,
Olivier.
