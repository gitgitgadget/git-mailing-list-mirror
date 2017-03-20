Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7127D20323
	for <e@80x24.org>; Mon, 20 Mar 2017 05:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdCTFVm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 01:21:42 -0400
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:10191
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751485AbdCTFVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 01:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector1-bu-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nwDkYDKNfGKARWj1DqjmpYY7yfUyVGJs09c1YDAq67o=;
 b=bEE5Ha1iIbgk6xJG0BTh90yM3FkXX0FsajV+zzxZM+1E3BalIe1HXl4Y/deuwFEOKx6igBs9Z86W/3Pbce7dp8kPMRMmejuJp7ViY0udwbupcg6DKRL5h0SQcRyzaKjonU/Zw94bvm8OGntv5JkH5wGy8/jEGqxy/bDnh02mVuY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=bu.edu;
Received: from [192.168.2.200] (209.6.145.46) by
 BN6PR03MB2612.namprd03.prod.outlook.com (10.173.143.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Mon, 20 Mar 2017 05:21:34 +0000
To:     johannes.schindelin@gmx.de
References: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
Subject: Use base32?
Cc:     bmwill@google.com, git@vger.kernel.org,
        ijackson@chiark.greenend.org.uk, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        torvalds@linux-foundation.org
From:   Jason Hennessey <henn@bu.edu>
Message-ID: <27077870-76d9-b45a-5727-c339a3d0ffc8@bu.edu>
Date:   Mon, 20 Mar 2017 01:21:31 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [209.6.145.46]
X-ClientProxiedBy: DM5PR22CA0006.namprd22.prod.outlook.com (10.172.192.144) To
 BN6PR03MB2612.namprd03.prod.outlook.com (10.173.143.135)
X-MS-Office365-Filtering-Correlation-Id: 2f188512-6872-40ed-4a0f-08d46f50fa96
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR03MB2612;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2612;3:LCQSsBn4oQkCtnAyTuVXl6cvcLg4W74Wq1n+ro9SKkDha32ryP+ucbHbYqMW2qz0w6M07wzpw1thnfBPDaf61cDTh0v856RVC+lKObgWJoXuOblwdl/147T0mQ+cakmLAQkrF/D32dt+y7RJM6W7MuQnwx+vV97E6Qjx6d38XRoERyIDTL0WO8HWITbo71lIiF9sJ6Kc+R6KPWr027C2Ik/dc4IBH3XOkYHmh68OYpqrNOzcRHbet5EG2ACxslMGpVMkvQ0OclTbynxlKU0DCA==;25:nn0S3vXn68DOMvnYQ70iwjJ17bl/xHZMdOFaaO2edsUyjBNU97R/dr2YkF9UKXQKc0gylMN1UvjqWBo9t1HGeM8tb+oJOBylsVEW3za4f2Vz+wOyNI21csJ0kLF+STiFWgmuNxCoQyRXdPDx6rtXgjOJC3wEdMo79WDRZg98cj2mYXrQu4oQRAZKhMGrYCOPRoP9yWVmUf8aFOigvBY0ny15fOykiEL30Mm3ACfVw3e9w7GN37UrtKJbSHBclYo8odLMZzvLPtuix/Kv5XkceO4YPHjFQwQaYrVVSNW9TEYQxWHD3yC5y4K1RDDZnUNMM/6XIoLPUCS/HkbrBv6HZRkSkuvaLdyRmINBvkxMA8pT6APHHuAt4YbAHVll7KFhnHmZ20LM+cEPtDDQxu/hqtXz5X3S5+bmseJppdeIy8oewBtisfqbPY2H/5g2ptXPcXGuAicef0i/xaBP7Quv/A==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2612;31:2hDfdcHLamLvYAycheXL5gxvwSThSlAS+c0STqYk8OUmyGNuMTqyNhLM2q7ziYbH1OepfWaoOCL9dWdo7G9dA9OC++woPxCg9uY/bxE6H9Fid4KBhj+mk6bdkhVDSTDaGnNFCbmLJeAcbJWWwDsP5pDGjasa1MHbEB7XK5U2Dqk6m22PORRMSeTpsSQ1aJ3AspbTwz6G1tcp98zLoFA7lBdMBCP2yvAi1vdz30EsIBiFeW8NcgIVcJMsM3Gtq1ikI1GH+JDeGwjtoaKRdjSbO4NEDLmVluobB+6dAsXpYfE=;20:VfKsL+hhfZm6xLp8zyiYQPgG/uSC6LcO30nl9SPiFXdOj1D7LjARgjBISnlt/Xq0JmIQ0P5Yx+S1lLgoHFNqg+dZVMQZ5It2vNdnY4OMxSr5xB6CHmswC+6q2XwJRs06dLFjtK+SavcwAU9veh0+blylKCRJlv54PTkOuC5ljpnhUD9v0oy72JeSxl5SfZ4+HV70Pwb2guWyIW6LFS97PumUEGTB0TaVsS/9PQTRkKOVLA+6hVa5wBDvWr2ybgdG
X-Microsoft-Antispam-PRVS: <BN6PR03MB261288A8B7609CC8615E71E4BA3A0@BN6PR03MB2612.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123558025)(20161123562025)(20161123560025)(6072148);SRVR:BN6PR03MB2612;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2612;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2612;4:m6DpPiB+J0QOIPp5qtM9mAaOPAhtbhyBDynuP1GjD8P8hPWsRDVrMHy7t+KrTrQZpFWz2PgiKZp4+EKaAdBZipGIeAP7VUdiuYXEUPIjo+l/YWvtx/aqy38jmiU7OgPp5upFDxGdsyCTVztGJwoDrzsiU2Fc/FK6jVgLfAsmcCpLx2dqA1SQ88RMuGpNjiuXXJOdNJUf6mXhA324gRpcwkko5FB21cP+E6GFNFlNF5Fy8G5Key2bPzyPaAYtKR0lqRtekQFeK83L9PiKqaE7zRn6LM4lCv+Kve4hUR9cEFgipcb9T60tSHG8AfNCAhFDAR5Rm3oSmZYfUgVfQCQ8aozF0RRIq9mTMlG1Zb/OsqlaZHpkFLXdcmO2j1OKCiLC7mbrLomB9vHbuExI4T01EUq8bO+fni9tivRhnJDGLwdXrQs50mEO3g4AcUKG+uRdNxHKmpZKnFB9RLVPcUv17/tQxwZAV581b2TlyOpvVpkmoBfmhzq02TcP6RTLcLPfdGBvpnTgRWi0QwK9XoBSbECRFLMdV1e8aNaTETVfSmdRKX67CttgrWcwwh+eqsXRdHUE6GoCXyWEki62uWcxc0Nq/Um2wTwpPEGGwkYI6uM=
X-Forefront-PRVS: 02524402D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(979002)(6049001)(6009001)(39450400003)(24454002)(52314003)(33646002)(54356999)(42186005)(23676002)(50466002)(86362001)(76176999)(4326008)(31686004)(81166006)(77096006)(6666003)(8666007)(189998001)(75432002)(6486002)(36756003)(90366009)(8676002)(50986999)(5660300001)(66066001)(2950100002)(31696002)(2361001)(2351001)(6916009)(3846002)(53936002)(47776003)(7116003)(230700001)(7736002)(88552002)(110136004)(6116002)(25786008)(305945005)(38730400002)(2906002)(117156001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR03MB2612;H:[192.168.2.200];FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNjEyOzIzOmJISUdoZitScDN2Ri82QzY3SGlhUTJzb0xt?=
 =?utf-8?B?RFdMdFR4TStKMHkrdkUrVVY5djgxcmtIaGFVVkF5eXRScmV4QTRVYUhHUmVm?=
 =?utf-8?B?RnBraXRGeWNQY0VOQkNxaS9mTFZsNVVYa2NtYjY2TzhKSDhpNFhlN3BkTnRo?=
 =?utf-8?B?L09GM0crSjRqdGhBbHMyQWkvMDNZalplaEJDdG9xSWlxOWJveXZMMU8yWGt2?=
 =?utf-8?B?MTFiTmxrOUpCUndqMkt3MjQ3ZFZqS1o3WHYvdUJsZUUzVWU1YXNDdGFjZU55?=
 =?utf-8?B?bTU2VlpCaXBqWWprcDBIcnVYMFJPVXlDK04zL3JLK0hOcWd0M21sY3RXNkZ2?=
 =?utf-8?B?UVhBOXFnSW9GSGtPMHAxZHJjVTRTWVlQQUN1b0t3WWZjb1NqUHFmMWkzV0w2?=
 =?utf-8?B?TVhiRnBZVFlFdkRNcjVma0gvMjdHZHI0YmlHTHFvdXJXWWhISGRPclk3ZWVE?=
 =?utf-8?B?Zjd5MVdGQWs2aDlKaHFSVVdlUGQ1djY0TFhHR0ltenE3T0I1c1pPVXVzWElT?=
 =?utf-8?B?RnBEY0lYV25HR2R6akNCZW14VEc0VTVGdFJQYzl4TTJDZndiU3IxeER5VHUz?=
 =?utf-8?B?Y1lMLzdQa05GZUFjb05mL2QvTWNKcktBKzhiYlhOUVIyampnWUI4QnhsV2kr?=
 =?utf-8?B?MlF4REtJK21WQmhRK3E2cWs1ZmJEQmtURFFzaXZOTUcxaVBzRG9qV2twRlVH?=
 =?utf-8?B?MzhmS1dkNjZhWW05YzdVakJoQ1EzZ2NzU05CZ1hmckNjWkh5MmJabmRVSW9S?=
 =?utf-8?B?VkRDTWVBOHplR0NmdUtndlVlaS8wVm9ESGlQREVLSnVRdTRzR2dxU2NzUnNI?=
 =?utf-8?B?NGdsUi9OdG85ZVRUY3RGalhLYWN2aWt3Z20xeWF2UkoxbWVSSk1mVlRCSlp3?=
 =?utf-8?B?d0lTc0QySDBkYWYvZ2RjTjFoaHNoNlI3QW5vRy83ajMwYlZoalhwanZyRVI4?=
 =?utf-8?B?YUJWZDN5dzNsVW43c0xucHdveVRoV2pTcmQwcWx2blR1NHZIR3pxdzhONXpV?=
 =?utf-8?B?UkhOYVk0bXltd2JGMGg5b3dNZW13M3U1Zzk4ZXUvdS9xZVZFa0YwUTZVRzVU?=
 =?utf-8?B?VjlnUWk1RGpVdEF2cUhaNUFpdzRRbExCeGNPcUowcW83SDhHeWVSQTdPSllk?=
 =?utf-8?B?eFVEWDlOUE11ZUNnWTQzeXB3RkhKd0EyQ21ON1UyeGVhdUs3MVNlWFBqUVBw?=
 =?utf-8?B?MDJ2aWdIVHlHdGNSY0g5R3VTbU05K1lObjBBV0U5R3lkQm10ZmppK2lGZDR4?=
 =?utf-8?B?eVBkcGJRSFFyWmRDWXVEUnBzVm12Tm5ISC9lV1hJL0hlSXczMEJRK29DeFRU?=
 =?utf-8?B?d0I0S1NaMXlUOXVySlZyczhXK0VhTXg3RlR5UndrZTN6V1R2eHlPUWpRMFlH?=
 =?utf-8?B?bWNiY3pYeGlLZkxxSlovV0F1cldtMEJMc3N5d1Z3Z0tCK0FLekp4NlllbG02?=
 =?utf-8?B?UG05UjgxZ0xweVplS1YzUDFNeVl4Nmo5aThreHlBSm9Qcy94a24yUXVkNG5O?=
 =?utf-8?B?MzV5NmM0Vk1hZ0VBMFQ3THFpVEdxVU9NZ00rWDZ2YW5NWnl1RlZZY09jN0E3?=
 =?utf-8?B?RnpGMmU2bEtQUnd3TndmbFpmWWJ2bVBKdjlBTkZEYlRrTVRQN3dxRFR3cUl3?=
 =?utf-8?B?cWJCV1VQeEViU3Iybm43UkVoaUp2S1hlaW91cUptQzg3NUhhN2NGczZRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2612;6:MAMTRSbnKZG+dGSV1RbtoaNfFp7eFVd25/mQLMqsNpkgeDePI/lq/gblTX4qF02woYwVYqzmHPqYyFg6HGiJfQvLha3aCT0Z8S3m9p4yY5tW7rFmgh7aTD63Ys404Wmok6En6Vc7e6Ju3jr4k6Mw+obEj/bP4LmE7nSzW/I+LCdrTGEFycqIa3pCgC9nvrQNgA08kqiYvSwHHByYoOIDXgRLElAgxSb2496BGjjpmdGgb5TYlhhYP18GDqp5LZnPmKZEEt4YevF2tONAiR/gOF37djUXhQModJXyNICvNNfKO6tfmSLYC340TI1MuL20tHKBDgW7dQea+PtMhFNi3hqncFhjZ/ws6v1gAp6FygT7fI7vyr827sXP3VLJeNoodFvI50UOJiq7fAzGMl0UYA==;5:Qiu14r06s9x21Romoo2HrOyn/J5mI/Ohr5hPxZlu9S9sAL9CWCY6FnNHyYxJxHoDFVJuBE2bc+A1Bnwb1Z0npwvun2BoznjbOOWO8MNLzb7JZYrVV5SCLa8sCWcHsR5K5noVfWwPyLieYP6Mnn1ml+8HoAVQ3vT88vd/ZPqF10E=;24:tt0pRRZsFip1WXHGoZqMLdRz8N1ybfu8PxX+GNTgVVEJriI7pZgrFiobn7xds8OdLj9JXNNlmDMUjiVv3BJBVhBFRPbgyR004n2v/HTL6L4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2612;7:RyPOvSc0I8HDTuRtPlpq2HQ2yB1IpiEr5rtaQ1OOA6ndsGIrEJoH0xWkIqqDb0iQAV3/CBwcAUUmS7KNdiv1wVe03n+fE8QYZ2k0qGJxDyNqu9N9S/MSNeG7bUB/bM0vuKao/c+w0f9JDZ4XjvBIy+/E+d8S9IrEXHr8fOmPgjOB2yGSbyds+eRuLO5gdN1rsStUipuEt5bImyrHbOPXB/SXX2CJv20/yBF+ulib9CqGookwHJ8JhdcJXoWINW1K1fPRug6vg4ArOOQdi2AV80rlFsF1GNl9bBqLRwnFNbYPS3jgBnLphuEYDpRWa7vCohbxKq9FkQp0nPh+zx152w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2017 05:21:34.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2612
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 8 Mar 2017, Johannes Schindelin wrote:
> > Linus Torvalds writes ("Re: RFC: Another proposed hash function transition plan"): > > Of course, having written that, I now realize how it would cause
> > > problems for the usual shit-for-brains case-insensitive
> filesystems. > > So I guess base64 encoding doesn't work well for that
> reason.
> Given that the idea was to encode the new hash in base64 or base85, we
> *are* talking about an encoding. In that respect, yes, it can be whatever
> encoding we like, and Linus just made a good point (with unnecessary foul
> language) of explaining why base64/base85 is not that encoding.

Since the hash format is switching anyway, how about using base32
instead of hex?

Still get a 20% space savings over hex (minus a little for padding), and
it's guaranteed to be a single case.
Jason

