Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9511F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeK1IIF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 03:08:05 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:43961 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeK1IIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 03:08:05 -0500
Received: by mail-io1-f42.google.com with SMTP id g8so18187566iop.10
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bbzl99qdHG6O/SV9rOevHId7IN1lpfUEWE9aEyGSRNs=;
        b=cbroML6/4B+Yp0bHd3+uz/PTLIz9+kD3eZ2/2fw5lPkdLCv3N98a4lWwE+cSv5CZE1
         83AqW0GI8+NwpMCe0fwM/EXUwMj3RkFHqCUwbU4NFC2p9zI/mx7fUTpUubb+mRo9arfY
         Noj2uOwRrWC5HK4Qem3jiM89FHCrGkdCeVSYbNZp1kuJT7PvcgZPZjeDYyte7EIOweYr
         P8+5+e1PBwn43nG8CZTQAuzxG0QN9CLEWcmct+JrLtjKrpRTXiFzGes3eL+sw+XtfKfM
         qYnICgp9FVh/A6QryrCZmfjwebUECzX9xmXghfr/dO/FGLmLI9oho1TFoQTzHbDDq/5o
         dJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bbzl99qdHG6O/SV9rOevHId7IN1lpfUEWE9aEyGSRNs=;
        b=f8Ra15AcE/KBYhUeLylb98/f099NIAKi1+vI2S3kruKZkuebIogX0MQDmPo/MVW8h6
         j0tZmlCD4fBmhMVHRPSLAR+mKCn12B/ZzgcOsyqSqhE2EiCLasIsB4uIdFHxHnfwMvrE
         JazXLOld2O+bJJH0RxCwbps4RQD1XauLAzcMphlYKyP/2KBclTBAFhIZmFSNhmRMVZxU
         8HwZ5iMBFdvqcm+qib2kUR3S+RslM91o5jnA/luuHwAWdQvPS/UVzsaf0F5ySJUWxKKT
         m2Jmu7HRZXGzj4uQ4qTl9sXCk3KI+3QL3VxNJESaWwy1+WoQcvQT8+DQfrmLKujYxYJf
         uicg==
X-Gm-Message-State: AA+aEWaPJdvWe5S899megxHsb3PJxfbbo88CLLiBSaTOchXT2OuYBY81
        ItJOtuhFQY2H4jhivYgSIQ2A35dfCCOJ/akkPZ5HJWw18GdNrw==
X-Google-Smtp-Source: AFSGD/VXIs1iG8NT3YMwZX3nMQSkCcutWe4MGlBeWzNDFahO2kmpsQJyGg/Nvw3uhnZeQVQrE3Ry+QZJ3GPNzKUuIX0=
X-Received: by 2002:a6b:4f14:: with SMTP id d20-v6mr27487913iob.68.1543352933575;
 Tue, 27 Nov 2018 13:08:53 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 27 Nov 2018 13:08:42 -0800
Message-ID: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
Subject: Forcing GC to always fail
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Something of an odd question, but is there something I can do in the
configuration for a repository that forces any "git gc" run in that
repository to always fail without doing anything? (Ideally I'd like to
make "git reflog expire" _also_ fail.)

Background: For Bitbucket Server, we have a fairly recurrent issue
where administrators decide they know how to manage garbage collection
for our repositories better than we do, so they jump on the server and
start running things like this:

git reflog expire --expire=3Dnow =E2=80=93all
git gc --prune=3Dnow
git repack -adf --window=3D200 --depth=3D200

They then come running to us with their corrupted repository expecting
and/or hoping that we can fix it (often without proper backups).

Bitbucket Server itself never runs "git gc" (or "git reflog expire").
We've configured how reflog expiry should be handled, but of course
that's overridden by explicit command line options like
"--expire=3Dnow". We _do_ run "git pack-refs", "git repack" and "git
prune" (with various options), so those commands need to continue to
work.

Is there anything I can set, perhaps some invalid configuration
option/value, that will make "git gc" (most important) and "git
reflog" (ideal, but less important) fail when they're run in our
repositories? Hopefully at that point customers will reach out to us
for help _before_ they corrupt their repositories.

Bryan
