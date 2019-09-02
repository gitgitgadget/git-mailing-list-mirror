Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7AAF1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 14:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfIBOrZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 10:47:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:49667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfIBOrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 10:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567435634;
        bh=RbT+5S4Sk7oJXDoYsDE4rEPv7lEWbaOyBIk5xVfXSHE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tx2VXFoyWUevwSOEISNfcbns80khBCJOkO0cT8mTdG/6yRADhAygkS0xdw7FRi/J8
         hLAVJ6s4bKiLZ7hxLV2ca0eD82mDbrfqyp2T5QpsB/XtgXgsvTh1Yx2DSgOElNFEz8
         80L1kiUcJ36NdSWJGTtRszZ798WLX+BPfAWi+5rc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1hzHp00MSK-00EKqi; Mon, 02
 Sep 2019 16:47:14 +0200
Date:   Mon, 2 Sep 2019 16:47:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/4] t6006: simplify and optimize empty message test
In-Reply-To: <20190830055707.7785-2-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909021645460.46@tvgsbejvaqbjf.bet>
References: <20190829000657.26415-1-newren@gmail.com> <20190830055707.7785-1-newren@gmail.com> <20190830055707.7785-2-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q9YLF4clpNZ+KkcO+gycTsamF5SkEFreM6wDfoK6mTrmVW1L5li
 /6DdCMZlQRUdi5S9PSJtZfuqsjqapb6ZvaRxjeuEdaqeFL/G8pOYx4AwKqEETPUHHdkgG7P
 8RaZZBer6+F8/ZWMNp858/CkEZMlMUwrYk/pWeXXz5XZOjaJeMS10FLI97T6xBFxi0VN1aN
 537zUB6IXdbbC1ZYF60Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XaI9X7/3zAk=:5j3/U2CMSxqDu1YRikDV6b
 XhpwWxHBxUBr+1EE9CikewYGIUMbpmkNSYXrJ+2jQkEbE34Yk11t1pHie3DkjWZ8wEMz+Wyw0
 vQLFkG3ngJuYK9IDi3r43Q6Slr3wEYWV0sMbKaigdEMniQ1j30rTt6Q4N3yMI09Ud5Arwwqjf
 vWLQV4cm7804dxvLcpjfAmWeBUnetD4oH8wLHqhFsXibaNPHEhjfgZ3GYNBp0kJLkXs9BOyTJ
 hNc9ikmJQEOxAV25LkVSMSBN00KbWO8ZjR7hXYd2O40el/ynrMC1bWNA+3TcmHPZjdnS/Ewil
 to2d26jdpz9iQU7dmScWhSouSbKoCx05f8lKFD+FvoGLD8iTPWZOPzw2SZwZqRsi4CH8uwy3P
 W6abxKHiMCTRGT6mM6SfrLXddTiFIPapZpc/yqhBBM9p2yThb8ePZoDM9F2dw6GOZ7IBl5ebD
 6e4QuIssYjHvLonyE7/P/vlPmoTODx73TOFNpClL16+rPEFSuV3kC9LeOZiTrikGPzTHYAtz2
 1AKy72TpilxkYtWr9MrESFHqUQfKsDEf4YyVXENaCFpk9EhEgCgx6MaX8CiYdhFbEhEljC6IF
 YVt05k7nqAf49Ph5ZlxT7UxpZFTJigaKeqInJqkEcwS/dzvXXLbGwnDSBdBnkcXYUbzbLJ9O9
 yAdQqe79M9i4mUHbSd1hWb8q17W+CxzvLeZcb2EioTHcDbkuF7GuMCxRNvfsfPVFtSNv8oma5
 RFgMxR47gXgTZhXFxzn4wl3zwVuQomxBetNOTJ5kqz40BhOguVrGw0E1qXb6O8oqffgCi65no
 s6Y1RwSL4q54JSU+B0uhU9Er6q+VKcRByj/2U2LB3ai6XSNUqXFeqoUaWyRLiHJFyhixJJJw1
 Yo7Ap6rUKSyGTmNYpO070ovn9KXmYFOwp7pPFzXUGl5+CcybPEc+uSt1uOBY1zB70MSwtWVNl
 MQ2ssK9QzxHe3z/EjBWS/F1B8vL+ik6u6TvD2dLD0RnIFxkjdIbGUS/0wrXVHpe7cvli/XoAn
 m16B6+EOVp0wW2yGNr3k4st5WWzod+EC2/xMqceQPZTpv4S3+hxeY/uz3F2fBV52uWX08oFv4
 719o53JkLIPnqgPS4+8wL5GZhyH/NFfOD1EUg1kOF9Q9tpzBXqv43FQ7+Cocfy5kEnSETKg+B
 3FQpXoMZLETXCod869UhY2Wp7ONukJeyi0UuZ2rsu2027UuL65Hc7s62l/MZ5qPD1CHHQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 29 Aug 2019, Elijah Newren wrote:

> Despite only being one piece of the 71st test and there being 73 tests
> overall, this small change to just this one test speeds up the overall
> execution time of t6006 (as measured by the best of 3 runs of `time
> ./t6006-rev-list-format.sh`) by about 11% on Linux and by 13% on
> Mac.

A similar effect can be observed on my Windows laptop: from 25s to 21s,
i.e. ~15%.

Thanks,
Dscho
