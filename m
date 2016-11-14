Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,WEIRD_QUOTING
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0311F858
	for <e@80x24.org>; Mon, 14 Nov 2016 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbcKNQCV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 14 Nov 2016 11:02:21 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:56767 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932447AbcKNQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 11:02:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 350B710005F;
        Mon, 14 Nov 2016 16:02:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VW8n63TsXQiL; Mon, 14 Nov 2016 16:02:16 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 1C5E28002E;
        Mon, 14 Nov 2016 16:02:16 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 14 Nov 2016 16:02:15 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 14 Nov 2016 16:02:15 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: RE: [PATCH v2] upload-pack: Optionally allow fetching any sha1
Thread-Topic: [PATCH v2] upload-pack: Optionally allow fetching any sha1
Thread-Index: AQHSPUyOEPe5zin2k0ap18cYXXllVaDYpXnw
Date:   Mon, 14 Nov 2016 16:02:15 +0000
Message-ID: <5516d21568954cd5b18f0e56aa6f0ced@exmbdft7.ad.twosigma.com>
References: <1478885028-30357-1-git-send-email-dturner@twosigma.com>
 <xmqqpom0yxyo.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpom0yxyo.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about that -- the first version of this patch noted:

"""This one is on top of yesterday's patch, "remote-curl: don't hang when
a server dies before any output".

That's because I want my test to show that allowanysha1inhead allows a
fetch to succeed where allowreachablesha1inhead would fail.  Prior to
the previous patch, the first fetch's failure would instead be a hang.""""

But I didn't carry over this message to v2.

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Saturday, November 12, 2016 8:23 PM
> To: David Turner
> Cc: git@vger.kernel.org; spearce@spearce.org
> Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching any sha1
> 
> David Turner <dturner@twosigma.com> writes:
> 
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index 43665ab..8d3db40 100755
> 
> It seems that I haven't heard of 43665ab.
> 
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -306,6 +306,28 @@ test_expect_success 'test allowreachablesha1inwant
> with unreachable' '
> >  	test_must_fail git -C test_reachable.git fetch origin "$(git rev-
> parse HEAD)"
> >  '
> 
> Specifically, the above seems to be missing in my tree.
> 
> Perhaps you noticed the lack of test for allowReachableSHA1InWant and
> added one, but forgot to send it out, while building this patch on top?
> 
> > +uploadpack.allowAnySHA1InWant::
> > +	Allow `upload-pack` to accept a fetch request that asks for any
> > +	object at all.
> > +	Defaults to `false`.

