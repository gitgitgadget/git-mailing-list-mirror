Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298E91F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbcIVOT1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 10:19:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39437 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbcIVOTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 10:19:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 957C961364; Thu, 22 Sep 2016 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474553964;
        bh=GrQ8moV8qE4u9ijM9rZxSxv13tj9FlSVbJjgtPBdcRs=;
        h=From:Date:Subject:To:From;
        b=FOoDXK4sDGaIf/CzjceDl6uKSIMWDjuxW0xLSjip9ELuUnRyq+jlGIiT4YflXufr4
         hAYx304znMMbK7PvE4k0V3toVRYEAOChmdi5ZrIg7cMDbNDHcxdITGPl3xaVgjB1KI
         wO4+fQitVnS5mUJhNkp6BvoEOVjK9csxQNYMP3xo=
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com [209.85.223.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DCED612F2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474553964;
        bh=GrQ8moV8qE4u9ijM9rZxSxv13tj9FlSVbJjgtPBdcRs=;
        h=From:Date:Subject:To:From;
        b=FOoDXK4sDGaIf/CzjceDl6uKSIMWDjuxW0xLSjip9ELuUnRyq+jlGIiT4YflXufr4
         hAYx304znMMbK7PvE4k0V3toVRYEAOChmdi5ZrIg7cMDbNDHcxdITGPl3xaVgjB1KI
         wO4+fQitVnS5mUJhNkp6BvoEOVjK9csxQNYMP3xo=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 4DCED612F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=timur@codeaurora.org
Received: by mail-io0-f172.google.com with SMTP id m79so87220137ioo.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 07:19:24 -0700 (PDT)
X-Gm-Message-State: AA6/9RnGOq7VLbSswEKZsZP6PqEMxHNCNju6ADeeDE7yLhWq8PQG/vmEcbR00BVwBimFE7/4ejWZ/2EvCPkMtA==
X-Received: by 10.107.140.12 with SMTP id o12mr3089916iod.206.1474553963730;
 Thu, 22 Sep 2016 07:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.169.25 with HTTP; Thu, 22 Sep 2016 07:19:22 -0700 (PDT)
From:   Timur Tabi <timur@codeaurora.org>
Date:   Thu, 22 Sep 2016 09:19:22 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
Message-ID: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
Subject: .gitignore does not ignore Makefile
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following .gitignore file in patch arm/arm64/boot/dts:

*.dtb
qcom
qcom.orig

When I do a git status, I see this:

    modified:   .gitignore
    modified:   qcom/Makefile

All of the other files in arm/arm64/boot/dts/qcom are being ignored,
as request.  However, the file "Makefile" is not being ignored.  Why?
What's so special about "Makefile" that git refuses to ignore it?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
