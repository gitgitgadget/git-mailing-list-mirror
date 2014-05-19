From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git related v0.3
Date: Mon, 19 May 2014 16:27:01 -0500
Message-ID: <537a7725558c1_afee5d30095@nysa.notmuch>
References: <537952234b691_10da88d308d8@nysa.notmuch>
 <CACBZZX6gOeTrLJwL-Zp5hEEbWCipioPgNKt7Tc41ixcQLQshiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 23:38:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmVGO-0002Fq-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 23:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaESViM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 17:38:12 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:44473 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaESViL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2014 17:38:11 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so6948943oag.23
        for <git@vger.kernel.org>; Mon, 19 May 2014 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=JbP0tkmgtMEKtNBrp/5Qbf4/OtQm3wmKRVc2Z8RILH0=;
        b=Q3UTm8ln1pypWtXrF9Z1GGLv65ZrzcrG8j2tIG4Pezm6iIX3LN6+NpkSjoEeXrn+0F
         MEmoMVb0c4IESBYmwQbFl2ej5mIu8YAv3AWjT0CbZZI/7GMDlwMGFZp4OD+SsRmjmi1Z
         hh18G0RBf2UWZy6CoPlpXmEuytUSTPsdTQg85t6jnrLJm/wr35XonwrFURpRqUKoaawX
         Nrko5rB3FHWOe7qoANca6rQIz1g3iO0nsCW6wFIBMB3yipIIO+9wlNMWwOKXuD7V94rS
         xVLoO/4Jrs2LYZgu5oElq9Fyo/6cOdmvRF8eRoyuYU3/uapDpL7HzTezzWJB9JRAuBOd
         5HBA==
X-Received: by 10.182.60.65 with SMTP id f1mr6162917obr.78.1400535490575;
        Mon, 19 May 2014 14:38:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm41343064oeb.3.2014.05.19.14.38.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 14:38:09 -0700 (PDT)
In-Reply-To: <CACBZZX6gOeTrLJwL-Zp5hEEbWCipioPgNKt7Tc41ixcQLQshiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249627>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, May 19, 2014 at 2:36 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > This tool finds people that might be interested in a patch, by goin=
g
> > back through the history for each single hunk modified, and finding
> > people that reviewed, acknowledged, signed, or authored the code th=
e
> > patch is modifying.
> >
> > It does this by running `git blame` incrementally on each hunk, and
> > finding the relevant commit message. After gathering all the releva=
nt
> > people, it groups them to show what exactly was their role when the
> > participated in the development of the relevant commit, and on how =
many
> > relevant commits they participated. They are only displayed if they=
 pass
> > a minimum threshold of participation.
> >
> > It is similar the the `git contacts` tool in the contrib area, whic=
h is a
> > rewrite of this tool, except that `git contacts` does the absolute =
minimum;
> > `git related` is way superior in every way.
>=20
> The general heuristic I use, which I've found to be much better than
> git-blame is:
>=20
>  1. Find substrings of code I'm directly removing/altering, and
> functions I'm removing/altering
>  2. Do git log --reverse -p -S'<substr>' (maybe with -- file) for a
> list of substrings

Yes, that is true, but it cannot be automated. When I'm lazy I just do
`git related -cfull a..b`, which will show me the full patches so I can
decide if they are relevant or not.

One possibility would be to add an additional --keywords option to `git
related`. Another would be to add an --interactive where each supposedl=
y
relevant patch is shown for the user to decide if it truly is.

--=20
=46elipe Contreras