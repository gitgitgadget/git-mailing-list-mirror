Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B395220A40
	for <e@80x24.org>; Mon,  4 Dec 2017 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbdLDHZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 02:25:08 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:25990 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdLDHZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 02:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1512372305;
        s=domk; d=cs-software-gmbh.de;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        Content-Language:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
        From:X-RZG-CLASS-ID:X-RZG-AUTH:Accept-Language:Auto-Submitted:Cc:Date:
        From:Message-ID:References:Reply-To:Resent-Cc:Resent-Date:Resent-From:
        Resent-To:Sender:Subject:To:Content-Alternative:Content-Description:
        Content-Disposition:Content-Duration:Content-Features:Content-ID:
        Content-Language:Content-Location:Content-MD5:
        Content-Transfer-Encoding:Content-Type:MIME-Version;
        bh=JBLoVAFPc3KpcYgtA3cEQb+KcTQ9VUu8ZwFf2Fs0Kcs=;
        b=fKvlAzRwGL/oIPewEJwEV3+xqqJJH0p1kQINokScQNnK2vCDvTXLcLo1owfg790/QN
        5KdXgu5VUYoXFud23F9jOY9q0Rjw4sP9CIktvbRo1X/fn+Bzkh9l8nGBbfRMSp45SJg1
        EDMMD6PNsiCEVw0Wwbw/2pOj9K2q14RaZSFu0=
X-RZG-AUTH: :LWABbUmIevNaG8tCOliF7QMk1+ctV4c3xgfkpNE0NajOhmQxl91LCNFTJgA=
X-RZG-CLASS-ID: mo00
Received: from remote.CS-SOFTWARE.local (b2b-78-94-62-122.unitymedia.biz [78.94.62.122])
        by post.strato.de (RZmta 42.10 DYNA|AUTH)
        with ESMTPA id 302409tB47IwiWb;
        Mon, 4 Dec 2017 08:18:58 +0100 (CET)
Received: from SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565]) by
 SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565%11]) with mapi id
 14.01.0438.000; Mon, 4 Dec 2017 08:18:57 +0100
From:   Florian Manschwetus <manschwetus@cs-software-gmbh.de>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as
 specified by rfc3875
Thread-Topic: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as
 specified by rfc3875
Thread-Index: AQHTa/zzit9rtTRuV0aXVXOBL7yf6aMyx+Zg
Date:   Mon, 4 Dec 2017 07:18:55 +0000
Message-ID: <F0F5A56A22F20D4CB4A03BB8D66587970253F87B86@SERVER2011.CS-SOFTWARE.local>
References: <20171126193813.12531-1-max@max630.net>
        <20171126193813.12531-2-max@max630.net>
        <20171129032214.GB32345@sigill.intra.peff.net>
        <xmqqr2sclj2q.fsf@gitster.mtv.corp.google.com>
        <20171203024958.GA31493@sigill.intra.peff.net>
 <xmqq1skcjqer.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1skcjqer.fsf@gitster.mtv.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.1.154]
x-pmwin-version: 3.1.2.0, Antivirus-Engine: 3.69.2, Antivirus-Data: 5.46
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,
I could provide a bash script I used in between to make this working with I=
IS, without fixing http-backend binary, maybe this helps to understand how =
this cases might be handled.

Mit freundlichen Gr=FC=DFen / With kind regards
Florian Manschwetus



> -----Urspr=FCngliche Nachricht-----
> Von: Junio C Hamano [mailto:gitster@pobox.com]
> Gesendet: Sonntag, 3. Dezember 2017 07:07
> An: Jeff King
> Cc: Max Kirillov; Eric Sunshine; Florian Manschwetus; Chris Packham;
> Konstantin Khomoutov; git@vger.kernel.org
> Betreff: Re: [PATCH v6 1/2] http-backend: respect CONTENT_LENGTH as
> specified by rfc3875
>=20
> Jeff King <peff@peff.net> writes:
>=20
> > ... Eventually our fill() will block trying to get data that is not
> > there. On an Apache server, the webserver would know there is nothing
> > left to send us and close() the pipe, and we'd get EOF.
> > But on IIS, I think the pipe remains open and we'd just block
> > indefinitely trying to read().
>=20
> Ah, yeah, under that scenario, trusting content-length and trying to read=
,
> waiting for input that would never come, will be a problem, and it would
> probably want to get documented.

