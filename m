Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C9E20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 14:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755004AbdK2O1m (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 09:27:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:51356 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752830AbdK2O1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 09:27:41 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXIcX-1efDDy3Cp3-00WFbx; Wed, 29
 Nov 2017 15:27:39 +0100
Date:   Wed, 29 Nov 2017 15:27:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Robert Abel <rabel@robertabel.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <20171128201818.4132-2-rabel@robertabel.eu>
Message-ID: <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
References: <20171128201818.4132-1-rabel@robertabel.eu> <20171128201818.4132-2-rabel@robertabel.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dj6M9ar9RxU/0Y3jEBM++YkvCym9POzOrs7YjlLdDf161mD1tzu
 t31cIolg6O3A0mBE/5a18A8OEVFHkCNNT6+GK8+VWBx+6KvWx9Ts7XTZHoxqZqDkdB8UP+p
 itJx1K9HbY8/DZfOWsA48kp2rS6JzA4sKFB2lbHZIGSnU+9+D0l12tGaAUJKdhRQM7Dk9TW
 jiR0xv852tzDSrizSczxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4fKPq/Wlj4o=:vphMGWQQgaqOYPLAwqXwoz
 1Rw+yK4d6QhmeLYKgBQkS/MTJHZGCHSiX0Ci9qs/MeGdvwgUGquxmWENH+W+Ax8rTcFbD7d64
 MnN6ru1exnLv2vtjGT5rRadrVjLfFbf3Ue2fgb25b0QsOHK+8cLdoQHhzempjMApVi3GPYTo+
 8pYgsINNXqeftkFUAFSS4R7W9RdqslvO2zGsxupuePvCaiHQZrFH7omzESx/J6NprMMaqwKIz
 FRJKaytAyE946usM4Pn9BfKWtQc2iPotaCf1KLDP4ugdo/7X+7DKMElAnMoALwWPdyrPykaoq
 5lK70/7MmgvRknCVtUVykmf6JHXzK2IH8sYbIbtoRXiaFjNhr6WeHtwUOAptCVYmXLotoa56Z
 Jup88ROLZoFEoSlMh9kBsiElmfrbW4KUinyxuuH+G3hjRKZ792gsC8fLFh8ZmH614zxwx1FF2
 0oGytLvSp5la2dBwMuQe4Bm26s3eNMndYmk7zLlhOLhhmrMogjt6D7gy6U77kKrxqoSjdvQJc
 Ciu5hGX8V4RokHzzjIxN1R3TvQ9senGwgpH6Nmwb2GeQDmoy+wWkf1eLt8GOPLXcupV+Evc+t
 eI8stobb8J700Q+jcDUJcUF9HMq3D8BCB6BLKlftNpgnCOOyv1o1xh6Uj5dIkxLPm4OEab9Jc
 YQNdFqPp5/uppoVFMWYjVLs1YTlsbI/25VzkexBYMucycJHIoBBw68FK8Nx/nfkz3444hSpML
 cH3DcUatndkSphlVm5vsLO5S0e2iF7PpwbfJoFWY3pWSVobziWAzHvLzvPwv+mPR5r89LglOG
 81cY3cXfT8iEiP0oPXUQA6eHmle+Kg/ELZLZPAMuws9zMorKTo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Tue, 28 Nov 2017, Robert Abel wrote:

> If any of the files read by __git_eread have \r\n line endings, read
> will only strip \n, leaving \r. This results in an ugly prompt, where
> instead of
> 
>     user@pc MINGW64 /path/to/repo (BARE:master)
> 
> the last parenthesis is printed over the beginning of the prompt like
> 
>     )ser@pc MINGW64 /path/to/repo (BARE:master

Thats' unfortunate, and obviously something to fix.

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c6cbef38c2..71a64e7959 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -282,7 +282,7 @@ __git_eread ()
>  {
>  	local f="$1"
>  	shift
> -	test -r "$f" && read "$@" <"$f"
> +	test -r "$f" && read "$@" <"$f" && export $@="${!@%$'\r'}"

As far as I understand, $'\r' is a Bash-only construct, and this file
(git-prompt.sh) is targeting other Unix shells, too.

So how about using `tr -d '\r' <"$f" | read "$@"` instead?

Or maybe keep with the Bash construct, but guarded behind a test that we
area actually running in Bash? Something like

	test -z "$BASH" || IFS=$' \t\r\n'

Ciao,
Johannes
