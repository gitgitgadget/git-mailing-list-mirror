From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] completion: verify-tag is not plumbing
Date: Mon, 1 Feb 2016 10:44:11 +0000
Message-ID: <20160201104411.GD29880@serenity.lan>
References: <60839686604d60632e1c80ef4fdd51eacb6b9290.1454244258.git.john@keeping.me.uk>
 <20160131143759.Horde.Ylcq6ydVoLduXCzBPzVjZMh@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 11:44:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQBy6-0005Re-FC
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 11:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbcBAKoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 05:44:22 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:57551 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbcBAKoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 05:44:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 68DE1CDA614;
	Mon,  1 Feb 2016 10:44:20 +0000 (GMT)
X-Quarantine-ID: <YmH8UyYtGmWr>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YmH8UyYtGmWr; Mon,  1 Feb 2016 10:44:19 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 70EC2CDA600;
	Mon,  1 Feb 2016 10:44:13 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160131143759.Horde.Ylcq6ydVoLduXCzBPzVjZMh@webmail.informatik.kit.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285195>

On Sun, Jan 31, 2016 at 02:37:59PM +0100, SZEDER G=E1bor wrote:
>=20
> Quoting John Keeping <john@keeping.me.uk>:
>=20
> > According to command-list.txt, verify-tag is an ancillary interroga=
tor,
> > which means that it should be completed by "git verify-<TAB>" in th=
e
> > same way as verify-commit.
> >
> > Remove it from the list of plumbing commands so that it is treated =
as
> > porcelain and completed.
>=20
> I'm not sure.  There are commands among the ancillary interrogators
> that are basically porcelains (e.g. blame), while some are more like
> plumbing (e.g. rerere, rev-parse).  In general the completion script
> supports the former but not the latter commands.
>=20
> Now, the real porcelain-ish way to verify a tag is via 'git tag
> -v|--verify', and according to a925c6f165a3 (bash: Classify more
> commends out of completion., 2007-02-04), the commit removing
> verify-tag from the completed commands, verify-tag was kept around fo=
r
> backwards compatibility reasons.  OTOH verify-commit was introduced i=
n
> d07b00b7f31d (verify-commit: scriptable commit signature verification=
,
> 2014-06-23), and as the subject line states it was intended more as a
> plumbing command.
>=20
> So I think we should keep excluding verify-tag from the list of
> porcelain commands in the completion script, and it was an oversight
> not to exclude verify-commit as well when it was introduced.

I can accept that argument about verify-commit and verify-tag, but
listing verify-tag as plumbing is incorrect according to
command-list.txt (and thus git(1)).  If we're going to classify
commands, shouldn't we be consistent in how we do so?

> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  contrib/completion/git-completion.bash | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > index 51f5223..250788a 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -728,7 +728,6 @@ __git_list_porcelain_commands ()
> >  		write-tree)       : plumbing;;
> >  		var)              : infrequent;;
> >  		verify-pack)      : infrequent;;
> > -		verify-tag)       : plumbing;;
> >  		*) echo $i;;
> >  		esac
> >  	done
> > --
> > 2.7.0
