Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA24C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07222527
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A7u1bg2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfLLTrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:47:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:53917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLLTrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576180063;
        bh=oRDoBoSh7W0WjaHMsO8tFE62D5Q5P64R6H5PM3CcH/A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A7u1bg2r9AICcg6g6lrkzeZyr5sYpP0JuYKzBIT8x97Xjgl0QtxTcHQrfQY3rccPq
         Ucwcyhmggfpw1sRZbfcvbUgR4sG+Zk+Kz49Wmk+SpKwWK6zxbQsk8YtAWoGtTVCEJA
         F84mXOaqa8TaqqPHwN0LTxgWRerVsY/OEqagg5WI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1hfrNG3apE-00zpq7; Thu, 12
 Dec 2019 20:47:42 +0100
Date:   Thu, 12 Dec 2019 20:47:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     panzercheg <panzercheg@gmail.com>,
        panzercheg via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom
 storage location by configuration variable lfs.storage, but when "git p4"
 interacts with GitLFS pointers, it always used the hardcoded default that
 is the .git/lfs/ directory, without paying attention to the configuration.
In-Reply-To: <xmqq8snipxec.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912122046400.46@tvgsbejvaqbjf.bet>
References: <pull.483.git.1575466209.gitgitgadget@gmail.com> <pull.483.v2.git.1575901722.gitgitgadget@gmail.com> <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com> <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1912101317340.31080@tvgsbejvaqbjf.bet> <xmqq8snipxec.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hMk7vi3lx8c+ec+Ga2uHLIyXVIc7hjlUnIAsnxAPxCYfdeRdZXw
 upc41xwzaG3E0C5XL+vwXGzLaVDoRu1v4Ccy/IGRcm4hM4tvh5VLA/RrusUydwTQFCisYzR
 UZILuCoSGaRUFJ3BiX3Y7Tbuw3Vp/LPDkhTkNpHMaR5mlYPnW+P0+dd6qn1KGV6mio4/sCY
 urd2aXnkDlPrh8+n6+dIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M8SmL9WZmj4=:IO1MNQF6IfQg06HKqVVIDl
 iTUTtI76DlFdxzj0xgWZJS+uAxoa8/s0WBdxuWedhbXciGtAZtt7TvgmpUb18+shf7NbRhwJB
 QBqis2sI5dptxo2pTnLnVKGTQ2MM+Vgx6U4hkvrkrKZ0ImYgv2zZM3nGVB3NnUOyzIda7Mrna
 ieVJoXuqtyMOP2zIchFi0n1oUkf8w1ickoCdxDlh6bbREXgIHYG0YO973YEKVCKAN9Nt5QriH
 0StRvKSWAIRYZoQ+D/1CKl0FE3wxJxiXEH3wDgQYTuVBw6gdscBYSm89pXppiYzIxRnMQayHN
 PbYzXhETpQxsvpKSrPKoJuYj7QApJOeGHeF1kRQ97P3xHUQQeynGHhekEKTGeUUDKKn2WY8MD
 nnq5vmJHf8ACRsF67yLeN3ADvheQKKoxEKzIMmLfsTB/x9puTKaDFudUwHyZUlWVofM1Q7smA
 9kSopH4UjNCHBN+oNdoni0QyVwRVRfLns2L/WvJQYUhVHfvxYIR63c+mOuKh2fYZjFETx/cZ0
 mV4JmVufKGzQV/OzSn38Ij9Yh0JeYxNmxiEF3As7u0sqJcuO9eJrFk8LVTmjHikJzXjkSfWNY
 DMs69rQMMyQKAkxZypHJ7AeuvoNncw+zozs1ST2zjmFKT8E894sHgxWytsk5CMuMMTuKzEWfH
 KMfo0h7Avw4TbPpCw69nRYkW7w+wbDibXyzSr7FnmRJ0n0XTzw6Eay6+rTPFMY4Qr/8u+H6Hg
 66D876RiHbvKfKhc0Y+E7sPmpYaO1BkT5EDRVRrn83zN7Nw3Mw7eQZnu3g79bUzXtFsvBPujL
 uBsf6zW07zJNUEjpgOaaXzMB6aGz8thbg1bRtsyaGmZpbvzyzx0+g/1NIFj043mxRxOWVnpxh
 /gklJ4YCE79i5D337QvE4DO6tNLpAxFTAQGe9qh1XXjx3N+coUR6y5nn6Uu2b23Uo8lXmRSvF
 1ciIRa5tiTtyvzx1QdBompZAFYbYa7FdSJQtnCXt8Wt/LarGo+VgW3tOp06KYpCGgeVvsn6zC
 cuV87voGXlSXj5l7tFaXI9Ofe6lYym09Fa1lXhUUBqFEVnjibxqsQaQ+bVB9qkxY0qyAXMlNk
 Jdkwzv0oIfnBlkiYEUlRSxI8RgQ7auZtSmzZbfanWnCJETPiVVBZ8wyLNGXBtkuHFpOttpsDn
 qRKsjPKpNiyKUw2rq9PNHPjGsY8dV9/EUO+mCHFwU5d98GBga3oLZBvu7JwlGiktm3+U0NyT7
 ncAw7t/a+L3Ucjpu6bUAL0+D+KaSYijMxOBeSTCWazhm39Rp0/CHEWl7vqls=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 9 Dec 2019, Junio C Hamano wrote:
> >
> >> "panzercheg via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> >Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the cu=
stom storage location by configuration variable lfs.storage, but when "git=
 p4" interacts with GitLFS pointers, it always used the hardcoded default =
that is the .git/lfs/ directory, without paying attention to the configura=
tion.
> >>
> >> Oops, what happened here?
> >>
> >> I wonder/I wish if GGG can be a bit more helpful when seeing a
> >> commit that looks "strange".
> >
> > There is already a ticket about that:
> > https://github.com/gitgitgadget/gitgitgadget/issues/120
> >
> > All it requires is a contributor with a little time :-)
> >
> >> > From: panzercheg <panzercheg@gmail.com>
> >> >
> >> > Use the value configured in lfs.storage, if exists, as all the
> >> > "git" operations do, for consistency.
> >> >
> >> > Signed-off-by: r.burenkov <panzercheg@gmail.com>
> >>
> >> Please make sure that the name/email as the author matches whom you
> >> sign-off the patch as.
> >
> > This, too, should be addressed as part of above-mentioned ticket.
>
> Tooling improvement is fine, but let's not sink too much time on
> tangents and steal time from *this* patch.

I fully agree.

> Would the following version (which I munged by hand) be close enough
> to what the author would have sent out in the ideal world?  If so,
> let's queue it.

I obviously cannot speak for r.burenkov, but from my point of view, the
below patch is very much the intended outcome.

Thanks,
Dscho

>
> -- >8 --
> Subject: git-p4: honor lfs.storage configuration variable
> From: r.burenkov <panzercheg@gmail.com>
>
> "git lfs" allows users to specify the custom storage location by the
> configuration variable `lfs.storage`, but when "git p4" interacts with
> GitLFS pointers, it always uses the hardcoded default that is the
> `.git/lfs/` directory, without paying attention to the configuration.
>
> Use the value configured in `lfs.storage`, if exists, as all the
> "git" operations do, for consistency.
>
> Signed-off-by: r.burenkov <panzercheg@gmail.com>
> ---
>  git-p4.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..0b3a07cb31 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1257,9 +1257,15 @@ def generatePointer(self, contentFile):
>              pointerFile =3D re.sub(r'Git LFS pointer for.*\n\n', '', po=
interFile)
>
>          oid =3D re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE)=
.group(1)
> +        # if someone use external lfs.storage ( not in local repo git )
> +        lfs_path =3D gitConfig('lfs.storage')
> +        if not lfs_path:
> +            lfs_path =3D 'lfs'
> +        if not os.path.isabs(lfs_path):
> +            lfs_path =3D os.path.join(os.getcwd(), '.git', lfs_path)
>          localLargeFile =3D os.path.join(
> -            os.getcwd(),
> -            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
> +            lfs_path,
> +            'objects', oid[:2], oid[2:4],
>              oid,
>          )
>          # LFS Spec states that pointer files should not have the execut=
able bit set.
> --
> gitgitgadget
>
