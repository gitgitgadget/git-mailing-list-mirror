From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] guard config parser from value=NULL
Date: Sun, 10 Feb 2008 18:08:20 +0100
Message-ID: <20080210170820.GA12162@auto.tuwien.ac.at>
References: <12025767241532-git-send-email-mkoegler@auto.tuwien.ac.at> <7vhcghet3q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Govind Salinas <govind@sophiasuchtig.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFft-0001yC-Se
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYBJRIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 12:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbYBJRIX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:08:23 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37345 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYBJRIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:08:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 37298680BEAC;
	Sun, 10 Feb 2008 18:08:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u-6+0SXnhb3B; Sun, 10 Feb 2008 18:08:20 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 1DCD8680067B; Sun, 10 Feb 2008 18:08:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhcghet3q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73377>

On Sat, Feb 09, 2008 at 01:07:53PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>=20
> > @@ -416,7 +416,7 @@ int git_default_config(const char *var, const c=
har *value)
> >  		return 0;
> >  	}
> > =20
> > -	if (!strcmp(var, "user.name")) {
> > +	if (value && !strcmp(var, "user.name")) {
> >  		strlcpy(git_default_name, value, sizeof(git_default_name));
> >  		return 0;
> >  	}
>=20
> This is wrong, isn't it?  When somebody says
>=20
> 	[user]
>         	name
>=20
> we should not silently ignore it, but instead say "user.name is
> not a bool!" and error out.
>=20
> The same comment applies to all other
>=20
> 	if (value && !strcmp(var, "<varname>"))
>=20
> conversions.

=46or all in config.c, yes.

=46or setup.c, I would say no. The code is called, when trying to find =
a
git repository.

I have seen, that a similar patch for the config.c stuff has been
posted. I will wait some days to see, what happens with it.

mfg Martin K=F6gler
