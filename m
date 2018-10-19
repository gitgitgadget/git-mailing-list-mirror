Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32621F453
	for <e@80x24.org>; Fri, 19 Oct 2018 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJTH1k (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 03:27:40 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39572 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeJTH1j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 03:27:39 -0400
Received: by mail-pg1-f201.google.com with SMTP id n5-v6so4001763pgv.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=l4SGLPDVfQ4+GVtK8OGRLuUzxCuPyq8Z1Afm0Ve2y2c=;
        b=tRr5xHaF5xvm1qva3Z1X7R+lIryw0pF6aEdHiG1Pedn0rWevJ0I1QyujHGO/ElfB6B
         Jy9GOWgSOvoHE3Lh/0r9d9PNdhWnBAsv7zF8nbjOqwL0HcDNKzW08Pav+wIN2w3H92eo
         tBouDv8Oye3Vtlv6nfRcpx5o68eOKmHO0RKPp/39wQvRctNeWHhJoc/HTJrq7ItQ6NOd
         WcOl8KSUkDcWsat6sgoREReyIx1TD77iRQyuapXKOPwfl+S67ysMQWeQ6U8gfSeGuJ5m
         5vfsNFnh6EYspsOTecXvuGcuG6vHbfb7ybCRAdMVDPvEu7AuU0pkPg6QeKj6Xh6dFnqv
         SE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=l4SGLPDVfQ4+GVtK8OGRLuUzxCuPyq8Z1Afm0Ve2y2c=;
        b=oZTe5NNY7eQ8XqFmNdtw0JcpeI0AXmfI04rz7xbLboNrcOmMsUx80tMWzPwNYv2G0z
         6ws6Q6ex3gTt3EIg0v5E7QW4jRH8QJ9JopPXHfaCO29Pxffv6Hm2ECa/LzhdIkBV0WyQ
         Jamo1YhhSbTm8O5Du0OalqecF6RA6twCd7Cu7oYrjvNHYQ3fNxJi05NDFvzhiIAsnedS
         RiLnTpcaJBUOOMEVtJI71q8xZat1cJUj+eoNa+FgsYcET8oGgm7eX3764iHaD6AO+Fn5
         liftg6jZwNpX5m9Qik55MmP/p2juXeD5VNl6U6F6nk8rkDEDSJluvTgccLV87hS4Ujg9
         kN2w==
X-Gm-Message-State: ABuFfojAtmQKBAg0j+8kkM6p6CWOeRzsnkYI9doRdS5R4WQJc5PYhrhU
        90wEPgPva3HH2H5GnX/JB03OmI0MQXc47Inu8aH5Vv9hBWuNVP5VR36649vxUroLE1n/Qm0P8gH
        iXsUdE7JquFlYwfTVgwbyFnpnPGOueY8UgSj3pFQAIBbF5hrcM3BlsaoSVSGtKGo=
X-Google-Smtp-Source: ACcGV61dgIoNEYNDthLCEQcevyC8I1CiaW9oh57ZsQZcqDXI0akbYEtXVfBpAX8tcJ9h1Q4pfH/JIGZi0TyVPA==
X-Received: by 2002:a63:1b03:: with SMTP id b3-v6mr17893813pgb.13.1539991171407;
 Fri, 19 Oct 2018 16:19:31 -0700 (PDT)
Date:   Fri, 19 Oct 2018 16:19:27 -0700
Message-Id: <cover.1539990488.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH 0/1] Fix format detection when archiving remotely
From:   steadmon@google.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git-archive does not properly determine the desired archive
format when both --output and --remote are provided, because
run_remote_archiver() does not initialize the archivers prior to calling
archive_format_from_filename(). This results in the remote archiver
always returning a TAR file, regardless of the requested format.

This patch initializes the TAR and ZIP archivers before calling
archive_format_from_filename(), which fixes format detection.

Steps to reproduce:

=E2=88=AB git version
git version 2.19.1.568.g152ad8e336-goog
=E2=88=AB cd ~/src/git
=E2=88=AB git archive --output ~/good.zip HEAD
=E2=88=AB file ~/good.zip
/home/steadmon/good.zip: Zip archive data, at least v1.0 to extract
=E2=88=AB git archive --output ~/bad.zip --remote=3D. HEAD
=E2=88=AB file ~/bad.zip
/home/steadmon/bad.zip: POSIX tar archive

(apply patch and build)

=E2=88=AB ./bin-wrappers/git archive --output ~/fixed.zip --remote=3D. HEAD
=E2=88=AB file ~/fixed.zip
/home/steadmon/fixed.zip: Zip archive data, at least v1.0 to extract


Josh Steadmon (1):
  archive: init archivers before determining format

 builtin/archive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--=20
2.19.1.568.g152ad8e336-goog

