From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with
 gettext
Date: Wed, 2 Jun 2010 10:12:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com> <1275440764-26153-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:12:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJk0I-00020N-GT
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab0FBJMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:12:40 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:34877 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754266Ab0FBJMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 05:12:39 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o529CTVI032153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Jun 2010 11:12:29 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o529CTIw032149;
	Wed, 2 Jun 2010 11:12:29 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1275440764-26153-2-git-send-email-avarab@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 02 Jun 2010 11:12:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148232>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> +		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...=
\" to unstage)"));
> +	color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" as =
appropriate to mark resolution)"));
> +	color_fprintf_ln(s->fp, c, _("#"));

This is a multi-line string, and should be translated as such.

The trailing "#" should either be part of the translated multi-line str=
ing,=20
or be added explicitely, and untranslated, at the end.

> +		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...=
\" to unstage)"));
> +	color_fprintf_ln(s->fp, c, _("#"));

Determine how to handle the trailing "#" as above.

> +		color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" to=
 update what will be committed)"));
> +	color_fprintf_ln(s->fp, c, _("#   (use \"git checkout -- <file>...\=
" to discard changes in working directory)"));

Multi-line.

> +		color_fprintf_ln(s->fp, c, _("#   (commit or discard the untracked=
 or modified content in submodules)"));
> +	color_fprintf_ln(s->fp, c, _("#"));

Trailing "#".

> +	color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to incl=
ude in what will be committed)"), how);
> +	color_fprintf_ln(s->fp, c, _("#"));

Ditto.

> +	case 1: how =3D _("both deleted:"); break;
> +	case 2: how =3D _("added by us:"); break;
> +	case 3: how =3D _("deleted by them:"); break;
> +	case 4: how =3D _("added by them:"); break;
> +	case 5: how =3D _("deleted by us:"); break;
> +	case 6: how =3D _("both added:"); break;
> +	case 7: how =3D _("both modified:"); break;
> 	}
> -	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
> +	color_fprintf(s->fp, c, _("%-20s%s\n"), how, one);

does color_fprintf() gracefully handle cutting text for multi-byte=20
encodings, and text width? Otherwise I can see this bite us for all=20
non-ASCII locales in general (if long translated are needed), and=20
for CJK locales in particular (for variable character widths).

> -		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
> +		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("%s"), extra.bu=
f);

Should not be in _()

> -	fprintf(s->fp, "\n");
> +	fprintf(s->fp, _("\n"));

Ditto.

> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial c=
ommit"));
> +		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));

Either a multi-line string, or untranslate the "#"s.

--=20
\\// Peter - http://www.softwolves.pp.se/
