Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8451F461
	for <e@80x24.org>; Mon, 13 May 2019 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfEMKXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 06:23:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:35131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfEMKXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 06:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557743026;
        bh=+RFnKrcr6GTVWGlBEXvQgFzfAs2KQi6y4otx+1AAzmQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eSZXWwTyZg5mbBMlV0+Ya1Bof0VV9liPDeedhy7TMcXtGwGzHe+gZdarMUN2jdl8a
         xfVbbD77dKuHmCWZ9ADuW/OiydqUprZVUCTVKZgIVlnSy6ANn8gUtZG6hoAInB+Eqn
         XJJ6fJsQBXXNz/axpXSzDXycyC4+tUsD/4CnLvho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwt0-1gw4Y42bXm-00nDZn; Mon, 13
 May 2019 12:23:46 +0200
Date:   Mon, 13 May 2019 12:23:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
In-Reply-To: <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet>
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com> <20190510205335.19968-6-newren@gmail.com> <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4> <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qZN1YqCHGFn1T2c76XGJ4noGAyS0s0JskbaxHWMc3hO1nX9mvKH
 unI8HPA4+aTNtKoaYh9YwTbGFeFfdY0SPJmntgJWMLtUvEZdzY+YyK7R0PB6xCsiDpp/v2q
 fSgivz0rHTfTv5Hp1+AIsm5Tj1/L/LPnPMyxIihaDoKK2ceHfgFHXY0VEhgV6E2ec9w8Ma5
 +IatXDF/7fghnetpLZabg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ccVJxZpqjiE=:06iMOuuoDOmpslS8C45MQF
 Mcc85ZUF99BKVi16UU5p2WU3ewYcGD9AXVcg/iii02hL/jbLNzVjKZ/NIpo1FCMhQb5SFb7bI
 gqQUv8VldZJ5jrLq0OnHpDML6Oyq2XBH3xgjZQ7gc41lLR/SIh4gLDOqtaRskxegQgrJIrMfd
 TuVDx9+0Aefh2rHpo00j60UGBkNaOzX10RbbDR43gOnnuoj8aNulQ5xvQhlNnxYA7n0thMJU2
 JzwJmkzM2vn5OPHP659zEU72pupFKWDCsdkyaejoVDgkLEJQyU+B6py58Gt/m8H49pVzpHxS7
 t5dlyBWAUFFe9fvK0iYJNM+gwbtVNrDTsog+horULUhY1k8CxIEaHKuwEyeRGHDk/Z7BiJbmS
 MZ6xiY03mdCYHOgxePfR7OSl9Wm2X//pPg83BiE1mznfBAyJUiiFjc83XxLB20oKKNtv/judT
 4fVmpQbeQPpa2sahhYJmetxQqNHhVQ6piT7K5bJk8pIOssF6/eyBQApY36DfIVyrI7fLv6xrh
 tnie8Xb1pacJL6Umj6u8lKcXEnW+O35Gh7XELGY33dL8TXSZJjOQWYkrTFdFO5kKEA4VdvAqz
 LCxVi5fF88VLv/bptEnKHHWT83YiDzSzwFqsm2hrqANnuyzrNN3bph1Q80F35iZwoX9PjCN3Y
 Ylu/VnGvzmmhNp1CKVjrBB+QT03IqcqeaqPAoCVSpziSSSdHK4d+zfhPAuacuu1gu5GaEhbIZ
 OSx1FOED+U2tzuDD+8Iqsply1l20sP/e94erwXfAz5Puzmj15MACegg3C/1fHrshrgYP3yzRv
 2pYYhGD9IaxooE53gNy1/PE7qTfmmEEyXQBUTsvY6YaCSBrDc1JRm6PDKE2w88BuIg5wcYrbb
 dYJ05v4l3gRaqa7hNRjTLvsDimcIUISHAita6DiN/9CKlZJ/UQ1lAsOFCK/BfrQrYkjSP98vg
 ZMNC+yAmXBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 11 May 2019, Elijah Newren wrote:

> [...] the craziness is based on how Windows behaves; it seems insane to
> me that Windows decides to munge user data (in the form of the command
> line provided), so much so that it makes me wonder if I really
> understood Hannes' and Dscho's explanations of what it is doing.

It is not the user data that is munged by *Windows*, but by *Git for
Windows*. The user data on Windows is encoded in UTF-16 (or some slight
variant thereof). Git *cannot* handle UTF-16. Git's test suite *cannot*
handle UTF-16. So we convert. That's all there is to it.

Ciao,
Dscho

P.S.: Of course it is not *all* there is to it. There is also a current
code page which depends on the current user's current locale. We can
definitely not rely on that, as Git has no idea about this and would quite
positively produce incorrect output because of it. So we really just use
the `*W()` functions of the Win32 API (i.e. the ones accepting wide
Unicode characters and strings, i.e. UTF-16). I don't think we can do
better than that.
