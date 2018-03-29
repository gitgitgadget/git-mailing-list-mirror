Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B26E1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC2PSs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:18:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:33867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbeC2PSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:18:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLNpK-1f27Hr2wTa-000eBj; Thu, 29
 Mar 2018 17:18:37 +0200
Date:   Thu, 29 Mar 2018 17:18:35 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ZdJjVXMplziVBjoUZ/p4PxJ8Jk9nm4xR2nUHZrtEHy5YPwLrCn
 ENx9/EMOoknRrj+54rc/QDeT9TeWBv7z5ZRUu7RTs9F5jYnlZQ/To1g5wLmGEvkaEK+R+cd
 Qnb6cIwCahKozK4kKZbbYfJs4Hxrw9ZQ+XKA+Dfjyq+5xp/3zJnUikZVFTDccz2OWOY/S4x
 RfRc8IN+ZHiJDVzMUU0UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LWDy+3X52Kc=:nqWVfTfu69F1kl3aN4bxdY
 6T1JhTE1txjE5EXgrrGEDAOsv4Cznxg3Ik9XReO3gySi/7M3iosSMDGjBhWkn7FyeP04Zd22f
 ILd6s0TZDEnRT6Y+pfU5S3Iafs9/FCGyHe24+t7NTsCyS0S1fEaXN7lTyjJNIkv0wf6GAxCpD
 c2mQcvr+wfhmWqQ/F5pkvgSk3f4Yxxu62FChk7GiJN+qZzHeae1vhVVEU/UzJGDwziA3beG71
 GQdAhzyGsnjIfNf+FfkS5OhtovMQ1K+6iJva30AQLKpc2uEiQpVjhZm8iPjtbT/YeKbuwxANs
 fnHdhoNES+5kHSNxjpBuRcd4uGZjbvsoKM3/ZEkE+/7LAJPe9qJbXac1Eeu4A8tpXGNwKpNXG
 UmdKE4fwDjkIjXjMeAbWzSlWDaCRd/NkbJZxYHZ0A7hUBX0VNPwKdZ2cR7eAz4kGdY18do8Lz
 rNVMHoOO9mbYsYkJVUNtVQFquy39fSBmFXOzz5uN03yFauGI5/HqatCgC7+B0XIHBmaGm63dB
 LM7Rq8/VseHSogpp6qTBTRDVhlpoTwGiFodiJ42IfPxmHIch7OyPEmmaMCDJVTcZzbvjLEORw
 plnj8R2pQhBvCiIqeGyA7c4+BF39S/8vJcPgLYJanJzfD8U9qtMgzNgUCr73DjNhafd/y7nQ3
 yw48KfR3pjNirP47My/68H07hSI67ssY88PEs3912fRpsTNLWr394m6soXhvQniqx5wP13NeV
 hqXnxdeJ2fGBDvcz2lE/rJpW7XfzloM1Fnm66Q83yXHaEgvTFHfYu9wGLIM83O0e3/l/CEfSy
 HNX732/07V/9QfDpartOADH7fTbMHReuo9WXBExCKjP7CmzLb62zz98M/W4A9h+dDjt2z8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we are slightly overzealous When removing an entry from a
config file of this form:

	[abc]a
	[xyz]
		key = value

When calling `git config --unset abc.a` on this file, it leaves this
(invalid) config behind:

	[
	[xyz]
		key = value

The reason is that we try to search for the beginning of the line (or
for the end of the preceding section header on the same line) that
defines abc.a, but as an optimization, we subtract 2 from the offset
pointing just after the definition before we call
find_beginning_of_line(). That function, however, *also* performs that
optimization and promptly fails to find the section header correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index b0c20e6cb8a..5cc049aaef0 100644
--- a/config.c
+++ b/config.c
@@ -2632,7 +2632,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			} else
 				copy_end = find_beginning_of_line(
 					contents, contents_sz,
-					store.offset[i]-2, &new_line);
+					store.offset[i], &new_line);
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
-- 
2.16.2.windows.1.26.g2cc3565eb4b


