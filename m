From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Tue, 14 Feb 2012 07:28:48 +0100
Message-ID: <20120214072848.724c1725@mkiedrowicz.ivo.pl>
References: <20120210213209.GA7582@sigill.intra.peff.net>
	<1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
	<20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 07:28:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxBsn-0004ex-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 07:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab2BNG2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 01:28:53 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41803 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab2BNG2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 01:28:52 -0500
Received: by eekc14 with SMTP id c14so2130780eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 22:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=xEquzhzXvIlotMREuif3e1SFf2qNxaUYPBIAXr7C68M=;
        b=gCfQmxINlJEFY7RJ935Ho1BpBdfATxMCJAkKRCJuCjRp16L9kMBt1TZm7uAHXxP2RC
         prvFAay9gHboBkSeJPXTqGJR3yYDE0bv9di26H87YH9yN5E3n8dQCTKGaPY4pAoH7y32
         rKeZd3nfRAe7aDSo0K2q3e1UG5zqv6DkBPeMU=
Received: by 10.213.3.147 with SMTP id 19mr184675ebn.122.1329200931536;
        Mon, 13 Feb 2012 22:28:51 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id a58sm69722531eeb.8.2012.02.13.22.28.50
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 22:28:51 -0800 (PST)
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190702>

Jeff King <peff@peff.net> wrote:

> On Fri, Feb 10, 2012 at 10:47:13PM +0100, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> >  contrib/diff-highlight/diff-highlight |   96
> > ++++++++++++++++++++++----------- 1 files changed, 65
> > insertions(+), 31 deletions(-)
>=20
> Thanks for sending. I looked at a whole bunch of patches, and I was
> pleasantly surprised to find how infrequently we hit false positives
> in practice.=20

Yeah, I completely agree with that.

> In fact, the only things that looked worse with your
> patch were places where your patch happened to turn on highlighting
> for lines where the existing heuristics already were a little ugly
> (i.e., the problem was not your patch, but that the existing
> heuristic is sometimes non-optimal).
>=20
> I ended up pulling your changes out into a few distinct commits. That
> made it easier for me to review and understand what was going on (and
> hopefully ditto for other reviewers, or people who end up bisecting o=
r
> reading the log later). I'll post that series in a moment.

Very nicely done.

>=20
> > After looking at outputs I noticed that it can also ignore lines
> > with prefixes/suffixes that consist only of punctuation (asterisk,
> > semicolon, dot, etc), because otherwise whole line is highlighted
> > except for terminating punctuation.
>=20
> I missed this note when I applied the patch and started looking at th=
e
> outputs, and ended up having a similar thought. However, I don't know
> that it buys much in practice, and it's nice to be fairly agnostic
> about content. I did leave that open to easy tweaking in my series,
> though.
>=20
>   [1/5]: diff-highlight: make perl strict and warnings fatal
>   [2/5]: diff-highlight: don't highlight whole lines
>   [3/5]: diff-highlight: refactor to prepare for multi-line hunks
>   [4/5]: diff-highlight: match multi-line hunks
>   [5/5]: diff-highlight: document some non-optimal cases
>=20
> -Peff
