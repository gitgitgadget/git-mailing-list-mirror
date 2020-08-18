Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C4C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFA820786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EGc3Ylfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRM3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:29:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:49971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHRM3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597753783;
        bh=h7rq69wgkSoN50fCDBn4dCQG3HQc/RlMwif/FuDrurk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EGc3Ylfz9ZL51v1P9nMK5YeqSxXQAuLXGbYXnEdmGN8wfs/oOW9IRC11yfIMAU/km
         NbSabSSSJf1wksMzgsMXesRfwKk5nqnC9k6oZ/OSBlJp7ZhOQBDrNPS93wghvTJei0
         kg1HWuujZB+LJi0r34LaIm/Q5eAS2h/rZ5sKqd8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.213.201]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1kgFMq0RGt-00aDBQ; Tue, 18
 Aug 2020 14:29:43 +0200
Date:   Tue, 18 Aug 2020 08:38:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] add -p: fix checking of user input
In-Reply-To: <752e13fb9fd9fd7930d83a0915dbbc0274a99908.1597670589.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008180837540.56@tvgsbejvaqbjf.bet>
References: <pull.702.git.1597670589.gitgitgadget@gmail.com> <752e13fb9fd9fd7930d83a0915dbbc0274a99908.1597670589.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9x7Y01/JDHQ10G+tXNaYvRt3aCNLUb0FOPlns34Lfpxmd/BbfNM
 HxW2gLQao6IoEdbtznr10CY84+7FroXLSbg7xlLoy8Cc0+rmzCef4w/gCNH2Mrncd+vkJer
 duE2EPPlMioagyI04evdeaHSa0mTyHIZJlVIeapSAzrxF6rflRG3/1+wP8uifWMA3dwqPdP
 llqGkgoZJhDWIfCI3P29A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1MYojVojEs=:0b5yavKMsnU4FLSF96FrSQ
 SyP6WQ2cKBHqaUAENMDPU3lBsja9TDNuyQtDFug5IMDdPOh+ndNKLlhBlcuLp2MSRsW4LmQB3
 uPGF0Z6ZX/m/YbvxE+Y1UDSolS/c9TMriGovMpD4Qc518vK0uQhrYVzQ18W1jp7oVDC/Tf3G+
 uIOdPiKs3L0FaFoRqBF2gTF5U1Wf+92Rvx9yoeaTve1g3MtwE2Y+Nu8cbHulZg3fmLdo8Y5xm
 V7SD6muGfk/2GVzUqve2Qp3KovdrjarkMcOCcjZ+mJa5vojDlffEGSiThTuBJXGg+FNSH/HOe
 WDDFHvqMw6hbF0Z7/vunH+rEtEB4dvJKDMipNFXpiWxHSoNZ9dydS4Nbsj/S8N8ZE2IwJyDW9
 fBD8tfXgTKRWsDxov7PptpFoljQ5sRHbhgDzCm82/ZrHS4ajXzVfHvvGkRmM0ddMllXoMXVgM
 yqbiHSgpJSaS0u5fkzRduYUaR8/28POtpAOkLxnvQbfCc6RLsNl3j8ZXpT7qU3SvB5sh/NTQo
 d3OfnIv3Ib04MbMxYzesYZXSeMTwD/RF+g5979m5JpMKRi16BITZAHnGyhYgkABLJFeblfkxC
 Q+3Yy3BhHgwo4rcM3OHO+JWV+w754ho6wQqRjGXLmLU/JpSbOd1accqJ34saRqaVUDMky7brZ
 A7QOvNuSRnPgi9b3SmcJJfymQtE67VpODPkacAyymIK1vOPA0qc50YU80tafpWyxm8HWzB2SL
 eNhe3SSIFMSS83axhJlChLC8yV/Rugx18qzfQMESzz2b/imuSR3lpmOqzkkce41zCEBoZ+0at
 sFqDSNHV40VGVmleSc286EBxkdB774CJKsI3/2oTDW0V1WKeuxofUeSiybjmH6ERTjwfnAX8f
 XPtsNdaQ1YD2+uCtO27oUvA4dqrEQc43xGZ5jYQOXmm71wtM4lg8KmM9Km+4Cv2yaNta+MeK3
 iNAC5KZbG6HDQTS8XmVYG2CInjUXfR75qCsfVww3Fmvr4dMTZC4a+d0wnrx71fH/OB4d6rU6k
 fG1AeAzv9DeCVbfS8Y1+LtvUHBP0mUANWNxkp57ULOt504zZkI588ujInM+r/cqNTyjyMv78p
 kuXCbg2T98tS9BVUjew7m14PlYvGe0StesajzndN3L9zQHzPKAQAwL3SMdygJPy91z4n0ctTN
 sMVVRka3b3mSscvAcLflUDY/vjf9rZ2Vz6mLRmh0eV/lWC9tJhz0H/wEtz7WG7SCatn8MD8AL
 eiSTfuJ7VwjFNq45kciWUgXp4jsuhA220JqnDrQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 17 Aug 2020, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When a file has been deleted the C version of add -p allows the user
> to edit a hunk even though 'e' is not in the list of allowed
> responses. (I think 'e' is disallowed because if the file is edited it
> is no longer a deletion and we're not set up to rewrite the diff
> header).
>
> The invalid response was allowed because the test that determines
> whether to display 'e' was not duplicated correctly in the code that
> processes the user's choice. Fix this by using flags that are set when
> constructing the prompt and checked when processing the user's choice
> rather than repeating the check itself.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

As I had mentioned on the PR, I would much rather have a bug-for-bug
conversion to use the `enum`, and the fix for the `edit` case as a
separate patch on top.

Thank you,
Dscho

> ---
>  add-patch.c | 54 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index a15fa407be..907c05b3c1 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1352,6 +1352,15 @@ static int patch_update_file(struct add_p_state *=
s,
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	int colored =3D !!s->colored.len, quit =3D 0;
>  	enum prompt_mode_type prompt_mode_type;
> +	enum {
> +		ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
> +		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
> +		ALLOW_GOTO_NEXT_HUNK =3D 1 << 2,
> +		ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
> +		ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
> +		ALLOW_SPLIT =3D 1 << 5,
> +		ALLOW_EDIT =3D 1 << 6
> +	} permitted =3D 0;
>
>  	if (!file_diff->hunk_nr)
>  		return 0;
> @@ -1388,22 +1397,35 @@ static int patch_update_file(struct add_p_state =
*s,
>  		fputs(s->buf.buf, stdout);
>
>  		strbuf_reset(&s->buf);
> -		if (undecided_previous >=3D 0)
> +		if (undecided_previous >=3D 0) {
> +			permitted |=3D ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
>  			strbuf_addstr(&s->buf, ",k");
> -		if (hunk_index)
> +		}
> +		if (hunk_index) {
> +			permitted |=3D ALLOW_GOTO_PREVIOUS_HUNK;
>  			strbuf_addstr(&s->buf, ",K");
> -		if (undecided_next >=3D 0)
> +		}
> +		if (undecided_next >=3D 0) {
> +			permitted |=3D ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
>  			strbuf_addstr(&s->buf, ",j");
> -		if (hunk_index + 1 < file_diff->hunk_nr)
> +		}
> +		if (hunk_index + 1 < file_diff->hunk_nr) {
> +			permitted |=3D ALLOW_GOTO_NEXT_HUNK;
>  			strbuf_addstr(&s->buf, ",J");
> -		if (file_diff->hunk_nr > 1)
> +		}
> +		if (file_diff->hunk_nr > 1) {
> +			permitted |=3D ALLOW_SEARCH_AND_GOTO;
>  			strbuf_addstr(&s->buf, ",g,/");
> -		if (hunk->splittable_into > 1)
> +		}
> +		if (hunk->splittable_into > 1) {
> +			permitted |=3D ALLOW_SPLIT;
>  			strbuf_addstr(&s->buf, ",s");
> +		}
>  		if (hunk_index + 1 > file_diff->mode_change &&
> -		    !file_diff->deleted)
> +		    !file_diff->deleted) {
> +			permitted |=3D ALLOW_EDIT;
>  			strbuf_addstr(&s->buf, ",e");
> -
> +		}
>  		if (file_diff->deleted)
>  			prompt_mode_type =3D PROMPT_DELETION;
>  		else if (file_diff->added)
> @@ -1452,22 +1474,22 @@ static int patch_update_file(struct add_p_state =
*s,
>  				break;
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'K') {
> -			if (hunk_index)
> +			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
>  				hunk_index--;
>  			else
>  				err(s, _("No previous hunk"));
>  		} else if (s->answer.buf[0] =3D=3D 'J') {
> -			if (hunk_index + 1 < file_diff->hunk_nr)
> +			if (permitted & ALLOW_GOTO_NEXT_HUNK)
>  				hunk_index++;
>  			else
>  				err(s, _("No next hunk"));
>  		} else if (s->answer.buf[0] =3D=3D 'k') {
> -			if (undecided_previous >=3D 0)
> +			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
>  				hunk_index =3D undecided_previous;
>  			else
>  				err(s, _("No previous hunk"));
>  		} else if (s->answer.buf[0] =3D=3D 'j') {
> -			if (undecided_next >=3D 0)
> +			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
>  				hunk_index =3D undecided_next;
>  			else
>  				err(s, _("No next hunk"));
> @@ -1475,7 +1497,7 @@ static int patch_update_file(struct add_p_state *s=
,
>  			char *pend;
>  			unsigned long response;
>
> -			if (file_diff->hunk_nr < 2) {
> +			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
>  				err(s, _("No other hunks to goto"));
>  				continue;
>  			}
> @@ -1512,7 +1534,7 @@ static int patch_update_file(struct add_p_state *s=
,
>  			regex_t regex;
>  			int ret;
>
> -			if (file_diff->hunk_nr < 2) {
> +			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
>  				err(s, _("No other hunks to search"));
>  				continue;
>  			}
> @@ -1557,7 +1579,7 @@ static int patch_update_file(struct add_p_state *s=
,
>  			hunk_index =3D i;
>  		} else if (s->answer.buf[0] =3D=3D 's') {
>  			size_t splittable_into =3D hunk->splittable_into;
> -			if (splittable_into < 2)
> +			if (!(permitted & ALLOW_SPLIT))
>  				err(s, _("Sorry, cannot split this hunk"));
>  			else if (!split_hunk(s, file_diff,
>  					     hunk - file_diff->hunk))
> @@ -1565,7 +1587,7 @@ static int patch_update_file(struct add_p_state *s=
,
>  						 _("Split into %d hunks."),
>  						 (int)splittable_into);
>  		} else if (s->answer.buf[0] =3D=3D 'e') {
> -			if (hunk_index + 1 =3D=3D file_diff->mode_change)
> +			if (!(permitted & ALLOW_EDIT))
>  				err(s, _("Sorry, cannot edit this hunk"));
>  			else if (edit_hunk_loop(s, file_diff, hunk) >=3D 0) {
>  				hunk->use =3D USE_HUNK;
> --
> gitgitgadget
>
