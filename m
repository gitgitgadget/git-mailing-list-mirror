Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF6CC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EE020756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TugBEUdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgKKQ1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:27:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:51307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbgKKQ1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605112068;
        bh=+DFqzKw2bpoO+G3a+7UaaTOptTyKsiVaKF597VX1D2Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TugBEUdXyBy4mt+D2A1OK1kR7/P2RSvBmtJ2IYRhJPIYNJxTiMzxh8XIVqY7nSI49
         Hp5Q5J41+LAKeO1JFyH6GEHnUr+WtylTJ+J2GEJkFajZddG+z+h+/WUadznQsDJ2m0
         U5bMD+2HP3jDpFqJdk3p55sfg1Xy92QzAwjK0OmI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1k8TyM41Zp-00e82p; Wed, 11
 Nov 2020 17:27:48 +0100
Date:   Wed, 11 Nov 2020 17:27:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jinoh Kang <luke1337@theori.io>
cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] diff: make diff_free_filespec_data accept NULL
In-Reply-To: <5d4315c5-a0ae-2857-fbcc-ec6166d025b6@theori.io>
Message-ID: <nycvar.QRO.7.76.6.2011111727090.18437@tvgsbejvaqbjf.bet>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io> <xmqq4km4lppy.fsf@gitster.c.googlers.com> <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io> <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io> <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
 <5d4315c5-a0ae-2857-fbcc-ec6166d025b6@theori.io>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v2bIQ5WS47Oy3Oy6SuAqw2nr/RVr1rhIA/akTVpR0Vl96ocenfY
 /at2/384Rmo8f9cmWU4FvxhiM+5ZA8nc7nnWqYo4HEdTEvP06yaSULKg7lPR4GoNOxy+qzk
 RcIjt7tbJJYGygjWfFGq2KNc7QyqoucLEnc2QoFojCl8lzZpRaMQe5TdaHaPo/fp/5RLLxU
 mq0kO4eOTN5TG3Oy6oroA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N2xHuvZi4f8=:JXU89Wtp+/y+RIgOtEyG/w
 GUuIMfHm0p+IAIoK+czAk17eqq7QFoGIVylIyDL8A2FabT/ap1g44bH1nuFl2azOMU+wLPJTv
 gU9pmSe5Vn5WkeAPN/EfmHPJ50iDL0flNq9mdoU6BLpcMQJkfSJwD6L6JkyEXrHrUXbXXbMpO
 JOz0FJqDSAcHgFPBuHZuqaUfwvqUMVbOPJQFokJOsE/b3hX5jFjJnDUEgqOPfB8QchDefIshe
 NFkEKkYtDKy8d3kTWK9DUIW8jWmfPr/oq5PykNKueUWeVekb/Qw82NfTisuFeUl0fwpAV5P8o
 vUpHnLrIf6Qef/PrtPZcClAQvtNDT8TKEwcSVtuNjnURZyQI/WJyp8ObE8SUiajcwS+qMjSFR
 NpM5lL4QwTLjkRaOOF2L6hZOsTN9AYlT8+t+qaP6k3Hhd3myNdmQG3meZebL6g01v2xA8+VO7
 EV8CqZrdnkp91Md11xvvih5OvbAeiRNFGtaw4w+tqd5UczyiIEhGGYDhzQ+XT4gzc7raIOk4y
 7m5L18+IRYcUVE9IOayF38265hBIu6MxZe0LLOynu+Rn+zE0GCDZBUwD8nAi9o8/E3mv79O1c
 uvIVv2I2DgzwtemZKZmb3LZiQL/fbs4eCsVuSRcdBCLtAtXlCp6djr/iG5bUVFSUQ1mIS9cPm
 xzvlpX1reYquhsLkdl8eoVIvKf2GIlMPMxO1bC1FQy8E5UAg5swhWaHfsNYai9IuTxW3qdmnz
 uawqD8HTHR8KqnpqHU+mxVUlqi6OC/yaV+aTWWz/FUe0NhHCNsW2zHaAWdYDUUdB5JCrU2087
 ZBocB76x/wj6x2z5Qa93JQY89soiR3Yc1doJjHN7sdcvjB9+CaOtd7+fxDMyJkqutUBEkrfNx
 HfurOyJ9X8ZxpDs07RGpPSH8Hd70ilxd2JugFaVeM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jinoh,

On Wed, 11 Nov 2020, Jinoh Kang wrote:

> diff_free_filespec_data crashes when passed a NULL fillspec pointer.
> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
> diff", 2019-07-11) introduced calls to diff_free_filespec_data in
> run_external_diff without also checking if the argument is NULL.
>
> Git uses NULL filespecs to indicate unmerged files when merge conflict
> resolution is in progress.  Fortunately, other code paths bail out early
> even before NULL can reach diff_free_filespec_data(); however, difftool
> is expected to do a full-blown diff anyway regardless of conflict
> status.
>
> Fix this and prevent any similar bugs in the future by making
> `diff_free_filespec_data(NULL)` a no-op.
>
> Add a test case that confirms that running difftool --cached with
> unmerged files does not result in a SIGSEGV.
>
> Signed-off-by: Jinoh Kang <luke1337@theori.io>

ACK!

The patch looks good to go to me.

Thank you!
Dscho

> ---
>  diff.c              |  3 +++
>  t/t7800-difftool.sh | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index d24f47df99..ace4a1d387 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4115,6 +4115,9 @@ void diff_free_filespec_blob(struct diff_filespec =
*s)
>
>  void diff_free_filespec_data(struct diff_filespec *s)
>  {
> +	if (!s)
> +		return;
> +
>  	diff_free_filespec_blob(s);
>  	FREE_AND_NULL(s->cnt_data);
>  }
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 524f30f7dc..a578b35761 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -728,6 +728,19 @@ test_expect_success 'add -N and difftool -d' '
>  	git difftool --dir-diff --extcmd ls
>  '
>
> +test_expect_success 'difftool --cached with unmerged files' '
> +	test_when_finished git reset --hard &&
> +
> +	test_commit conflicting &&
> +	test_commit conflict-a conflict.t a &&
> +	git reset --hard conflicting &&
> +	test_commit conflict-b conflict.t b &&
> +	test_must_fail git merge conflict-a &&
> +
> +	git difftool --cached --no-prompt >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'outside worktree' '
>  	echo 1 >1 &&
>  	echo 2 >2 &&
> --
> 2.26.2
>
>
