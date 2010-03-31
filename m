From: Jan =?UTF-8?B?U3TEmXBpZcWE?= <jan@stepien.cc>
Subject: Re: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 15:32:18 +0200
Message-ID: <20100331153218.6b13853b.jan@stepien.cc>
References: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
	<7vy6h8om7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 15:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwy25-0001UO-Ud
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 15:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344Ab0CaNc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 09:32:28 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:47694 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933319Ab0CaNc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 09:32:27 -0400
Received: from localhost.localdomain (chello089078159032.chello.pl [89.78.159.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 9282E2A10358;
	Wed, 31 Mar 2010 15:32:25 +0200 (CEST)
In-Reply-To: <7vy6h8om7q.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.1 (GTK+ 2.18.9; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143674>

On Wed, 31 Mar 2010 02:48:57 -0700
Junio C Hamano <gitster@pobox.com> wrote:
> Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:
>=20
> > This commit adds $show_owner_column configuration variable which al=
lows
> > to hide the project list "Owner" column if desired.
> >=20
> > @@ -4430,7 +4433,7 @@ sub git_project_list_body {
> >  		}
> >  		print_sort_th('project', $order, 'Project');
> >  		print_sort_th('descr', $order, 'Description');
> > -		print_sort_th('owner', $order, 'Owner');
> > +		print_sort_th('owner', $order, 'Owner') if $show_owner_column;
> >  		print_sort_th('age', $order, 'Last Change');
>=20
> Ugly.  Think what you would do if somebody else asks you to allow him=
 to
> omit 'Description', or perhaps 'Last Change'.
>=20
> I would understand if the change was to introduce a configuration var=
iable
> of the array type @project_column whose default value is qw(project d=
escr
> owner age) that is used to control which columns are shown in what or=
der.
>=20
> If it is undesirable to allow reordering the columns, the configurati=
on
> should at least be %omit_project_column used like this, no?
>=20
> 	print_sort_th('project', $order, 'Project')
>         	unless $omit_project_column{'project'};
> 	print_sort_th('descr', $order, 'Description')
>         	unless $omit_project_column{'descr'};
> 	...
>=20

As I wrote in my e-mail to Jakub Narebski, the reason for hiding only
the "Owner" column is a single-user situation. There's only one owner
and repeating his name in each column isn't necessary.

I agree that your solution is cleaner and allows further customization,
but it covers a slightly different issue comparing to the one I'm
addressing.

I like the idea suggested by Jakub to make this config variable cover
other pages. It could remove the owner information from both the
project list and project summaries.

Cheers,
--=20
Jan St=C4=99pie=C5=84 <jan@stepien.cc>
