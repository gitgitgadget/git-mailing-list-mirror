Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351761F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 08:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbfJWItp (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 04:49:45 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:2732
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390034AbfJWIto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 04:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCm4/4orU3ZvJa+FSC92BEUMSdsTbpF9G+ssdXykf+mJjP/LYxul48pH1750ER8ipe0c2PmFW3wLiUtQvOuCCPiKv+k9wFv8rWK/rGI/VtnSw4Z0joLAL5SeP5Uy8+bMTHPxkZHI1fdhUtxHEE851ar727FAVSblkBGi16EVhPYZfdjLTqVbpKzg6HMIdYl3P5qrIXvu7quQV9jHKiQKIplJoY1BzZ9fw+l9klY4emkh1ndFKhLTe7+Yq0A3GSCbChB6lRaIXjENBV9OiisrKpodSkLg8o1sihpJSy/U5hOnj2xpAPpUJc4jDrfr+7Sq2C3Q9KM05zgKmLJy5VZHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/3tkkQUdVueq9aAVsgnWzVMLWZYhGOORy0mtUr2XUU=;
 b=NCtwqu9cepKiY1/W9fO71x/ckQ4qVNP18DxogJp5nLk/oAVbUquLWduyPDW8oYy5kMjJj3fOIRuZzbE2Z+/3WONuP5eyUaydE7dlr4/uOs4877Nd3q8fKZE86w33U3KuAKaGYytqSa1tWX2H0z4aqaLbx4wnQ9zFnENVkvrL+M4S2/qHZ9S/efna9CpxJ5oktm5YCU5NjsUThNXTTYwsUcasgjPUU96SYJT8c2pKhBaBAGGb7RkjxSt6nJhEhCD2vsRwUjNQTJmbNFcEYbGNkGcAdosHWnYqBfbBbgUv2HslcUujxETK+HN4USOtLo5I9uDbasyPaJsqd6fK90E2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/3tkkQUdVueq9aAVsgnWzVMLWZYhGOORy0mtUr2XUU=;
 b=dJPgnAf9e3bO/7HNh8H0wueLeIKqc2JrYO9UEsQ1ZiibvxrodWMSnze1yRA0d3FvPH5ipJTyT59154H1c9mUoksGEXwENSgv/+YbfaQegQgV2QvIykhR2VgO0ve1nWF1tzDeLP3Ux8g3b5SakEqVMoebCUA+rbJ/66MqH+WmrnY=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4398.namprd11.prod.outlook.com (52.135.37.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 08:49:42 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 08:49:42 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Topic: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Index: AQHViMH8W7ZVg6yI2Uq8GUvXcCiKxKdngKj6gABrcAA=
Date:   Wed, 23 Oct 2019 08:49:41 +0000
Message-ID: <1791353.RaUiIlXgNR@pc-42>
References: <2154192.LVDMpRDY2h@pc-42>
 <xmqqzhhsi4g5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhhsi4g5.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81f3d6bd-aa90-42cc-b2bc-08d75795f25a
x-ms-traffictypediagnostic: MN2PR11MB4398:
x-microsoft-antispam-prvs: <MN2PR11MB4398CDD1C51B363EAB1D7004936B0@MN2PR11MB4398.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(51444003)(476003)(316002)(5660300002)(6506007)(14454004)(6916009)(7736002)(229853002)(486006)(26005)(11346002)(478600001)(76176011)(305945005)(102836004)(66556008)(64756008)(99286004)(66446008)(66946007)(76116006)(91956017)(446003)(66066001)(66476007)(4326008)(81156014)(81166006)(2906002)(186003)(71190400001)(71200400001)(8676002)(8936002)(86362001)(6486002)(66574012)(33716001)(14444005)(3846002)(6116002)(6246003)(6436002)(25786009)(256004)(9686003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4398;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6FcvuBWeKMFXRsE3z/mUzYj/3Kx3CKa72YGJCIgNkCxlq7+TwQSAUSQasYzYlAwA0vG9iaDuFwS6OEyjDogrEnQoGt9gk+9oeH7mqpOXDtordcNICge8IUbom0cFK618XZ4FgIW/8qPJvBUoDU3TLQCrBvV6msh7SrF/2nFzxWjN/kSq40XqCbiFPehFs0oz/UZhx4kkp5JW61ODr5nQ6tbZgj0ssiAppZwWk9MSA20YzxBDha5hpPu60TzqsHHmWwfI+VAQw8Og9ck8Y6dsNQO/NYXh4IZ8ZXeY8Ol8MMVXlO0LQjVWnwbCc6eUd621ArWcldbpAKczPD36YuzWn4zcRosw6aE6MX1VFlikK/9+i4kdglsQGrYZ9JcizMqvWDH/qbsHwJPhjK+3kg7Pos2AwlGzigfIDhrhOR03ja4wCxE7EUcqsTduhMR+NUq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C06504988D21C24BB356C1CDE21E693D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f3d6bd-aa90-42cc-b2bc-08d75795f25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:49:42.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4dCrmCJIRaYBr+jJG/33tw55YTOe4d/QcFtK9LmtzLiQ3OVfzgI6X1KSRKV7cyccrpH6ZSZBoyaPOzK7GTMMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4398
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 23 October 2019 04:24:58 CEST Junio C Hamano wrote:
> Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
> > I try to use "git am" to apply a patch sent using "git send-email". Thi=
s
> > patch does not apply properly. I try to use "git am --show-current-patc=
h"
> > to understand the problem. However, since original mail is encoded in q=
uoted-
> > printable, data returned by --show-current-patch is not a valid patch.
>=20
> I agree that --show-current-patch is a misdesigned feature.  We'd be
> doing a better service to our users if we documented that the patch
> and log message are found at .git/rebase-apply/{patch,msg} instead
> of trying to hide the path.
>=20
> Unfortunately, it is likely that those who added that feature have
> built their tooling around it to depend on its output being the full
> e-mail message "am" was fed (and split by "git mailsplit").  So I do
> not think we will be changing the output to the patch file only.
>=20
> But even then, the documentation can be fixed without any backward
> compatibility issues.  Perhaps like this?
>=20
>  Documentation/git-am.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 6f6c34b0f4..f63b70325c 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -172,7 +172,7 @@ default.   You can use `--no-utf8` to override this.
>         untouched.
>=20
>  --show-current-patch::
> -       Show the patch being applied when "git am" is stopped because
> +       Show the entire e-mail message "git am" has stopped at, because
>         of conflicts.

I agree with you: I think that manpage and/or output of "git am" should
mention ".git/rebase-apply/patch" (that is exactly what I was looking
for).

Maybe documentation of --show-current-patch should be clarified with a
note like "This option is mainly for internal purpose. If you want to
get current patch, rely on .git/rebase-apply/patch".


--=20
J=E9r=F4me Pouiller

