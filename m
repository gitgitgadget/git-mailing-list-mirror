Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C9DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiCJB0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiCJB0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:26:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F7E08A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646875547; x=1678411547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSpOq5L+wlJRliNeuGhGLsT0gO4eGzGrTI+fRdRgwZk=;
  b=G3ufBxhs371ZuYYcFg2aYn0mPluOCNlvPeEWa+pRAlE5OK09VXjJ+4NU
   pnoE7OaaQoZTe5G5a6z9eQRp3HYX4zMG437pXMQ3UebSNFsQWVzktZevs
   LFkVuZaoZ894DS7p7XpzxyrU80WCuWGNrXcPIvb5qjK3WpwhelOhe+GEy
   cDOWIYS8CaN5Uy4DHZQNAtsp2FE/xB/crwf8UPONxlJhXswGNkH8ZpqGE
   RsCwZMoSbNiIhRbLLbMAOdtxYXDCW+Owt1ENjjsA+QBsjG0e4LZOzU45/
   TfYrsuu0PdSOxJlH/qnm7CwoGAmjXNcrWmbuLt/9s2Hty1QqRrTAyD/QX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279866595"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="279866595"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="547840570"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2022 17:25:29 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 17:25:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 17:25:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 17:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8DWdfUHNHTxNqYyllJOpsbsQYugO0G+7JlpFY9ciARTwxzLSBiSBfs+4ga5DHOQ/Kfs/a+BTVcmYktxkZduCy6MhdTzNArUH+UDoAyfVIFWhQYYhfbn9tRB8QfIMgIOBwR5vX37E89AehUasv2s2n2hJ1vXp/aH7p1qt02lpKgyYi4vsGyXx0SPvOWKD74cXFuTgazIinyqVqiA2/4IUUrC59cLqaSQDiPvchtPMiEmgGiCH5voR5KvX3ZFmJYVNwHSt6lv/As98kVaQBD70nyCxkNds9ZgAnF9DSX0BYRVRgxwPk0HUNdyLK/EmbuzQsP8AoaaaBPaztXxhW+VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHs+GpzuJKeNZSvM/UvLsxXr67mO84o0YltpuDn28t0=;
 b=bLOZh0jcpc+sUeVrFFMPmqGd1ANRH76cURqKMYOT088vfg1vQZPXosorj89iJ66BXCtvmcWA+M8H1ewpUkatFTIzhamRlMOq5hfweK8iGX6wbkE5wT0iqSfQtFYrTkRylJvYU7srvpy2aOvzqN7qPVZi7lZHKp07GjeGwOwtewCiPDYb/rvVNIDVDSztGJ5d2WMKioZ4JcyHfIn0bgyQSAsJJs1zyyDBYarDRRRqSCPBjKhvbPkNik/dWdKPlwnBwZQyrc8JvQQK21pg8S2YXWrJgYnNHp/dERu+0CtSbMEsAb5nywCO5ANwXxVEVojmRxkvkDMniX1LQAdy82Luow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN6PR11MB2877.namprd11.prod.outlook.com (2603:10b6:805:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 01:25:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::8441:e1ac:f3ae:12b8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::8441:e1ac:f3ae:12b8%6]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 01:25:25 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: RE: [PATCH v3] name-rev: use generation numbers if available
Thread-Topic: [PATCH v3] name-rev: use generation numbers if available
Thread-Index: AQHYNBKntL4qorAvB0K57fsnYL9XPKy3xMA9gAAOX8A=
Date:   Thu, 10 Mar 2022 01:25:25 +0000
Message-ID: <CO1PR11MB5089439F5FBB755C67049AC5D60B9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220310000550.2368737-1-jacob.e.keller@intel.com>
 <xmqqilsmir41.fsf@gitster.g>
In-Reply-To: <xmqqilsmir41.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 408b5fcb-5371-48b2-66c1-08da0234dab6
x-ms-traffictypediagnostic: SN6PR11MB2877:EE_
x-microsoft-antispam-prvs: <SN6PR11MB287747E7348D817AC84D4D5FD60B9@SN6PR11MB2877.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWROQs3GI3ajFW9FBul7D9BJ3D7UhQEK60aLcuPAf2Z/oaQyEne6wIRjH6atqNROY1kk0nzrqVVUPaRaCa5g3V32DmwT22HPckg4o+VZ6BTqFG9HiY/c9YGgJctG6GXWfOKVMDgT3GcKqGOtaEPOmo5aH1lm9d2c+8EV3BMq7loSU3hSRoCwZYKF3RywL/GkzlM/IS6Q8AOkyj5wRUcBFhD7XB016Mo+hohOkcyDxiTIsf/wz649pBdTh/WszfQ4Gt+W7hpPTpiUGde/PXPhehVuJB0GGbv25vcE1Ry5zkv98gBwYBiS6hMnHenqIVIUMo5jGE1LVT3NrPoUdyb6WTDCM7Y5NCes84WB7RY83MJeSGrrhOJTRx3dqguPl3fRNPpz6kUgLgKM2/dRvhY6g5tisdqTkEE26jC5C76/8t1zF0gayPVs5hHlTEFjULabCyST4vBZKnqTeJYzbp1p99pFbsWiZIARAY6qEfh20nRiADf9HlJvA/BolvA/LmBLBNoVRRaq1Wdg4Prvod6QKnaNsliln0G7vcEo5hBxpTmLhfv4YNDbRXykU6BcBcpYyKc2MnQlrwj2KHPB45MzfQKABNskQo/a307u0FldQeqUYQ/1PtUgaaan5dr+wKzNJunCeHaR0i5hoNBeDSzsQJNu7Pzt4ln94TdeZVA+SFUiUkEZVIM9JmuZle9P3ksjq0w4nHvEDz6O1Kkq8DgqoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(5660300002)(38070700005)(9686003)(83380400001)(71200400001)(6916009)(54906003)(316002)(64756008)(8676002)(4326008)(66556008)(6506007)(66446008)(53546011)(86362001)(66476007)(66946007)(8936002)(508600001)(52536014)(76116006)(122000001)(7696005)(38100700002)(55016003)(26005)(186003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?an31vk4U0FRsDZPk4d42Q5KRdADlNB9+ATZVgzW8xnzONRFmBzN4NwgzNW9s?=
 =?us-ascii?Q?5Z8tLC3QOjELoULUs8BFWJQ071jz8K0BBZoXQlDiOk+QoNM6rzeIw/crGevZ?=
 =?us-ascii?Q?4LvtvS5eYlvydIDfSuCaStScV+KUpolnil5vdcpHxxsrEL7VJpF4qDjdp9ou?=
 =?us-ascii?Q?oXThzfW7p9eHtaWaP6VzWE6BO2BJ5qpsM6qDJ9p71i7ZNPPzEgJkoCw0ngA2?=
 =?us-ascii?Q?lCviErmmd9MsShmk5JXLNJhQ/eaGPyrXGgGiPPnr7DzPwm/A/piwlF/x4ygF?=
 =?us-ascii?Q?vD++yGuzlNZ5p93p6jHt+54W0cmorzoUZYq10fbiwZDgxQ/jB9I0xKMxH/tD?=
 =?us-ascii?Q?pO+7HFQJqyBirKy/+T4JvdH735Z6qT6+328M9jHmr750cdd67/6JNh15jqVi?=
 =?us-ascii?Q?HOWxjvwlw6bJLh0kGO//itCdymd3f7JO1AZbM6mlhvXNlQa0yH0y6Dk9sN58?=
 =?us-ascii?Q?nO9RIhEPboqRGY/WD3R7MisA1+j+AXcA+F4nMNzRl2g79A8qq17zphlQ8Jsn?=
 =?us-ascii?Q?I5jKanv1rqhiQlhkvGo0ikP5X6TN9SjfDJf0uDh4Q8X7UGRZmSAAZVNeXDGy?=
 =?us-ascii?Q?bOSAmHM8lLtkzJ7993tE4zq3OAx1D9iMgYDt6YO+IwEZOqK2o2Z4fz0eEKL6?=
 =?us-ascii?Q?lhPAJSXEHIEKiXVjt/XwCpPzMAP0JF5rj2O7gMM/JNOmiHA0CM+zKx1RLJAd?=
 =?us-ascii?Q?jNWKhtbeVf1vQLFestWukajqX3xnrZRczz3+II7OSy2WCj7lQqFYX7TjqAkU?=
 =?us-ascii?Q?eA+ELEkMkgI7w+JWTKBFHreSEVjVVWtDnWwLU4rVnFjYlbHnVrBLhi0ckbTk?=
 =?us-ascii?Q?o7KAa2W/XkGYxtZMrSQIfPrmLhlAJ+tf0o8vckfbq14geJs5kysByhhru+HS?=
 =?us-ascii?Q?V9qMeZ8BC+DegEILWkzTSLOLyt/Ut3F2HMBNyB+jHz3s9yiyQK4BbDUH27yZ?=
 =?us-ascii?Q?qiCvGWSPG00zVWPf9O2sWJaSF2YglPy6RJg/JKQrVGG0iuBOMDl5U2fzkCMy?=
 =?us-ascii?Q?IJSDNvalxiguYxnEd6Yh9KDTlZJcRA0aPkA1Hi3VA34gGWAosG9OzSA+k4oA?=
 =?us-ascii?Q?B8Ir0oZ0VQax7ZygvKe+TOd9/bAlsl3v/PMK3hXztxti0yWPsKuNTKC+w2aG?=
 =?us-ascii?Q?SfGYQFavDzdVUTyw1rQVwqgao0AK6g6/yZiqBhUJUc+zgMSNS/jNrAbTN2pB?=
 =?us-ascii?Q?YYDKylcgEPzyBg67dEpf0XbvMP1GlVhBOFutD/s0+OoR+GikaFd2g8phnJ2n?=
 =?us-ascii?Q?eWEC0ADRmu2e87r9B2JLJJWhkYs2serCemjwz61MMpafUujzc3ATZQZeNCsi?=
 =?us-ascii?Q?ZOF7+AESI7GbQisbDKz0w/jTT2oHLv7TOiun9MtLxDZHaOhgPkjM15Y+L9K0?=
 =?us-ascii?Q?H2pr5UAt5Bpuuz775n5Vq3Lp5+dr3CPdfPw57sPqap7+H5Pa8O29MdVTnh9H?=
 =?us-ascii?Q?OcYY8wxMLG344udIeAThf4OrjdhmfLssDtfQkFAd1E/jEjKn79NEixd9nVrC?=
 =?us-ascii?Q?HoXqkJsfi7+3G79WRBoIduCHRIn0/2arYZlkOWdwD1hR87SfE6IguHo4vf7P?=
 =?us-ascii?Q?iV0v4+gA73bAwiR7WnFqMc6q3iQgWJtlN1qZK5ELfrPc84TKtWNMdjIevcdA?=
 =?us-ascii?Q?gKMp05Yl9jjBywtjydXi9fbsGFp8AmxsEwrPOypgs+qfBYsoiQositqPUX9r?=
 =?us-ascii?Q?jt6Ymw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408b5fcb-5371-48b2-66c1-08da0234dab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 01:25:25.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEw9h1QbXlaBX7ZRXVxr9guit4unSbiI68J9GiDO+/p6/GfkXXybxLrbl3wl3HSRRfoCnO+rNr32ijh4NOge7F57qbCX5vAPUSbVbxwHSZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2877
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Wednesday, March 09, 2022 4:33 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>
> Subject: Re: [PATCH v3] name-rev: use generation numbers if available
>=20
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
> > +# A-B-C-D-E-main
> > +#
> > +# Where C has a non-monotonically increasing commit timestamp w.r.t. o=
ther
> > +# commits
> > +test_expect_success 'non-monotonic commit dates setup' '
> > +	UNIX_EPOCH_ZERO=3D"@0 +0000" &&
> > +	git init non-monotonic &&
> > +	test_commit -C non-monotonic A &&
> > +	test_commit -C non-monotonic --no-tag B &&
> > +	test_commit -C non-monotonic --no-tag --date "$UNIX_EPOCH_ZERO" C
> &&
> > +	test_commit -C non-monotonic D &&
> > +	test_commit -C non-monotonic E
> > +'
> > +
> > +test_expect_success 'name-rev with commitGraph handles non-monotonic
> timestamps' '
> > +	test_config -C non-monotonic core.commitGraph false &&
>=20
> Don't you mean "true" here?
>=20

Yep. Will fix.

> > +	(
> > +		cd non-monotonic &&
> > +
> > +		echo "main~3 tags/D~2" >expect &&
> > +		git name-rev --tags main~3 >actual &&
> > +
> > +		test_cmp expect actual
> > +	)
> > +'
>=20
> Other than that there wasn't anything unexpected in this iteration.
>=20
> Thanks.

