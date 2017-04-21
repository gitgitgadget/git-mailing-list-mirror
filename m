Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6CB207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 04:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbdDUESa (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 00:18:30 -0400
Received: from mout.web.de ([212.227.15.4]:49811 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbdDUES2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 00:18:28 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMEyj-1cvfFe4ATF-0083wo; Fri, 21
 Apr 2017 06:18:04 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
 <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
 <7d075a07-edc9-83eb-25cf-7f8b13700584@web.de>
 <a718ca38-4c07-9f3d-e7f5-9efd7ef59007@web.de>
 <0882e8f6-f9e2-20c2-4e94-3fa8a50097c9@web.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <62e3185b-3cbb-f0b4-47be-f4093bfb9a6a@web.de>
Date:   Fri, 21 Apr 2017 06:18:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0882e8f6-f9e2-20c2-4e94-3fa8a50097c9@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:mcG705bugXX8cMury/PpgXURwwMWuOJvr+7PtPtVhvJYoPsFY9I
 v6ncjluFYHygxeLnYM6CqttNIHo/V80RtM2MrjuCmbvoX8Zc6HZ4HuvGfoaj24C/E3lmccP
 dYea/NJlV9VNmSMWO3ZobYFO4Zgv3GTHH1Epvej9gzWlC0aUoZxLdFQiL4+x2ZlM4qJPC0n
 /IwHKIJHi0Ar/zNUTZ+Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:seBSakmHUAw=:96/q0YrTNTJdKVaaHreILm
 bIdbYN7v1m2z8hzBoE3G6AjE+EGsXV0UJW1IpokTvvKAlnLz2lqFKUCWMgDn2vmDulI7LXKCQ
 1OnjLFJjJEUnPV21aGAJe/yvQzvvGSmMoUm82uINjq7HYJ6GJb2HBwIsibaUxyvsvlF2prH+E
 FWOYn83cCba1Bpk5sUrISLfa0bTfaJDfcYocjeCuzAyt236rWa2qUPmMjg/em/iRPqTlOpO3z
 jpN3nA2cKn+lSg7VXciaBtS6CVQJvMekQspXTp9PedsgGeu6hdZplHhsDOgm2BLHLhBkh+wII
 sy4HHKCKHm1M8xvLQeyZek8NbMwuRzsIfEHJILXyHRvm4sicM4W8GdWnfLuEl+TW+Lu04979C
 6GQqEHfZYKW1nyZkOxBIgAqNKuFEJpfcJ62Y5amzhAAIxtd4Mv4W0tef4yHAnBkWcxp/XfuRj
 7sbfQ5negizPKhHmQ5HEsgVEl3ZVeRHEkNJ/RsyqO/KGExjKG9xkoS0S7BN1cHk6ZzXdS0WSj
 O5FuSkZMk5PhPJohnQZMiMl5I2yNTadMFfqu/71z7uKwvfoLeQee0uC2IIHqLn/z9aGh/Ttfl
 0fvQmJ+lF1g0rE5GGrAE8wxzEou9pKffl1NdiHhkVEENoUwGyDIJG0NwwF7yuOfICuhCM1gL8
 wSja30d2jYk2t8qLeD2yZHie6a8vNTg55UYCCQGX2PNmaH+OfB+Mj9kozLomQAdYj3444NSAp
 I1VGFA6ceu2fzgOV422vwEDxmHaHYwACdVTssA9dum5iMqCDHzdaY3hZ8i7UGgBzDdtGURMrQ
 LNJeIDF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I think I meant to write "big pidfiles" there.
>
> With xsize_t() gc would die when seeing a pidfile whose size doesn't fit into
> size_t.  The version I sent just ignores such files.  However, it would choke
> on slightly smaller files that happen to not fit into memory.  And no
> reasonable pidfile can be big enough to trigger any of that, so dying on
> conversion error wouldn't really be a problem.  Is that what you meant?  It
> makes sense, in any case.

In short: Yes.

>
> Thanks,
> René
