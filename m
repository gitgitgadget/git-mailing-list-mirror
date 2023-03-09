Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7286C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 05:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCIFwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 00:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCIFwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 00:52:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD15B1EE6
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 21:52:17 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3293GVVW027488
        for <git@vger.kernel.org>; Thu, 9 Mar 2023 05:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=EWAUWbolXgMTUkvdicLH9vOqTJsHZOUQR4vcqSxxSQA=;
 b=UrLxLD3TdwLYvXDO/wHjLK98sxejbtNvguNxX0jJTDYCeB5ZbM4bpGdqdLLf7GpmL3NH
 QtrtDv5/5tEs6Lf1guzKW/5tGUCSH/qGqttrcysXgnq70tLGTLKX18TVTyjPAIvJTqex
 55Gd/RGV4Osr6N6BUNGkRHfu2vxBljHXe5zAzjA/AUexcDPFJ0HTgwyO2firjlR3ZqdS
 jlEHO8hjp/Dpc8BKRIv5UKFyRaMjaOlOSQwR0EveBOSyl7mLY6K2WpZCpNp7Lgr+ynOB
 C998Ct0nkBOSWSV6s1n5sNJluVk/9Hf2YFptvOYBs4FA4V1MnIi3rLqsI7/PjAHkNrpQ Xg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6pa7mptq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 05:52:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6u3K/9DA2M3VVrCxuC+WPJQ6GnPAcwCgslE7IdCEWsZAIFWaA9dgg2l0sYsbFTgqjZjPlNPSDZuHIOL9WiiIkGIZIaidEEjdHrAjoSMcf2L6pqwRqoBz7raTOtCAfV38Ll2B0S1tGbPnRc5lNJdnQRTULagMc8rKUUHXB2U82hligU+Bf0TRjkiy5SYJIN1ncQH9zr4+A0gQAVKZUUVa1ymdcXHfTMUBUc42gveCzu9k+EdkPgVJ7lbR7+zvK+TJfivGUtuxRq3yDeDJk/HNHfAqiZ7Et8ov1+aITWphDijOygGKAk3B8pW5gqgb91UUE4URNGsi3zjCu2kw+KNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWAUWbolXgMTUkvdicLH9vOqTJsHZOUQR4vcqSxxSQA=;
 b=M0PvLoBk1Kyu//y5/XpwWkxvy0QD/PkI9JZIRb/4eDnqWBxF4Iiq30RfOD18v1Ck6LrloBd3VtlJ516LdO1Lq2V5bTBBnEMtwX15v0z/J24TmfUgLzDLyZL7rI3XdV6p+advxb/CJcqhmRJgS2qYBiJAmF8lsp/iwKWD3xyxGl7gQySsYt79zz1TZSNgO4n08ALCEzaqdETWk324HESzt6TDxXumhEVwOIUeHA/iou/V/qbnb0+71g8EfIA+cef8HQ+k3Z+RhaRBjhbhzkH0u8Mi7TxMrJPRf6csvYarYjqUqYuzw3apptjMp26UPQAzaA2hXpzIavniektx/34J1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from MN2PR15MB3454.namprd15.prod.outlook.com (2603:10b6:208:a5::10)
 by SA0PR15MB3870.namprd15.prod.outlook.com (2603:10b6:806:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 05:52:15 +0000
Received: from MN2PR15MB3454.namprd15.prod.outlook.com
 ([fe80::613d:9d49:482a:bf08]) by MN2PR15MB3454.namprd15.prod.outlook.com
 ([fe80::613d:9d49:482a:bf08%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 05:52:15 +0000
From:   Sudheer D <Sudheer.D@ibm.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git diff without intermediate commits
Thread-Topic: git diff without intermediate commits
Thread-Index: AQHZUkqRXxCa6/1rXEyRsKX7G88n5A==
Date:   Thu, 9 Mar 2023 05:52:15 +0000
Message-ID: <MN2PR15MB3454AE2CE41E79F2B260DDD3E1B59@MN2PR15MB3454.namprd15.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3454:EE_|SA0PR15MB3870:EE_
x-ms-office365-filtering-correlation-id: 250ad3ca-9d80-427c-71e8-08db20626f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxrzLjJKGmzlI+X+AN/oG5De8PX1evMWeus+p1J+oL1IFNjZf0FPWIjhOvYgi8LI4lJmxFBHsjRPJ8ueCk9+7cjT1sbLlyUKaW+befumj9Vjmw+PXUpwhIxj1R9rlTB7UTJIjYdFZjsYtS8/UHVRWQof/S7CZtWM0rFXYqDgtRSHv++qQMr58X8DkM2EgwQTPF47vg99gnXuprqCG66Oz+QRkKEU9/fEBwwvBTdsL31Cbtjjwm2kF0CxjExEeumydx7MwNiiOkA2yt0xJgyL42ARwqq6+76mFw3GwPiOVd8pMW7BbYnqfg1xulV5qsBTsYj2WAUgK/eXhuWd/nHP3hdkQw0g60Nbdlkswn/9LKxDvlF5YG3m9nvytPGXVqqO5QeZyB4GzxWp67gnZxiVOpt9vjoBhTPYDOYklk3MHIafR22KMBBzit+K/BlEHrpsU4p+dPWwFAok6s9xrVrTb6HCzCaU+lKVUmURY+iArP/LLoDX/sB/50UnVxjwu1hB5uTZT+uYKuTzH9bF8Wh7bNOpWNVbVJ6DILt2aTNcUOkn33tmC6mVX8JGF1XRtQGzI1Lbz3H/2vyNcinTwOrgX91MJskpEelQnAoXl0u57fAMId9mHvcd3XBO+0d1KTFKthGl8VL6MxYrAhbG6Bc5igCCmxIGjf/5Z34KyA3xTCpXkpRZXHUI3m+PFcxcqP163BKkckc/jMQA5aFrTbJfDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3454.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(38100700002)(316002)(86362001)(66556008)(6916009)(8676002)(66446008)(52536014)(66476007)(66946007)(64756008)(76116006)(122000001)(8936002)(91956017)(38070700005)(478600001)(5660300002)(41300700001)(71200400001)(7696005)(2906002)(55016003)(186003)(33656002)(9686003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TqOmSYnfi2nuLj4KvUjmxEkYc2TDbIcDf6glWs06E8pJ/UGIrYWTvL024D?=
 =?iso-8859-1?Q?mcc4IvvuAXATWk5ckGquGL8Of7z03B9BJJfJP85w538UpwBkEVaiT327de?=
 =?iso-8859-1?Q?8SqpMxFl35ZddmuxKSR35YbUzrYyiZRdyxmvn9DkAKeCCTj/5wxOvQ+Jgb?=
 =?iso-8859-1?Q?40SPajtl9yph403GSPFyiKgw7l0IYD/FOGgEKl+gV8lMEasMBI5/f+eWDC?=
 =?iso-8859-1?Q?jNUNGzcnMf2ybTlqHryokUOcJXCX02EexjeVQzLeggA4uog4rpjo8Ag309?=
 =?iso-8859-1?Q?eymMkPU7Q/TO5WiLe65qSHwzM/MUmtD9tVlzn2eY/J8VAniDYf6Dt1QQTd?=
 =?iso-8859-1?Q?rQk3EO2VrcY815EbOJ5BzlpsiO+yUMexKdrY4A5OEZlRXkFcgNSom/5gTd?=
 =?iso-8859-1?Q?M/nebtMRSmuOg3v3u3XgeNEyMAq9BsQ3eWudZvcqCkCqRsU3SzTA1xXWmp?=
 =?iso-8859-1?Q?vIJtT/4v61mMMjGjyKY6Sq+gIR1257ozpnXNcWuDFxlsEMoTDAcJ0o9gp4?=
 =?iso-8859-1?Q?g4zexLX8Qw1kGlJoCsUIcjjBW5IMwO/BiHGOhmUDwigez90PQwQaH5toYt?=
 =?iso-8859-1?Q?it2hEOTqeLUosTRw7ZZjJpzjElyvHtqVkzLXJ86Fnjid/LdpPcfsmQiHC6?=
 =?iso-8859-1?Q?9vlYLtFgrL6vP2LT79QyB1QPIYP/pY3LxacJObrtzbqYdHnayUGJs7mnTK?=
 =?iso-8859-1?Q?HzCyYXRGritKSpIGTC6jQwUJEVxnouGclxSWVAMP/NQ9uBwD7e6gImqjeX?=
 =?iso-8859-1?Q?yO+dCE633warOnHJUrN0+huYhuYEadfgut4vM895Ix3U5kqlRgHl24xU2Z?=
 =?iso-8859-1?Q?zD307VkoJtZdo6sj3g97VJ0xJIkxdVibc84qswgJhaVK7roAE4CwZhKVS4?=
 =?iso-8859-1?Q?DzyaU66dxK3Cp8878lmPSrUYAn6yVG5CH/VY+tOc0k6Pb9WY4Bh7YIyYaq?=
 =?iso-8859-1?Q?yQQJG9y4lSF2gbTeYQmKwuWyHxXmRD2dfDj9D+4iHDlMIBWbYEokgCtaCG?=
 =?iso-8859-1?Q?6I2pYpP3c9GD3fVQVvgRnob2fPridZsYdeoXPTPDUMvvE2VRf6Z5NTtuQ+?=
 =?iso-8859-1?Q?cKda/154Ob+91D951s+0QV2J4vHoZGK19u8lvOKqu2OfiAJF2a9XMdSict?=
 =?iso-8859-1?Q?AZxqYP0FuYSz9AdFt4p3OuyLNLxNNFDucaDCm3bAZglGPD9xYnW/IrlI4K?=
 =?iso-8859-1?Q?Jphrm4KedLEJqnDSvpnP7BYRs+m0D6Kcdm7s43VctMZHBwUDPL1qPxuUeZ?=
 =?iso-8859-1?Q?8GBCldvgEMuD98vr2DnZ4rWW7WwZ3+2e7h6wJzLc0bNY7nKiLxHzVIacdq?=
 =?iso-8859-1?Q?2rrCGTluKVn2R+GbzexjEm33+52p/Zt6aDNkEQGBW0neqLWnOybZyqaexR?=
 =?iso-8859-1?Q?12VXvme4E442hDUpYoEL0otNU/riGwfACHu5HpienYrRPPUmwGGfmkLIMl?=
 =?iso-8859-1?Q?UBQWfXjfKtnwqIHce3cm1VCswhDwwvTqUQI001LGitondTSdCyE40BcNNf?=
 =?iso-8859-1?Q?Wg/EELLaEsiqtKzHF6d/zo5BY4j1UxPyIWdeiA0b2i953LC7FSRJ7F0FrK?=
 =?iso-8859-1?Q?HR3Z4yg7eaO+NdgKQBbJuy6y6iFjuajjrBpnd5HOqjSO+ZvfI6y6f2P3LC?=
 =?iso-8859-1?Q?R57uzk8SmeZqw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3454.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250ad3ca-9d80-427c-71e8-08db20626f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 05:52:15.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H19n0ZypMG8v7kF4KdTOdUs1rDJF/0fL/WjX7VKK9MVrUlT/Y6QsRxLeRGq7duAylK9hW2Hp8pNPnM1OXZOeSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3870
X-Proofpoint-GUID: AgCQHNoiKmIcMwfPP7gIz9DetHP_o70z
X-Proofpoint-ORIG-GUID: AgCQHNoiKmIcMwfPP7gIz9DetHP_o70z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=591 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090044
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello List,=0A=
=0A=
I have a question regarding git diff command.=0A=
=0A=
My Problem:=0A=
When we work in git projects under github, we will normally=0A=
create a local branch, make some changes commit it=0A=
create a PR & send that for review=0A=
may have to merge 'master' branch one or more times to make sure that autom=
ated build works properly after merging the latest master branch.=0A=
Will enhance the PR based on review comments OR add new changes.=0A=
=0A=
Assuming that my commit history is as follows:=0A=
=0A=
a. commit1 =A0 =A0 <-- My local commit 1=0A=
b. merge_commit1 <- Merge commit from 'master'=0A=
c. merge_commit2=0A=
....=0A=
f. merge_commit_n=0A=
g. commit2 =A0<-- My local commit 2=0A=
=0A=
=0A=
=0A=
Now, if I issue 'git diff commit1 commit2', git will show a diff of commit1=
, commit2 plus the intermediate merge commits. What git does here is absolu=
tely correct. But, my requirement is to only have the difference between co=
mmit1 & commit2 (without the intermediate merge commits).=0A=
=0A=
We can definitely compare individual files between two commits in the follo=
wing manner=0A=
e.g., git diff commit1:file commit2:file=0A=
but, if I want to get the diff for all my files from commit1 to commit2 wit=
hout considering totally unrelated files from the merge commits in between =
commit1 and commit2, I think it is a tedious process. Correct me if I am wr=
ong. =0A=
=0A=
So, my questions are.=0A=
=0A=
Is there a feature readily available in git that will compare just commit1 =
& commit2 without considering the intermediate merge commits?=0A=
=0A=
=A0If the answer to the above question to is 'no', if I am providing a patc=
h for the same for 'git diff' & 'git difftool' probably with a new command =
line option, would you accept it?=0A=
=0A=
=0A=
=0A=
Thank You!=0A=
Sudheer=
