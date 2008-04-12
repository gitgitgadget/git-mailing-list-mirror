From: Santiago Gala <sgala@hisitech.com>
Subject: Re: [PATCH] make --color-words separate word on ispunct
Date: Sat, 12 Apr 2008 19:50:21 +0200
Organization: High Sierra Technology, SLU
Message-ID: <1208022621.15135.19.camel@marlow>
References: <1207996421-29651-1-git-send-email-sgala@apache.org>
	 <alpine.DEB.1.00.0804121621560.16366@eeepc-johanness>
	 <46dff0320804120832x733000e8md813e3f8525b889a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 19:51:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkjsg-0007WI-Je
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 19:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYDLRu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 13:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbYDLRu3
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 13:50:29 -0400
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233]:3565
	"EHLO mail.hisitech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754862AbYDLRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 13:50:28 -0400
Received: by mail.hisitech.com (Postfix, from userid 65534)
	id C50B315CE7D; Sat, 12 Apr 2008 19:50:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	webserver2.intranet.hisitech.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.9
Received: from [172.27.70.188] (unknown [172.27.70.188])
	by mail.hisitech.com (Postfix) with ESMTP id 15B1215CC81;
	Sat, 12 Apr 2008 19:50:21 +0200 (CEST)
In-Reply-To: <46dff0320804120832x733000e8md813e3f8525b889a@mail.gmail.com>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79371>

El s=C3=A1b, 12-04-2008 a las 23:32 +0800, Ping Yin escribi=C3=B3:
> On Sat, Apr 12, 2008 at 11:23 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> >
> >  On Sat, 12 Apr 2008, sgala@hisitech.com wrote:
> >
> >  > Note that this may actually be harmful when trying to spot punct=
uation
> >  > changes, but for this use case I don't think color-words is help=
ing now
> >  > either.
> >
> >  I do not know how commonly supported ispunct(), therefore I do not=
 like
> >  the patch too much.
> >

I didn't like the patch that much either, but at least it was a quick
proof of concept. :)

re: support of ispunct, ispunct checks, according to the linux man page=
,
for:

any printable character which is not a  space  or  an alphanumeric
character.

so isspace(c) || ispunct(c) -> isprint(c) && !isalnum(c)

> >  Besides, since long ago I want to make the list of boundary charac=
ters
> >  configurable, preferably as a tr(1) style list, but I have not com=
e around
> >  to do that yet.
> >

That would be cool, it was my first thought until I saw this "easy try"=
=2E
But I'm not a C programmer, I was just trying to spot the correctness o=
f
a few name additions in lines of comma separated ids of 100 names or
something like that. The patch I sent is not perfect, but achieved 80%
of what I wanted with 10 minutes of effort (including build, test and
sending the patch).

On the other hand, while --color-words is very useful for text or
detecting typos, with big text changes it sometimes gives worse results
than --color, see for instance, on the git repo, the second hunk of

git diff --stat -p --color-words
f59774add488a6c5fb440a4aaa7255f594b1027d^ -- builtin-fetch.c

(and just --color) Not sure how to fix it, or, ideally, having some
automated way to switch between line-oriented coloring and word-oriente=
d
coloring depending of density of changes.

>=20
> It is so good an idea. I look forward to it. Futher, should
> --color-words support
> multibyte characters where every character is a boundary?
>=20

This would require more changes, to the
iswspace/iswpunct/iswprint/iswalnum functions, with associated change
from chars to wide chars.

Regards
Santiago
