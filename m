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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7423C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500F1206B2
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Rmpufx6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJMIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:08:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:43277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJMIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 07:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605010104;
        bh=Id0LFaKaRgsPFCucmuEI4PFAIkpmrPHEPQ0fL8Xllls=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Rmpufx6wYuKdpKJ+Y2er0C4tmQ5fLK79QjIj3cEREqjeXEBWnRRYpwRDQmbNRaoaJ
         4J6tpaAIBiPMl0RzKbyE3W2kT7LiB1eLfh90X0KtnyZU4L+w/jxh1BHIOhWb5zJOIO
         HtWk8ia1TDyYyvmY9mWcBTcYfRT9dE+/p4m30OqQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1k54Ut2xVz-00gowg; Tue, 10
 Nov 2020 13:08:24 +0100
Date:   Tue, 10 Nov 2020 13:08:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jinoh Kang <luke1337@theori.io>
cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] diff: make diff_free_filespec_data accept NULL
In-Reply-To: <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
Message-ID: <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io> <xmqq4km4lppy.fsf@gitster.c.googlers.com> <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io> <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qcNzIEzljyiyf44/SAVHrJGMldai28mCJ2pYkKa4+qBnocz6qks
 peT5IjQbnSLKO2XRsOIxDLHNvLxTzc6I3CRv9m/yHEcnQ5vt8LZBdFK69lUeM67FZqzbjLR
 ppFWrtWrY/VtNi5TD621fVw3BlGMh1I8X+Pj49T5O/BT+AFpvfLDtCBEJutt4scBmp+bFk6
 WxN//DrMIYp8A8YZs2jYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KIR9nuslhr0=:x7QqoZy7atlY6WYOltDOkC
 WhbozoepLfya/QZJMD+OrhArEJw/S2mowWMLyIDJygOokKhQhtZEz/XuM4UCU7ryaWepmh+Wz
 rD3pa8BzPI5naNJGoLg1DTRbaHewAJvIpNOud1qsJlnThY2h5p/RW4AO1lRtF/FpdfDuvVQ2/
 v/gHl13llYs4rwmZFP4e/QgbDPSijbK0NB8WyWFbO0D7wG4swjdkGpOxmfjUkjqm2RfMPlvnP
 DwHYQ5icwLmIqePJQv3bMHGWRGLoSQAn+GLyOODde96p+iaGjhSulqQtkr4PCdKekUaYJRsZv
 /VY/joBM48JyJLaGBSnw+68SPIVoNzwF7LE/sxMpof+9z9xKqGboiybAiwnHO+cFfZxAu8Vxj
 2a0O84ROkbUXTUIWUwEc80O7Z+A7ym1gOmOpyx4Tq2kDwL7TNZY14Q49+6C6pJuxpfZ2SZEoM
 bts63mBSKjBjhw9aUa3448CQsyS+cHYQJEfPzEc60tAO2/QunKv3l8fkLdB7MPD7Uu1NE9iL3
 HksgzY/n79kxPA2u71fusPnGCv/5rdH+AqarlCGcRTormO9IXTXQmX178GfE0KI5bzGOs3WCX
 SI+R9sS5cGFr7dxmzQ44mXvOWBahs/GOrY6CMXire+meFv1MIKxTvy82pXkaZb/yFLd3+QDHR
 kTuD9+vJ2q9LudiT9el9gPmtObqzdktVcm+e5RVvDRLW1mAQ/UcEmOQsICzeNDzJVgwnoZcI9
 cuUG/OdyGO245UdYA3E9TL9e/IoV7B3NlSBCA3wKg4PqA/cJKN5b56lBog1dAyUcz2NWgC1uB
 QYZ/aHCVGoEOFPZCYzIu2EzaYxcGIVwc+AxWYHphySxNlc1aVGPgH45G1FGsci3U07G1l/E/5
 sbOrDWYdPfUzNfszQTBve42nShTQkcKI+3ZMciFvw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jinoh,

On Fri, 6 Nov 2020, Jinoh Kang wrote:

> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
> diff") introduced calls to diff_free_filespec_data in
> run_external_diff, which may pass NULL pointers.

Sorry for the breakage!

Maybe the commit message could talk a bit about the circumstances when
this happens? Of course, I (and every other reader...) could analyze your
patch to guess what it is that triggers the bug, but it's really a good
use of the commit message to describe it in plain English.

>
> Fix this and prevent any such bugs in the future by making
> `diff_free_filespec_data(NULL)` a no-op.
>
> Fixes: 3aef54e8b8 ("diff: munmap() file contents before running external=
 diff")

I am unaware of any other commit having a `Fixes:` trailer in the commit
message. In any case, I would have expected `Fixes:` to mention a ticket
or a bug report, not the commit that fixed _a separate_ issue (but
unfortunately introduced this regression).

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
>  	diff_free_filespec_blob(s);
>  	FREE_AND_NULL(s->cnt_data);

We can write this in a more canonical way without wasting all that many
lines:

	if (s) {
		diff_free_filespec_blob(s);
		FREE_AND_NULL(s->cnt_data);
	}

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

This does not advance the committer date. Let's just use the helper
function we invented to make this much easier:

	test_commit base

This has also the advantage of already tagging the outcome.

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

Shouldn't this use the `test_must_be_empty` function instead?

How about writing the test case this way:

test_expect_success 'difftool --cached with unmerged files' '
	test_when_finished git reset --hard &&

	test_commit conflicting &&
	test_commit conflict-a a conflicting.t &&
	git reset --hard conflicting &&
	test_commit conflict-b b conflicting.t &&
	test_must_fail git merge conflict-a &&

	git difftool --cached --no-prompt >out &&
	test_must_be_empty out
'

Ciao,
Dscho

> +'
> +
>  test_expect_success 'outside worktree' '
>  	echo 1 >1 &&
>  	echo 2 >2 &&
> --
> 2.26.2
>
>
