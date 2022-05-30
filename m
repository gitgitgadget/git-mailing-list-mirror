Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F1C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 01:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiE3BuO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 29 May 2022 21:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiE3BuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 21:50:12 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 May 2022 18:50:10 PDT
Received: from USSLC4RNPMX03POUT.l3harris.com (usslc4rnpmx03pout.l3harris.com [128.170.196.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525FC15A35
        for <git@vger.kernel.org>; Sun, 29 May 2022 18:50:10 -0700 (PDT)
IronPort-SDR: TxK3wHUH3GYIWtS9StHaivQzqoImpBdqs7+yZKQR/NULG0On5/mxZspohLClMfwLlxYzc4+mGF
 UDEyydLZCSNXBalmPVTg5aEMJXB6zzxaQn6MdLsRpBnuLqhhvMVyMcrKHJeY7MQROW+9zi1rJH
 Zl7IWGrIbwnUV4bUyu3dajSh9/bWAhDk7PeLJdHziN8qnwHzv+DNS6BE4CX2aKO9sAUcvHaugC
 XR4kVZ1bcIAqiimt8GTMwxP5nwaxQqKWt6CUCH/hImoxDixyyEoV3T7NIZCTyOeT89v9Ia5213
 9wmzHYblZEypgqid2eAr7O9B
From:   <Graham.Menhennitt@c4i.com>
X-IronPort-AV: E=Sophos;i="5.91,261,1647302400"; 
   d="scan'208";a="22396726"
Received: from usslc4rnprt05pout.l3harris.com ([10.64.252.31])
  by USSLC4RNPMX03POUT.l3harris.com with ESMTP; 30 May 2022 01:45:08 +0000
X-filenames: 
X-filesizes: None
X-filetypes: 
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647302400"; 
   d="scan'208";a="38443102"
Received: from ex09dag01azusva.rootforest.com (HELO mail.l3t.com) ([141.199.128.139])
  by USSLC4RNPRT05POUT.l3harris.com with ESMTP; 30 May 2022 01:45:08 +0000
Received: from EX07DAG01AZUSVA.rootforest.com (141.199.128.137) by
 EX09DAG01AZUSVA.rootforest.com (141.199.128.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 30 May 2022 01:45:06 +0000
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.152)
 by smtp.l3t.com (141.199.128.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 30 May 2022 01:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=jx23Jkip7/JVFtu1ViOyDD1fzI2oV1bWcuIaKnx4h8Y3v43595z118d4FCWHUmzFfC0jjst2ESXncdsuVly1EMrQyz98WRyJp5gMJBbGM1XoBVXRDEMwiDDKoHYnx7TbIA7MoQ+x6+cm1fXDlDXm4URUm9Gfs5Ku3ugxJfxSjOoPjznMVeKehm1e1d8EZCOAoy7kmvfz595vP3epyY6vjdLuz0h8e1q8Va6Z7BuG8QmQnyi6hhLJiAu9KOp8rzoVtOpKJ2MPRPw8FJc9GEHgtY92dKFAEHR3vSAZL6bnJSS8SFoXuJmtklumwmURjK6CDzHvDSugGTwlLOWxkFQVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipju31kpDDxuKCBZW+8oRQn4mqVcDDPQ+EvB6leSHyo=;
 b=rVkKQ/xnufzyeGaPE6WqymcLe13Jf772du5KOX63rB+CzncxnXEagP5kqBDxp3t3wxA1dL9JqslpihXJFEA34Fjwf+8uwAlwmz/PwKbuo9TimoLVePNOlbkaZK8RcJFgFmCBkhzXa/dsToKoEcriodZYKnuQWft1WsfYlr94YgLzRhUaIC3TdO4+mV7qTqIIIVxCpCKXGDcV4hItNC6SP2JgD4D39JD3mBQhaT82AfPjx4Mcm/ER4F0cSCGFa/q2zmvVknE+VQ+7RP1l9QK0lbS3Js0ee+/L0KeeaAmtidBMNCZG+0myJfILjcENls7PDjAMelJPKJysxXU4Xxu3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=l3harris.com; dmarc=pass action=none header.from=l3harris.com;
 dkim=pass header.d=l3harris.com; arc=none
Received: from BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16a::11)
 by BN2P110MB1509.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 01:45:04 +0000
Received: from BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
 ([fe80::390f:4b:78d8:19d5]) by BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
 ([fe80::390f:4b:78d8:19d5%4]) with mapi id 15.20.5293.015; Mon, 30 May 2022
 01:45:04 +0000
To:     <git@vger.kernel.org>
Subject: request for development/build workflow suggestion/fix
Thread-Topic: request for development/build workflow suggestion/fix
Thread-Index: AdhzxrAHCd1doVchRB28GYAVqQ2qtg==
Date:   Mon, 30 May 2022 01:45:04 +0000
Message-ID: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=L3Harris.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fddbdb6f-14f2-4909-90f5-08da41de0498
x-ms-traffictypediagnostic: BN2P110MB1509:EE_
x-microsoft-antispam-prvs: <BN2P110MB1509E1081037D5A50569D244C5DD9@BN2P110MB1509.NAMP110.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HU+P0pOTMYylSEumhwxxcFuGXxJxI23AZyuwMrUN9BREsEUChZFpc+JMzOyCkrIObQJaU3MBtZbhKkt/CIQQLzkCgBoFK8vZv2HSjstdxMnJKcHKNfacl2ETcXpaZqLuCdCOyYuKGXPEUiJ8aYy4VvkCmFpeULVJR/KNoKvOK4mKCDKIqMLcJROVXcUcHQaSz45u/FO6JsvvwPBxig3iqymiR3g5nui0aVV14FVGzlHOCv1ZrP+eYZGpqJPJ+jbjw4/+n6y92RXDxN5Udjm0vuBkCpBSQYqiBkOrrM3+bUeVBlvWOClM45kU8+f2DLCFbMFGg/D58ltHhhoIqILwE486gp8/DZCjZQzIJLLfbgtCnK0Qv0reuaPYmBtfyi4xec6pIqIa6s//R35BlXLidYYpHwHy0/gWkTEAmnuSF7EtsB/DSTRMdRmO2ycn0xeqZ30sYGEeNpqYcdpNRKjMIRUP0AWEPe36rQ+TxyQXGpd3CWUbxK5e+n3dv4nK/OeFlMI6v3dw7/yiJtvy4nXjuRXMh8K3Dz4kyW1PBtbN7PDlPYFroY8Q7GBRt1yVAOzjT+mjnt96mNnTZR5aZYr48f7Unwbced3oqUWHaf1L/PcbBLnzMTUL10oWsH3I+Kfa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(71200400001)(38100700002)(38070700005)(498600001)(7696005)(9686003)(6506007)(52536014)(5660300002)(8936002)(26005)(86362001)(6916009)(122000001)(64756008)(66556008)(66446008)(66476007)(8676002)(66946007)(83380400001)(76116006)(82960400001)(186003)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: jdtQS1Yf4xG4YR2Xw4EcUb+texmAORAjtH6YKqttmHqHx0E3PxxJupNEMyBUOOc0jaVKrZ1GTEALsgugtz9BGLh9SR9VYaeJxhSnZstrbJFNfkwiDEOHxdQXSIqdxuKk742HL7sfmtjREezxq+P++o2AS/6J1lE9N2eSELFnL03Df86lf8YKpo/2UNzRAeoTYIK+ommDd0kfYnZkqB1AEPzEOlAESZe2qbMZCpE7HaJeWehhll+Qj9bjX05aIt9qetsf0msv2DFXhhJ8qdJxHtOSfhj4tNee/vvRXdBZy8Q0Pm5FdYN8mnrYwexH8FxJhyMTEzpQzkGQ31/hs+6uzvDAH55OuqdpIJvPo4eyujeCiLozl+TvrYm9MTieUgqP9EoX7ImI17+n5hm6OGb6qZSD+Giz3Fs2+NDCKRhlLsfmOkcKMkmc8+XN+oQqGbTOhwv/ppIlTPUOWRrQdMTlD4cIwdTQ/8NlRqosk5O07q+DAgX2QUBU+ZhVgMTB4hfJ8TvmvMg/NBSql4mjnVUm1u+irG49AMj6xp2V1pEz9vsh0QYuRbYLtNo8zmxNxZdA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fddbdb6f-14f2-4909-90f5-08da41de0498
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 01:45:04.1374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba488c5e-f105-4a2b-a8b1-b57b26a44117
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1509
X-OriginatorOrg: L3Harris.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a (small) problem in our development/build workflow. I'd like to request suggestions on either:
- how we can improve the workflow to avoid the problem, or
- how we can fix our build system so that the problem doesn't occur. 

Our (simplified) development workflow for fixing a bug or adding functionality:
- clone the repo and create a private branch off the Integration branch
- fix the bug or develop the functionality (and test)
- merge the private branch to Integration
- create a tag to identify the fix

Our build system:
- clone the repo's Integration branch
- edit a 'version' file in the repo that contains the current build number and increment that number
- build the software
- commit the edited version file
- create a tag identifying the build number
- produce a list of changes since the previous build by diffing between the newly created tag and the previous build tag

The problem:
- if a developer merges to Integration and creates a tag while the build is in progress, his tag gets included in the diffs even though his changes aren't actually included in the build.

Below is a shell script that demonstrates the problem. A quick description:
- create an empty git repo 'origin'
- clone it to repo 'buildClone', create an Integration branch, add a source file and 'version' file with version = 1, tag that as build 1, push
- increment the version to 2 as if we were doing build 2, commit and tag as build 2 but don't push yet
- create a second clone 'develClone', create a development branch, modify the source file, commit, merge the branch to Integration, tag with 'develTag', push to origin
- in the build clone, pull and then push to origin
- increment the version file as if doing build 3, commit, tag as build 3, pull and push
- get the diffs between builds 1 & 2, and 2 & 3 - develTag should not be in the first set of diffs but it should be in the second set

So, my question: can anybody please suggest an improvement to our development or build workflows to fix/avoid the problem? The obvious change of omitting the pulls before pushing from buildClone doesn't work - git won't allow the push.

Many thanks in advance for any suggestions.
	Graham


========================================== shell script ==========================
export GIT_COMMITTER_NAME=committer
export GIT_COMMITTER_EMAIL=committer@example.com
export GIT_AUTHOR_NAME=author
export GIT_AUTHOR_EMAIL=author@example.com

set -e # exit on error

set -x # for debugging

# clean up any previous leftovers and start afresh
rm -rf origin buildClone develClone
mkdir -p origin buildClone develClone

# create a bare repo in 'origin'
git -C origin init --bare

# and a clone for building
git -C buildClone clone ../origin .

# create an Integration branch and check it out
git -C buildClone checkout -b Integration

# create a source file, commit it, and push
echo "this is some source code" > buildClone/sourceFile
git -C buildClone add sourceFile
git -C buildClone commit --all --message "add source file"
git -C buildClone push --set-upstream origin refs/heads/Integration:refs/heads/Integration

# create a version file, commit it, and push (as if build 1 had just been completed)
echo "version=1" > buildClone/version
git -C buildClone add version
git -C buildClone commit --all --message "add version"
git -C buildClone push
# and add a tag to it
git -C buildClone tag build1
git -C buildClone push --tags

# edit the file to increment the version, and commit it (but don't push it yet)
sed --in-place --expression "s/1/2/" buildClone/version
git -C buildClone commit --all --message "increment version"
# and create a tag on the build
git -C buildClone tag build2


                        # develClone repo

                        # clone again for development work and checkout Integration branch
                        git -C develClone clone -b Integration ../origin .

                        # create a branch and check it out, edit the source file, commit it, and push it (as if a developer was making changes)
                        git -C develClone checkout -b develBranch
                        sed --in-place --expression "s/$/ with a change/" develClone/sourceFile
                        git -C develClone commit --all --message "edit source file"
                        git -C develClone push --set-upstream origin refs/heads/develBranch:refs/heads/develBranch

                        # merge the branch into Integration
                        git -C develClone checkout Integration
                        git -C develClone merge --no-ff --commit -m "merge develBranch to Integration" develBranch

                        # create a development tag
                        git -C develClone tag develTag

                        # and push everything
                        git -C develClone push
                        git -C develClone push --tags

# back in buildClone

# get any changes from origin that have occurred since we originally cloned
git -C buildClone pull --ff --no-edit

# and push everything
git -C buildClone push --force
git -C buildClone push --tags --force

# now do build 3

# edit the file to increment the version, and commit it (but don't push it yet)
sed --in-place --expression "s/2/3/" buildClone/version
git -C buildClone commit --all --message "increment version"
# and create a tag on the build
git -C buildClone tag build3

# get any changes from origin that have occurred since we originally cloned
git -C buildClone pull --ff --no-edit

# and push everything
git -C buildClone push --force
git -C buildClone push --tags --force

# finally, test the results
failed=false

# we do not want the following to contain develTag (but, of course, it does)
if git -C buildClone tag --contains build1 --no-contains build2 | grep develTag; then
    echo "build2 contains develTag when it shouldn't"
    failed=true
fi

# and we do want the following to contain develTag (but, of course, it doesn't)
if ! git -C buildClone tag --contains build2 --no-contains build3 | grep develTag; then
    echo "build3 doesn't contain develTag when it should"
    failed=true
fi

if $failed; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!! failed !!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi
