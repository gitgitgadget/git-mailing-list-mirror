Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D7D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbeKFH05 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 02:26:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:43913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387441AbeKFH05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 02:26:57 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1fh68R0PUC-00nkv9; Mon, 05
 Nov 2018 23:05:03 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1fh68R0PUC-00nkv9; Mon, 05
 Nov 2018 23:05:03 +0100
Date:   Mon, 5 Nov 2018 23:05:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, shoelzer@gmail.com,
        gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around
 issues
In-Reply-To: <8b22754b-89ec-ae04-c839-83810f93872f@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1811052304420.86@tvgsbejvaqbjf.bet>
References: <pull.64.git.gitgitgadget@gmail.com> <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com> <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org> <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org> <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com> <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org> <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
 <8b22754b-89ec-ae04-c839-83810f93872f@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fYjQVBYLRvc39F1ut8bKKGK175I/ZZJtqQPyjphWlRyurJxWYVI
 PrKIl7EQQAkXA/qGDT8FB1l5N2AUNEsADTgA1l1cozbPv9SkCOkznYaRyeuqgXeyDW0GE3F
 s1BYGVITNQO9q8xYjbv+NY9CWV8vxQ9HMTzq3hAYfB6ifIiISycS66Rnmv0x1Zn/qy2v9qF
 LnL033vw4jIjDuQXm81Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s0YGueXXDh0=:yTSli8waWAFCJoOp9CMvzB
 PCjix4NG0PyyJPUunik3E1XY1Ibs5VqArjVNKadVBZ2UFQMAzTVtAVwVrf6ZWf+2NzYYI1LCo
 rE4WQmaaWA5+uIINazP6jYpbSt4LFpH2dcZ2x/TdsiEjM7qqykcUqmOq5nuEABIEvJ0/eRj+g
 /6VFCXUttzNCgMXn20z0VR33IywO6xsQowqxHF0acEsQ7u/Fw+iyW0V5T9eWs0jERyTSajs+h
 HgMDrsxZ55WLrPhm1iwV/4XuJnxsbWQx/5PIkNVLhi504oppJHT5RAd/AUfnRZR5zwV85Vu8o
 WCYLSrJTsqW8jK9RXb9XFMwohFuQ0rFbB6w/m8gk88fxm2J8sdhloVBcKCWDY5IG6hCQ7v0cX
 ms6KuPEAUHOvo338QElpwg62Q7evlOosKsTjBBEcCnwsc/U05OMlSFhumPY/l1Dvs/9mnAwu7
 YC9Eg96pF/HRx+xFVTZWTRTN9qk04huYhkvJoVXhTifYycheNkpjiUt6qECz6JLZ9xDh41rJg
 +/ydAha7zMt9yXJX2cVqnCmyk3ZnlpdHzAufk718TSjgMooywpggncBhVuXgAJqRUAQgXUASM
 PW67/gNn5BcXJ4TI7dgXd9ahP3MLjB6k4P0ugj9BDlJuU7AeiYw6ZL1/+VRK1oLUUvJagPsrz
 9nctk2EyQ2SCtzzxhdY3wW94dwWqAHeJ9ojgmfTpUJipW/8kHhZEg3vVlcrI8AO5sZJrTtVgK
 w5Vyz4TNutg++012SWeelkA7chIv5VGWwg/MiiSuQ6Z614AXhjwJOm8IyI7Mq+AHD5smmKbZK
 AC4ja1fEsjF1V1vQQv1ZPQC7aL9wpuca7DkPKld/imPgOM2W0cmMw19Yqug4D1CoWK3ZNbVod
 YN+x2KZb6Qay2M20GSE1t+7lDkuq/3LgWXJpcUgo3MSdAKBg1y4eEBG6E7G24/hpJC4j3XAyY
 qTls7B5d/NQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 5 Nov 2018, Johannes Sixt wrote:

> Am 05.11.18 um 00:26 schrieb Junio C Hamano:
> > OK, thanks.  It seems that the relative silence after this message is
> > a sign that the resulting patch after squashing is what everybody is
> > happey with?
> 
> I'm not 100% happy. I'll resend a squashed patch, but it has to wait as
> I have to catch a train now.

Thank you for running with this.

Ciao,
Dscho
