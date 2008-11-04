From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Tue, 4 Nov 2008 01:24:36 +0100
Message-ID: <200811040124.36708.jnareb@gmail.com>
References: <200811031943.30033.angavrilov@gmail.com> <200811032017.47652.jnareb@gmail.com> <200811032259.03394.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 01:25:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx9k1-0004ZM-Rc
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYKDAYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYKDAYk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:24:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:37295 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYKDAYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 19:24:39 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1139814nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uVIZZPeCh8DFMQqXc6dQCoTCSSTHbJFTvK86tpGr0nI=;
        b=MfLTl2j2kG1u8Fd7Ut9DagFdTECJ1f+xWqYfm2zqHL6pJGrxjNdg9nFjLhFxssQXd2
         ZseaL+ee6UkskvjBk8Lrjz5Q2gTNSgrezcneD46tyOXgxMoQxN7dsHVSxwyZRhLrvRrs
         gaJ0ppdPo7FTTcMLbi7oiPzoBEGPW0Om6I0jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q5LNWXVKtMfeMTFiHjxzCx66n/iLKG13+6DXxHssy1FK5dw1FCLYjz3xzFgGPlbHX3
         jqYrtFr9gbfhrcnjBYxyTP7hujeZgliQzBoJP8hzAWQbW1go+MxuCMj+goecSHsY010m
         axmAq8JuKnQwVe9FVSjWUcefEH/R9qhA6gtVk=
Received: by 10.210.130.14 with SMTP id c14mr861140ebd.192.1225758277724;
        Mon, 03 Nov 2008 16:24:37 -0800 (PST)
Received: from ?192.168.1.11? (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id 34sm40283287nfu.24.2008.11.03.16.24.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 16:24:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811032259.03394.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100015>

On Mon, 3 Nov 2008, Francis Galiegue wrote:
> Le Monday 03 November 2008 20:17:47 Jakub Narebski, vous avez =C3=A9c=
rit=C2=A0:
> > Dnia poniedzia=C5=82ek 3. listopada 2008 19:44, Francis Galiegue na=
pisa=C5=82:
> > > Le Monday 03 November 2008 19:18:56 Jakub Narebski, vous avez =C3=
=A9crit=C2=A0:
=20

> > > > Well, the question is if Apache (and other web servers used wit=
h
> > > > gitweb) can do authentication based on path_info or on query-st=
ring.
> > > > Because it is encoded in gitweb (via $projectroot) where to fin=
d git
> > > > repositories...
> > > >=20
> > >=20
> > > Can you expand on path_info and query-string? Keep in mind that A=
pache
> > > has mod_rewrite, which can rewrite URLs in any way before it gets
> > > actually sent to the underlying program (whether it be a CGI or
> > > anything else), even badly (or mischievously).
> >=20
> > What I mean here that the following example gitweb URLs
> >=20
> >   http://example.com/gitweb.cgi?p=3Dsome/project.git;a=3Dcommit;h=3D=
HEAD
> >   http://example.com/gitweb.cgi/some/project.git/commit/HEAD
> >=20
> > with the following gitweb configuration
> >=20
> >   $projectroot =3D /var/scm
> >=20
> > both refer to git repository (directory) at
> >=20
> >   /var/scm/some/project.git
> >=20
> > Apache (or other web server) would have to somehow decide based on =
URL
> > that it refers to some project, and based on project and authentica=
tion
> > decide whether to grant access to it.
> >=20
> >=20
> > What is more, and what cannot be done by web server alone, is that =
we
> > would want to not show projects which you don't have access to in t=
he
> > 'projects_list' page, i.e. at
> >=20
> >   http://example.com/gitweb.cgi
> >=20

On the other hand we can decide to display projects for which user
doesn't have access (via HTTP authentication) for, just like
directories in *Index* directive can be shown even if they cannot be
accessed.
=20
> I see the point. Note that the second URL can be converted into the f=
irst
> one with mod_rewrite, and probably the first to the second as well.=20
>=20
> As to what repository is accessible to whom, does gitweb really have
> an internal mechanism for this? Wouldn't it be "better" is privately
> accessible projects were available on another website to start with? =
=20

The problem is that Apache has to decide whether to deny or grant acces=
s
based on URL, not on path in filesystem. Perhaps that is possible...

As to having in gitweb mechanism for this... even now gitweb supports
bare-bones access control in terms of $export_ok. BTW you can have
 not displayed but still accessible.project
--=20
Jakub Narebski
Poland
