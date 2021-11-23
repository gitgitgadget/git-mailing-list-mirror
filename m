Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDFC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhKWPMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:12:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:40427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhKWPMo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637680171;
        bh=XTKiEm7sZ67l+AL8FiYoxEoRb5RoF4eC/ZuhsWkJys4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A3g8/D/x1H9BhWATOQRKzgUaca2sAMo/sOMWGrqb03zGYtjk6hW8NY4mLcpSj/UHN
         sm9mlTJqy4ro+bg0xIx9gH34h9UdZ5ZqPEMb0fuR4Fi5abNCrXLsf/F/chAHxXSPYQ
         68mjbELBCj48yqIvHxgNT5louKa7b2sWmqBo2qcM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1nB6Zp2SXO-00WTVL; Tue, 23
 Nov 2021 16:09:31 +0100
Date:   Tue, 23 Nov 2021 16:09:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 09/15] diff --color-moved: call comparison function
 directly
In-Reply-To: <c3e5dce1910b3d640757e0845d646c3b040a8e28.1637056179.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231605520.63@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com> <c3e5dce1910b3d640757e0845d646c3b040a8e28.1637056179.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ufa8GFG+L5j4TYQnx4pOjXNxFA9MwL/DIELez6ufLqTV6QxbqXC
 +BY7Jxg4rwYX29EVk4G4c5BshOLiOgWJLXX4OJjA2yZT1LLR0l/GqaMMYN3ySB1Ypcvy3IQ
 cTMt5nPXIGvWsIegjMG41mKUScHWTOEdakx8BRaWrA/9rTq3FvIiEkPiernzWsMjsDWpj4y
 pVlfRRhnt3M7+Q4g3pWaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wN9wJPW/x64=:jKUZ+xzWs1Zo3KHXB2PuJs
 1fl8H4x95KIYw9sGs7tCBLsCH+mXdZ6X9zzzP87Jziv3uKr9D910dkwB/dsI26kgBsfLwhw/Z
 n5/NjSWacUVOy/i7JH3IkZqP7Tg5OhacxkTE+3GiuxosVxFrPtCjehul0zeYLStjGjnmrWqCK
 oc+vMYuWq5C1W6jap93way2Ftt51petnkRjBE+WgpD/MWnFfTblqj2emfMeL7fnAX0LvMoYUM
 M/z/OPXUWpLZqHNX88UEWfHHGLr98bmg/SsmQcDpO1z9U/hNdowwm/eWgW6HAH5X1qAEPWG2D
 zL6VZa3DC+xdBcgtpIN5KWsmDWn5T3xGuF9sIoGJru0uobEenZYOxEwR3CnTr9rze/h0x2tRl
 csnCgFi3F+A3vtZIS439sR7FElR9eqUpmrMlvUH3QitWWxDVWe42Z8xUdLkeWr0XDzRohy8ul
 GgoXNjNoqC/Q6eFZQXK5112Nd6wH84770VawVjoPRY/7qQNLtSLjhh37aKg3+fACuhH3McLg0
 Qc8WAHSngcp7CiPv/AXN/u9tL6Dx8UEiQgMBVo1ELGvrjthOHHLN7TwpwA6hEqvf/9+5fuXMB
 uJJGiDyRb3kfxluth9ZxGWCuazWcbNuoqOM5jbOXLQXcDYPdBusnYEWeI/uQaMhcvpXM5+fgu
 JvPaCw0phoH0bKQapopHBz4DFMf1X+MVX52U6GkbKlm46JDECSaTjakd0NiQOIK1b3iwp8tE2
 Y4MZ+n8TlidgiNX5V0VQUP0SmVmXxxN42NoxVOmg/I4QTkIlOtBbpfHdPPimF9iuaZTl3gbhy
 F3raJC1uDFENwBlaEtssfvrzesj2DK5VQUSYCfiut1+EFhBRujddAu/8ZN1097SUzSjabsYmY
 S+ZqflmKs/fLIigfrxvmJGBdlYXsP+DU0YQ2uM/egE8qQXIqN58+0KK3d5WJohtJ5MfDV87gw
 cvtxB9QwPJNV6l3QW/jPokbRLGPsjeGMiXtCcYfpTv6e1IDLJ/oOJU+TiwylhjGO3eJ7hX2Hs
 yormLI5ESB/3dFt2Ujnr3beVUNF0QBFuGBZk3+oNQaN7HidY85fD+pwk3wME+aVwpmMqiiJBI
 VZO5cpzqNSfh2E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This change will allow us to easily combine pmb_advance_or_null() and
> pmb_advance_or_null_multi_match() in the next commit. Calling
> xdiff_compare_lines() directly rather than using a function pointer
> from the hash map has little effect on the run time.

Good. I verified that the function `moved_entry_cmp()`
(https://github.com/gitgitgadget/git/blob/c3e5dce191/diff.c#L918-L944)
calls `xdiff_compare_lines()`, and it is this function that is used for
both `del_lines` and `add_lines` which would have been passed as `hm`:
https://github.com/gitgitgadget/git/blob/c3e5dce191/diff.c#L6339-L6340

>
> Test                                                                  HE=
AD^             HEAD
> ------------------------------------------------------------------------=
-------------------------------------
> 4002.1: diff --no-color-moved --no-color-moved-ws large change        0.=
38(0.35+0.03)   0.38(0.32+0.06) +0.0%
> 4002.2: diff --color-moved --no-color-moved-ws large change           0.=
87(0.83+0.04)   0.87(0.80+0.06) +0.0%
> 4002.3: diff --color-moved-ws=3Dallow-indentation-change large change   =
0.97(0.92+0.04)   0.97(0.93+0.04) +0.0%
> 4002.4: log --no-color-moved --no-color-moved-ws                      1.=
17(1.06+0.10)   1.16(1.10+0.05) -0.9%
> 4002.5: log --color-moved --no-color-moved-ws                         1.=
32(1.24+0.08)   1.31(1.22+0.09) -0.8%
> 4002.6: log --color-moved-ws=3Dallow-indentation-change                 =
1.36(1.25+0.10)   1.35(1.25+0.10) -0.7%

Honestly, I would have expected an improvement, given that
`moved_entry_cmp()` has to do a few things before it can call
`xdiff_compare_lines()`.

I love your attention to detail, providing performance numbers in the
commit message to prove that it at least has no negative impact on the
speed.

Thanks,
Dscho

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 78a486021ab..22e0edac173 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -994,17 +994,20 @@ static void add_lines_to_move_detection(struct dif=
f_options *o,
>  }
>
>  static void pmb_advance_or_null(struct diff_options *o,
> -				struct moved_entry *match,
> -				struct hashmap *hm,
> +				struct emitted_diff_symbol *l,
>  				struct moved_block *pmb,
>  				int pmb_nr)
>  {
>  	int i;
> +	unsigned flags =3D o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
> +
>  	for (i =3D 0; i < pmb_nr; i++) {
>  		struct moved_entry *prev =3D pmb[i].match;
>  		struct moved_entry *cur =3D (prev && prev->next_line) ?
>  				prev->next_line : NULL;
> -		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
> +		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
> +						l->line, l->len,
> +						flags)) {
>  			pmb[i].match =3D cur;
>  		} else {
>  			pmb[i].match =3D NULL;
> @@ -1195,7 +1198,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>  			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
>  		else
> -			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
> +			pmb_advance_or_null(o, l, pmb, pmb_nr);
>
>  		pmb_nr =3D shrink_potential_moved_blocks(pmb, pmb_nr);
>
> --
> gitgitgadget
>
>
