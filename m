From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] merge-file: ensure that conflict sections match
 eol style
Date: Mon, 25 Jan 2016 10:20:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251001360.2964@virtualbox>
References: <cover.1453632296.git.johannes.schindelin@gmx.de> <cover.1453709205.git.johannes.schindelin@gmx.de> <4bae6450eb64461584a9acdefc9a3226c95ef357.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:21:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNdKl-0007iH-Va
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 10:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbcAYJVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 04:21:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:60893 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbcAYJVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 04:21:05 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LwJko-1a33fB3D3e-0186DZ; Mon, 25 Jan 2016 10:20:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <4bae6450eb64461584a9acdefc9a3226c95ef357.1453709205.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rH1OBlYmXVbiMb6BzFFBXce8fmwWXjWfYpM/Y3r7QHFBO/2Ss4H
 U3jJq/8c4R8m6OvilpdMsBS532tvncKKzPftEcVzy1ceQypDFejPw/16p1ic0uibh/d4zR7
 zdPdUR6vQbyn+F/xBepK8Wg37nl/7D9JUmCzduohs2qftECBvbNGGLjFeaESvR2mlE6VvQd
 uhTamUgC95WAELGoaKMOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g2kxoYutnhY=:HHCq+l7w5QiA5Z5IsWDLvP
 nRT51f+JNcHRkAHc1HoHiWToBm43ALb81851amaHkQpmCiNo5okc5r3gPtLtbEYHweMKZdEhI
 PVbXarGrtymJHwUmnLwtrfguqXvy5c6TtrxXcDB0sxb0mZaFvW3nOW89bwXCoR3WSW4uGMruo
 mZmaBmIbIhD9HxQ5AgnonCsk4SCGNAM+7Wn+nSr80HvNysiPKUDpPqpp3Qyvk7OgOgaw+LN+v
 zU1RP30EcYVBWQHppebpQ7gP2qpczsx7GQ7ay275I71kz9qN7bsW82MEOaJK7q2sMYhewasIi
 VXd3JfpHHHBU6Zv8OlQnzGbq08MqS+D3bjv1Zq+8JAYETPljmKMplGq92clOrk4UxAzc8o5HK
 L2Tso2uMrJpPnta3f5L3y2z2xZAfV2T1/fiHCZenYq7PqRVvtA9WEoW4GmcwYA9wixd7rciAZ
 Kh1HJfxgk3Ydtjm4EKEd2rQzs/LdrdC0lNWV4xfG+Br2mfIFoBvkSpxtokSGlgoVJ0ped1F2+
 A5qKG9w7M5zqQDBQiIUwnSkKpeMPXNAY4soSAyMyI/w+UuJsjmhCxm9dsioq56ywQwHNsSk8X
 yQW7U+WKGvN8tLuhXgbmp/5ghNkiBDe/gfZOpsEYgxkIdCu0PEC2FaVmimNMVwM+G6fAkgKaJ
 MYx4bOPvJqkpebneXKTKWnrJE+E/dOYeTKquHo6XiYTrul8Yth7MbCeNya230KfmN2SdA7akT
 3KJHUQbu+1oj9WzJVgfb2+uxmoA2va765clGeGQ7GWbanR1GlqrTsRtHY/+fC5JAEwp7tFxS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284728>

Hi,

On Mon, 25 Jan 2016, Johannes Schindelin wrote:

> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index c852acc..d98f430 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -172,15 +178,8 @@ static int is_eol_crlf(xdfile_t *file, int i)
>  		file->recs[i - 1]->ptr[size - 2] == '\r';
>  }
>  
> -static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
> -			      xdfenv_t *xe2, const char *name2,
> -			      const char *name3,
> -			      int size, int i, int style,
> -			      xdmerge_t *m, char *dest, int marker_size)
> +static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
>  {
> -	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> -	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
> -	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
>  	int needs_cr;
>  
>  	/* Match post-images' preceding, or first, lines' end-of-line style */
> @@ -191,14 +190,25 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>  	if (needs_cr)
>  		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
>  	/* If still undecided, use LF-only */
> -	if (needs_cr < 0)
> -		needs_cr = 0;
> +	return needs_cr < 0 ? 0 : needs_cr;
> +}
> +
> +static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
> +			      xdfenv_t *xe2, const char *name2,
> +			      const char *name3,
> +			      int size, int i, int style,
> +			      xdmerge_t *m, char *dest, int marker_size)
> +{
> +	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> +	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
> +	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
> +	int needs_cr = is_cr_needed(xe1, xe2, m);
>  
>  	if (marker_size <= 0)
>  		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>  

Oh bummer. I just realized that I should have refactored that already in
patch 1/2 before sending out v3. Of course it would be true to history to
do the refactoring only as part of 2/2, but who cares about true history
when one can rewrite it?

Will send out v4 in a while (I want to wait for more feedback in case I
need to change more things.) In the meantime, you can always look at my
patch series' current state here:

	https://github.com/git/git/compare/next...dscho:merge-marker-crlf

Ciao,
Dscho
