From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-describe: Die early if there are no possible
 descriptions
Date: Wed, 5 Aug 2009 17:42:05 +0200
Message-ID: <20090805154205.GA17792@atjola.homenet>
References: <20090805141740.GA16846@atjola.homenet>
 <20090805153411.GG1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYidI-00033i-B5
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbZHEPmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbZHEPmO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:42:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:46194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755797AbZHEPmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:42:14 -0400
Received: (qmail invoked by alias); 05 Aug 2009 15:42:13 -0000
Received: from i59F55BB1.versanet.de (EHLO atjola.homenet) [89.245.91.177]
  by mail.gmx.net (mp021) with SMTP; 05 Aug 2009 17:42:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18nPEtd+JcnWJXv131yhzIN6vfbBhnYoBSDWlqQ6t
	Yu1kqhhl2uqt07
Content-Disposition: inline
In-Reply-To: <20090805153411.GG1033@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124917>

On 2009.08.05 08:34:12 -0700, Shawn O. Pearce wrote:
> Bj?rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > If we found no refs that may be used for git-describe with the curr=
ent
> > options, then die early instead of pointlessly walking the whole hi=
story.
> >=20
> > Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
> > ---
> > In git.git with all the tags dropped, this makes "git describe" go =
down
> > from 0.244 to 0.003 seconds for me. This is especially noticeable w=
ith
> > "git submodule" which calls describe with increasing levels of allo=
wed
> > refs to be matched. Without tags, this means that it walks the whol=
e
> > history in the submodule twice (first annotated, then plain tags), =
just
> > to find out that it can't describe the thing anyway.
> >=20
> > I'm not particularly sure about found_names actually counting the f=
ound
> > names, it was just out of the thought that maybe the walking code c=
ould
> > make use of it, but I didn't actually check that and ran out of tim=
e, so
> > I'm sending this version, hoping that it doesn't suck too much.
>=20
> This seems reasonable to me.  Really you don't need found_names
> to be a counter, but could just always set it to 1 every time the
> add_to_known_names function is called.  All you care about is that
> add_to_known_names was invoked at least once.

OK.

> Also, I really think that first paragraph after the --- should
> have been part of the commit message.  The message above doesn't
> justify the change, even if it is fairly trivial, without that
> additional explanation.

Oh, d'oh, that's even what I intended to do (the original commit messag=
e
was written in even more of a hurry than the mail itself), but messed
up. Will re-send (also with found_names turned boolean)

Thanks,
Bj=F6rn
