From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 5 messages
Date: Wed, 7 Aug 2013 11:17:08 +0200
Message-ID: <87r4e5vp0r.fsf@linux-k42r.v.cablecom.net>
References: <1375813794-4578-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 11:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6zrn-0004t3-LG
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 11:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300Ab3HGJRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 05:17:12 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12907 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756495Ab3HGJRK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Aug 2013 05:17:10 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 7 Aug
 2013 11:17:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 7 Aug 2013 11:17:08 +0200
In-Reply-To: <1375813794-4578-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 6 Aug 2013 20:29:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231813>

Ralf Thielow <ralf.thielow@gmail.com> writes:
>=20

The changes look good to me.  The following is purely about the origina=
l
English messages.

>  #: builtin/commit.c:62
> -#, fuzzy
>  msgid ""
>  "The previous cherry-pick is now empty, possibly due to conflict res=
olution.\n"
>  "If you wish to commit it anyway, use:\n"
>  "\n"
>  "    git commit --allow-empty\n"
> @@ -4014,25 +4012,30 @@ msgstr ""
>  "Konfliktaufl=C3=B6sung.\n"
>  "Wenn Sie dies trotzdem committen wollen, benutzen Sie:\n"
>  "\n"
>  "    git commit --allow-empty\n"
>  "\n"
> -"Andernfalls benutzen Sie bitte 'git reset'\n"
> =20
>  #: builtin/commit.c:69
>  msgid "Otherwise, please use 'git reset'\n"
> -msgstr ""
> +msgstr "Andernfalls benutzen Sie bitte 'git reset'\n"

This results from Peff's c17592a (commit: tweak empty cherry pick advic=
e
for sequencer, 2013-07-26):

  diff --git a/builtin/commit.c b/builtin/commit.c
  index a17a5df..39717d5 100644
  --- a/builtin/commit.c
  +++ b/builtin/commit.c
  @@ -62,8 +62,18 @@
   "If you wish to commit it anyway, use:\n"
   "\n"
   "    git commit --allow-empty\n"
  +"\n");
  +
  +static const char empty_cherry_pick_advice_single[] =3D
  +N_("Otherwise, please use 'git reset'\n");
  +
  +static const char empty_cherry_pick_advice_multi[] =3D
  +N_("If you wish to skip this commit, use:\n"
   "\n"
  -"Otherwise, please use 'git reset'\n");
  +"    git reset\n"
  +"\n"
  +"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
  +"the remaining commits.\n");
  =20
   static const char *use_message_buffer;
   static const char commit_editmsg[] =3D "COMMIT_EDITMSG";


I was wondering for a while if this was a smart move, based on the usua=
l
observation that it is better to translate things in one chunk because
many languages have more interdependencies than English does.  The
gettext manual says:

     puts ("Apollo 13 scenario: Stack overflow handling failed.");
     puts ("On the next stack overflow we will crash!!!");

  Should these two statements merged into a single one? I would recomme=
nd
  to merge them if the two sentences are related to each other, because
  then it makes it easier for the translator to understand and translat=
e
  both.  On the other hand, if one of the two messages is a stereotypic
  one, occurring in other places as well, you will do a favour to the
  translator by not merging the two.
[...]
     Translatable strings should be limited to one paragraph; don't let=
 a
  single message be longer than ten lines.

So it seems that concatenating sentences indeed falls into a gray area
between "avoid sentence lego" and "split at paragraphs".  And Peff's
style of splitting it saves the translators work because the first part
of the message is shared among two code paths.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
