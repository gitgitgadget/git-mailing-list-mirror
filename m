Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB921F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFTOcg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 20 Jun 2019 10:32:36 -0400
Received: from mx0.karlstorz.com ([62.134.46.134]:26587 "EHLO
        mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:32:35 -0400
IronPort-SDR: S71TyuImQyfMOu+zixCcOBFFQgp9oIpkDBkjVzfltjPvlO+odE7pGnZ7sliQ/kFSUbKm13Yur4
 xmncEVYj5I1+qhsSClTpYn+8jWGjvONgEpbCV5tffZJM0I2YRDOgsmuSjQVkdaj8/sW+8Rrmf+
 cF2mD2hxWRzJsCqZmZliKuhcxkPdDKLXBiIAed/18Qx1kecJWzwkQheEkfg2eqruNWaRUFQ1CF
 h0OHNRV/uynm9xeNCpWgBeBNNCOivIapZuwvHBtGd9gNcUyKzm6jqyy88zTV/e6XcRgiS15xJh
 +iE=
X-IronPort-AV: E=Sophos;i="5.63,397,1557180000"; 
   d="scan'208";a="837385"
Received: from tut-ex04-pv.kstg.corp ([10.0.10.234])
  by mx0.karlstorz.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 20 Jun 2019 16:32:30 +0200
Received: from TUT-EX01-PV.KSTG.corp ([169.254.1.209]) by
 TUT-EX04-PV.KSTG.corp ([10.0.10.234]) with mapi id 14.03.0439.000; Thu, 20
 Jun 2019 16:32:30 +0200
From:   "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: specifying revision - how to enforce matching a tag/branch-name or
 revision only
Thread-Topic: specifying revision - how to enforce matching a
 tag/branch-name or revision only
Thread-Index: AdUndPq6jw27fdRITDCM6LgaQQxNWA==
Date:   Thu, 20 Jun 2019 14:32:29 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.10.41]
x-kse-serverinfo: TUT-EX04-PV.KSTG.corp, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/20/2019 12:58:00 PM
x-kse-attachment-filter-scan-result: Clean
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I discovered an interesting problem when using `git checkout` to which I couldn't find a good solution. We have an automatic system trying to checkout a branch only when it exists. To do so we check whether `git rev-parse` finds a commit for given branch name:

git rev-parse "${BRANCH_NAME}"  || git rev-parse "refs/remotes/${UPSTREAM}/${BRANCH_NAME}"

Unfortunately somebody used the branch name "add-gcc10" and `git rev-parse` which didn't exist on one repository. However `git rev-parse`
also supports to parse the `git-describe` format which resulted in checkout a commit starting with "cc10".

We saw a similar problem with disambiguation of tag and branch-name. If there any possibility to enforce that `git checkout` and other commands such `git rev-parse` handle a revision as a specific type (branch, tag, commit-id). Is there something like
`git checkout name@{branch}`  or `git checkout name@{tag}` similar to other rev-parse format such as  `branch@{upstream}`.

Best Regards

Heiko Böttger

