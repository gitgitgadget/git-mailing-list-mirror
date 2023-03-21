Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C1C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 11:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCULJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCULJa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 07:09:30 -0400
X-Greylist: delayed 2207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 04:09:24 PDT
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E8211DF
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 04:09:24 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 32LAW2Ma011807
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:32:02 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 32LAW2Ma011807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1679394722;
        bh=DzuywIEvp/uGApx0oZY28cxJlNtsUJgmBpgICIdnkxw=;
        h=From:To:Subject:Date:From;
        b=fZvWgBI/7yS6EimClHB60lFqAjGzsoHfp01FtCfmQxNDVSTDZxJ9uQ6tDD92E3EOb
         9qdaRe6Aq/qy/vHZ4bBqJ/ks0uK/XANG1zY/d3TXGpU0rAU2Lbbz6IENltNtBmMY6e
         jpQKbV7YUvT05/z+L7EK+ioTtsiLe9QtaHfTZLS9uUY7C1SytcCOwDGKqvOekcJxML
         6Eig940X38vyYtz8F5aDBImRd84RERnuQHud5O0qSN2ncRo3aoqMBc9hoaQi3xFzMT
         g2hWNUZ+nlmr6ajJ0gaD/nMOimsFZ70oABkBzYg09UApjuWf7IdWuJ/ag1lIPVIkrb
         vJOsWn8U0qtDQ==
Received: from corpappl17778.corp.saab.se (corpappl17778.corp.saab.se [10.12.196.85])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 32LAW2I93502061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:32:02 +0100
Received: from corpappl17778.corp.saab.se (10.12.196.85) by
 corpappl17778.corp.saab.se (10.12.196.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 Mar 2023 11:32:01 +0100
Received: from corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18]) by
 corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18%14]) with mapi id
 15.02.1118.026; Tue, 21 Mar 2023 11:32:01 +0100
From:   Lundkvist Per <per.lundkvist@saabgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Soundness of signature verification excluding unsigned empty merges
Thread-Topic: Soundness of signature verification excluding unsigned empty
 merges
Thread-Index: AQHZW9YuL0XHoZNDkEewevJzAqReew==
Date:   Tue, 21 Mar 2023 10:32:01 +0000
Message-ID: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
Accept-Language: en-AU, sv-SE, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.18]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27516.006
x-tm-as-result: No-10--7.910900-8.000000
x-tmase-matchedrid: gIzQ6PxOy4OvxJaYc6X9S6zSsZt54aj7sat+wgYyTWzhxMV9ENWPXYO6
        W2ZdoUAOaKybzfe1YMQ22RdCnDiVMSavgFgwU2PFQQ5+hY6u+45pkBMYDn8FeNe0QKEEFPqMgsI
        JV9NWYtaWQGirAGq0wdez40ONsDlR2yGIb79O9Chuq3SU2oCL/uMuseq8CJLLS3LxyJ8YfRTmIS
        JBKMpm63OM5qj8y16ELF8oHIGwHp4sm617PZ0pZ+fOVcxjDhcwPcCXjNqUmkXCttcwYNipX4nxg
        mBGuBcXGmxnR6qqyPT3aLp4aMZCwCn7qWJPG81boBX87rW6rl0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.910900-8.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27516.006
x-tm-snts-smtp: E991D80DBB311F3553BFF1420A63BF947726662900B76E502C67EDBFE1C6B0422002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We are investigating adding commit and tag signatures into our existing
repositories. We currently use the common workflow of developers merging co=
mmits
to master using an internal git hosting service after having passed code
review. Non-local merges like this would then be unsigned.

But it seems like if we allow unsigned empty merge commits, i.e. those that
themselves do not introduce any any other change than what its parents
introduce, and require all other commits to be properly validated, then we =
can
safely validate the whole repository?

A simple naive example of this would look something like this:

    rc=3D0
    tags=3D$(git for-each-ref --format '%(objectname)' refs/tags)
    tags_verified=3D$(for i in $tags; do git verify-tag --format=3D'%(objec=
tname)' "$i"; done)

    for i in $(git rev-list HEAD --no-merges --not $tags_verified); do
        git verify-commit "$i" || rc=3D1
    done

    for i in $(git rev-list HEAD --merges --not $tags_verified); do
        diff=3D$(git show --text --pretty=3Dformat: --diff-merges=3Dcc "$i"=
)
        git verify-commit "$i" || [ ! "$diff" ] || rc=3D1
    done

    exit $rc

Or is this a faulty strategy?

Thanks,

/Per Lundkvist
