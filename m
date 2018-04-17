Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0471F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755668AbeDQQW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:22:28 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:21028
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753828AbeDQQWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cEL/3zdKmAIR7eieiXGKuvNTZLFdRiWGSI/+c9XFciI=;
 b=p42Xhnk2oOaS083LBVMxfR5qpOfzsn6LaNIGyE4yqSxiqJwYnvW9xI8ta+RjG5/svMl27746UeYY83ZJMzah8TZoP7XWTs+rIuNBckO00xCUxCj7qo+5aKT/9bbb2nupEi/S14kd15BeZ1QaPnASwDs7k4X6k/1w8ZmKOZiCsL8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
Received: from amazo-desktop.cernium.local (70.163.25.109) by
 BYAPR08MB3845.namprd08.prod.outlook.com (2603:10b6:a02:82::27) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Tue, 17
 Apr 2018 16:22:22 +0000
From:   Andrey Mazo <amazo@checkvideo.com>
To:     git@vger.kernel.org
Cc:     Andrey Mazo <amazo@checkvideo.com>, luke@diamand.org,
        gvanburgh@bloomberg.net, larsxschneider@gmail.com,
        miguel.torroja@gmail.com, thanvk@gmail.com
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
Date:   Tue, 17 Apr 2018 12:22:12 -0400
Message-Id: <cover.1523981210.git.amazo@checkvideo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.163.25.109]
X-ClientProxiedBy: BN4PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:403:2::11) To BYAPR08MB3845.namprd08.prod.outlook.com
 (2603:10b6:a02:82::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3845;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;3:tWyE2By+L27tn43W7xb0B6APpFi3HW4Js3kk5drh7cyG6WnVrdDkjmn8L9kRA1AD26o3qh/wrH5gT2k2fqExUfBci98LyEfAgVViKfKVcMHtf3LB4ALzV5ph6JZ6Q5YRV3MfR+LX/oOWp8PNwqWc3/karQYJUGuWNDZYbWQ/qzLYrIGEubCw/u57GtOmdTNOgoJ19BjmF5RFUJL/nwg0+YS0pSWOFSfw029kunCJ7R/pLulUN0U7DK25TDOCBFaj;25:ypZPZjsPjKJ1OgwaqhbYTUudUklkrxBQWTAAxHJA1S4M7LGGGriZEqr8DJgdhZbQgJ+psR05kRFqdl5/9RIc4+o+1jhak6po7F6l4M6jWh+/pBzU64WYaUQgHDW8sK1DiGZ1au7jwfd1zF6Omcn8jqBLlc2UT2C0L54hdO8Xn10iRNhlWJ/g/+SVWzO8TSkaIrKTJIS+CHD3EzbSX/AiU5H99vEvWkuJS7z8bo4wgOB9LgdTvyEAsx+jcq9Oy78V12iY8AwV1QsU+dmXdn/EZMh9qZFXSKmXECy+60W5qVzFMC/NvQQpdB8StbeLo+Y8H4OKpnnwdw6lqRX+f3dl4g==;31:/VzGqpjXGRtlxc8nHqpAkxmiGmWf61A0S8z9RaMbXaNBDNA8S69tM8Le8xVumidkOjj8E1TDeOh5FcS1GnezZCzMm9bxevG2xE7MegxF8qxlB90MtSlC4IPyD36HlfJhvp5fTEXAz119LkP5HMQbLpL4XNAGIxZrX4QR5uIe3CRI9AJu4jqJFGCAAWpuc4tVRc9+lgBolcVlT8rLttDBG6SYuHTkyH1SkFH0jQYB50I=
X-MS-TrafficTypeDiagnostic: BYAPR08MB3845:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;20:t84heJx586bin88j5vWesqkKXBDawYYMxJUSUVY9Z+WdmWNCdGolInxS1t3V1FoTnU60cfWjTh6bqY5ZOI0xVBGPFHt1K+wGhMo1H+YfAuYmYNmrMwy8q79YjGMqsg0EpbSDbOm9KG/CVu7V5g0sWlk94WwO/IEloSUTHigkkYlpAJJBXCLiktGeq2jJwXrwIWNTKYcCa8wjcIC5F+k5fRPooFFSJzK/gWWgpmvfgVoFaGfRBuJfAiXhfneXODqVayy3qj8ffehoe2aWFJYD17sb/58HbiXaA31F3GNm1k82lmlEoBgz+Ncii867yLJ6u+EaKVhlLO+lEPbgzQjze1HbOZRdzrkWNdjgUXeEhVlb5OXSiW6aGYBbp728E9Fr5Qz9cDsBLJUtoXMScjJws3WkH+T52OwafM3yqM2zNgLisR5fQFpr9DbBCK/fXAWCw9e0IAob5LXPIlcQQoaZlpkuVquHf3DhAYqaNxhUiVJ4mxgJ3GiUv0r7mAwKDupC;4:voDAByyM6YKD4NyUDtFhKWR00V4biKYlyfD4YBDbayufpeDpvv/n/9ntAjTVImILQQs+s7lAY8cUXKU8GMopovkUALfsZ616QnIVkhJhydPfDVxU/rSdFZCaCr66InmpQK3UC99Fic3X27JkQGOQ3KQ39NvhXe0l2NZslPDTGAufx3gUKIwEED/f6DoR2bc0cueh84S6eP35ZA+6yp4J2AZ0HEPqImTwNy4vmQPE7m21rebQHL4ZnGtaAYm6caujw2aptyW3psnSEfjllNojWw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB3845D7DD6F1157134591970DDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BYAPR08MB3845;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3845;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(199004)(189003)(3846002)(50466002)(2361001)(48376002)(316002)(446003)(476003)(956004)(486006)(2351001)(11346002)(105586002)(2616005)(47776003)(81156014)(5660300001)(16586007)(7736002)(6116002)(8936002)(97736004)(66066001)(50226002)(25786009)(81166006)(51416003)(26005)(305945005)(478600001)(76176011)(386003)(6506007)(106356001)(2906002)(36756003)(6916009)(52116002)(4326008)(39060400002)(68736007)(16526019)(186003)(229853002)(53936002)(6512007)(8676002)(6666003)(86362001)(6486002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3845;H:amazo-desktop.cernium.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB3845;23:hssEJzuV3OYo5xMq0vRThN52hXmING429T61HbxTu?=
 =?us-ascii?Q?4UNvCL822fBfa5IQHdedySgk5TrSfuWlpEj0oLheKmlaKmphUR/wxkU7SRTt?=
 =?us-ascii?Q?pPmRkHD+DfW40rBqa3N/ipF0qN1s1DI7aCMbHObY7kvQvRTkpJToMs/6ZHjG?=
 =?us-ascii?Q?1/RmpcMxjQydAt8+2DCTSTKfQLQZbrCifZ71IyFPHsRNYNteBDppe0mmvGYu?=
 =?us-ascii?Q?w+RbywimoTkAjA49VthYJvRIdRyZzZMeSXvIlxgDIPhaKwvIzCCJ7KFeOUJ5?=
 =?us-ascii?Q?PvDHgfGpT4+h6DU/cNC/h/qjAmC5NLQpSBkfvCzWdYK8aFE5Vay+Wkc4nNjX?=
 =?us-ascii?Q?LnsbmPTX1Z/I4eiuPoWXrsz7jjk3Pr/ejAi4UgUaEuk8nTdo+Wo1Uuvt5ic4?=
 =?us-ascii?Q?vrYSugx2h2Z/dnoaNoY216SdZVB13h9vTbFf429FcTVOIaKku4vrQUel3PvR?=
 =?us-ascii?Q?B+p60t/rR7+ZPN9Wfqw3+Pj9iMY2vPKII77G+x0tdRH9dSauqyqjtYmi7Ovz?=
 =?us-ascii?Q?2vd/UfVQX2HSFadPBjQv5VhxO57/35PCdaeww5ts2QQ7zWfLldOZteXTLEHl?=
 =?us-ascii?Q?FwjhN1r25ugvmmK0bzE/EkKgqn24+goTEz0aruQs1SbeqvFPShsntq3FmD/a?=
 =?us-ascii?Q?U2Agv6osdvEekjsFsA4gJHR+tycRsH8EIPe3fQ835bCAz6i6hjzs6xdXjbem?=
 =?us-ascii?Q?FPQEGwuJJOdEr25FEVvRGUZvHuX03c3alqsYLlHhze3WqvPBNqABdcX4HIk3?=
 =?us-ascii?Q?mWvTBRTVGtM+zU7uBwy/X6R4XUhLEFkKeIw2H9QDG/aGC1ez4rJohVqOojsT?=
 =?us-ascii?Q?yTN+Bvze43q+vELl8mN2Awi8nrc3ig0dN85bCSGpRyDe26P7TJ+9svG+2kJg?=
 =?us-ascii?Q?M8Drmc8wZVw0RaiQFfgZlYLtFPbH2nS12gtHlXNUe7oMVXZlptcbBM3x7uKL?=
 =?us-ascii?Q?v2INvyjfU5GcWR4ZgA/gP6askO509UhubMsNmfcuy/00bDymfPAVnUlE5Bev?=
 =?us-ascii?Q?T6VQ4P8+LrtOnUiuFGHtdpZl/CjMBz/O55HleEQ0MkVLCnZ/svJrcyPgLZ0Y?=
 =?us-ascii?Q?0+VykBNW+wt0R0RVxCpO8DNesK19OjVOGhmPXCV6WTgnrtFzISEfe0me0Y74?=
 =?us-ascii?Q?wetu8eUK4FlL5qv2d82X4hxlubZVlkd6sxGqRlA09yGLWtlrBiiMlbQOlgW1?=
 =?us-ascii?Q?rkgE9QTU85IoOqOhxmDNJKmK/vMv0oI0zMAFAb41Xj1krR7XYU4jDKejkl34?=
 =?us-ascii?Q?0p0gr/HWzJ/uYWGqCGk8GoS6hp9EIo/g+m7ixQDx26EmKSR8wix6lh2sjYaj?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 3z/v6u3ILG2HnXTU27o/2MTQ8tff3Q2XKtCHl1l27UErCOReCE6ui8vuxu9vDCA3+INkwyYMDtY7nYPT3q6ghVSyUycYf80TBrBEApBPqWCdMJQtLZR5DmihuAeUfmKNBl5aa7AGjbw4069MIdrvZlxIs4Ldz8ZJ4a5jdNR0CWdDEf/WzmwvSP4ad7mClkBT
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;6:yqdGjqxdGuKJESjTfHeLLD0NeEA4lUV8vKdqxo1C+h2Qkds5f2vj4oCyAmgD0HNKA4/j2l988xshYGMVOWyaGy0md4dNsaE+jrVSe5Ug0+TedCcwioVa1OdZM+ORVJhS/ARgaWHKGBrTFr90pU1ONGcMgG0CMOAdt4SXwg6n0cxvsqgvI7dEcbzf2l8f80f2J2ifReJsMbh3KypOH7Zed61It14m73nvd+UTvA3Tq+FiKwnk/xd5Xfn5MVfSaqZx0YOCakQS4NGiN99C5MR5M46qEiQ+WddhPCc+0+4h6RmU0DodC4QXszk5nN1GqlQl4VPCBRSW/cNLRLANO8JbvEvKSYicXRssX+oFbmHYDpp2LZ79ovzI5OzwOClK6rkSdC428n4TeCO4fdaLyqOfPlh11xx6Xrz8KLMIXcPoU89PuKYglye8G1OoHQ6X4xaI5HWcogKv17hbuNmhD5g8bw==;5:pFvZBabYPjojoxAMvOmVFtYtsvv/faq9po8wGzm8ClI0eEdA2Re3OGsWzU99T6VoKxETmsMQ8ZMP041hrYw7e/xWsHXlqy+f3ZpwhsLjMXb9ZO75dLmmGp/ydXOBriSSsEYyzLzvDhQfQDZKBh2N2g9nlQiDRgR6DUFFk3r/L3o=;24:cKzpzg1JBDK0CdLG+G+MEMTDNfQCT9T6eIzy9wjJJgN9ELks/G7ajGR2wKOywe2liJSC8ANetLPNFPdCCOIskijkkR1LgM7QY2T+CX/174c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;7:8PcLKHvSAtk9Ho2mJ6Pz1R075AAkvYD0lS1NjN7vF6Yn2rYksyMZrpwaEpEc/b769RfqfrjT7gDhM+ThTvcPn4TYUN2Lppmnu18X9wHVvpatIMzprb1k1OAlqh4Ec46JwpWGyOeWmjV+rG49CeHglrkLdIqYPN1cCBejUpeRo1u3BiCkI0NDaSgrH1P5sJK32fw4A3YUT+6L51yvE+7KPxxacHtE8zGf4Vr/oF5EPSNBCOTxw0dJ0mCJx9lN9TV+
X-MS-Office365-Filtering-Correlation-Id: 0d34e0b5-c541-4070-e9c4-08d5a47f66ba
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 16:22:22.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d34e0b5-c541-4070-e9c4-08d5a47f66ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3845
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Huh, I actually have a slightly different fix for the same issue.
It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.

Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.

Andrey Mazo (1):
  git-p4: fix `sync --verbose` traceback due to 'fileSize'

 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
-- 
2.16.1

