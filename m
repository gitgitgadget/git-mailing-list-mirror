Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4476C1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 00:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756546AbdCHA6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 19:58:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:57152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756438AbdCHA6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 19:58:21 -0500
Received: from virtualbox ([95.208.58.158]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1cYEcs3xM8-00DHbD; Wed, 08
 Mar 2017 01:57:07 +0100
Date:   Wed, 8 Mar 2017 01:57:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 04/10] setup_git_directory_1(): avoid changing global
 state
In-Reply-To: <20170307233549.GA128647@google.com>
Message-ID: <alpine.DEB.2.20.1703080156040.3767@virtualbox>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de> <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de> <20170307233549.GA128647@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LBrhtifWQabK1orTxWP8TpRpLgS3sTLH97TMiEiwOEL3BCXZUGX
 F0/SQDBfngfGpDBTnyYykhAdRToG8RvYSCPj08/6Ph2XdZRGb8xPf8YrTOJ1RNI78J4WV1D
 6SGnfHc+iEp/LNhIGqTpUx8Z8trKu2rgXmqludtH0rPB3YE6z5D6A1L1+pI5zcgjYZ+/YuG
 s76YO4TbKktvaGxRJIrFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+3XnZnBpocs=:GNByLWP1TktmkmJAyZPef/
 irAG3M1gYJmp8rREfqmi1paKzK4FmPDWA+FSNEcOw4UnV485aA8RdFNRkuXTscX0yoeBdJdt1
 Ta+63wcBgCZ2DQTBmxz9s/NNQ5dmXkCwXxYt5bpkVbBcnTn6Pmm1gSWhw/m3S6TgSMaF/w8dh
 O9V2QrVwwky5dmqnhEuUT8XEEBe2xCyPPUBr1R4RFGfQACnbJ2pZCl2e/5U4dOCYhw6+nq0FN
 PEhgik67jkn/9Zn2xuWk+7tUjJnR03rfKkyaNUM0rDajj0MplYSOLO6OUY8N/qhQOBGJ9XAcs
 LwlKRYYrHqtu+iHYtaCo+pjwzlRhTjHMlBOKKLDShbqUod7VtDIEUMt+7PbQEpjHCX8DqvhQ8
 5/jUDwZCKS1L+ogEaeL0A/gSMWE7cvrR/sJkLljsFLy05eHlSGOf7SMRnozj7PoATzccjvXU9
 aG2M04+wW1tn5M+XSdbMZ7z2GwswpfUd13bSl4STEAmFE871uqdXIjE8IaSmXCtklMwk4g7WT
 L3QGgzNcHkLtYArvavVdhIAxyABux/3ZXR28w9sI+8nin6A/FE8z9Ow3MJeIuP/iFBk8Pghp4
 bXNCX5xEhWjsMBU1G9QpkzNideHpNMBfa+ZXWYYgB8qV7lewlIvZ3tZ/zW26U9Y2j2U8I96+D
 N6TFimSHiXGB4i8oYUCIKAXlNKRk+fN4AKrosAQWQ8JWqx5B6symiZMDbsN/iY6FaD016VtTh
 QDbBmBoP/MIXWLp9DqIeaGRGzngf1VoxrkGG/gzqUIiH07Bi+TOLqcfN23xM2/ZUO2+2Dub29
 GsP2HlnJcadGDuyM1VqPDNmT2QSoPVEaIg9Ej+TEcu4uOpJNyZh4suLwgMbRPYbw/Objqd0w4
 vXWa9/mbcxu8HN+2NHANnQFhK5zk+vX5c++Bf1NA5gZkYQXD5Misb9YdXYTwgOjd0e50STdm0
 L6UTpu62Pe90am/YN0bTuQ92k5SyrclStZ3eVcagfEDJlUm8BJCOgK7EIPEqu2W8naQYhjKDo
 hhzFbzh1ZKsdj0yoQjU/vKcUMTLk4fgyX68N7i4c2CBVvNhr/CHaBcs9FVrWEFm43Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 7 Mar 2017, Brandon Williams wrote:

> On 03/07, Johannes Schindelin wrote:
> >  const char *setup_git_directory_gently(int *nongit_ok)
> >  {
> > +	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
> 
> I couldn't see any strbuf_release() calls for these strbufs so there may
> be some memory leaking here.

You are correct, of course. Something like this may work:

-- snipsnap --
diff --git a/setup.c b/setup.c
index 9118b48590a..c822582b96e 100644
--- a/setup.c
+++ b/setup.c
@@ -1027,6 +1027,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	case GIT_DIR_HIT_MOUNT_POINT:
 		if (nongit_ok) {
 			*nongit_ok = 1;
+			strbuf_release(&cwd);
+			strbuf_release(&dir);
 			return NULL;
 		}
 		die(_("Not a git repository (or any parent up to mount point %s)\n"
@@ -1044,6 +1046,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	startup_info->have_repository = !nongit_ok || !*nongit_ok;
 	startup_info->prefix = prefix;
 
+	strbuf_release(&cwd);
+	strbuf_release(&dir);
+	strbuf_release(&gitdir);
+
 	return prefix;
 }
 
