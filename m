Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FEC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiK1NTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiK1NSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:18:48 -0500
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 05:16:08 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C231DF09
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:16:08 -0800 (PST)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
        by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4NLQnZ41RDz5yjb
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 14:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrell.de; s=key2;
        t=1669641042; bh=Y46LlhGJrrCu7T32mGWgj3Bzw/6kCly0/x5CvNx7C+Y=;
        h=Date:From:To:Subject:From;
        b=djQ/Zrv2wCGCc6zzgCeqXGWKhqfnUIaxZFMwjfJ29z94OUsy8bjFQvrVD9AlSlbKa
         AM9VNpMJtAsJiXAXenfGJj1KKr1QAjK2drxl511cWXL3fKT1C4ECKguoNRD3vwTMWn
         hEZlgUsN/oNyL5RNeNPV7Htdbtx9CQpFNvT1DZO7894jmhkQNcVBREsNZUeVlPvH8v
         0eIxFQ/3HFR8MsXvfYh+lgMiwuY1mKPqjCZ8LrPczWhPAaJ3hbwVhd7ecBFIPVEyrM
         yqH3miSaHDEguB3342dFiBI6BQG1YpG65n/4GoqqdxtRd7LNlOQxCDtffpxQePMm5Z
         n6OGrpNq1duSA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4NLQnZ3Frtz536x
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 14:10:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mx2f3e.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4NLQnY6n17z8sbY
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 14:10:41 +0100 (CET)
Received: from webmail01.netcup.net (unknown [46.38.249.153])
        by mx2f3e.netcup.net (Postfix) with ESMTPA id 2CE8060886
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 14:10:41 +0100 (CET)
Authentication-Results: mx2f3e;
        spf=pass (sender IP is 46.38.249.153) smtp.mailfrom=as@schrell.de smtp.helo=webmail01.netcup.net
Received-SPF: pass (mx2f3e: connection is authenticated)
MIME-Version: 1.0
Date:   Mon, 28 Nov 2022 14:10:41 +0100
From:   Andreas Schrell <as@schrell.de>
To:     git@vger.kernel.org
Subject: Program path added to sparse file specification if leading slash is
 used
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <db69818f32a2723cb7ef9ddf79d3ae39@schrell.de>
X-Sender: as@schrell.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <166964104131.25399.5412478463136724230@mx2f3e.netcup.net>
X-PPP-Vhost: schrell.de
X-Rspamd-Queue-Id: 2CE8060886
X-Spamd-Result: default: False [-5.60 / 15.00];
        BAYES_HAM(-5.50)[99.99%];
        MIME_GOOD(-0.10)[text/plain];
        ARC_NA(0.00)[];
        RCVD_COUNT_ZERO(0.00)[0];
        ASN(0.00)[asn:197540, ipnet:46.38.248.0/22, country:DE];
        RCPT_COUNT_ONE(0.00)[1];
        MIME_TRACE(0.00)[0:+];
        FROM_EQ_ENVFROM(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        FROM_HAS_DN(0.00)[];
        TO_DN_NONE(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: P+JuFyqbakQgA8eUbMKeDaCpfHx4Hclrs26GCTc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

What did you do before the bug happened? (Steps to reproduce your issue)

$ git sparse-checkout set /Workspace/Build/Pipeline $ git 
sparse-checkout list C:/Program Files/Git/Workspace/Build/Pipeline

$ git sparse-checkout set Workspace/Build/Pipeline $ git sparse-checkout 
list Workspace/Build/Pipeline

What did you expect to happen? (Expected behavior) The program path 
should not be included in the file spec, if I set the leading slash

What happened instead? (Actual behavior) The git program path was added 
in the sparce file spec.

What's different between what you expected and what actually happened?

Wrong path

Anything else you want to add:

Please review the rest of the bug report below.

You can delete any lines you don't wish to share.

[System Info]

git version:

git version 2.38.1.windows.1

cpu: x86_64

built from commit: b85c8f604d375d4d773a36842964e8a7ec056aae

sizeof-long: 4

sizeof-size_t: 8

shell-path: /bin/sh

feature: fsmonitor--daemon

uname: Windows 10.0 19045

compiler info: gnuc: 12.2

libc info: no libc information available $SHELL (typically, interactive 
shell): C:\Program Files\Git\usr\bin\bash.exe

[Enabled Hooks]

Mit freundlichen Grüßen

Andreas Schrell

Software Engineer
