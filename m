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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA47C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB57D2068D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E4cPhwj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgKJPis (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:38:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:40453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732457AbgKJPir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 10:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605022720;
        bh=Jk0Z81kTOFRF2epYhMLg1vMdkcI1ForQ2k77aDCsuZ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E4cPhwj6R0epSmH0Z+PopqhXYZWo4cDYxoxNwKB9OA0Jc0+XgEbLrsWVYPL+wQKPp
         y50NPoS39anboDHqQVASjJm6iAGwZnbmmyTY8NUXAeQOJjBgIbiOaTqyOEg8gMtPef
         49hN8FB/uzmQX3TJwO5wdC9cZ7vYXRu3VJ9Gq/fs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1kJCUo2TtO-00urtb; Tue, 10
 Nov 2020 16:38:40 +0100
Date:   Tue, 10 Nov 2020 16:38:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jinoh Kang <luke1337@theori.io>
cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] diff: make diff_free_filespec_data accept NULL
In-Reply-To: <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
Message-ID: <nycvar.QRO.7.76.6.2011101638080.18437@tvgsbejvaqbjf.bet>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io> <xmqq4km4lppy.fsf@gitster.c.googlers.com> <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io> <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io> <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HP6yu1IkV0rVUKRy4HnRIZqFydpsNVh4jSHoWpJmdpIyUVGft3G
 dhsIHio4UD4b+rF10lr4I1qQW1NrfbRGqxBTd67+JyrK6a+K77Ld6mlMm2fZkDnI7qFdWdp
 lE5sK3gybc/KP8P31sZiaERkExLOJU9TXC9EMJHHk6iq+fkQm6bIKgH4d+yUcnr3GzKF1ce
 cMCiTZJsk968VDVLenKXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kSrqXTUEnsY=:TtS/mcv53cFdayn9TcRTpf
 I1SspcF6Vzf/zksACrHR07hv0Q5EyJ0a/61PMVk9Jm3Pz+1vvSt93Xq81RGmnoXI7bJlK6Lg5
 0G6Ns2rSv5E5xOcs0bHqZkm19RqRnp7DdfzY05ZEFFD1Ic+SuX1rU6pypwHpBielIDI+TMXuw
 r1uyRcNMe0GPkffq9oIZ/WIqMwm55oAdQdNAN5NN9MMV1iHwpgKci3KYa2HLNmvNhNdED36ca
 mLt0l6g1BePvWZB9K4z3YINsvSfqhI8IWjes0oS54a46GOLQ6nnhVE0t4xUI1KalOEfT8lhpq
 ytEX1dUjCbYIsvYFWAPbK5Rn8iYq0LY3FjtCoIWNXtkKuhx/icoZinccswKm/98kK+BY3JOMO
 Bp6Lik6BFopSJMuP+1aiFz+yGsSG62kOvZEdCkn5vU3uxIwiiXr09rEqh0qmxE52fl+BtyUmI
 U2RjD7fGNlZOgdgnHxLLOtWg4+JGZc8oiIoz+gP38cRbmdSpdMrHnsGaYsMwQ6m22NED9Ui4D
 bxKYIwPPfumSu6xaAp94V/6qMRwRxDcR9SOKmO4nhuBPJufY50H5lfofyKdlw2y2NezXsGaBP
 +acOMKy2BFjDtVO7ymbhgM28TZN9AYPC0H2BWVfJvEYyi6fZfb9D7XUBzAGTA5bZMBnGdVBRS
 0YdOX6SkbvVl+oReWxcQEpWXdepYTzjMw3qLpvu9ApVvjlnMtolgP4WgUP911n4GlJN1FyiXj
 alxlC70mPZHpgO1Bwm0ByGaIYGamCbu1W89sHjvFqH7nWkYHAXtA/WRIkjJsc19Lm/3lK7Yrj
 yayq25AxpDRbrvf7BFQwNKHUJ35oCzQnofRrR7/9WfueSzijaYZV9tNLOXWIp9mxVzsi3pozV
 XQtFR/I7XBuw7ngcMQWNo952xhrj/7Blr7gHsDNto=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jinoh,

On Tue, 10 Nov 2020, Jinoh Kang wrote:

> Today, diff_free_filespec_data crashes when passed a NULL pointer.
> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
> diff") introduced calls to diff_free_filespec_data in run_external_diff,
> which may pass NULL pointers.
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
> Also, add a test case that confirms that running difftool --cached with
> unmerged files does not SIGSEGV.
>
> Signed-off-by: Jinoh Kang <luke1337@theori.io>
> ---
>  diff.c              |  3 +++
>  t/t7800-difftool.sh | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
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

I had suggested an improvement for this hunk as well as for the test case.
Fell through the cracks?

Ciao,
Dscho

>  	diff_free_filespec_blob(s);
>  	FREE_AND_NULL(s->cnt_data);
>  }
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 524f30f7dc..e9391abb54 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -728,6 +728,29 @@ test_expect_success 'add -N and difftool -d' '
>  	git difftool --dir-diff --extcmd ls
>  '
>
> +test_expect_success 'difftool --cached with unmerged files' '
> +	test_when_finished git reset --hard &&
> +	echo base >file &&
> +	git add file &&
> +	git commit -m base &&
> +	git checkout -B conflict-a &&
> +	git checkout -B conflict-b &&
> +	git checkout conflict-a &&
> +	echo conflict-a >>file &&
> +	git add file &&
> +	git commit -m conflict-a &&
> +	git checkout conflict-b &&
> +	echo conflict-b >>file &&
> +	git add file &&
> +	git commit -m conflict-b &&
> +	git checkout master &&
> +	git merge conflict-a &&
> +	test_must_fail git merge conflict-b &&
> +	: >expect &&
> +	git difftool --cached --no-prompt >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'outside worktree' '
>  	echo 1 >1 &&
>  	echo 2 >2 &&
> --
> 2.26.2
>
