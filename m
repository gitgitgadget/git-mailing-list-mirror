From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] git-send-email.perl: Add angle brackets to In-Reply-To if necessary
Date: Sun, 12 Aug 2007 14:49:01 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070812124901.GA9662@informatik.uni-freiburg.de>
References: <85lkchqixk.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 14:50:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKCtQ-0006Gm-SH
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 14:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbXHLMtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 08:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934785AbXHLMtM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 08:49:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46629 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934581AbXHLMtE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 08:49:04 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IKCsR-0001eN-1I; Sun, 12 Aug 2007 14:49:03 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7CCn1eU009998;
	Sun, 12 Aug 2007 14:49:01 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7CCn1hX009997;
	Sun, 12 Aug 2007 14:49:01 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85lkchqixk.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55679>

Hello David,

> I have not actually tested this, but from staring at it intensively,
> it should be correct.  One of the things that bit me when I tried
> using this program.
>=20
> ...
> -	$initial_reply_to =3D~ s/(^\s+|\s+$)//g;
> +	$initial_reply_to =3D~ s/^\s+<?/</;
> +	$initial_reply_to =3D~ s/>?\s+$/>/;
> ...

some rules from rfc822:

	optional-field	=3D ... / "In-Reply-To:"  *(phrase / msg-id) / ...
	msg-id		=3D "<" addr-spec ">"
	phrase		=3D 1*word
	word		=3D atom / quoted-string
	atom		=3D 1*<any CHAR except specials, SPACE and CTLs>
	quoted-string	=3D <"> *(qtext/quoted-pair) <">
	...

With 1*... meaning "one or more" and *... meaning "zero or more".

That is not all fields of In-Reply-To: must be enclosed in '<', '>'.  I
didn't know that before looking it up and I expect it's not very common=
=2E
Even if no "phrase" is used there can be multiple msg-id's and then you=
r
patch doesn't do the right thing.

But anyhow I think it's bearable to include these angle brackets in the
cut-and-paste process.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+electron+mass%3D
