Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F74C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 19:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbiDYTjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiDYTjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 15:39:10 -0400
Received: from us-smtp-delivery-154.mimecast.com (us-smtp-delivery-154.mimecast.com [170.10.129.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E79CB111153
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genesys.com;
        s=mimecast20160503; t=1650915360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfovyerrKl17+iLPZvu8Kw1vVgO64Fo+3cc3d9UKbmQ=;
        b=AYgqH/w4wMxijhBrdUcnzkROP/lJLMuAYVwjMxkRw6gDKQv78C3oq/py0KOyWYPV3+2BnV
        tVaCDBGxuLvAefapyzO9LBTAiVxNtJYXdDeFJg4szD1XZ6JN83J9vb1FG4/DmB35b6RmcE
        Y/2z5mOudkJlPvBr7zlpfr5xgaJcvSQ=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-s0Qh9IOTPdmw1sMzW8JWQg-1; Mon, 25 Apr 2022 15:34:18 -0400
X-MC-Unique: s0Qh9IOTPdmw1sMzW8JWQg-1
Received: from SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22)
 by BYAPR10MB2742.namprd10.prod.outlook.com (2603:10b6:a02:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 19:34:16 +0000
Received: from SJ0PR10MB5645.namprd10.prod.outlook.com
 ([fe80::6594:78c1:2ae5:5208]) by SJ0PR10MB5645.namprd10.prod.outlook.com
 ([fe80::6594:78c1:2ae5:5208%5]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:34:15 +0000
From:   Jason Mathison <Jason.Mathison@genesys.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Suggestion for the --word-diff
Thread-Topic: Suggestion for the --word-diff
Thread-Index: AdhVor5MCgGx+FBlQPyNodj50LvQTADOEkCQ
Date:   Mon, 25 Apr 2022 19:34:15 +0000
Message-ID: <SJ0PR10MB564512089A259429773C2C7899F89@SJ0PR10MB5645.namprd10.prod.outlook.com>
References: <SJ0PR10MB5645CAAA092FE04C6A76B31E99F49@SJ0PR10MB5645.namprd10.prod.outlook.com>
In-Reply-To: <SJ0PR10MB5645CAAA092FE04C6A76B31E99F49@SJ0PR10MB5645.namprd10.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamFzb25tXG?=
 =?iso-8859-1?Q?FwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?iso-8859-1?Q?YmEyOWUzNWJcbXNnc1xtc2ctYWYyYmUwM2YtYzRjZS0xMWVjLWE3N2UtZm?=
 =?iso-8859-1?Q?MwMTdjMmZlYmIyXGFtZS10ZXN0XGFmMmJlMDQxLWM0Y2UtMTFlYy1hNzdl?=
 =?iso-8859-1?Q?LWZjMDE3YzJmZWJiMmJvZHkudHh0IiBzej0iMTI1OSIgdD0iMTMyOTUzOD?=
 =?iso-8859-1?Q?g4NTMzMDE3ODYwIiBoPSJTQWI1MVo4S1ZOQWw4cUFyVjhrNnl3RlNFdU09?=
 =?iso-8859-1?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2?=
 =?iso-8859-1?Q?dVQUFDUUVBQUFFZFlSeDIxallBUm9teGpESXc0VlVHaWJHTU1qRGhWUUdB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDMEF3QUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQWJmekxGUUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUo0QUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQU?=
 =?iso-8859-1?Q?dNQVl3QmZBR01BZFFCekFIUUFid0J0QUY4QVlRQnVBSGtBWHdCMkFEQUFO?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhN?=
 =?iso-8859-1?Q?QWRBQnZBRzBBWHdCakFHTUFiZ0JmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QW?=
 =?iso-8859-1?Q?JRQmZBSEFBWlFCeUFITUFid0J1QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?VBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?iso-8859-1?Q?Qm9BRzhBYmdCbEFHNEFkUUJ0QUdJQVpRQnlBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQ0FBQUFBQUNlQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJrQUdRQWNnQm?=
 =?iso-8859-1?Q?xBSE1BY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQU?=
 =?iso-8859-1?Q?FBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4fa3c00-758a-41c1-7827-08da26f2958a
x-ms-traffictypediagnostic: BYAPR10MB2742:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2742F7BFCEB08667ABAD137F99F89@BYAPR10MB2742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: o37BpAPbu5PkAC9N6ZU0d6ofCyokeFL9l+yQURC0cXUJv7LTmYKcIW872vwpCHRiIq4O5Khmo8XSkHGNqeJP1GMA6mLIxJBiaKoqAkGGhY/5dwqBaPCMTZgwaSYaFQ8QTZDcsuIRyrvfn+iFOusJyrOM5jXB9P8IHE9NJ9RBSblgUKLcBEV27RzZDmkLQo0EDcH0DZZLda11DDQNSVUNgY5Eh3Z+NbAvKGTjXnyeFt3ZrRkhu9xAKC6Wo2RP8A/ZDB5rP+ErppybgX7FCHCswhcV412x9XbYI19vbR8JzDWM7pWSNi6oa3FF/kHMh4yqiYtSTth2Es1QFAUblO4Xo4H52UHfJmD+H7T5VQr/O5Lc0rC9LTCpv06WgXCmN7f/06mIyNq+TkvHHrHPPUN/ybZ28nWvunciszmtKdqJb2OYMLgaO4PSgluyqxNJSdnwEjevquiasIkFju5I95fN57Z6o/oWnii0Eg+fcDZF5P4BWqlklO2QV709ui+8Kjcp+UyJHv5WBHps2fc/ZDm4nm1HVu9p/L0QrqCht3uoOoEF71ReYBkltXJMWqI/cGuFTj/019tAflJQRa3+ATTpG5hkewjwI+wsGhYPAKguRDVyq47J8Awi0ekCe5E6uXXGb0yC/xFGiA6hqqX+1M4cDXTnTiZWiUWp/3DiKTmFM3FLcwWh9K9mQLMpKfBIAkyTqH0haRNJynl2Wxs7zBtefd4bNkctvpnU0GFtlJCfIybdhbpBxOt6h9DeCUONUWL+Ap+S6xH8mMjN+n3qR01Ad/0KDK2HNpD+a3MdG/kaoEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5645.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66446008)(64756008)(66556008)(66946007)(5660300002)(8676002)(186003)(38070700005)(38100700002)(6506007)(26005)(4743002)(6916009)(9686003)(7696005)(316002)(122000001)(76116006)(86362001)(966005)(33656002)(55016003)(2906002)(83380400001)(52536014)(508600001)(71200400001)(8936002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JH7e1pbXXHvSITrF22mhmiROQXKnoCPGG92lFxd57v8tzi1E7tX6fzgMMF?=
 =?iso-8859-1?Q?h04zB+G0rq1Mk80LeuZQEx6efZS4+S0a1C59wOYZPoZ+94lIs5jAxgQLlz?=
 =?iso-8859-1?Q?+jC8vWIzHbiNog6pgeIRW4YTj2qp2KkOdIGnLcfWcg0CDsMCYRm+VC/phS?=
 =?iso-8859-1?Q?WyJmuAfX18pG+J0toIYBQCW40IvtHwK1tHykpE+x3zeaiTjygiBJqZ0WTx?=
 =?iso-8859-1?Q?MkuoLmLlZfxbfigTBMDOszRvN3dWuQPJKY0adCY8XNJh0q8qqOXKaW2aiB?=
 =?iso-8859-1?Q?+pVHEbTJdxh46gHw5VhSrEnLz4zpq8ykvrSo4Oq9Sib3Ef0rNeI2aafeqq?=
 =?iso-8859-1?Q?LSk4yVha3nf17glmFyIBTdkwzzzkr5u9BjDWYY6tpENoPgGY8ap0D0Uzx2?=
 =?iso-8859-1?Q?SjjrD5FsDYrO4KQHjLpc8mrK6XZdZeN1Ytzoj/Nad3MHEyy5gL/lJdCDuY?=
 =?iso-8859-1?Q?KZS8Ga7FCewuWcKm0+LRSl+X3+ECdBN5FVDJlfZRSaZRATJrGuKb9W3FH0?=
 =?iso-8859-1?Q?vqJZZrW7xdd+wjjQYjqsg/efRSHUCxp/dJKtKuCbazmdbCk+JujVQOhLeF?=
 =?iso-8859-1?Q?eV1/yzCDXHYv6/EDdMYMV2WKcL6L4L2FfwjW9hSfDyB/7Yf1Wci/zWu8Qc?=
 =?iso-8859-1?Q?f4ST4G94xmv2Vq/EEOY/wdzvr0/26b7iAzMOwCE102bZblYsSMaojOD8P+?=
 =?iso-8859-1?Q?q2gUvm2L2b7dwoGaMf8T1VBm7asaSh/5XtoFrlAPk2PM1SJ3JJqO5APMtT?=
 =?iso-8859-1?Q?Xz+skgNeM6XHJw4rM/A491cgsbdhu6zQ6tR6asM2nSUm9zWxhsHCwHOfOM?=
 =?iso-8859-1?Q?+6+owJnxg99mIN4QpcqoonJ5cYDtd2w5559D4S0BZWv75PjwxVSpeRj6xu?=
 =?iso-8859-1?Q?xfiKsf9lvTEP/K/AeS7qII8nSl2l9kx2cBb4mHGIXEu4DtzF2J/eSgMwiI?=
 =?iso-8859-1?Q?HAhpUwVrQfTbvMBybJUJMt6buBGPTpB+nCogpfc+GNNZRcJnuFpWYO/5vs?=
 =?iso-8859-1?Q?G6PEa7C8yvwxo0coLWLJe1eUXN8ClASyQEiAn/2gV/PQQ3ldhG2w0i5ACC?=
 =?iso-8859-1?Q?JzE1jLdVvT+alCXmjqxoMH7wkTTGJm5sCK+CSorsar3actSEUlYTKWNevr?=
 =?iso-8859-1?Q?QEpJtpBZSPbyQiY6+mplg/pHeC4x8iPp1dDvrxF5ESCxAuLQvrQ6Dr+PUY?=
 =?iso-8859-1?Q?YWDMb7L739BIBNjj+UqBX27jLn+pCy/WgtkNfEUbha/lQX5qfcjYNjYhQC?=
 =?iso-8859-1?Q?Z2eSJ9fk2rRjO0XhNoxYHD05QyLaqdBzsZCUoefq+bICq9Lfo/SCT5KXk4?=
 =?iso-8859-1?Q?z0q+jGXjf2JJYtI7onE7Y4hqzcaV2lVYv+gmkJOXz0BPg67GkK964y8tms?=
 =?iso-8859-1?Q?RdHFHP9mqwfJfbMXJacWpRkCby9gAV78D/uBMCu1F+2dbK5d6sU8M+1PpK?=
 =?iso-8859-1?Q?geQdzfIPKMjEOBEVcTO+JgqaMuWRUdhA2lmTFHBKWeZLqIodWtVJ0tS9ws?=
 =?iso-8859-1?Q?9NiBSk78X+QTEU7e3XZVQ4MamWNRtBrdsoMQMA026tKMIl1hh7bVH2WcJR?=
 =?iso-8859-1?Q?G24zgmw/lW3XtBxWZdJYy22b2z3b9zZZOQFZHYcqJTCx9Xy3+dEk1YvIoG?=
 =?iso-8859-1?Q?Mtlwt/x9tS+40Xqct/BaJz1UiYgaT6VFj3La7rJa5zCF6OVfWQKGXE9aG+?=
 =?iso-8859-1?Q?Te0ZlgA0PpugX0iuyEDo+ucOrJdtFm08gM8noXMcxlXQAAPASoB5IG32P+?=
 =?iso-8859-1?Q?oGE04kTFPV2nzMDls2gUAUri9u/uQPs3RXA0tAoYwB4Qd2ZdZCX494uaOt?=
 =?iso-8859-1?Q?5NLI9PkrsmYZz3K9he92mRGmEcUQ1oQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: genesys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5645.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fa3c00-758a-41c1-7827-08da26f2958a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 19:34:15.8542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 785ce69c-90cf-4dc7-a882-eaf312d1d15d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8iZ6bWx18Rs7W+U3nZTU7NbuidLSmcu4AsMGBAzA/No1i5d45qvAJvsbBwEJdSdMKw1QVtO9bwClXnvs3N5aJHtFsbIq3BashwJ3RTHC74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2742
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA54A3 smtp.mailfrom=jason.mathison@genesys.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: genesys.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into a situation where Git ends up giving a sort of strange diff in t=
he --word-diff mode.

Starting with something like this

protected static String deleteMe =3D "I am going to be deleted";
protected static Var1 var1;
protected static Var2 Var2;
protected static Var3 Var3;

I then deleted the first line and removed static from everything ending up =
with

protected Var1 var1;
protected Var2 Var2;
protected Var3 Var3;

The strange thing about the diff is that it didn't completely delete the fi=
rst line, but instead kept the protected on the first line and deleted it o=
n the second line.

I created a Repo to reproduce what I was seeing
https://github.com/JasonMathison/BadDiff

git diff 76e4a079b5a985149ef09ebfd3df9f475d08fc93...4f8429ad13c4209ec375f67=
f60a3a797b6368088=A0 --word-diff
diff --git a/code.java b/code.java
index d44a054..1118c6a 100644
--- a/code.java
+++ b/code.java
@@ -1,4 +1,3 @@
protected[-static String deleteMe =3D "I am going to be deleted";-]
[-protected static-] Var1 var1;
protected[-static-] Var2 Var2;
protected[-static-] Var3 Var3;

My suggestion is that the --word-diff prefer to remove an entire line in th=
is situation.

--Jason=20

