Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E95C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbiFQAHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiFQAHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:07:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAF62CC0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:07:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 129so2645013pgc.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Eio7sGy6PH0AJ/vGbAwUuykd3n8/V+df2T/BYbp/juk=;
        b=YpzQFq0KuUXXAVnky0vuR7AO3QU9Xkl+p9GgTGDyEVOXRUw294rqla/IjSxh61ZxQD
         zweONvXehT+p6kZoamkT4r1CL4EuWV0ZPm+zXSHwbXfBeo6Gez7fkAp1HcP80/Tl1GTv
         V5i1kLhzr2LAvNrh8D7bWPkcc9O3qH9kKb8aW87mUj0eWjyuP2LplyjFLFh+F+s1ju/0
         35/EIy+6SdF7NLcM430oVtw06nz2X3D49vwCarCv0Wb+5PDn8+rbLkz+ayDUdmsVGnuY
         7nitiJuKBiYxKhP+gag1lCddb2VLJYHGaTA43IvFkoLqsIlCeEhYw9Hozkc6B03ejEmt
         32qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Eio7sGy6PH0AJ/vGbAwUuykd3n8/V+df2T/BYbp/juk=;
        b=NApd5MleWA3cupGP23HBHjWdgv1S3Ry7AAHrbrAq4TEtFhfejAhpAtlxJNgJmyo1PL
         vF3NnVFnrC0aeQq3KOZKFEtnmpjnjEbSDZ1s3wc8vp6sdkVkftwwP1CXCkBYqGr5my2v
         W2z4vZGJuhmI/vYOxlEOygz7NlOe3q96odZUkpabT+qO7GsSmaf5uf/QkIYHhY8OgyfB
         jaG6bkaT4Y4bQfh5JlmMBeON8Wmm0EY6AJZ4/M10F5qsKm/EMvfHDGyMsTkQpdolkrtn
         BkgdfVhxeYw+jA1g3v/ltXE4hDQ1hjzAGxFwNnMrIZEn6aaMy4A+YpVoYlqMBQYH28pc
         DRNQ==
X-Gm-Message-State: AJIora+z0QkVmdCjeMHDrcZR54tuHoaZrDqBgO1t/DI4AoVZihddtRDW
        dlq36JlnQWG/S3+goscRkgtN4Q==
X-Google-Smtp-Source: AGRyM1tB1leJKcME/gKGk4Y8GtZI4oEFFRva/nb2RbscgmvZXGfvKX/EPLqJjH2ANjIvdsm3b86e2g==
X-Received: by 2002:a63:fe42:0:b0:3fd:f49f:20a5 with SMTP id x2-20020a63fe42000000b003fdf49f20a5mr6634228pgj.210.1655424426129;
        Thu, 16 Jun 2022 17:07:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:21e5:9333:e535:23])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm565412plo.14.2022.06.16.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:07:05 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:07:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 1/2] run-command: add an "ungroup" option to
 run_process_parallel()
Message-ID: <YqvFpcfUqyL+SlhB@google.com>
References: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
 <cover-v6-0.2-00000000000-20220606T170356Z-avarab@gmail.com>
 <patch-v6-1.2-45248c786d7-20220606T170356Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-1.2-45248c786d7-20220606T170356Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 10:48:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
> @@ -1766,8 +1791,15 @@ int run_processes_parallel(int n,
>  		}
>  		if (!pp.nr_processes)
>  			break;
> -		pp_buffer_stderr(&pp, output_timeout);
> -		pp_output(&pp);
> +		if (ungroup) {
> +			int i;
> +
> +			for (i = 0; i < pp.max_processes; i++)
> +				pp.children[i].state = GIT_CP_WAIT_CLEANUP;

FYI, this broke for us downstream where we are carrying patches adding a
'pp_buffer_stdin()' and friends to enable stdin buffering to parallel
processes. It also appears to break when pp.max_processes exceeds the
number of actual tasks provided. I needed to add something like this

+    if (pp.children[i].state == GIT_CP_WORKING &&
+        !pp.children[i].process.in)
+            pp.children[i].state = GIT_CP_WAIT_CLEANUP;

That is, only set the WAIT_CLEANUP state if the task wasn't waiting to
be given work (GIT_CP_FREE -> GIT_CP_WAIT_CLEANUP leads to some "error:
waitpid is confused" errors) and if stdin is not currently being
buffered. In the case where .process.in is > 0, GIT_CP_WAIT_CLEANUP
causes pp_collect_finished() to stop spinning in this IO buffer loop,
but there is still stdin to pass along.

Anyway, I think the first part (GIT_CP_FREE -> GIT_CP_WAIT_CLEANUP) is a
bug that matters for the patch as it is now; the stdin bit will not
matter until the later config-based-hooks patches which introduce stdin
buffering anyway.

Thanks very much for this fix otherwise.

 - Emily

> +		} else {
> +			pp_buffer_stderr(&pp, output_timeout);
> +			pp_output(&pp);
> +		}
>  		code = pp_collect_finished(&pp);
>  		if (code) {
>  			pp.shutdown = 1;
