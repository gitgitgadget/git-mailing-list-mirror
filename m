From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 14:23:08 +0200
Message-ID: <20130811122308.GH25779@paksenarrion.iveqy.com>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
 <20130810232026.GF25779@paksenarrion.iveqy.com>
 <CAFw3YtSp4QLXHkycRmmQNYkvoR=2_qC9YYV1mFV3PiwfWHspzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git <git@vger.kernel.org>
To: Kristian Freed <kristian.freed@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 14:20:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Ucq-00086M-3q
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 14:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab3HKMTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 08:19:36 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:63281 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab3HKMTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 08:19:35 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so4067788lab.19
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=80FKpJg5e58gxKXQAsha+ebnFpMTiCOkOQLxhCRuGw4=;
        b=cJJhsO5RYQ1BIsuYKLOp6oUwi2dRKwqiO6ZidnPqp/q/67CGTiE89RiSeArJs6bOKO
         4Wz1Oi9WWT1o6I347r3XCQJQ1QNRBToi6UE5OnlVDfuehqh+hqEULkwTIG3LqLXjD2Dq
         L1MGd2rONYtchK5/Zzu6ij1BrypH4yrzwCEfJqtFxsFxTs6EtKGySfgS2dZIe7wVT2U6
         EnyvoHYsVH681eQFl45WyuVJloi9r0OyKAu6B6sKP/QDtAjAIX6XDxmbkA8zaWj8JMhQ
         lgHmDGVlk0RB4wyuQMve7zrOCz77Ctu2FMzH2fKMMtOBCRGJQYv4RosNNN65nfr+z0jP
         KulA==
X-Received: by 10.112.34.178 with SMTP id a18mr3485723lbj.67.1376223570571;
        Sun, 11 Aug 2013 05:19:30 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w5sm9538173lbw.3.2013.08.11.05.19.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 05:19:29 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V8Ufs-0003oj-Dt; Sun, 11 Aug 2013 14:23:08 +0200
Content-Disposition: inline
In-Reply-To: <CAFw3YtSp4QLXHkycRmmQNYkvoR=2_qC9YYV1mFV3PiwfWHspzQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232135>

On Sun, Aug 11, 2013 at 12:13:18PM +0100, Kristian Freed wrote:
> On Sun, Aug 11, 2013 at 12:20 AM, Fredrik Gustafsson <iveqy@iveqy.com=
> wrote:
> > I don't understand, why is it better to find between which tags a e=
rror
> > was found and not in what commit. It's much easier to find a bug
> > introduced in a commit than in a tag/release. It sounds like you're
> > doing the bug hunting harder. Could you explain this further?
>=20
> For better or worse, the current state includes a lot of noisy "fixin=
g
> tests" type commits which I
> would like to automatically skip over when hunting bugs. This is not
> great and is being addressed,
> but I am trying to make the most of the historical data we have today
> - which does contain tags
> for all builds that passed automated testing etc but does not have
> only good commits on the related
> branch.

Thank you, that make sense (even if it's really sad to have such
history).

>=20
> > My suggestion if you want to do this, is to have your buildtool to
> > checkout a special branch (let's call it tag_branch) do a git reset
> > to get the worktree from the newly tagged commit and commit on that
> > branch once for each tag it's creating, when it creates the tag.
>=20
> I can see how this would work, but only for future builds. I would
> need something like it but loop
> over all existing tags as this is a problem with historical data.
> Could you please be more specific
> as to the steps required to automatically form a commit that
> represents the change between
> two commits (i.e. tags)?
>=20

Create an orphan branch:
git checkout --orphan tag_branch

Now for every tag, t:
git checkout t
git reset --soft tag_branch
git add .
git commit -m "t"


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
