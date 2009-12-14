From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 21:55:17 +0100
Message-ID: <20091214205517.GA1317@atjola.homenet>
References: <20091214183337.GA25462@atjola.homenet>
 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
 <776A5AB0-E6BC-4230-800E-BE1B7A6B09BF@silentcow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jason King <jk@silentcow.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKI2z-0008KQ-AO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbZLNVAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 16:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbZLNVAO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:00:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:52038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932617AbZLNVAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:00:12 -0500
Received: (qmail invoked by alias); 14 Dec 2009 20:55:22 -0000
Received: from i59F56AFC.versanet.de (EHLO atjola.homenet) [89.245.106.252]
  by mail.gmx.net (mp068) with SMTP; 14 Dec 2009 21:55:22 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+8pW0P4Ua8Vc6AfAZILw1z3hkyOY6YItP00axnsT
	ZqK/q3txW/OM4t
Content-Disposition: inline
In-Reply-To: <776A5AB0-E6BC-4230-800E-BE1B7A6B09BF@silentcow.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2009.12.14 12:38:30 -0800, Jason King wrote:
> On Dec 14, 2009, at 12:27 PM, Junio C Hamano wrote:
>=20
> >Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> >
> >>Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF
> >>line-endings"
> >>seems to be responsible.
> >
> >Yes, that commit is not only responsible but was deliberate.  For
> >a better
> >backstory, see:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/124718/focus=
=3D124721
> >
> >You'd notice that I was one of the people who didn't want to have th=
is
> >change, so you don't need to convince _me_ that this was not a
> >change to
> >keep everybody happy, but you'd need to try a better job than I
> >did back
> >then to convince people who thought that "am" should directly work o=
n
> >"Thunderbird saved mails" that what they want was a bad idea X-<.
>=20
> I dunno Junio, the back story doesn't really seem like a convincing
> argument for totally breaking am's handling of real CRLFs.  Right
> now, it seems to be a very bad thing that git can create a patch
> that it can't apply.  The default am should always be able to apply
> whatever format-patch has generated.
>=20
> If it's desirable to have am translate CRLFs to LFs, then why not
> provide this as an option to am so as not to break merging of real
> CRLF patches?  Eg.:
>=20
>   git am --convert-crlf

Hm, currently it checks everyline. I didn't really think this through,
but wouldn't it makes sense to have a per-mail flag, that checks just
the first line, and if that has CRLF, then enable the dropping (unless
--keep-cr is given), otherwise, keep things verbatim. That should (I
think) make things work with non-messed up patches regardless of the
files being patch, as well as with messed up patches as long as they
don't try to patch files with CRLF line-endings.

I can't seem to come up with a clean patch though (btw, is the comment
for split_one that says that buf may contain a partial line still
true?), but maybe I'll find some time to try again later this week
(don't count on it though, I'm pretty stressed...)

Bj=F6rn
