Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA2C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B25206B5
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kuka.onmicrosoft.com header.i=@kuka.onmicrosoft.com header.b="wRuKq4XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgHXJar (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:30:47 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:27783
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728831AbgHXJak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 05:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqfucbsFFTZdoEc1Ncnz3+MhtonDPCRpmE3Mh9AWevMGw2vLW+vGZHfx+7yKkGEQZz5gSOblOIQRXPYjyV3w8Lwx5DPOAdA5RD3305un5Ck3j3SdGbw0aXvdshcQy8zZVWx4W/eFKOE/OOt2xB+OlYWXRW8t6/K1rsNkaX5DmMDWB4/3CTgcW7lh/ALgFn+t8TK2hkqhD9rnnJU/ul2BMssVpy+vL32GCtF1DeU7ei4jPF1PxdTlejPYSCmPhyZMKcQHzhrVIFAFrM1zCiFDSuwZkhAAESJ2tiTvsQN8n4P55IGRvEWU7+tSAY6aYJM6nsndPrIH+UW5s3YR5+q+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZSMQ1deojBcy5ibWfMuWXQHkXTMuV/o/rfBZax6obs=;
 b=n00vp9fy7VkKYQdY2Pu2138Sx9ntQCwg0dMS2+z1TfZbUGz/ovnP9Q5RxpcpvK3cR8lbbwGYFYKsQPH0tvNmY6C9Ax86UVF5eNLqlX5s96NnGmsIfddg/cGyEuxZQdb1ZM1gImuTDI/205emGYLhgL4xR7oC6mLoAzRtIeAcBZIsrbM6CvxQUnM5n2XLb6YYUO98WnrrGHjNjjur3HlYMevlKn+dBMYo2m2ntqKLsNocj7bmejYqtMGIqhiEIMcgiLxVeMOTBdN9QD3M6xqFVyAaZlZHg/ac7rTd+20/tZvBlpcsI+NJa0ZrFKCibzjbNdcc2ZCKU/Wu0FTVg66MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.onmicrosoft.com;
 s=selector1-kuka-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZSMQ1deojBcy5ibWfMuWXQHkXTMuV/o/rfBZax6obs=;
 b=wRuKq4XRkqXWzn2b7eFgi1aFeKdoZ79lFA22ce0hzIx6Ip8fXB/lxY+IZrtSl7LdDpapptOlas5Q/3pe4ykrVSqqAJnBAVXUWYx9VSISN9DFEVsn7Ea9upOSt4GoIr7OYNnMvq/9ETNsACW3gPkoaeqjcPIq7yafbdi1Yv+AIRQ=
Received: from VI1PR0102MB3279.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:c::14) by VI1PR0101MB2336.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:52::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 09:30:37 +0000
Received: from VI1PR0102MB3279.eurprd01.prod.exchangelabs.com
 ([fe80::459c:e023:e612:b584]) by
 VI1PR0102MB3279.eurprd01.prod.exchangelabs.com
 ([fe80::459c:e023:e612:b584%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 09:30:37 +0000
From:   "Ramold, Felix" <Felix.Ramold@kuka.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: For how long will restore and switch be experimental
Thread-Topic: For how long will restore and switch be experimental
Thread-Index: AdZ5+N5GVxUlrL1xSmqTjCwvww44rQ==
Date:   Mon, 24 Aug 2020 09:30:37 +0000
Message-ID: <VI1PR0102MB327987955EE48E5CB6DD140AE8560@VI1PR0102MB3279.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kuka.com;
x-originating-ip: [2001:16b8:262d:ef00:157c:7d75:6935:1a72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8726902f-f838-461a-dfac-08d848105c09
x-ms-traffictypediagnostic: VI1PR0101MB2336:
x-microsoft-antispam-prvs: <VI1PR0101MB2336A9D11C16B1B65CA47237E8560@VI1PR0101MB2336.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jntu7cG2yjJdE/f1FDwrs5ZMPSWKjnDDZBZqEjQaT96FZ/GaqbJMbbqTQPvK6QBj7cuADX6Dot+mtH0NdJs+r3pqX1/4RJOnV0pXREg2fCWS4itz8ZhWlMq0rytVv/g9sniLTmnBEmL953iz6CrrFWWO9F3voTIFET9Boz/YIsL5H+IDQSAR9hpmzCGecDvI6JdFqHO4424I51NUVqBBZdoc+ZUqT3T1bLLXn5fO7AxHlRPMlFcfhO1IY4lSJvMOV/roG7WQzrhLpUkLaIIcXP57YyQcR7NyQ0nJAwYMeVMXQPQIaVi/+CgxtRt0t1coP6BQybVlAn7/Z7nET5Dd5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0102MB3279.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(7696005)(66556008)(55016002)(66446008)(5660300002)(76116006)(8936002)(66476007)(64756008)(86362001)(66946007)(4744005)(2906002)(6506007)(9686003)(478600001)(8676002)(316002)(71200400001)(33656002)(6916009)(52536014)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5f1TOlg6sdJvvlci/BHtiqyGPEvvd7mxwoWpnciPg4lWcYpZzgXQl2vi99Osv3VnpTMBO5LaYPGUCkP+CPgf18FclEhunjG087cCZreWketbcrNdWnNhINEZUVT/D7PeLfADTQKDdAtDL9EkEq7UGm6vUl0eGFke6WksYePLe9Q2HWaGVgTEmZt2JL8PrfOsRw36UngsnA9FdvFSOLbauCHTzA6uos5cbrFAjWYhD8+w35pmSD+yu/nLIFD42K+E+TZrIX67qnqamfJGvLKgvbFNpn/ZQhrRuadv0jYuqOkWLZZNuVq/+2Tq2N9Ke2LnMR5pgqkXLsQSgb/Jyo3+qbbZo+6mMcUEWqhSyh16hL0meUjI2yVuH5EfdVDMRHhLAPNvPTNV8v65Q8yzf238NRqvJEPPWniKkF0kiiEqYf421vqN0S5AhdP2bCYe8QTVa4riHGwBQghK5O2Ra3RvXJJjLyDgG60VzzXTOP10NeQ/zRhnvZGGvAPcrBAxVrF3/OIsj6veBMTyH9Dxe9WdvfThH+3EfuxGyGoTjTozWLeMfJChhMAey2EBwGzBmIpX66Kos8bIQY7/1+2Rv/H1aM6SbeDh6VBtijLWhTRW8rNIWFlWxLXSs6qdGTc/xqvTXTRA8jyFxJOhUnMlv1gSgOnWtUQ5y8n+HuRt7kQSlDf2FTcxcUSYP7/3wF7/IaoPIaXe9PDAni3fLzwjF0EeXQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0102MB3279.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8726902f-f838-461a-dfac-08d848105c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 09:30:37.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CieJEyLjRo8UFqV1YAfcXk2rR96hGN8mRR7Y64vUg1dUAOfvX9NavmUYfW2SRl9jkn4vlUGxTFntOV/PWrnO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0101MB2336
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The features git-switch and git-restore where added in 2.23.
I think they are great and I want to use them frequently. Also teach collea=
gues.
However, they are still marked experimental, and may change. I don't want t=
o learn or teach something that will likely change.
Can this be changed to stable?

Kind regards

Felix Ramold

