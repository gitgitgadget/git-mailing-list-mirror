Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0CC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 05:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiBZFVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 00:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiBZFVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 00:21:53 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A741D6814
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 21:21:19 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so8336226qvl.6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 21:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CuMq0tAvSAv3jzfrCFH0P+pHZB5irgqOCTwfY0Bu614=;
        b=Ypgq8/R927/G9DpdGKpV7UWbFvLZBG34Ai3+HMU4DNMzjdI5F6WH7qBTyZF1WIQHpk
         2nI17JJsuAm3yDv8Ro1JpO4GDDrG9ds50HebpLtFUBZi9ASGbzztpg+IDB+52lJwlkvR
         dXCDBxqF56CV8SMK2ENy0C6K0TVV3wDxGuMPEuS8cWhU/WeA7YNfsAYHqrn7jWoN+x9U
         FnYY6tyBqf8XFgE0VEKDRILuPF+0CFBuD83B+S71u4UF9IE0qlUawFkaWN71Kb37BYAn
         Nj+PsqBXdnbmNxCjAQxNZ2orjrNA6Sotp8rL6z95cg7mhHatbMNVoCgZONCH3y1aXY7z
         IWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CuMq0tAvSAv3jzfrCFH0P+pHZB5irgqOCTwfY0Bu614=;
        b=SlJ7w07LQkZZ7yydlkEZjY8DB48wCT0u8nzJX65k36+YybVCpRayJiegWjbXog8OvI
         /ap+MaHbAN9flzo60DHDv19o0BCF3pcFPGoWTyxFBLIId4pMoS7gV9VXnyCiQBEvuJ1l
         +wyxRSvbm1IoV6qfHlS4sgATiFlPGsq/2Vve5g8TuGGZPYh3Q7PJXxW3k6L7PE5zzpjX
         mM/533CgSwvWavWsbAOG3vBds5vI8rhh7Vysw2Vy/3BvDcgbZJDF2ySDS38SNEU/ZUTv
         iQipnnKtwWVGnm7tCacO2bQ3tfeLwfl3EDBFO18cGm2YvlfAzYdCnP3++otxsop1NaZh
         IPgw==
X-Gm-Message-State: AOAM530j8ZhnMLJaii/bv6WSU2mkO0lbExCFrUeSyMIvTNqriIVBC5jK
        0PjRjSl9h5QCdtSHxVRarqW0hx3c3f8mUG209nLKgHMcSB8=
X-Google-Smtp-Source: ABdhPJyr4pR0oULQMb3AuE1nal0C/icZyPwmrh51dWrMciJLnI1WmrGCE1/QLpVuNkcjzepDT2uRefv61SJe72TMI/w=
X-Received: by 2002:a05:6214:e6f:b0:431:46cd:dd9a with SMTP id
 jz15-20020a0562140e6f00b0043146cddd9amr8292156qvb.125.1645852878187; Fri, 25
 Feb 2022 21:21:18 -0800 (PST)
MIME-Version: 1.0
From:   Hunter Laux <hunterlaux@gmail.com>
Date:   Fri, 25 Feb 2022 21:20:51 -0800
Message-ID: <CAMQF8MhTmVs_LE8Te=9EL66Py8OtAMo7APf-cC=Ot6tykvaBpg@mail.gmail.com>
Subject: Git-p4 UnicodeDecodeError on ascii 0x93 character
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of my p4 commits has an =E2=80=9C(0x93) character in the p4 description
and I'm trying to export it to git.
I'm using the latest git-p4.py as of c70bc33.

I think python2 didn't throw an error, but python3 now treats this as an er=
ror.
The error is.
Traceback (most recent call last):
  File "/home/hlaux/.local/bin/git-p4", line 4292, in <module>
    main()
  File "/home/hlaux/.local/bin/git-p4", line 4286, in main
    if not cmd.run(args):
  File "/home/hlaux/.local/bin/git-p4", line 4043, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/hlaux/.local/bin/git-p4", line 3910, in run
    self.importRevisions(args, branch_arg_given)
  File "/home/hlaux/.local/bin/git-p4", line 3658, in importRevisions
    changes =3D p4ChangesForPaths(self.depotPaths, self.changeRange,
self.changes_block_size)
  File "/home/hlaux/.local/bin/git-p4", line 1080, in p4ChangesForPaths
    result =3D p4CmdList(cmd, errors_as_exceptions=3DTrue)
  File "/home/hlaux/.local/bin/git-p4", line 711, in p4CmdList
    value =3D value.decode()
UnicodeDecodeError: 'utf-8' codec can't decode byte 0x93 in position
21: invalid start byte

This patch seems to work.

--- a/git-p4.py
+++ b/git-p4.py
@@ -707,7 +707,7 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b',
cb=3DNone, skip_info=3DFalse,
                 for key, value in entry.items():
                     key =3D key.decode()
                     if isinstance(value, bytes) and not (key in
('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value =3D value.decode()
+                        value =3D value.decode('latin1')
                     decoded_entry[key] =3D value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') =3D=3D 'error' and 'data' in
decoded_entry:


Does anyone have a better fix?

Thanks,

Hunter Laux
