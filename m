Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D345C1C
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735147403; cv=fail; b=cw8IvmoZp+P1y3dkpEaMs9ESrF64aYhuq2bdY3OKcP5nnLg0Xj7IuM7bY+RqwN7GAOtoGQMSJgWNLkpAjLqW2XaaYabf1LmvZK5OCw6jczTPbvIAXYsuJnsVSjEYO5I2EngZgLBJ4SZw8zXpXcsZtRZOw6KhxTMuKjcBf76yT6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735147403; c=relaxed/simple;
	bh=fM9rb8TSxedDPE049FeV94DFEMp0xhDxZ8MDJtdBAds=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OEN/dCPaaEN1QQ0PMFviOJyIAMVTZmMKcN/pMGQwdAIYGkKlySU1Lb8fSb3JyL4NKv2q+6l6aZ7QXja0J3BJH8ci0/GOxY4/+5k8njFiR8btk1Z4TcWBgZNOMznqm8Mdqf7mLDV5rtdfRkFWyRvAnjisFdMiFHI7rLRFAnKgUNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzbue7kl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzbue7kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735147401; x=1766683401;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fM9rb8TSxedDPE049FeV94DFEMp0xhDxZ8MDJtdBAds=;
  b=Mzbue7klvSD+Kv7NKZKGJrmsiuHhZ8nuERT28uO6QtsMQyIf9tmudYmz
   NDq9OQupoesrf5ny2If/cXpTBsOpId/Tt7q8j/2cw1UYHqzWo2CQCmPpY
   Js1RL6mx6ZRfsMVrgGLSOp2YU6RYj0Bg4wrvF5Q1xAyhdIMOFy0YPmD6o
   hyuqEch4FTn+KYlE+GXGW5FNDH2eB3JKTLPYyr8wrJgsAXY4mOW4Zx/F2
   IHpDpVMJNJK3xuk1nXDl4z9tQtcf5dD9dV0dE7OpRexCqQBzywIgG7/UQ
   qvbOd8dxpBYZ1YZ7BycZ4LVI2JYZkzutxNuvePd7wIFkZEzobzBbZbCmt
   g==;
X-CSE-ConnectionGUID: nYlTFKjuTqeQc2DlT2b0MQ==
X-CSE-MsgGUID: e74uqt4gQkyhISydAywXeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="23178697"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="23178697"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 09:23:21 -0800
X-CSE-ConnectionGUID: h+mvvqcbTQKzK83aOaDDvw==
X-CSE-MsgGUID: XXByNmgkTKWVj25edwE8wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="100109914"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2024 09:23:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 25 Dec 2024 09:23:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 25 Dec 2024 09:23:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 25 Dec 2024 09:23:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk1l6unxdmP07MZN9XjdhI4lcqSMxtN0rWLVw3udV2oyv3HaSO0ER/72ePyKtyLLDdN83GEl+H4LkkxsSm1Tj8j+YN2PlLcukbDSLldY6k8dIOLgq3ks0e4orsC0TdttMdUT04tpK+l7C+uEn2xn7g+8jyJFJJaOAJTo1VbMCnX8xAKrFYdixsLyOEWuFL97+qJoBMv6Zy/jgfu41SBkCiGnAEQ71fp5m5byecYum978xNj6HOJclUbv3rhTp72JdL0GuF9UgRT7BCHqv1iG5rcrD1lNH/+nI5uvx2Cw5rfm/wFuHwnBKEe3+Ols4LZWUa8xLC21xhcN2GRxRl8daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pYYgdhATdYCO/J5/rKlvN08vArdAMqUksqcmNEjIFY=;
 b=svfs4HwaUe9dulcN+sy4qQizxXuC12Ou+HvNp05MOjiR6lUlvWySYs1cgJUY365TOA5NhC3ok62yQraeup++c4OWmT/HTGKGXgkZXVQ7uL+7EYOr/6SlkIFR5AxxRLQqiSC7XCH7ofigJsZmBxJwFoeaie55j11vcsgCG2pnDp9rdN+4KGn0GAwckH+pJqmVro45JFvJzGPONKeqtMDU7bIDnuwSu/4b5EcSwTPEH9/OMDijZb5mHOU6L6a0xrXC3/E9F7hiptSIcAo9UqPIo3S3ozmtRrNlwew5bxuBRosMnm8dMk/qFfWxwqm/ITWPTClLXG0GFRoQeeKUG0r4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Wed, 25 Dec
 2024 17:23:13 +0000
Received: from SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445]) by SJ0PR11MB5814.namprd11.prod.outlook.com
 ([fe80::cbe1:7fe9:cc13:4445%7]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 17:23:13 +0000
From: "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "git fetch" fails for a --reference clone after an outer forced push 
Thread-Topic: "git fetch" fails for a --reference clone after an outer forced
 push 
Thread-Index: AdtW8agD8oNkxpxFQYmlXNFV0tRXmw==
Date: Wed, 25 Dec 2024 17:23:13 +0000
Message-ID: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5814:EE_|PH0PR11MB7660:EE_
x-ms-office365-filtering-correlation-id: b3704398-f98d-49fe-a39f-08dd2508cfb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wBP8+EgSRWXDmyqFcgDFSiJO7zqkeUDR0HURu4p4RsdMQk1Q5i2+7NICgz9n?=
 =?us-ascii?Q?jsYoiVSlGSK5KkZVyVx2QaLO+oMaBvpEAtLFQp6/O1Mqa85GMbjZBxu+QmrU?=
 =?us-ascii?Q?YSLDtJUBCRSb1mcAX9JCokoldIWUKRaObfGArjWTXup8udYh9aMnwD9VPsuc?=
 =?us-ascii?Q?AoIZ1d+KRRFbJniE6hx71EhZ7J0mY2uKN/1Bk3skFsiXyFEaj3Apy8YMKFZy?=
 =?us-ascii?Q?sSDVKduJSBXRLRmIGVP+smVLNfWpTgxMMExyatmFtF34MUA4yDqn1RALOMWF?=
 =?us-ascii?Q?7dF3oJTs0bSma0zGsqF7VqzT64N+ox34VdN/ziIutb/WVkZekI2MUNR2i492?=
 =?us-ascii?Q?LVk9mus1gOBmJdlHxhqk+Z5wzaa6q9+y8UInJrxIOOf5sdemytbFsUEu5Zqw?=
 =?us-ascii?Q?YUxZMfN+uwlqSTngQQ0Ch9Hqi7H+mtcTabgEeQdgK9UTbQwLJ1LX71wXFso3?=
 =?us-ascii?Q?ZA0znQ2BrWk+Xd+SeY+mebZZToDz0UvIqYCWGsQIxVir/VWycodG82+z2kH1?=
 =?us-ascii?Q?N7NNpEcYtpSbUfOFmUCWpZEU23feiGSWF08l7Ff+Yva5G61V9Yx0+S2o9fC0?=
 =?us-ascii?Q?Y8aRloTGmuC9DdHVVLKNpRj74D0xxeLKqdakUdKdBNp2RWTpJe8F1cJ44qH1?=
 =?us-ascii?Q?qFy8Zg16Pqb6KemGULaXFcy4HdoLwSROHGwrByLQBCPZkuqBcQYJ1LIoaJA3?=
 =?us-ascii?Q?DvyUY6TDC4X3CIuBqbl56N23k1+D62BO6QpqiQfnTto7eEaocmYTOnVRKaWY?=
 =?us-ascii?Q?PplSq9m6j6NVmaEp6zSvz8RFWIBOb4HicyeD3mY5D0gfAivm6j5z9nQb2f5C?=
 =?us-ascii?Q?7ipBRZE6p/aZhQh4M1+E6hBI13vK/sm3mXNvtKbtXiQAJYsMVTfKc5T+nP65?=
 =?us-ascii?Q?58/sP0jbz+/BXvZpuvewi6JYwbHkoIFBDuJIWfCknlkQyJKGdg2hadQ/v8Dl?=
 =?us-ascii?Q?ro6p/v3aYJiOBk9T4o2MJzN5LLWtL8KM5rLI7+VmRTJt9LQ35Vg9dFZAIbMk?=
 =?us-ascii?Q?O7OMsStEezcFq0V3K01YkfBKX0xY/dc8vZVWQ7F0bjE7EgWEXLR4x9TGcBnT?=
 =?us-ascii?Q?V12YJlPkHppIzdQ/LHmy3yaivNaRRJYKDqie83CchiI8UGro0ebvt2BR7cB9?=
 =?us-ascii?Q?cn4vdABZl38hQzwAcCU8/SEtRxWYUqgO44pshRZ7AWnZEa5wgGjQlY01LJZt?=
 =?us-ascii?Q?xmCU16lCE8m7n2RWgXzegzb3hjCBmxN5RfG+8LRz0LknHRSqQ7NgD8IN8xPV?=
 =?us-ascii?Q?IYOZok2/xAMpoKbVcxkhjHUVmeGPeJOiFn1CoI2gWArwLp3l07KCvOP4YOgi?=
 =?us-ascii?Q?+MVaZ4Pzn/UwGT/hQw0GwDMkhzrt4xVT42J1BCM8P0ci+L8VprqelGDqm7UH?=
 =?us-ascii?Q?1v8IISAWz0V7OuH+LeBF1PjqBVpn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5814.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5DbADM0nht+f6G1c8j5/3fMiMbHLPd5rbu5PWmmLREuYpJG7qcNz1/iYl2y8?=
 =?us-ascii?Q?hXC/fNAUtX5Hf5zP+zxl83ihzljydHLueNQ2OaB5/HY4/IAKtpxaYb/i00yU?=
 =?us-ascii?Q?LsUc6l+Fsc26Gg/R1lgopWGxRNumbkPbue7zxXCJu4qtXSIeKeb5xxcjTOyf?=
 =?us-ascii?Q?8bhM4o96XLJInT2kNhG/a71vvf2pLfol9TZQwTYDcrSV4VCMoctdEMibfmk6?=
 =?us-ascii?Q?4xXG2IpxS+uxqHpWJuTPSgV+GakjlNaFHcpklDfhIP45enKxXT/QpWSYPCEf?=
 =?us-ascii?Q?QA1H1WzXUOekDo8YnSYxmsK4VKMUpj7CkcUWJ5jAuA3nTmnStLSKtfzA8btv?=
 =?us-ascii?Q?cUlR6AZctcuAnB+NpVJ+hqTyEZERrH68FRwvDTKbUqmBeDH2vrEuxas29ilL?=
 =?us-ascii?Q?M4HUQzXbP8RIUiUv2u4mMDgDTNTXoCvV8D9NBgFs1Y6fgmwKeefNeBgXiaR0?=
 =?us-ascii?Q?Fv75rh1XV/nrTmMLqDlohgrAl/sOUsNgQpMHHhexFkYfZk3Hgky9qdaoBiz5?=
 =?us-ascii?Q?Lagt59wRa0p06mbuzbFFfN7EPrChatqOz/Yw9ATRB0PeQuOu2spOwPENHQVe?=
 =?us-ascii?Q?BTk6qQNSYVKzX4waJW97CYsuUBBeCoK4nGxLUyLkKYz029fgJRNSv5IpJliL?=
 =?us-ascii?Q?NEcexTKFHHlkruqs8Y3CT4rmcx6rx/SK48jaQfjyNSm98uWdNxvkEFyNHr12?=
 =?us-ascii?Q?N3Bpy95KU+1RgbEWKfpWKhuUotKOPpffsxjM4VlhRkWuyNJnI7mmVhyNBtrW?=
 =?us-ascii?Q?LENKCxfBaXavZ9yWk7yAyKMGbzn432zLWTDdKo2375ho7NzqyxwdwA//q1Gc?=
 =?us-ascii?Q?7WtX+wGtNkeDFsOYC0WdWyNwA9G+WTbw9d6LK6flzQyV9RdQczVVj3P8kAKV?=
 =?us-ascii?Q?zcPwAJgcw71qoTGAscBdWTaodXQ+1JzyIMHwaU0k8QCBOh0F4xHXMTpLXlYl?=
 =?us-ascii?Q?xw/IPL1bm8lHm1LoCWKCqeDiallSpiM9BeSd8VfXE8jVIG/BAOc7nO7HabP9?=
 =?us-ascii?Q?c1i1vY9/zqV/Iz5Ba3jXGb/D1SyeF8e6pAM5IF0LcMiECyfxUxmq3SG7cK03?=
 =?us-ascii?Q?I1n3Yy4o3sy8saZyZmE0494sHYlrQHI/5EzFYPqQ843+V/wvHZXsDwr825ax?=
 =?us-ascii?Q?iPTsvKE378hqI5/x3Yzx4gViVHIGGLLhAhSvuIjfZhZnuNYXtTjlrXWpKHtw?=
 =?us-ascii?Q?JKRDUOE4VIkheaFOYc4p6S/exho71wo9CIOxMRBYy/Avn0TpDZFktTkxh3jF?=
 =?us-ascii?Q?oxsJQPLt90qwDjq7Kyx+Rp+b3MwH3kVFWBU09KUCXAYsUKXlDTf07suxroBk?=
 =?us-ascii?Q?4sX3AWqyxGgLdztU0y0oVdBxbpdInqmx5/Mml1rPs7YlyGz1PFKRJTaJ1dU/?=
 =?us-ascii?Q?NaTD0xZe/vZnG6QWW7oEaSzVZ2QKCK4/L04zjvmTf/Kc1EuMsYvHNA7kV195?=
 =?us-ascii?Q?5qdnTDz67+UTS8t6XAwfNp1PWOI1vL07zXBcPSce4Wn0vnLLVxXZ0INSH3On?=
 =?us-ascii?Q?zforv1f1cVXFijAyONeiIitfOzUtsv+pNoJlgeY5oh0PPIs4N8tf5i8EuVwR?=
 =?us-ascii?Q?nW41j3K49BjLOBnQfUgZ/1Pah9jx34gld0hA8/v+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5814.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3704398-f98d-49fe-a39f-08dd2508cfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 17:23:13.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEmXzoFLQHy+OI//DuxAZRo4fENY0y1gelpMhFvfbN2xZInavpcIzz+R9DiOHRVTHvPWbO2Y0xsMVBkulR46KuxiqyUvtBlKBxwxEiEBoSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com

Hi all,

To reduce traffic, we use local mirrors via "git clone --reference mirror .=
.." commands.
And we regularly get problems with update of few weeks old clones and must =
run something like below to get rid of outdated branches:

git for-each-ref --format=3D"%(refname)" | while read ref; do
    git show-ref --quiet --verify $ref 2>/dev/null || git update-ref -d $re=
f
done

This can be quite long operation as number of refs is significant.

Details are below.

Thanks,
Oleg.


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ cat ./doit
#!/bin/sh
set -xe
rm -rf tst
mkdir tst
cd tst
mkdir master
git -C master init --bare
git clone master local
touch local/foo
git -C local add .
git -C local commit -m init-commit
git -C local push
echo foo > local/foo
git -C local commit -a -m dummy-commit
git -C local push origin HEAD:refs/heads/dummy
git clone --mirror file://`pwd`/master mirror
git clone --reference `pwd`/mirror file://`pwd`/master local1
git -C local1 log --oneline origin/dummy
git -C local commit --amend -m new-dummy-commit
git -C local push -f origin HEAD:dummy
git -C mirror fetch
git -C mirror gc --prune=3Dnow
git -C local1 fetch
git -C local1 log --oneline origin/dummy

What did you expect to happen? (Expected behavior)

No errors; last few lines like:

+ git -C local1 fetch
From file:///tmp/tst/master
 + 552a293...248c7fa dummy      -> origin/dummy  (forced update)
+ git -C local1 log --oneline origin/dummy
248c7fa (origin/dummy) new-dummy-commit
0636429 (HEAD -> master, origin/master, origin/HEAD) init-commit

What happened instead? (Actual behavior)

+ git -C local1 fetch
fatal: bad object refs/remotes/origin/dummy
error: file:///tmp/tst/master did not send all necessary objects

What's different between what you expected and what actually happened?

Obvious - should work and does not work

Anything else you want to add:

It works if "git -C mirror gc --prune=3Dnow" step is skipped or if local pa=
th is used for the clone steps instead of the "file://"
The same issue is with https://github.com/...
The same issue if use "git -C local1 remote update --prune" instead of the =
"git -C local1 fetch"

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

podman ub24 container is used to get a newer git version.
Exactly the same behavior is for the git v2.39.1

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.0-70.13.1.el9_0.x86_64 #1 SMP PREEMPT Thu Apr 14 12:42:38=
 EDT 2022 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
