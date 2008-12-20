From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 20 Dec 2008 01:35:48 +0100
Message-ID: <200812200135.51151.jnareb@gmail.com>
References: <1229203014.31181.7.camel@mattlaptop2.local> <200812132351.37420.jnareb@gmail.com> <1229220398.3360.66.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 01:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDpqP-0007CE-DB
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 01:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYLTAgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Dec 2008 19:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYLTAgC
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:36:02 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45707 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYLTAgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 19:36:00 -0500
Received: by ewy10 with SMTP id 10so1341864ewy.13
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bIuYlBUaVjSRi6Yj0QMw7651dDgGHXZyD1c606vLuOs=;
        b=CkjOMMNu6kBByCylapNKWoRIPCDpVRKgo0oaJfpg76DTI0p/ueNGtEB+FrHzT7mniw
         eRAxkyjJFoOFgIdXNEVVxPDg3f0VYCW9jAxr/i4vo9M5rAjIswjgqBMwaxL8qXFI4GuZ
         FtQrTi4lualpaxwYdZD71shzFhUw230kYwqb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CK2tUWs153i4m2RCqwHt4syk2iSLUIZ1+nynIjDciCxiOjHjxhswpKBQp1tOGyPCag
         y13JEvUlXj48EDH90rKVsVqroYwAZIRpoj2gmustpLlRNT0LUfHAZgZggpghHWcjq6ct
         K5ROBkHk7CvWtWvTohCmCJ1YXClx161EexUa0=
Received: by 10.210.30.1 with SMTP id d1mr4459717ebd.182.1229733358644;
        Fri, 19 Dec 2008 16:35:58 -0800 (PST)
Received: from ?192.168.1.11? (abvm23.neoplus.adsl.tpnet.pl [83.8.210.23])
        by mx.google.com with ESMTPS id z37sm11558367ikz.0.2008.12.19.16.35.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Dec 2008 16:35:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1229220398.3360.66.camel@mattlaptop2.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103611>

On Sun, 14 Dec 2008 03:06, Matt McCutchen napisa=B3:
> On Sat, 2008-12-13 at 23:51 +0100, Jakub Narebski wrote:
> >
> > "no_hide" (currently "include_forks") allows us to _not_ passing th=
is
> > parameter in other places than project_in_list(); undef is falsy.
>=20
> Right.  That's why I made the current parameter $for_strict_export (s=
o
> only project_in_list passes it) rather than the negation.

Still I think $for_strict_export is singularly _bad_ name for
a parameter. $no_hide or $show_all would be much, much better.

> > By the way, doesn't git_project_index and perhaps git_opml also nee=
d
> > this parameter passed to git_get_projects_list?
>=20
> Yes, now that you mention it, I suppose they should show forks, thoug=
h
> not hidden repositories.  Then git_get_projects_list can be called in
> three different modes: include everything (project_in_list), include
> forks but not hidden (git_get_project_index and git_opml), or include
> neither forks nor hidden (git_project_list).  Should we have two
> separate parameters to git_get_projects_list or a single three-valued
> one?

By the way, I am not sure if your idea of "hidden projects" and project=
s
list (projects index) file.

We have two way of specifying list of projects. One is scanning
projectroot directory for something that looks like git repository,
the other is having projects list file with project paths and project
owners.

If you use projects list file, you can have projects which are in not
on project list, but are accessible in filesystem. Those projects
(repositories) are hidden, i.e. they are not visible on projects_list
page, but still you can access a project. If you want to have projects
which are not on list to be not accessible at all, and not only hidden,
you have to use $strict_export... using which makes access to repo
views a tiny bit slower (and _only_ slows down gitweb for when scanning
directories for projects).

But why would one _want_ projects which are not visible, but still
accessible; "hidden" projects? Moreso what you want, the three class
of projects inside $projectroot: visible, hidden, and not exported.


With newly added $export_auth_hook you can limit accessibility of
projects in other ways, for example using .htaccess control files of
Apache web server.  Check gitweb/README (or gitweb/INSTALL) for
example.

> That raises another point.  I was going to change git_get_projects_li=
st
> so that forks of a hidden project that are not themselves hidden appe=
ar
> on the parent project's page but not in the main project list.  This
> way, users who know about the parent project can navigate to the fork=
,
> but the fork does not give away the existence of the parent project b=
y
> appearing in the main list.  Then I guess git_project_index and git_o=
pml
> should omit forks of hidden projects, meaning that some fork-checking
> still has to take place with "include forks" on but "include hidden"
> off.  This will make git_get_projects_list somewhat more complex but =
not
> unmanageably so, and I do think it's the behavior we want.
>=20
> I will send an updated patch.

So you see that having explicitly hidden files have yet another
complication. I wonder if this is really worth it...

--=20
Jakub Narebski
Poland
