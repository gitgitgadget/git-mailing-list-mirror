From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Tue, 29 Apr 2014 00:40:49 +0400
Message-ID: <20140428204048.GA21365@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <20140428162536.GB13002@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesME-0007IH-HG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbaD1Ukx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:40:53 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44229 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbaD1Ukx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:40:53 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WesM5-0005Zw-3e; Tue, 29 Apr 2014 00:40:49 +0400
Content-Disposition: inline
In-Reply-To: <20140428162536.GB13002@google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247440>

On Mon, Apr 28, 2014 at 09:25:36AM -0700, Jonathan Nieder wrote:
> > -STRIP ?=3D strip
> > +STRIP =3D $(CROSS_COMPILE)strip
>=20
> Before, STRIP from the environment took precedence over STRIP from th=
e
> makefile.  Switching to the more usual 'environment can't be trusted'
> convention is a good change, but please mention it in the commit
> message.

Taken from [1]:

> Simply expanded variables are defined by lines using =E2=80=98:=3D=E2=
=80=99 or =E2=80=98::=3D=E2=80=99 (see Setting Variables).
> Both forms are equivalent in GNU make; however only the =E2=80=98::=3D=
=E2=80=99 form is described by the POSIX
> standard (support for =E2=80=98::=3D=E2=80=99 was added to the POSIX =
standard in 2012, so older versions of make
> won't accept this form either).
>
> The value of a simply expanded variable is scanned once and for all, =
expanding any references
> to other variables and functions, when the variable is defined. The a=
ctual value of the simply
> expanded variable is the result of expanding the text that you write.=
 It does not contain any
> references to other variables; it contains their values as of the tim=
e this variable was defined.
> Therefore,
>
>    x :=3D foo
>    y :=3D $(x) bar
>    x :=3D later
> is equivalent to
>
>    y :=3D foo bar
>    x :=3D later
>
> When a simply expanded variable is referenced, its value is substitut=
ed verbatim.

I don't see how it relates to environment precedence. Could you please =
provide me an example of
a situation that changed due to my commit?

[1]: http://www.gnu.org/software/make/manual/make.html#Flavors
