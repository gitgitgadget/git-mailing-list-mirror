Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98012C3F2CE
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 02:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3D2222C4
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 02:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtBOT9CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCACIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:08:37 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44198 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgCACIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 21:08:37 -0500
Received: by mail-qt1-f173.google.com with SMTP id j23so4993596qtr.11
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 18:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oYh4it47Al2LFp5Ddn7PRHCVjpqBueHO/+L8jkd4/Eo=;
        b=EtBOT9CKxQa6KkxPtri2+xmAAKarjkWne0wo+QOqPgElxZc1QRtljPwGidLY86tdiH
         er/6dVoCDC/HslPII8QbnvyvgYNgqTyQ8SC7wKVWyLydsMwePGtpr2JoN+ZPZXSUf3AE
         XRMRVFS+aidnwlOXbnDsTJUZji14e/zYkrVXPN3mSBJjwckp73Fd0i26fefVLysqTFfE
         C2hf2NtIMpuYhzp74lhBLOmUAwmlGK3gEzsTth5lsVJkfLMsB4dGGK71Tjk8fSXcbrVW
         PUbGE9A/BGBQytKG70stWouASh/h6L2SjKiJ6sW2lrlnu47+Zvo3Ms0aIQcQK56Va23p
         x/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oYh4it47Al2LFp5Ddn7PRHCVjpqBueHO/+L8jkd4/Eo=;
        b=HOrITS1Dep9D2G+En0i+a9/O+ozfG5yCoS1GIqZsSZWmCEHLJZeuJiIJlG7+Z8+ok9
         b/38O0382+GcTOtOMFQG0o/xvEu3t076FYsvfjkYIXFXIH0Pw9+ohEZS0TexMooiZDD8
         gGtIgxFPO++BtTO4ozDDSH+UC//ZVP+ECPMO/92s7eEZBsJ/Wty2b5+VRz49dfDewYr0
         81dTJ1iruSk7y1DevNcrlw9b6bC9YLFzTyUTDycpMJtgwk+H0fUa3UR0rCd2cgMNdJhb
         gKwgfuLfT69tBVYNYKp8CZPibkAJDwQtF/C1Q0KNFFKh/fxYNyzwF7Nl9krZwU0YCJBm
         EklA==
X-Gm-Message-State: ANhLgQ2v4nF9mT9GUcZU09SHD68h5ilyFLG6R5djWpYdeFxyEDB5TJPj
        GpcxkEqnQKE5OTc2wsPiFrQJfp/kcijXf9dxkWmSGn7l
X-Google-Smtp-Source: ADFU+vvc7i2QHpW//j1mFiDLH54dfTDWEpw/TqhNekRZz8lweBPF1sM74R31+v8yU0n6tdvDe+RSqSd6s5i+Zc07C10=
X-Received: by 2002:ac8:4792:: with SMTP id k18mr487685qtq.192.1583028516047;
 Sat, 29 Feb 2020 18:08:36 -0800 (PST)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Sat, 29 Feb 2020 18:08:24 -0800
Message-ID: <CAOTb1wcJyQchyGqTqY6B+j94Tw6Htp7tB4Bt-J7pyXBC7q-XCg@mail.gmail.com>
Subject: feature suggestion: git symbolic-ref --create-reflog
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This email is to suggest the idea of adding a --create-reflog flag to
git-symbolic-ref in the same way that git-update-ref has one.

(This suggestion relates to my previous email with subject "ambiguous
git-reflog output for symbolic refs," which points out an issue with
git-reflog for symbolic refs that don't have a reflog:
https://public-inbox.org/git/CAOTb1wfXp+gXSwbG-CVgVE8E_5yzxQKwNKh_=3ECqTMvZFw7dQ@mail.gmail.com/T/#u
)

To illustrate, if you create a symbolic ref in the standard set, it
creates a reflog for the symbolic ref:

$ git symbolic-ref -m create-symref refs/heads/my-new-symref refs/heads/master
$ cat .git/logs/refs/heads/my-new-symref
0000000000000000000000000000000000000000
b2d80b44f20594470d9f3c2d16bbb83d71370e1e Chris Jerdonek
<chris.jerdonek@gmail.com> 1583026811 -0800 create-symref

But if you create one outside of the standard set, it doesn't (and
there's no --create-reflog option like there is with git-update-ref):

$ git symbolic-ref -m create-symref refs/foo/my-new-symref refs/heads/master
$ cat .git/logs/refs/foo/my-new-symref
cat: .git/logs/refs/foo/my-new-symref: No such file or directory

I do notice that Jeff's "one-shot config" approach that he suggested
in reply to an earlier email of mine [1] (with subject line "create
reflog for reflog-less ref") provides a workaround in the absence of
this option:

$ git -c core.logAllRefUpdates=always symbolic-ref -m one-shot
refs/foo/my-symref refs/heads/master
$ cat .git/logs/refs/foo/my-symref
0000000000000000000000000000000000000000
b2d80b44f20594470d9f3c2d16bbb83d71370e1e Chris Jerdonek
<chris.jerdonek@gmail.com> 1583027929 -0800 one-shot

--Chris

[1]: https://public-inbox.org/git/CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com/
