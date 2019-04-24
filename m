Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741621F453
	for <e@80x24.org>; Wed, 24 Apr 2019 13:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDXN6o convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 24 Apr 2019 09:58:44 -0400
Received: from smtppost.atos.net ([193.56.114.166]:14251 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfDXN6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 09:58:43 -0400
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1c6c_7957_a440e7de_119c_44f9_b3be_357544809ab5;
        Wed, 24 Apr 2019 15:58:32 +0200
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3ODwWsP016671
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 15:58:32 +0200
Received: from DEERLM99ETZMSX.ww931.my-it-solutions.net ([10.86.142.48])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3ODwWNt032671
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 15:58:32 +0200
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net (10.86.142.105) by
 DEERLM99ETZMSX.ww931.my-it-solutions.net (10.86.142.48) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 15:58:29 +0200
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.105) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 15:58:29 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB3720.eurprd02.prod.outlook.com (52.134.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Wed, 24 Apr 2019 13:58:28 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 13:58:28 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] git-compat-util: work around for access(X_OK) under
 root
Thread-Topic: [PATCH v2] git-compat-util: work around for access(X_OK) under
 root
Thread-Index: AQHU+pQOK7o0X8XzDU2gNrjAC7OR3qZLUS9+gAAAqA0=
Date:   Wed, 24 Apr 2019 13:58:27 +0000
Message-ID: <AM6PR02MB4950DF3BBE222BE90EA7E3ABEA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
References: <AM6PR02MB4950ED66291B16F35BE61A26EA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>,<xmqqa7gf1q0y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7gf1q0y.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d245e69f-3de3-436f-44e0-08d6c8bced4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB3720;
x-ms-traffictypediagnostic: AM6PR02MB3720:
x-microsoft-antispam-prvs: <AM6PR02MB37201A0690F20200BDB44B6EEA3C0@AM6PR02MB3720.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2906002)(7696005)(76176011)(11346002)(102836004)(71200400001)(476003)(6916009)(6506007)(5660300002)(486006)(25786009)(71190400001)(478600001)(54906003)(6436002)(256004)(14444005)(14454004)(99286004)(446003)(33656002)(81166006)(26005)(229853002)(68736007)(66066001)(6116002)(316002)(7736002)(53346004)(186003)(66556008)(8936002)(81156014)(64756008)(4326008)(8676002)(66446008)(66476007)(76116006)(55016002)(3846002)(66574012)(97736004)(74316002)(52536014)(6246003)(73956011)(305945005)(53936002)(86362001)(66946007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3720;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hj+VUwubXGKGG+KsIWkkAxJlYdZ0vEgZsfHlmTe9CYRrL3YW+CUBQ9/kU5S05UPLi5ggjP3LIIu/MvUmybnyBYuLVzbmt5LBb2PreMk+phna609DH27JqV6+WKq3GPFjBAceU9HLS1I+fPNo4U8G5ES1luQqg+Tmpu9F6T65oO6bnUrawPtMwQH6wTLM+rjMhuWpFY3PEWwK1qWdM5agyUuyGBYm4PxV3gY3RQXO8ylx0WD+tqwvrbYfH8sVypmyCBDLYUSfpVAj9WthNhhFm/xjxj9pNr2cGzbS36x2FdA89SalTmPXShftTy3d9IHbikxUvfyzMQb8c6LqojxfzTdVkDoBNjo+gSA1NHc8jFAquimMDbxthQ1FQpqlTZpUGj/xdy2aniwkzxk7Ao/k7GSNpQOOim0VX2YipVK4zNw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d245e69f-3de3-436f-44e0-08d6c8bced4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 13:58:27.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3720
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano <gitster@pobox.com>
> "CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:
> 
> > On AIX, access(X_OK) may success when run under root even if the
> 
> s/success/succeed/;
> 
> Also perhaps s/under/as/.
> 
> > execution isn't possible. This comes from the POSIX specifications
> 
> s/comes from/behaviour is allowed by/;  I agree with you that AIX
> behaviour is suboptimal and I do not think we want to give an
> impression that POSIX encourages such an illogical behaviour.  It
> merely is permitted.

Yes, that's better

> 
> >  "git commit -m content
> >   fatal: cannot exec '.git/hooks/pre-commit': Permission denied"
> 
> I am not sure what the double-quotes around these two lines are
> about.  Perhaps drop them, and if you want to clarify which part is
> your word and which part is quoted material, have blank lines to
> delineate instead, perhap like:
> 
>         ... POSIX says:
> 
>             ... for a process with appropriate ...
>             ... to any user.
> 
>         This behaviour can fail the execution of hooks, like so:
> 
>             $ git commit
>             fatal: cannot exec '.git/hooks/pre-commit': Permission denied
> 
>         Add NEED_ACCESS_ROOT_HANDLER in order to...

I'm used to do that. But if you think that's clearer, I'll do it. 

> 
> > is root.
> >
> > Signed-off-by: Clément Chigot <clement.chigot@atos.net>
> > Message-ID: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
> 
> Drop "Message-Id:" from the footer.
> 
> > ---
> > ...
> > diff --git a/compat/access.c b/compat/access.c
> > new file mode 100644
> > index 0000000000..fcfaefb0c0
> > --- /dev/null
> > +++ b/compat/access.c
> > @@ -0,0 +1,30 @@
> > +#define COMPAT_CODE_ACCESS
> 
> I am torn between just using COMPAT_CODE like the other one does, or
> introducing the new symbol like this.  If we were to do the latter,
> perhaps we should give the original one a more specific name as well
> (e.g. COMPAT_CODE_FILENO or something like that).
>

I think using the same define is possible for now. But it might become confusing
if others are needed. Moreover, I'm not sure it will work if, for example,
fileno is needed inside git_access. That's very unlikely to happen, but
it seems better to have one COMPAT_CODE_X defined for each special handler. 
I'll let you decide., anyway. 

> > +     if (stat(path, &st) < 0)
> > +             return -1;
> > +
> > +     /* Root can read or write any file. */
> > +     if (!(mode & X_OK))
> > +             return 0;
> > +
> > +     /* Root can execute any file that has any one of the execute
> > +        bits set. */
> 
>         /*
>          * Our multi-line comment looks like this,
>          * with opening slash-asterisk and closing
>          * asterisk-slash on their own lines.
>          */

.. I've forgotten this one, sorry. 

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 31b47932bd..d0cb380522 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1242,6 +1242,13 @@ int git_fileno(FILE *stream);
> >  # endif
> >  #endif


> > 
> > +#ifdef NEED_ACCESS_ROOT_HANDLER
> > +int git_access(const char *path, int mode);
> > +# ifndef COMPAT_CODE_ACCESS
> 
> Notice that the fileno thing we are trying to mimick protects us
> from a system header that defines the macro we are about to define,
> which is a good practice to prevent compilers from complaining
> against redefinition.  We should imitate it like this here:
> 
>    #  ifdef access
>    #  undef access
>    #  endif
> 
> > +#  define access(path, mode) git_access(path, mode)
> > +# endif
> > +#endif
> > +

Ok. 

> 
> Other than that, looks good to me.
	  
