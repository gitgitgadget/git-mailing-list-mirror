From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 6 May 2011 19:36:56 +0200
Message-ID: <20110506173656.GA2872@madism.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
 <1304667535-4787-1-git-send-email-madcoder@debian.org>
 <7vei4b20we.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:37:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOxd-00023L-7V
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab1EFRhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 13:37:00 -0400
Received: from pan.madism.org ([88.191.52.104]:46970 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab1EFRg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:36:59 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C371251ACA;
	Fri,  6 May 2011 19:36:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BCFDC2B0E2; Fri,  6 May 2011 19:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vei4b20we.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172994>

On Fri, May 06, 2011 at 10:29:21AM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > 	$ git status
> > 	# in the middle of a git rebase -i of master (detached head)
> > ...
> > 	#       qkv/A/
> > 	no changes added to commit (use "git add" and/or "git commit -a")
> >
> > If we have an ongoing operation then:
> > - if we are on a branch it displays:
> >   # On branch $branch ($what_is_ongoing)
> >   #   ($ongoing_hint)
> > - if we are on a detached head it displays:
> >   # $what_is_ongoing (detached head)
> >   #   ($ongoing_hint)
>=20
> I'll reindent the above to align these example output the earlier out=
put sample
> when I apply them.

Sure.

> > +	const char * const rebase_advice =3D
> > +		_("use \"git rebase --abort\" to abort current rebase or proceed=
");
> > +	const char * const am_advice =3D
> > +		_("use \"git am --abort\" to abort current mailbox apply or proc=
eed");
>=20
> If the reader does not even know that the "--abort" option is used to
> abort, " or proceed" needs to be followed by "by doing $this", if it =
wants
> to have any practical value.  I would suggest dropping it.
>=20
> > +	const char * const merge_advice =3D
> > +		_("use \"git reset --hard\" to abort, or resolve conflicts and c=
ommit");
> This codepath being in wt-status.c, I wonder if any of these advices =
could
> trigger to appear in the log message editor when the user tries to ru=
n
> "git commit".  If so, I suspect any of the above is too late to help =
the
> user, no?

Well I'm not very happy with the advices, feel free to reword them in a=
 better
way.

> Also, should we make these conditional upon advice.status or somethin=
g?
they are
                          vvvvvvvvvvvvvvvvvvv
    +       if (advice && advice_status_hints) {
    +               status_printf(s, color(WT_STATUS_HEADER, s), "");
    +               status_printf_more(s, status_nobranch, "  (%s)\n", =
advice);
    +       }


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
