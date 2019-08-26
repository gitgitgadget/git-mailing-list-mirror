Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2EC1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfHZUII (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 16:08:08 -0400
Received: from mx0b-0016e101.pphosted.com ([148.163.141.31]:54682 "EHLO
        mx0b-0016e101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387395AbfHZUIH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 16:08:07 -0400
X-Greylist: delayed 3711 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 16:08:06 EDT
Received: from pps.filterd (m0151359.ppops.net [127.0.0.1])
        by mx0b-0016e101.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QIx6rJ026846
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucsd.edu; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=campus;
 bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
 b=hVxoph6jnSLZYd5Z0wrnd2GV0pIotEORqnRFoBklcNeU4M/V2LLCsjVKofW4J18PTa46
 U7f3Cv0kRCSFL7sPC2gkmw2kHdQMx0szfTUijzKtDaWBhn6VJ2+1kevQEeIxXJtb5ayO
 4fQk0UHSObqPZLXuVbL7SgLZTlc+3Pbdf4I4w7TKzwTFYvo7gSQ+WAc4Drhyj7HBbagt
 vY2AeRg1ynBuFLoZiKYdGN35JUA1X3xe9SRYhz24iK9aFege1U8AJuWqtw/jkMYpFJF1
 pQI8a0qqoiKFlgirKEv1VMzSDHwvd16fMB8kKgxqfKKMYzZustg7h/GEHANa9xvHZwMb Zw== 
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by mx0b-0016e101.pphosted.com with ESMTP id 2uk0kyxuh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:06:14 -0700
Received: by mail-pl1-f198.google.com with SMTP id t2so10517984plq.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsd-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
        b=bnrFseOUMEWTU+KFj7iVUkXKPYVW9XlBb/AuciNOyRPsSit2/inqmQpYKsXl64Fxwq
         y9KwfjY9AnzEczi3tKTGGl1BK4OIvrAqicgKPTTXrVsOXG0bY1fMFYwzGenahFJrEMVh
         ERHZt5nTgZJziDE+6LW0vsgXl5Nq6xYEpL1ZCpjWsOPvSRMcaN8bVn7vQa5z3NJGVK6k
         qLVpwGH34D/n6rI8Y8ZL0OhyCWIwZHJ7wzplgrzrRVjPjb+nomsMKMOyXCvCBXNaBqHL
         MixCaK68ncRJH0Q1OPQQo0VpU71E2wbTKCqAhjVAqfd8qL3wXBS1BvaUvoOQsHrut94K
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tqfE68vGFky5E+D0gy4J9ynjoAXWJkQomKIAMnpB0KQ=;
        b=GujJvfyd8NRqiMLHYcWbF3oZWvcX/EvUxhbT9jbwcJgIy/DUalUgn/YyREpxqn9phH
         Kg2aocVly0Rhv28SHn9GPMD7Bao9gJH/sQpYsen2Ak7zVTRbf4H4wHmSi5ZxP19aEyMS
         EEGbXPykgmraalGBzLdbsqTypLw9k1B6PG4xM0JZf410sRpcE3Q2j8N4sytM6VX2UQh7
         6sOSceeJw6RS6garZMmsUG3AhKjI69yyDBiSG2nQChAJy5y6cSk2R54JSmzNbIZxCnB/
         eJuVecvp2qi5ZrvoRmewId6HX9WS45ofecEFZFz4h3nS6MP1kzNUzypa7JNMsHuniZID
         F4Og==
X-Gm-Message-State: APjAAAUIyTM/w1hgWkYX5lg80dGuzG9kV8YXSdv3gpUIa0HWM4817jgD
        IkQXZfI4y8Md9c63asfRAmHYRUzLqtRYPnDZ0/1sx5insPOSrKnjLT4DiE5mPz1PH1EzbX14M43
        2GIkR75FoJIE=
X-Received: by 2002:a62:db43:: with SMTP id f64mr22578411pfg.38.1566846373824;
        Mon, 26 Aug 2019 12:06:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxL8lpwKuNyr1O9ub0ZiA+H5lZSIk6nuQvGe/3XpSoOnNLGI4hGoNADuLnC3RmeHM+JZKa1uw==
X-Received: by 2002:a62:db43:: with SMTP id f64mr22578387pfg.38.1566846373606;
        Mon, 26 Aug 2019 12:06:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c101:8c30:b92c:823a:6706:8ac1? ([2601:646:c101:8c30:b92c:823a:6706:8ac1])
        by smtp.gmail.com with ESMTPSA id s4sm200588pjp.15.2019.08.26.12.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 12:06:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
From:   Andrey Portnoy <aportnoy@ucsd.edu>
In-Reply-To: <20190826183317.GB23399@sigill.intra.peff.net>
Date:   Mon, 26 Aug 2019 12:06:11 -0700
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Andrey Portnoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E17AF17D-AF64-4791-A38A-6510923005FC@ucsd.edu>
References: <pull.322.git.gitgitgadget@gmail.com>
 <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
 <20190826183317.GB23399@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-campus_gsuite: gsuite_33445511
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=913 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Aug 26, 2019, at 11:33 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Aug 26, 2019 at 09:24:10AM -0700, Junio C Hamano wrote:
>=20
>> "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> Previously sprintf was the argument to the BANNED macro, where =
vsprintf is
>>> expected.
>>=20
>> Good eyes.  Thanks.
>=20
> There's an identical patch in:
>=20
>  =
https://public-inbox.org/git/cab687db8315dd4245e1703402a8c76218ee1115.1566=
762128.git.me@ttaylorr.com/
>=20
> and both were inspired by:
>=20
>  https://news.ycombinator.com/item?id=3D20793298
Nope, mine was not =E2=80=9Cinspired by=E2=80=9D that comment, noticed =
the bug myself. I did look at this header because it was posted on HN, =
though.
>=20
> whose author has little info there, but I think is separate from =
either
> submitter.
>=20
> I don't know if we want to try to spread credit around via trailers.
> "Racily-implemented-by:" ? :)
>=20
> Anyway, the original bug is mine and the patch is obviously correct.
>=20
> -Peff
>=20

