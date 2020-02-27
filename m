Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0963EC11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB7424688
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XT2XGVnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgB0P67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:58:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:56393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgB0P66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582819134;
        bh=+68Z6g9Hm9iMeVYXapPlSAVp94qHc43CyiwbjtBWyNg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XT2XGVnlQRgBJ/Wsecnh9C2VNmaB4tg5iay1tJfsVjhoOapiJrnKyATzZhXsORtW7
         8md04ehOcY4kcE01GPP+gr7YkhHW8jitAQAWnHS5O6rVPw4doOJmiVdV9GMgEu7BGo
         tirn0ReOjEM/ptRN/hEmWBK8ci0MdMTn6OCHPLmA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.114.107.104]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1jlcNX0OxJ-00qEnX; Thu, 27
 Feb 2020 16:58:54 +0100
Date:   Thu, 27 Feb 2020 16:58:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in
 the Git directory
In-Reply-To: <CAPig+cR9wwcbnuFmVuoDr6OSq29ZCSt6Kr5KtG3HPsDgM5mGSA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002271658250.46@tvgsbejvaqbjf.bet>
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com> <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com> <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
 <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com> <nycvar.QRO.7.76.6.2002241942120.46@tvgsbejvaqbjf.bet> <CAPig+cR9wwcbnuFmVuoDr6OSq29ZCSt6Kr5KtG3HPsDgM5mGSA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iJsof8BwnGi+qHHFqFFMCVsQinwBz3KOTLtkh/n+dpQQIQzNhnk
 TdiXCl44p6U+PDpS5vgdwz+f22fkuYxQ3VU/lGaaMAr8OLK3uacsaiameHa60HR9mEVdcKx
 LCCdie1SbaHBi2YC52hWGyFp/8k4n7vEs9ANTBRNwV8pOnf2H1/Xshf3JEIVyMg7A9HxwtJ
 Im4BHwY2uOVKUuaX+BdhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YyG+fjQfVYk=:B1gXiBJyLktkkLV+3vRSIm
 GWP7YlOS+v9lgsSnYJUZx2LPDIgmglXlo09x3PLpA407TJccHb/i0Hrh6HACVibW6t8Wyr561
 AqILvMuPp5RMFW63mINvt5395sMJQK6Y4Wg4uFUDbXgeD1KNSspNxZq8JRqE8mnyYlKBIZJLK
 xFJQe+f2SNx33E98ygUiPEFWsrJxJ3DuPm8TFKSO2FyX0Ayr/9g58SceYaF7ZkKjj+YaOQd7R
 03YJU3SEbyYz2V+XwijxpNaj4bEvyup/FrunrfJnIp7ZEWQ7WZhw3fgBbw6vrlpVTMrAUqXTk
 Q67tZohLFI3ERQqTiBQzOxiiigmyFcdJ3teXM7ZzoGZXuyHwYw8Y0iTh04zKOaa0buoD3eD2v
 26M10lU2X2hFETkUI0wzBWmp5SogaiHc34Lzj9F4RyWSjv+UpjAMd8KstkJMLIpEYUBEjQoHa
 xGnon2UMd5SRyR2WEqdBEHAksZbPkfAGfG8XN7iPJl3VRIIuljW2DgnR4+G2SBF63hdnA1HN8
 GZVSnOITgYFs1dybbk4vTOYrS5OkRoqpwrbcJGlyYy43dYVBUixifew1GfR+jLb3P9rAy+p6A
 x+EnEyLnnmM9VnIzgx06EWh19z0o45eCtx9q6EAksqMZkrugA5+k8hiQOgKsphmSYLSBPy6zq
 yR2QwzdPzUgMlO13EDocNttPwRYsoBH84Uff/pRjIO1d+qCihW6nVfIjsEaDehUSf1o5gX2Gw
 BcuqIEoXjXMM5zLm9euhPWpk6UcvcuE642w5mWqrhsCFeYjFt0FtR6aPQsHJ0PMb9WaaWkeHY
 S67+NF2uI9CojW0XmeOs38U6yAQr0Od2/wEx9XfKq0z0uPPJWEN6e7u6XIabFyzwvgXzVn/Dh
 TDYOMzFDHo/p7HYsoC3cD2YGalTgw/02e7vd/uBpYKBStzeDrciLJqqnJmuIDdEHZCS8jse7c
 DSyzuDvUKor6sKeZKjuo0+MGYR7DVKh2YUlg/6dELrImHRBaIsQlBuwI7uZpvTPki4g96FfhG
 8uBIoEZIQjtkWD5Hb5a0NP50mREKaYRO064WATQANxzBYYAoeu18IRqLvMDdHwvJhECSpwgZq
 OD/T5CSXm2NuBN7YfjDgtZZu2A8vwHZNwLnULyf/uAwEwraJk6u/F2FduUci+cp+fxqOrLUoi
 +xOVM7kQXgHFvYLXq6GkDcWedZ+uf2/MroVTwkR3W+xVP2jKh1zQUpD2gohdC0JnaSG5MOdK1
 jDh2F3JvyWDyTV8tI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 24 Feb 2020, Eric Sunshine wrote:

> On Mon, Feb 24, 2020 at 1:58 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > > On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> > > > This change makes the code unnecessarily confusing and effectively
> > > > turns the final line into dead code. I would much rather see the t=
hree
> > > > cases spelled out explicitly, perhaps like this:
> > > >
> > > >     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .=
git dir */
> > > >         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in work=
tree */
> > > >             strbuf_strip_suffix(&worktree_path, "/."); /* in bare =
repo */
> >
> > I would be really cautious about that.
> >
> > To me, the originally proposed change says: strip `/.`, if any. Then,
> > strip `/.git`, and if successful, strip another `/.`, if any.
>
> That's not at all what the original said, which is reproduced here:
>
>     if (!strbuf_strip_suffix(&worktree_path, "/.git"))
>         strbuf_strip_suffix(&worktree_path, "/.");
>
> It says "try stripping '/.git'; if that fails, try stripping '/.'".
> That is, it recognizes and handles two distinct cases: (1) the path to
> the .git directory of a non-bare repository, which always ends with
> "/.git", and (2) the path to a bare git repository, which always ends
> with "/.". So, the original code wasn't doing any sort of incremental
> stripping of suffixes; it was just handling two known distinct cases.
>
> Perhaps you missed the '!' in the conditional?

I totally did. Sorry!

Ciao,
Dscho
