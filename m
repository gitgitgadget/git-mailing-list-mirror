Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334DD2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdHGVKq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:10:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:50727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdHGVKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:10:45 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqzIJ-1dAhDA2SkF-00eYyL; Mon, 07
 Aug 2017 23:10:39 +0200
Date:   Mon, 7 Aug 2017 23:10:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
In-Reply-To: <xmqqshh3p3b0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708072307410.4271@virtualbox>
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause> <xmqq1sonql76.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1708072136290.4271@virtualbox> <xmqqshh3p3b0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:REZ/g782EmKLSAQP+pHiv9egzazRd7MOd2WlmD/vhbTtlhFi/vU
 +JjSuFzv4lzihPvVsTGtBXMzYwKqbX6ki9EMO145KUIpXBhydobW8pERWQeRJFosIZDFqF3
 R9a44zjCum/ItPJJ1ye0ESpmV67DdeU5VkjfniaXQrL8QiYTqOSw9Ji02g4QDz2gKmr7MEJ
 NRnTiQqaAEjuBQGgoa6Ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7AlFsr8tQI8=:+xqxgOb7k+z7nWUe/5C72E
 RpdStXuLvtIXsTffmfkA2VBVyU2YnU8O3IPoUtG57ivJ831Fv90JQ/4iRrrE+VL1c2ljPcYwX
 jWvdFNUompfD9evybWzNyHJsRGqxv9C0cYDMA/6i2VPwLdQDciwVby1uMqUHtkk2mLFeezTGG
 ui6UqMZnTMxFTyD5/f6r/CnGoA92TqMM82w0Q3N8pn467hhOnSoyVeSb/iu8I+9sDJGtpgUeC
 KpRLO9QW+ppVUrEqUJgjrWl4NVmUTM974SDUex/Nf94ms64FcFZ2WX+mDcdRrpEmcjGaA04dU
 XBD2tZuVVrhSHeiu6ebXpxqAJoFSehek6ZNZ5+dNGX5wnGIn8IZVvnzSW/X6WmfWxBjARslDH
 EiPsxyXWofa2X575kOMARf7ekEiB+eAUroc0g7DL429gf/S7a8KR7dcGGBRVqk3AnOxn2eVZi
 KR5+9+lSMf2QJNUW1VN2trQdNDiiN3NJgUvJ4LQJY6Z6Ws2WZwsVdgVAt7zJCa1k8wx8w46dB
 chxNDHfiVsObAZIM+QFXhZ/O85miwCIXOqFgJnvlF2FrDe3y1vMW05kxfsyYA98tpuvLDdw1M
 49U53lg+ldSBPhNPGtuShLihbBdS02uY20TMSSG37RAJ/OU1nxBYck1NwFhufh1T7uS8S0Z0s
 g4RsQv7sAjE8H4Dlyp5aqkNFikzVV+nbfgOC3drvEf9AYohZCdSH+5I56ayJNKGoasz9ezWCK
 Y+wRm0ii8tPSwas4Wx1Br9MqGjjB82XoVCdWHDSPqdHzcyJNdpemVtDV7bDQ0JL2B4NuIoO33
 BHchhNZvL4VcymT4y4nygEMbhvuQ1KwtD0ZxLGQQxUeDuDa9JQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Aug 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The patch obviously makes the code better and self consistent in
> >> that "struct delta_index" has src_size as ulong, and this function
> >> takes trg_size as ulong, and it was plain wrong for the code to
> >> assume that "i", which is uint, can receive it safely.
> >> 
> >> In the longer term we might want to move to size_t or even
> >> uintmax_t, as the ulong on a platform may not be long enough in
> >> order to express the largest file size the platform can have, but
> >> this patch (1) is good even without such a change, and (2) gives a
> >> good foundation to build on if we want such a change on top.
> >> 
> >> Thanks.  Will queue.
> >
> > This is sad. There is no "may not be long enough". We already know a
> > platform where unsigned long is not long enough, don't we? Why leave this
> > patch in this intermediate state?
> 
> This is a good foundation to build on, and I never said no further
> update on top of this patch is desired.  Look for "(2)" in what you
> quoted.

So are you saying that starting with v2.14.0, you accept patches into `pu`
for which you would previously have required multiple iterations before
even considering it for `pu`?

Frankly, I am a bit surprised that this obvious change from `unsigned
long` to `size_t` is not required in this case before queuing, but if the
rules have changed to lower the bar for patch submissions, I am all for
it. I always felt that we are wasting contributors' time a little too
freely and too deliberately.

Ciao,
Dscho
