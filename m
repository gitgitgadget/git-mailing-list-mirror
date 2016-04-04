From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of
 @{-1}
Date: Mon, 4 Apr 2016 23:53:14 +0200 (CEST)
Message-ID: <1048705176.2897167.1459806794368.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com> <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAJPOeMeqMpy8wmZ3jMfw_XLAS2WbPOtJF8_Rd_sPGQNeCNyFnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 23:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCNZ-00020K-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 23:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbcDDVtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 17:49:39 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:37484 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655AbcDDVtg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 17:49:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 777E92327;
	Mon,  4 Apr 2016 23:49:32 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0VwYwBuMOSs; Mon,  4 Apr 2016 23:49:32 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 616A222F7;
	Mon,  4 Apr 2016 23:49:32 +0200 (CEST)
In-Reply-To: <CAJPOeMeqMpy8wmZ3jMfw_XLAS2WbPOtJF8_Rd_sPGQNeCNyFnw@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: branch -D: allow - as abbreviation of @{-1}
Thread-Index: Vw71cvSJ8XC7OJf3b3hQlkWllht7RA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290728>

elena petrashen <elena.petrashen@gmail.com> wrote:
> On Thu, Mar 31, 2016 at 6:31 PM, Remi Galan Alfonso
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> > Elena Petrashen <elena.petrashen@gmail.com> wrote:
> >> +void delete_branch_advice(const char *name, const char *ref)
> >> +{
> >> +        const char fmt[] =3D
> >> +        "\nNote: to restore the deleted branch:\n\ngit branch %s =
%s\n";
> >
> > Shouldn't that be marked for translation, like is done with the oth=
er
> > strings?
> >
> > Thanks,
> > R=C3=A9mi
>=20
> Thank you for letting me know about that! Could you please
> help me out and explain how do I mark it for translation? I tried
> to do it the same way as with the other strings but evidently
> didn't quite succeed.

I am not sure.
I tried to grep similar cases, it seems that you can do the following:

	const char fmt[] =3D N_("\nNote: to restore [...] \ngit branch %s %s\n=
");
	fprintf(stderr, _(fmt), name, ref);

Some similar example in builtin/add.c:

	static const char ignore_error[] =3D
	N_("The following paths are ignored by one of your .gitignore files:\n=
");
	[...]
			fprintf(stderr, _(ignore_error));

Or you can define fmt as a 'const char *' and in that case do the
following:

	const char *fmt =3D _("\nNote: to restore [...] \n git branch %s %s\n"=
);
	fprintf(stderr, fmt, name, ref);


In builtin/am.c:
		const char *invalid_line =3D _("Malformed input line: '%s'.");
	[...]
				ret =3D error(invalid_line, sb.buf);

I don't know which one is the best way to go though.

Thanks,
R=C3=A9mi
