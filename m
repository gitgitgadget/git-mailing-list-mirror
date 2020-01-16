Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BBC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1981120661
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cDAcZ3Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgAPVIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:08:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:42799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgAPVIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579208904;
        bh=xLFeDXfd057uXrY7+YsEbRJADOUrkNEStyStGe1VBu0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cDAcZ3Gt/pzajLw3rfNxDm5Sy0FIBQCbDdUPgHYaFDQ8xGmonUydWpwbV+fT8S60C
         yOzkrP1bnSYqfQkpbS7zIhG+yESLbN2ZSvoycWR0OibX94uPYg8eVH4FwIwtbmUfxS
         Erj2DTz/sBwmYYYNh+KWbz8/0J15kkOAlrOMfsSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1jdKtH3tLI-0132yD; Thu, 16
 Jan 2020 22:08:24 +0100
Date:   Thu, 16 Jan 2020 22:08:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7800: don't rely on reuse_worktree_file()
In-Reply-To: <20200116181940.GA2945961@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2001162207220.46@tvgsbejvaqbjf.bet>
References: <20200116181940.GA2945961@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SHrEFJcFnVPeQDQemRQxJxTqbi1J8d9LvfjPSEW+eoM1xPbK1bg
 WulESnusmmxEWrCg9h0fcm/R04nNF5HGy7ov32tRapELwyEG5Z5uCgNTzHDw8AYElQhnuV8
 KghUTEdHw5A1QRQXdKMSD2w6arWvHXV6tPkvdiCVioZxPcRro4bWPURT8Fk6bjeJl5D0W7U
 CxBdPB68dq8j1eo+PKeRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fR9lRfNGGE4=:CUJELQSik/hIxCIud2Fkpi
 VF1MYuG17vkRWZbvnEPz4DcLRc1gEYKL2At6t+0CWu8JrTI6HM5fikzpqmuoD6hef3G338TPp
 Zsjyfj5f2tmexJH3Z0a37SQmge7O7RQidsw3U8ot3d7vu90C6KnxSQkFfBSaIjB94IqcFjAL/
 Oo7CFAFLzE02miBZQXdNTTK+NbVXPOqKUmqXAW2zbW3QXIMnKl5xrPz4MLfdxUfLdUzaeyIj3
 v7l3hV0X5yTf/MKSWdVCEgT8zttjOOFbG61g1uImPWKtixrax+mai/SVqXQIVj/XZ/V+249tX
 Dd2sTNPCofaUNLRQI4kuKGyb4qL8l2/6VXrCPCRmcWKwN8qgyZCbrZRb12xWjqI+Litj54xFP
 eOppd6kDXb+uobV90I0ryYc0RJ3/Q4ofqu5j6y+pITqFIuP13G1KDHPVm3lyDRF/2Flzzz1iS
 E7zpft/pWC0X90UMy9pYKh2tG5MSgJ+68D+U2ieZ72BzEXZcJw0alw+VCTmCVzNg7SMD2k7OT
 Ujq2fmqiQHfV6h26Kub8xLaQRlqEUDecwu+b5CDgq5jt/U54lqgsqebvF2qpUbbc+BfLppxQl
 oR7Y8xha0H2WN5P22U6D5qcZYGhr0yMhFCZZI7EPdnMKbOQLHBqzi9yHoefHWsSEoISLJ6N9d
 gVlj5K6nDAU6POUVcH7hXSN7i0jwofvhzJvMCTIxxO5ntzv5Qsi0wpj8d59ylHA2fj7Hgpvcl
 ksI3vQmbxNM5PKftsf8GMe7VXSEV2iDl/MvOUXtOa107O+L/v70mK9opZ4H3t3Eemh4WQPPyz
 ko6Lj3zanEjNCdvqgErMIeT04fH0Qg4qOd4sVX9kD+XBKoxIwCljqzYhgq0go8z1PEGYhOCS7
 uuB0JIjgWlDaCpcn8sQxftiYnyC4tZbiOymj7xs40Z8J2bfWYg5H8GwANoyJqonMGUXWGmUxf
 z+G8p4VMAeFEEufn92MPgbgrPJNEbFjcToj5rl9Yfh9zn+PY6DC8ZnZ+YchsAvZRArYM3W0Wv
 4+YaqbB49ahScYgiHyaWgY0WxTqfE/bXGiJMXLkwWPI4H1au8jdd4BdV2lTcRzkIQoElvtyha
 pIdmpAXHVz09Cf0Xew6GgRr2epG7nSoow7ipzw4tau55WD+Zb9PRbIoXjpIr/jbC87gtyFFZF
 Pivah0tZy13W4F14LcQF3HwEewAf6FM2UeUNRwWFKYPEKaz5Jc5AsJIrbP6tQ6URyUld3842X
 OPhHJh1KV7e5escA2NxN9KFlJn3pu/EUysgmhVPQaWUB8zudQ17LG8oS3Xdk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 16 Jan 2020, Jeff King wrote:

> A test in t7800 tries to make sure that when git-difftool runs an
> external tool that fails, it stops looking at files. Our fake failing
> tool prints the file name it was asked to diff before exiting non-zero,
> and then we confirm the output contains only that file.
>
> However, this subtly relies on our internal reuse_worktree_file().
> Because we're diffing between branches, the command run by difftool
> might see:
>
>   - the git-stored filename (e.g., "file"), if we decided that the
>     working tree contents were up-to-date with the object in the index
>     and HEAD, and we could reuse them
>
>   - a temporary filename (e.g. "/tmp/abc123_file") if we had to dump the
>     contents from the object database
>
> If the latter case happens, then the test fails, because it's expecting
> the string "file". I discovered this when debugging something unrelated
> with reuse_worktree_file(). I _thought_ it should be able to be
> triggered by a racy-git situation, but running:
>
>   ./t7800-difftool.sh --stress --run=3D2,13
>
> never seems to fail. However, by my reading of reuse_worktree_file(),
> this would probably always fail under Cygwin, because it sets
> NO_FAST_WORKING_DIRECTORY. At any rate, since reuse_worktree_file()
> is meant to be an optimization that may or may not trigger, our test
> should be robust either way.
>
> Instead of checking the filename, let's just make sure we got a single
> line of output (which would not be true if we continued after the first
> failure).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

The reasoning and the patch seem sound to me.

Thanks,
Dscho

>  t/t7800-difftool.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 6bac9ed180..29b92907e2 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -125,15 +125,14 @@ test_expect_success 'difftool stops on error with =
=2D-trust-exit-code' '
>  	test_when_finished "rm -f for-diff .git/fail-right-file" &&
>  	test_when_finished "git reset -- for-diff" &&
>  	write_script .git/fail-right-file <<-\EOF &&
> -	echo "$2"
> +	echo failed
>  	exit 1
>  	EOF
>  	>for-diff &&
>  	git add for-diff &&
> -	echo file >expect &&
>  	test_must_fail git difftool -y --trust-exit-code \
>  		--extcmd .git/fail-right-file branch >actual &&
> -	test_cmp expect actual
> +	test_line_count =3D 1 actual
>  '
>
>  test_expect_success 'difftool honors exit status if command not found' =
'
> --
> 2.25.0.318.gee4019ba55
>
