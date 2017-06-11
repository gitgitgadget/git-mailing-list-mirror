Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D280F20282
	for <e@80x24.org>; Sun, 11 Jun 2017 17:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdFKRhV (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 13:37:21 -0400
Received: from mout.web.de ([212.227.17.11]:61768 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdFKRhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 13:37:20 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6LH-1dFxmy2jlD-005FhR; Sun, 11
 Jun 2017 19:36:51 +0200
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
Date:   Sun, 11 Jun 2017 19:36:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KlAMPhRpt9IPv0BqQVsIBU8oV3nXhaZW1fq6vLzbc4a39iGLi9V
 2IPcXEELEAoNGJiQOp8tKSBGqwWBDhRK7mJYqYKLeaGuR/Ae6NKxeOn4dScyzKyHpOpDb+S
 wF1PhZY2wzF1Z2zZ/fKIKOm/Zvgh/+KIQO4QVGUMZt6e/MOiCCEbkwludp5hHpaCJ0s39uw
 sHGppa6Vh5MTF50sEDZSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0nIlYm3+NHs=:gGRZxAWNtToILB957o8hrm
 EtkhMGYTuS+kWJMjVvjdDY2bCXO3XYOihWDuNNC7OG0ldp+zm4Zyr4hr2N4QTfCoZXwRPYtHS
 ym8y3Iprz/KbeRLdkmdJNH4m2baZL/4n9VVosBDy1w1Z+wyko+y1cOjqm1g06zMioWKE/b64/
 qFqGLx3NTtWimQb3/j9QCLORTpSsvGzYPyVj0XNKXYc+qRqYSDjyZI2X+72+L2J2qncmXKkQ8
 KQ11D6+/Ue0UdAZGt4aNQfngzqoQMau2p/aXQl/0ZuFS2pGzEqHqVc7P7s1yq/MXWGphdnevK
 ZEWq9aJSLcpbtUSrFmCRz52RTgVkoKwNeqhGui0zBVdOt1cPfzcWPJrkVQBmv5Krs4KtXPk0I
 zeF4y5shoTlgiAcl4T/tL2dU+PkZdMeKS8Qdn7S0wRhO9gdLD992G0bjUZ3GZ9j6ySvfUdJNd
 FMIqdhxQ6bmjtsD9MNWGQ32nw46xJ4u445MY/IwGssS3trrjIbmDRFdexc2+s7RxMOosfTrDG
 0uvpzA9QGS4sc6+J12StmG5ZCBALV/7g1RB9qGWqRWhxOiChP+q6j8YFKOHSeUHS8sB+R1cGh
 bNIQxFUqmUqPEOl78I1FxwKIJuwm1O51XFFM+aC1Qmm/KnGFsS0HIGEmMjvuzVsSXNGEM82Ss
 Oz52txyIjp2G1HhRVCB2ZIx6g6qT1oQObURInLr8UKOQrp75e1moW3yBuz5dMqVTBNiDaHf87
 81iRERnGs4VPrNV8txzXer7zuSxURTKWuE8HSAtfIy7q63klrjbJ85M/i5S0DY/jUbmlRK51Y
 C1qrcur
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.2017 um 10:17 schrieb Jeff King:
> On Sat, Jun 03, 2017 at 12:40:34PM +0200, René Scharfe wrote:
>> Duplicates strbuf_expand to a certain extent, but not too badly, I
>> think.  Leaves the door open for letting strftime handle the local
>> case.
> 
> I guess you'd plan to do that like this in the caller:
> 
>    if (date->local)
> 	tz_name = NULL;
>    else
> 	tz_name = "";
> 
> and then your strftime() doesn't do any %z expansion when tz_name is
> NULL.

Yes, or you could look up a time zone name somewhere else -- except we
don't have a way to do that, at least for now.

> I was thinking that we would need to have it take the actual time_t, and
> then it would be able to do the tzset/localtime dance itself. But since
> I don't think we're planning to do that (if anything we'd just handle
> the normal localtime() case), the complication it would add to the
> interface isn't worth it.

A caller that really needs to do that can, and pass the result as a
string.  Not pretty, but at least it's a possibility.

René
