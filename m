From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: Optional grouping of projects by category
Date: Thu, 4 Dec 2008 00:12:29 +0100
Message-ID: <200812040012.30885.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <87prk91got.wl%seb@cine7.net> <7viqq0c1pg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?S=C3=A9bastien_Cevey?= <seb@cine7.net>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80us-0003Da-2y
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYLCXMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2008 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYLCXMl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 18:12:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:6736 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYLCXMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 18:12:41 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3568724ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JmRoskBzt0sLTLsWYFaqhbr30wY++eLHJUjweTazr4k=;
        b=azI28fvWW6WB0/8MG892sucUsqDEaEHkOLS82zXHgS3Pkalczi+3k8TCvXYz6/KTcP
         1lUWKN7AxyPK5w7KzjBB3OVjsFn5KVpXxquUmPY7+eMZJEZpGTXpeQ4p/X0DxdkrAz22
         iUJw/RtFU5Lr+L/odt3QslxwXXgEASRkQikvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=u2B2fgC4a4pLJUkCxlffOQHsYs3hnPc+wrup56QadMwxorztNteYpfjlZtdwmUv5lG
         9F1EK+0gjsqoKNhgIc+byCBlDNBNX3pu92HnCZA0erKKcs0B7vgtR9nraGHu9C1ixL0w
         bpWD9Cqa0q/sGNIvrk7gbExZmZCgcFEqKwLd4=
Received: by 10.210.61.8 with SMTP id j8mr15916747eba.45.1228345959041;
        Wed, 03 Dec 2008 15:12:39 -0800 (PST)
Received: from ?192.168.1.11? (abvo179.neoplus.adsl.tpnet.pl [83.8.212.179])
        by mx.google.com with ESMTPS id 7sm9070364eyb.54.2008.12.03.15.12.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 15:12:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqq0c1pg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102304>

On Wed, 3 Dec 2008, Junio C Hamano wrote:
> S=C3=A9bastien Cevey <seb@cine7.net> writes:

> > This adds the $projects_list_group_categories option which, if enab=
led,
> > will result in grouping projects by category on the project list pa=
ge.
> > The category is specified for each project by the $GIT_DIR/category=
 file
> > or the 'category' variable in its configuration file. By default, p=
rojects
> > are put in the $project_list_default_category category.
> >
> > Note:
> > - Categories are always sorted alphabetically, with projects in
> >   each category sorted according to the globally selected $order.
>=20
> I am not sure if always sorting the categories alphabetically is a se=
vere
> enough restriction, but if it was, you can use @project_list_categori=
es
> array that disables the feature when empty and otherwise enumerates t=
he
> categories in order.  Just an idle thought.

Well, this way of sorting, i.e. keeping order of categories constant,
and changing order _within_ categories has the advantage that changing
order (the column we sort by) doesn't change page layout, i.e. in this
case doesn't change categories layout.


It means that if we had:

  project1
  project2
  [category A]
  A/pr1
  A/pr2
  [category B]
  B/pr1
  B/pr2
  B/pr3

when sorting by project name, we will have similarly looking

  project2
  project1
  [category A]
  A/pr1
  A/pr2
  [category B]
  B/pr3
  B/pr1
  B/pr2

for example if we order by age (not shown here)
=20
> > - When displaying a subset of all the projects, only the categories=
 with
> >   projects in the chosen subset are displayed.
>=20
> Could you clarify this bit?
>=20
> It is not very clear to me how this subset selection happens.  As far=
 as I
> can see, the user does not choose the category to view, but lets the =
usual
> page limiting to decide at which project to start and stop placing on=
 the
> page, and only show the ones in the same category as the one that hap=
pened
> to be the first on the page.

Currently the only selection is by tag, but lets assume that we have
some page length limit and only first N projects (first N in given sort
order) are shown.

If we have selection by tag, only those categories that have at least
one project tagged with selected tag, and only projects with given tag
would be shown. If we have page limit on projects list page, and we
sort for example by age, then only categories with freshest projects
will be shown.

At least it is how I understand it...

=20
> While I think both the introduction of "git_get_project_config_or_fil=
e"

Errr... I think it is git_get_file_or_project_config ;-))))

> which is a generalized interface usable between description and the n=
ew
> feature and the refactoring of project_list_body into a seprate funct=
ion
> "print_project_rows" is a good idea, the patch would have been much e=
asier
> to read if these preparatory refactoring steps (without any new featu=
re)
> were done as a separate patch followed by the main patch to introduce=
 the
> new feature.
=20
I agree, especially the second part, as adding print_project_rows patch
looks harder than it actually is.

--=20
Jakub Narebski
Poland
