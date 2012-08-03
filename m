From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC] l10n: de.po: translate 76 new messages
Date: Fri, 3 Aug 2012 10:59:27 +0200
Message-ID: <87y5lw73m8.fsf@thomas.inf.ethz.ch>
References: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>,
	<worldhello.net@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxDjM-0001af-OP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 10:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab2HCI7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 04:59:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33262 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab2HCI7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 04:59:30 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:59:25 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:59:27 +0200
In-Reply-To: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 2 Aug 2012 19:12:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202822>

Hi Ralf

Thanks a lot for your work.  Below I am pointing out several items that
actually need to be fixed in code (mostly lego messages), so it's a bit
of a TODO list and I don't mean to imply that you should fix those
before your patch goes in.


Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: merge-recursive.c:497
> -#, fuzzy
>  msgid "diff setup failed"
> -msgstr "diff_setup_done fehlgeschlagen"
> +msgstr "Einrichtung der Optionen zur Bestimmung der Unterschiede "
> +"fehlgeschlagen"

That one is really unwieldy.  Judging from a cursory look at the code,
it's an internal error anyway and should probably be "BUG:
diff_setup_done failed" to begin with.

>  #: merge-recursive.c:627
>  msgid "merge-recursive: disk full?"
> -msgstr ""
> +msgstr "merge-recursive: Speicher voll?"

Maybe "Festplatte voll?" to distinguish from RAM.

The funny thing is that write_in_full() never returns 0 unless count=3D=
0:
it explicitly sets errno=3DENOSPC and returns -1 if write() returned 0.
So this error will not trigger unless the caller passes in size=3D0, in
which case it is misguided.

>  #: merge-recursive.c:690
> -#, fuzzy, c-format
> +#, c-format
>  msgid "failed to create path '%s'%s"
> -msgstr "Konnte Verkn=C3=BCpfung '%s' nicht erstellen"
> +msgstr "Fehler beim Erstellen des Pfades '%s'%s"

This will need un-legoing...

>  msgid ": perhaps a D/F conflict?"
> -msgstr ""
> +msgstr ": vielleicht ein D/F-Konflikt?"

What's the terminology for conflicts in German?  For D/F, the user need=
s
to know the English terms.  Not that V/D would be much better.  Maybe
just spell it out.

>  #: merge-recursive.c:726
> -#, fuzzy, c-format
> +#, c-format
>  msgid "refusing to lose untracked file at '%s'"
> -msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
> +msgstr "verweigere, da ungefolgte Dateien in '%s' verloren gehen
> w=C3=BCrden"

Your glossary[1] says we call them "unbeobachtet"?

>  #: merge-recursive.c:1038 merge-recursive.c:1052
>  #, c-format
> @@ -437,6 +435,8 @@ msgid ""
>  "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s of =
%s left "
>  "in tree."
>  msgstr ""
> +"KONFLIKT (%s/delete): %s gel=C3=B6scht in %s und %s in %s. Stand %s=
 von %s wurde "
> +"im Arbeitsbereich gelassen."

This needs de-legoification on the first and fourth %s, which can be
rename/renamed or modify/modified.  Furthermore, in line with the D/F
above, perhaps you should translate "delete"?  But I see that you have
not translated "renamed" etc. below, either.  Was that on purpose?  It
will read a bit odd as

  KONFLIKT (rename/delete): foo gel=C3=B6scht in bar und renamed in quu=
x. Stand ...

>  #: merge-recursive.c:1591
>  msgid "content"
> -msgstr ""
> +msgstr "content"
> =20
>  #: merge-recursive.c:1598
>  msgid "add/add"
> -msgstr ""
> +msgstr "add/add"
[...]
>  msgid "CONFLICT (%s): Merge conflict in %s"
> -msgstr ""
> +msgstr "KONFLIKT (%s): Zusammenf=C3=BChrungskonflikt in %s"

More candidates for de-legoification.

>  #: merge-recursive.c:1832
>  #, c-format
>  msgid "merging of trees %s and %s failed"
> -msgstr ""
> +msgstr "zusammenf=C3=BChren der B=C3=A4ume %s und %s fehlgeschlagen"

Capital Z?

>  #: merge-recursive.c:1862
>  #, c-format
>  msgid "Unprocessed path??? %s"
> -msgstr ""
> +msgstr " unverarbeiteter Pfad??? %s"

Stray space at the beginning.

>  #: merge-recursive.c:1918
>  #, c-format
>  msgid "found %u common ancestor(s):"
> -msgstr ""
> +msgstr "%u gemeinsame Vorg=C3=A4nger gefunden"

"ancestor(s)" is not listed in the glossary.  I'd personally pick
"Vorfahren" but I'm probably bikeshedding.

> +"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"git rebase --=
continue\" aus.\n"

Not what you are actually changing, but "resolve" (a merge conflict) is
not in the glossary.  For me

  Wenn du das Problem _gel=C3=B6st_ hast...

sounds nicer.  "aufgel=C3=B6st" sounds like "resolve a domain name" or =
such.

>  msgid "fatal: no such branch: $branch_name"
> -msgstr ""
> +msgstr "fatal: kein solcher Zweig: $branch_name"

kein Zweig $branch_name gefunden?

>  #: git-rebase.sh:474
>  msgid "Please commit or stash them."
> -msgstr ""
> +msgstr "Bitte trage die =C3=84nderungen ein oder benutze \"stash\"."

I really like this way of dodging the "stash" translation :-)


=46ootnotes:=20
[1]  https://github.com/ralfth/git-po-de/wiki/Glossary

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
