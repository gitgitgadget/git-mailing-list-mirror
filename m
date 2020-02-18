Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524CC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1983521D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T0lFKQmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgBRODF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:03:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:47323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgBRODE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 09:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582034583;
        bh=+WJRmfkpmWT8sz1w4HpEez5TdLjwzxYs0Qj00hWmBHg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T0lFKQmyiYX4mvUNP7jWIVDCJ+zwF6MkQXx9pucDxwOdPDiR11GlDHNMnA6kMe1xE
         q48WnMi56wnEvKUsCVMcV8TtDd/CsZC39ZFP8FaLFKz8qyHrv0Y/Hm+pMjh4Ukr/p3
         f6LVSOhPoBGd3i5KZRbUDjPK8ftqkK0/kJLw0IUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1jnXIa3Od0-00pNwa; Tue, 18
 Feb 2020 15:03:02 +0100
Date:   Tue, 18 Feb 2020 15:03:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like
 failure
In-Reply-To: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002181501240.46@tvgsbejvaqbjf.bet>
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vs8JU9BR2QwZmsodDUqEvtQ2ma8alIRKuEiI66pqQB8CVuL32U9
 2pxDPM5/2t0AYQtZ3KyPRU9ZuFA/rm1AwD4+iDK982uzczD2yupHYL4bMx3yoL4eFb9K3wv
 lA4F6e+24yxiqVjPH5bcuRRUDeZkiX5+3F29vLv2CoBf6zTF3SzYDBbHhu0gB4fB3B4Hb+L
 zhIdmxVgoln4JxOpnqI7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:amtnQIne7ak=:RgufRQbk5eWxM53OBrhX1B
 MxlOBg72iJpO8n8G2eghBJL0tiEGoYRHUGJAWmZPyvQqAgUfGQ5ZeDoLZXtfXuD595CNmsCIC
 3alziBavrc0+Md6K7zZFN+fPvovy55L8oY8tEOMAzFML1U3XkZflPpUeOapcc5YyeG4kOqt8q
 OOhOE000ubYOhQTpPKfEoGH4XblOB/QeJz5OzurY1b6Mu9GUH54Jx/etdshmMraj4mMYc6OoE
 akdT1GCBNWq6p08hZFM7ZdpZBlwoG88g48GJQM9y6ca4cprC8g8frLGrWR+O6yNCFCJ/cGjaX
 uLFZCC68jNPAef/jep08LglUEHhOLh1X/SGD70PTXoJZ0Ode0W5dcVyI/oSIRwDrC2I3zjuWb
 J9HtU87DGzkHv7Utm1ncaXlJRIyp9WFbou+VYJaETFHdS8Om5nKDoo1phQ5zwH5MN7UwkR+NV
 DiDzxI4Qh2mghiT0WvvXjnrRhueMQHGc0TXPFxNDaseY6vDzEafWywuu+I5h2W5AiFms0NFuu
 V+lYY8mtYSEtZfHYAhl3Bu2hDnj87GG3s1Oe4yNytcj97Ghvff0viKfBzCReG6tb5tmv9tE5O
 PiH4Sx5DTuqVJ7I/rGjT7rrrKuz2+yBhDKU9JN6GOHFPSdCXUn6tSCETq3XR3R/6e7Uwupn8l
 P88kP6hEhrlRx9Z7Zcpi/hsZq0xgrkRpU1pGPY8C23Q+XzreeIwfzGph49MEm2+xEP73opnJz
 /ywkJNoA91uVrmWVOrffaBRL/JyAnQJMFMQcoVm4cCxhr4S4drhuNyO7eT1ONRr20cW2zrwaQ
 l6FBJXKu68xofU1X9r0XoZL0Gy5vHP8CW0JGy3CUe+N6qrOSgUtbNGSjvZWAhAaIX/WrOtbrh
 a+umiEoBXggG2NKqOMbVbG8xkKgYyCvxwPkTD7UJlqW1jKooJGRsMmX+2a4PfyR0FJg74UwgV
 np73gGEX7YTPGNdRrT7kX325DfV8vnpVXIYYjgnH+nBDzUmBrRKNHH+GTtDDiV7wjeNKe1JWT
 JVuPI264fJ4ejW1AtQS4wQGSder/EfpaQ/MX9R5sVytP1aEdhzYcmovvzTrIs/PN4RmcVr1I/
 +CKMnC1ME3hWLgVKopM8Zmo7ZogRQXCXQDWE2PL8JREriNbD9376cjo7XotlMuJi7oUaZyItf
 uvRJk5fBZcRo6MavJPRUtWIVM6bVVPgN/ddlkNtNHcdB0UyaLjbhmruD1lgp25T6eu4oEy/9b
 7DcAj/+Zm7Xv9wV9C
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I am awfully short on time these days, so just a very quick observation:

On Mon, 17 Feb 2020, Elijah Newren via GitGitGadget wrote:

> diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-acros=
s-mode-change.sh
> new file mode 100755
> index 00000000000..4d2eb1dd7c6
> --- /dev/null
> +++ b/t/t3424-rebase-across-mode-change.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description=3D'git rebase across mode change'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	rm -rf ../stupid &&
> +	git init ../stupid &&
> +	cd ../stupid &&
> +	mkdir DS &&
> +	>DS/whatever &&
> +	git add DS &&
> +	git commit -m base &&
> +
> +	git branch side1 &&
> +	git branch side2 &&
> +
> +	git checkout side1 &&
> +	git rm -rf DS &&
> +	ln -s unrelated DS &&

This requires symbolic links. Therefore it won't work on Windows, and will
at least need the `SYMLINKS` prereq. Maybe there is a way, though, to
change the test so it does not require a symbolic link here?

Thanks,
Dscho

> +	git add DS &&
> +	git commit -m side1 &&
> +
> +	git checkout side2 &&
> +	>unrelated &&
> +	git add unrelated &&
> +	git commit -m commit1 &&
> +
> +	echo >>unrelated &&
> +	git commit -am commit2
> +'
> +
> +test_expect_success 'rebase changes with the apply backend' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -b apply-backend side2 &&
> +	git rebase side1
> +'
> +
> +test_expect_failure 'rebase changes with the merge backend' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -b merge-backend side2 &&
> +	git rebase -m side1
> +'
> +
> +test_expect_success 'rebase changes with the merge backend with a delay=
' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -b merge-delay-backend side2 &&
> +	git rebase -m --exec "sleep 1" side1
> +'
> +
> +test_done
>
> base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
> --
> gitgitgadget
>
