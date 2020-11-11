Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB2C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F72074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P9J7SlcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKKQ2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:28:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:36233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKKQ2i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605112113;
        bh=xRU4HciSvtEa54vlZufkyNc2yN+OOOnd2nYZTcZdYLs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P9J7SlcL5tu8yDe+5n0RYWSgTpv2ujkduqzKnfLDPSM5N59Sh8BxV6RwtDLXodOkA
         r8i4Qb26a0o7SjI8xRoONtZPKH6y+e+t5CqhZ72AbTqBNXX5MJ5ys/QtLs5qKqBo/L
         EOWk9LNkZT65JfJe+d6vh71NBlxUSuUKCvZYnf8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1jwhzy44v0-00qVKQ; Wed, 11
 Nov 2020 17:28:33 +0100
Date:   Wed, 11 Nov 2020 17:28:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jinoh Kang <luke1337@theori.io>
cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] diff: make diff_free_filespec_data accept NULL
In-Reply-To: <01640022-5bda-9712-8228-501374474d5f@theori.io>
Message-ID: <nycvar.QRO.7.76.6.2011111728040.18437@tvgsbejvaqbjf.bet>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io> <xmqq4km4lppy.fsf@gitster.c.googlers.com> <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io> <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io> <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
 <nycvar.QRO.7.76.6.2011101638080.18437@tvgsbejvaqbjf.bet> <01640022-5bda-9712-8228-501374474d5f@theori.io>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RGbjlGF/lqVaNtvUNd1oDMtwsZLlMpFPPt8V7L+kf+t56SUQiFA
 lmbmUlv0iGSCB3mnXAqw0o1qJEScbfFcqS4rUXKuv48a2OCQSebVlIvBlx4EAymDvZwM9Rp
 X9lZVl1jdkWmFqb17wKBrvaXhycsi4PMPaF17MuDLzPD2lxHLzSBRx+MfT54tyYmwkjahS6
 TNp8OvrBlNlc1XLpdqm8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DA4hf3pqoRI=:ecmae9w/ykNKBiMZPF1KVm
 USlte4cEx3EENHCDoxtAxUtDKgqDqz4oE0n11OzCeQkm/wVPxLyS7i/Y1sn6mFn2EW7CEzyR7
 toG1AT7dXLJMiNF3IpsVsvsfCZnQPgXNUTe9x529FnXNj9Pu0LoaMOkr1MCr3SBEatRCEDyfj
 5FF+lGNRI/y5Mm6bKJG7aZkuxVrGGtM7znRooIdWiKCVhLcKCqrnRjJeRsBIZMWdhQkQ5Hu8j
 QExr9234ECB4rTO1BB+ZzsDx9Z9l+mwAgRaqYkno3bKdAn7mrAh/C+ldrjuOWQcKosl/AU1Fh
 fNRgFjw/1Qq3oAgs1m9elOiBgYcd2ajJHtQNUgOEyXUQ+1vl+YOgsZoHzh0Wqz4g9WyLVhYt7
 jqizRoHi8w6JG/b3elF1dBehpa9DIblPYpqFWXtCPXWMvuQ/AUUKTCitw1RNcFyM5jtlYXRQ1
 t2bbOMJVUZpbvbf+ZIPut11vvcgTkXUY5XxjLHJKHrwViUrlVmEzjNaW08y/BHaQcxTvu5DWy
 apGihX48W8LW/lMggWP9ESI3rg5/JbRf7qXT58l34x8vImbhwe55qwEVzt4ZMkfUFx5Fv2QKS
 TgER1W+Koaw9mRr577VXo8pVtbk63IVE7lZqMgyIX/+6AP9OnfFkEtAjU6C1cmAWmHSJI9t2+
 For70EKPdFSodDU7EYX3C0MEBweSwP4xBq/W6qp/lLGBeM7zt6HDiCdi4UlI0Xu2IzZdMLalj
 jRrHOCx0R7m7eMkhyIxpesQMijoWe3ivq0FWk5PlpmRI8QnVS8GM03N4ujhJok0O49ASFl/wo
 Jv+KbyoUNLrjpnf12lnZTpLLLgSWtW3zzwnpAT79fA0vvZtYZ2iIRG92KeNEEt/COj6i/gym+
 1kabZOh5xpOcGyAeQPXovmT3FgH6UB++EBwYlEMsY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jinoh,

On Wed, 11 Nov 2020, Jinoh Kang wrote:

> On 11/10/20 3:38 PM, Johannes Schindelin wrote:
> >
> >> +	git checkout -B conflict-a &&
> >> +	git checkout -B conflict-b &&
> >> +	git checkout conflict-a &&
> >> +	echo conflict-a >>file &&
> >> +	git add file &&
> >> +	git commit -m conflict-a &&
> >> +	git checkout conflict-b &&
> >> +	echo conflict-b >>file &&
> >> +	git add file &&
> >> +	git commit -m conflict-b &&
> >> +	git checkout master &&
> >> +	git merge conflict-a &&
> >> +	test_must_fail git merge conflict-b &&
> >> +	: >expect &&
> >> +	git difftool --cached --no-prompt >actual &&
> >> +	test_cmp expect actual
> >
> > Shouldn't this use the `test_must_be_empty` function instead?
> >
> > How about writing the test case this way:
> >
> > test_expect_success 'difftool --cached with unmerged files' '
> > 	test_when_finished git reset --hard &&
> >
> > 	test_commit conflicting &&
> > 	test_commit conflict-a a conflicting.t &&
> > 	git reset --hard conflicting &&
> > 	test_commit conflict-b b conflicting.t &&
> > 	test_must_fail git merge conflict-a &&
> >
> > 	git difftool --cached --no-prompt >out &&
> > 	test_must_be_empty out
> > '
>
> The original test code was copied from the "difftool --dir-diff with
> unmerged files" case above.
>
> It might be worth cleaning it up too, but let's leave it for another
> time.

Indeed. #leftoverbits

Thanks,
Dscho
