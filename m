Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B36CC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4A2071B
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12hATy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKWFyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 00:54:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWFyb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 00:54:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so11207749wrr.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 21:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFqusGb/4wqKo8WLwRr+YPhX+sF9/SRlsh6KU1YC+DM=;
        b=X12hATy97pLTnsD41f5jq7I44mdR2ZTSV1ge9RUtKq1oVlyR7aClLuvroh+zkRrbvP
         ICEthgxdRxrjJPXrVkbI290WkYkIRdmHd8Gi4tFTpXxaPRDIz3Ji6mvCsRdMX1TDTja/
         FvLXEZnjNX1KJ2j5yTktz42Zskav+R3seI48qDBlpIUh37HNexWSwKwoinYaOjQKNDCx
         LjdDLG/8X4RoOM85HxQgZKk713TBrAOgpxVpYP8GBpA2XxLFTqQ5NHlbq3K2fuIi039d
         f7UTtejthUi9HLl3gvJi2QJjNDVpgwSPGRCSFLYq/SgP70BxdXoi+bJoMeuIEe6eurx3
         lC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFqusGb/4wqKo8WLwRr+YPhX+sF9/SRlsh6KU1YC+DM=;
        b=k/wVcIeQJVtB4gQ/uLmZuvrECtTuyE4WQfYjWeGEBQYdQSNf16bpyVN67xGK8PQrTo
         sH6brNH3FVCgD9ARgMTwYJINaz47KQHUce6glzL3xIsEyZWAKpgHo63XBU8yr0Ibl1/G
         adNh/5Vi0zCGLwUwcmvQ5dM7Ywwy8GaP5llW5yeT6PBlIPmKxvsSy5oX3VRVixX689k1
         CRq6TNV3UPbnVihAwDaWuLlW/g3NEN4Ki1RD+RUo/I362ZwWLZkkuwyc17fiVXvxY6Mz
         5bnKFyAStLkYgslm/RfBlgNk6FqP0n2lwTIeAmw7ZVdDXCEhe1w1viRCqYkHgEJXmgvp
         DajA==
X-Gm-Message-State: APjAAAXMrZRFXc2dvWrNckoEgZJmdtwpYOttMvIGWKP5QtmYZJ+jBuHe
        zpk/bBrxwgzetgXe6L4ioi8JFRXX
X-Google-Smtp-Source: APXvYqwlTFVHbPDuBnrmILEhse6GCLgUgdwVvzdSCVqt+Mv1DzA+VAkMpq80ISKw/DjZi9KVhEVH9Q==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr19800713wrv.136.1574488469221;
        Fri, 22 Nov 2019 21:54:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm856629wro.25.2019.11.22.21.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 21:54:28 -0800 (PST)
Message-Id: <pull.470.v2.git.1574488468.gitgitgadget@gmail.com>
In-Reply-To: <pull.470.git.1574464285.gitgitgadget@gmail.com>
References: <pull.470.git.1574464285.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 05:54:27 +0000
Subject: [PATCH v2 0/1] doc: Document 'git submodule status --cached'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's currently undocumented, and should be mentioned.

I previously thought that git submodule status was displaying the behaviors
of git submodule status --cached and was thus incorrectly documented, but
that wasn't actually the case: turns out that git submodule status just
doesn't work when not in the root directory.

Manish Goregaokar (1):
  doc: Document 'git submodule status --cached'

 Documentation/git-submodule.txt | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-470%2FManishearth%2Fsubmodule-sha-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-470/Manishearth/submodule-sha-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/470

Range-diff vs v1:

 1:  0eabb27ba0 ! 1:  3168924c3c Documentation: Correct man page for the SHAs reported by 'submodule status'
     @@ -1,11 +1,9 @@
      Author: Manish Goregaokar <manishsmail@gmail.com>
      
     -    Documentation: Correct man page for the SHAs reported by 'submodule status'
     +    doc: Document 'git submodule status --cached'
      
     -    'git submodule status' reports the SHAs expected by the parent project,
     -    not the SHAs that are actually checked out in the submodule. Checking
     -    out a new SHA in a submodule will not change the output of 'git
     -    submodule status' until you 'git add' the submodule.
     +    'git submodule status --cached' reports the SHAs expected by the parent project,
     +    instead of the SHAs that are actually checked out in the submodule.
      
          Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
      
     @@ -13,13 +11,12 @@
       --- a/Documentation/git-submodule.txt
       +++ b/Documentation/git-submodule.txt
      @@
     - URL in `.gitmodules`.
     - 
     - status [--cached] [--recursive] [--] [<path>...]::
     --	Show the status of the submodules. This will print the SHA-1 of the
     --	currently checked out commit for each submodule, along with the
     -+	Show the status of the submodules. This will print the SHA-1
     -+	recorded in the superproject for each submodule, along with the
     - 	submodule path and the output of 'git describe' for the
     - 	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
     - 	not initialized, `+` if the currently checked out submodule commit
     + 	does not match the SHA-1 found in the index of the containing
     + 	repository and `U` if the submodule has merge conflicts.
     + +
     ++If `--cached` is specified, this command will instead print the SHA-1
     ++recorded in the superproject for each submodule.
     +++
     + If `--recursive` is specified, this command will recurse into nested
     + submodules, and show their status as well.
     + +

-- 
gitgitgadget
