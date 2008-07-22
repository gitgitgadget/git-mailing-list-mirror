From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] parse-options: fix parsing of "--foobar=" with no value
Date: Tue, 22 Jul 2008 21:25:42 +0200
Message-ID: <48863436.50309@free.fr>
References: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr> <20080722185427.GA10453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 21:28:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLNVZ-0004sc-GI
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 21:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbYGVTZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2008 15:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbYGVTZp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 15:25:45 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52986 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328AbYGVTZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 15:25:44 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 229E012B6F4;
	Tue, 22 Jul 2008 21:25:43 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C1AC612B715;
	Tue, 22 Jul 2008 21:25:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080722185427.GA10453@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89513>

Pierre Habouzit a =E9crit :
> On Tue, Jul 22, 2008 at 06:44:27PM +0000, Olivier Marin wrote:
>=20
>   Wrong, --foobar=3D is the option "foobar" with the argument "" (emp=
ty
> string). as soon as you use the --foobar=3D... form, that is the "stu=
ck
> form" for long option, there *is* a value.

Ah, OK.

I would have find it convenient for things like --foobar=3D$var where f=
oobar
fallback to default when $var is empty. But I don't care that much.

>   IOW --foobar=3D is not the same as --foobar at all. If like you cla=
im,
> --foobar=3D pass a "random" value to the option then *this* is a bug,=
 it
> should pass a pointer to an empty string (IOW a pointer that points t=
o a
> NUL byte), but I see nothing in the code that would explain what you
> claim.

I found the "random bug" while migrating "git init" to parse-options. I
think you can reproduce it with:

$ git clone --template=3D <repo>
error: ignoring template /var/run/synaptic.socket
fatal: cannot opendir /var/run/sudo

But now, it appears the problem is not in parse-options, sorry.

--=20
Olivier.
