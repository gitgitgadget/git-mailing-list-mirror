Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554CC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjAMQdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjAMQcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:32:47 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE0DFEF
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:27:24 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id y8so15086650qvn.11
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvMbzIlHtKDMWkbtqCX7X4026Y0DMk7QeDmZ/jzIEcQ=;
        b=XDBdUjBQKd7N8sJVXVQmYeJ6nMDLD//kWtBjbnOCiQg85cDU5k+eYfOxsMeMCw4Fx7
         77pH4DeIObayk6Ouj0THCw/qE11/AvhYUf4fIV4G4+Mh48rYBe8QMzNxMpE3jHw4azl2
         eHcrOqPbF5PZ0h0N1gluIYLb7KY/DGf7vG1Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvMbzIlHtKDMWkbtqCX7X4026Y0DMk7QeDmZ/jzIEcQ=;
        b=xpQ9HqyuBXYzc99EHGSwH4o5l1FmNmVig8hicOB424lZnpcKxGFAnQz3VOftmLnCb4
         RqdE55tUcHBC7saxQGbKi+TnzbPlv9UoqgIe1zOrIGGA+eSfIB9kjQI+Smij8rZCJ+6K
         xeCX3A0I3Q6DeNDqKeDTpH1jJoXGCVkGwPYPtLemA1oGRTx/7UfoIzP/56fbCaoWdkDP
         aZnfXjOkWoS1Si9PIxvlxwG+gNi3KCH7qN2El97v2G98rzdHPl6eOsHsDeOOqhilC49Q
         /j7OMPjpmmmmZzbTSZSIbIbfm+nrCpLu4E7j5L6dMmdiCavVlIsK9fIi/Kxy2fGVLBGd
         LxVQ==
X-Gm-Message-State: AFqh2kp5BtdV6uQDGrNMkveCvt/M8lrI+mvsA6/HaaKV1ToarlQNc5Zw
        DVR3IqEUtvRbLufEZT1WtWcZGp11wtfA3ZIu
X-Google-Smtp-Source: AMrXdXsthWnsb1ArzjZqceo9gutngQy9lR2vozVfoujOfORBiwFblqY6SHp2EsVz7pPbxpcZ4I7r6Q==
X-Received: by 2002:a05:6214:518:b0:531:7bc3:7cf7 with SMTP id px24-20020a056214051800b005317bc37cf7mr88647420qvb.21.1673627243347;
        Fri, 13 Jan 2023 08:27:23 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a430800b006b615cd8c13sm13005610qko.106.2023.01.13.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:27:22 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:27:21 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113162721.qwl2asjo542cxe3c@meerkat.local>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 05:06:57PM +0100, Hans Petter Selasky wrote:
> OK, if you say so. Though in my mind 46K rebases of millions of commits seem
> a lot overhead.

Not to discourage you, but you seem to be making statements without a good
understanding of how git works. If there is a history rewrite (even one that
for some reason goes back millions of commits) all hash calculations will
happen exactly once -- on the system of the person who's rewriting the
history. After they push it, it's just a bunch of objects that everyone else
merely downloads.

> However, if history can be edited anyway, why do you need the cryptographic
> hash algorithm. Why not use a non-cryptographic one?

The answer is, unhelpfully, "because that's how git works." Every commit is a
standalone object that references the previous commit, plus includes hashes of
all trees, and those include hashes of all blobs. SHA-1 was picked because of
its speed and the fact that it guarantees an extremely low potential for
collisions (even better with SHA256). As a side-effect, it's easy to calculate
the integrity of the entire tree, including its history, by verifying its
hashes (this is what git fsck does).

Hashes aren't really "cryptographic" anyway (they just happen to be used all
over the place in cryptography). It's really just a one-way function to reduce
content of arbitrary size to a set of bytes of a determined size (and give a
relatively high assurance of it being collision-free).

-K
