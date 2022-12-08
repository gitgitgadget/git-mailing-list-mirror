Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A99C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLHMKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLHMKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 07:10:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A458880EA
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670501406; bh=FBm+79w/Z5mZ1ALyYRSoHbi9Ht+agdh5QDfyd4MfFIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=sLLXLUIeVlIxC6Z6owSz6yiQRwMJnnSPtvMbF4JcyiDCcwK/b5cwsLt+GNelmxBDo
         FMMR58eHAVKNmx43a9vib30EwMyq83qXTxnH4dslMg7Eg5aYYW964S59UgA8cyl64y
         ui63FP0u7pMnTSwNWuRW0BxHxARYWAwcs7A7Y2OKZiFQUo58ZOdIZ0TtgSSJm5A+wL
         LAtoM7F555zF4uG/MZocJ/iaukETls9qtHfwmMzWUzLh5VfuKNg5jzIzV88eqw4ozX
         /imTrKkZf3tKYn2ZGGNd7NcQj4om8gW5mkz2PPTnFREYnGsG1jh9jgz2BWyKd0UX56
         wK20NawTE6HiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([46.114.106.61]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1pTtYz14kt-00RGpW; Thu, 08
 Dec 2022 13:10:06 +0100
Date:   Thu, 8 Dec 2022 13:10:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/3] fix t1509-root-work-tree failure
In-Reply-To: <CAPig+cT6z5kzM8suwqxJ0wrzHjnj9ChROVBiQO3AR1rJ11pkNw@mail.gmail.com>
Message-ID: <96178n12-4255-q093-qo51-r37n5o569s6p@tzk.qr>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com> <CAPig+cT6z5kzM8suwqxJ0wrzHjnj9ChROVBiQO3AR1rJ11pkNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1ZdZTO52jWBYTPxW/QB5/KRSQ14cuA2FdZK7nxDXXGj26pHwPhh
 4Go+JbXR6zi8gAJ9Ck+7o+SPfP3bP/vM+SJLG5/IybRNqz9fkTBzo2ljB2yd0UQeR06ZtKx
 unjL/Bu+zIz129C1vlbksW2t8Qyfh8R+B0alEf3TcdLa3zHge9DTTh6J2tnTds0Hl1Kr0P0
 7W4c9zlSKG6/tmr34+9tA==
UI-OutboundReport: notjunk:1;M01:P0:8DLDndS7I/k=;mJd2AGj1wUs17GLsPUgk/cxVtCq
 3EAV5mSxdOyUHT/TGEfTfSkis+J+52edXQEp5qN948OJMTzJJf4V+GYZy3xvdy4/T1PsFQWxp
 mzeW2ytiMc89N/dDrkRnV/GJ3TTfqX6pr/gtBCTi1UOUJ61YCbDqT4Mh2NzI3ADiGZaXnpqmP
 UL0koF7SGrcujz2Dfg2re0BdCt0wttt8rPhACQSGJGpmpTjLzLjiV9g3PGu1zEkgl8uYjXcxj
 rImAdTZdJize8dvqdDiAHzWQteJvkYN5oFAbwovtTUrwGw3iZevuEoRD7DRCJURrUIp9qsYVb
 j0DoKE5/EvlwAdP6EWIqCOnj3Pijy6TgzvC0dX2p6A8xq7cuQHPgRPPXanpd9+G9OAaUhkXEl
 AmfdfEXNgVyOPSSccQ4XIkSaUrWr9hjX0Y1ozW4J1Yl899PwtZckFAnHJ9Phros0eQAnlv0WS
 81tuGScMBnAE7VBb1jSyXF+HJcMf55bxgr8F6l6wQz1UinUKo3NZvCJd/1Kx6zM4PfwsxfCE3
 TP7iaFKYO+AIrCuDWaFLcyJ0/Is0AdGiRJaJbXGDwZ87nuKmDqX6UO4/2rp4UVai7Y61plX44
 B00oQrM7FVUV936s4D5sp9AYq6UGRXGm9KDVj+hMW4BD4qQQ48ic5Dj2vQUk0gAmgIyIAjn+S
 1sqRs/+sVEFLEDvbRC22kXJDWL9Rizl7N8wNo48vp7o6kloH4AqlCCyopTSDRWeWBlC4Epqt8
 bfljJ4BkgEAqskld7HUN45ZkuRSZrqStvfv7OOn9zIj4W9Yl9PDG3PAE9T3Ynhh4ZG5vR8SWl
 +Jg929gTlfVGh0Efdu3bSpVg5RcA1URgCJP0Efu49P14rCFmS0LjxpNNEfrKU2hiJ6lm9yEOg
 XBpgPDcaH0IifLT+jmRmO/0pMfgnuooSxO/vFZ4IOxedihQ4UKW8nz/sTDQFf6Np44xgHKNRs
 eJOqwyfdd+NRkNbfdH5iDucBu+Q=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 5 Dec 2022, Eric Sunshine wrote:

> On Sun, Nov 20, 2022 at 10:00 PM Eric Sunshine via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The t1509-root-work-tree script started failing earlier this year but =
went
> > unnoticed because the script is rarely run since it requires setting u=
p a
> > chroot environment or a sacrificial virtual machine. This patch series=
 fixes
> > the failure and makes it a bit easier to run the script repeatedly wit=
hout
> > it tripping over itself.
> >
> > Eric Sunshine (3):
> >   t1509: fix failing "root work tree" test due to owner-check
> >   t1509: make "setup" test more robust
> >   t1509: facilitate repeated script invocations
>
> Ping?

Thank you for the ping. I did not have much time for the Git mailing list
as of late (too much Git for Windows stuff going on).

The patch series looks good to me, with or without the `test_atexit`
change I suggested.

Thank you,
Johannes
