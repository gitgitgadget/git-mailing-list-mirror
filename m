Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434832018E
	for <e@80x24.org>; Wed, 22 Jun 2016 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbcFVQPL (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:15:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:60215 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbcFVQPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:15:10 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MdFwl-1axwvu088p-00ITYp; Wed, 22 Jun 2016 18:14:45
 +0200
Date:	Wed, 22 Jun 2016 18:14:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
In-Reply-To: <xmqqeg7pns0a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606221811300.10382@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de> <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com> <alpine.DEB.2.20.1606200814510.22630@virtualbox>
 <xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606210906190.22630@virtualbox> <xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606220849480.10382@virtualbox> <xmqqeg7pns0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MMmM71J3xELV/zwqRY4l72WCNuwUdw7jAalRKMcYXUSZvIlAjDi
 oJt3np3KRYx8NynGCE+sfCoOhLOwJ0pqb/IIAWt1JMECoBhYEBg3RaFK4USn8fs2epdruDq
 82HeDfwTp9wgXXhoO30OEQ8TGyjDUDlQucPd8nZ1DCQcc9LFgrebkzSbjOgEVmL03jHfu3x
 eKXBPeCh3AjMegeiDYMrw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zDlXQ3iW3H0=:8WOtavBvGeHGvrQpBFd0zk
 RsW2XIhAhp401KphZhBr6hg6qvzByPkAy35sBcPW00NZiBH4QEdgY8QPVpQi+wyKCXgbqwzgL
 OckyVi8FBF/wTfrUdWGZy29X/fbWqljXvDl1O/bGjkWLDcxLXU9DerBPSOSkkhE/zaE+TACc8
 bpi8wNm4M+s8a4OaVnc4BX328BFA5QO9IB7/46ucnHaRk/JLFhJdXeP1f1x9VeyMByVrqa2vV
 KeiQNjCPKhtiu3MTCweVHyet3Kgfs6onUKguL4QwGiyvi5oNKFQqRF65AWB6Z2ospvq04Y+Wg
 iIXeK4Z04v3dlhQ8EnB66aGT8TDrMF+bXi49fWU4/Qcezk9j0Bx2tzAjiYZ6Cp38YjPhLBRhk
 V1HU29T1MMn2GCmQt8BY0SDoww5ENq1XFVFfxuHKyxxm6G/IiIMNN03SwSPwKrJv0sWGRabOu
 YMQ6VpkKSd7Wq7TsmsPTrguCgx7ZbSSZC+dkXvlGM4BuDPRZ2zY5zXvoELw+WXK6Lnw+mBZho
 mHk3re+udjBB1F2+q27Zt/YgYoB9NmShjj9Dde5KfCAQY3qW/AkMIVokr4FXEm6ZN5sELjAeO
 HBnhQIQQ3O/W+hhALIUIDvLRAVzxHxlNjjcDo4nJ709u6U9gsZKag5/1HbxqVEo2yXvlZBjrt
 Q20IUf8JRsnJu3lsFFFKiX0afpNvZ5wTzdkvuNGJryhQ43/5zFeIePZi3KRWen988Q8/fFb12
 b0T0v8+T5zBBIspprd1J3gl99zCpOcgBj5ScMp/g0Rf+lMkdeskUcmhqqRiweo/b/yB/uHfRo
 Ve7oSMA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 22 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But there's a rub... If you specify --color *explicitly*, use_color is set
> > to GIT_COLOR_ALWAYS and the file indeed contains ANSI sequences (i.e. my
> > analysis above left out the command-line part).
> 
> Heh, the command-line is the _ONLY_ thing I raised, as we knew
> ui.color is not an issue in this codepath, in $gmane/297757.
> 
> Going back to that and reading again, I suggested to check with
> GIT_COLOR_AUTO (i.e. if it is left to "auto", disable it) because I
> think the former is a much more future-proof way (imagine that we
> may add --color=<some new setting> in the future) than checking with
> GIT_COLOR_ALWAYS (i.e. if it is not explicitly set to "always",
> disable it).

Well, if I change `rev.diffopt.use_color != GIT_COLOR_ALWAYS` to
`rev.diffopt.use_color == GIT_COLOR_AUTO`, then the files will contain
ugly ANSI color sequences if I run `git format-patch -o . -3`.

The reason is, as I tried to explain, that the use_color field is *not*
initialized to GIT_COLOR_AUTO (which is equivalent to 2), but to -1.

So the difference between your version and mine is that mine works ;-)

Ciao,
Dscho
