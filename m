Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F05C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824D6610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhFWTY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFWTYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:24:33 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA9C061280
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:21:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3065787otl.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nVoK9loGgyB47qib1Zr1JzbNRYserN47PUCpeovi/oU=;
        b=AP+RNA3p4fD0+ZsYvXuKj3xPcPcmoqqM9F5qscbxcLQaOfEPruPXUmZHZs4FBXwK+e
         g/6yHKng5K5dadhbRHa6xCPni2PXooSRCq1Y35y9O+HE4Q1tuUU0IyM2uf3dgdqTUI5u
         ZFvqB4OM+rCa6Suw+rz4ir+AyjCqy02At58I3L3P0d1nu5u45CEVjHSoh0Hr8qWuP8ut
         suzfNFWw3E00nVBiEiT6cov8lI7MNPM/A3guGaqNqb3kRVY9AQTqd++xSw59PEat7321
         hwyaEhzKOtOKlQwe3qhsRRo8iWaMAsTGY9sFNEtIIA5m7ySOMMtEDkbTPHE2AcPHejzC
         Zvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nVoK9loGgyB47qib1Zr1JzbNRYserN47PUCpeovi/oU=;
        b=lWV8IP8Of0/9slaRL1iphd0L5NvXqByIpDNT/DQOdcsABw8U2PTonu4gA9NpH17QxK
         aCs/hQ/y+qI2aiZ6z6RtYDQn6anAV9GwXMHipO8rTN6SYrqaZ1a6vP7n3NggXKqItsyh
         aKIKon9Crp14nAu+yNm3hNl2YVRs97L19PD/Xy5N33YeKWzWGRUOLys7m231ciNvT0lJ
         ftHqJ9OMf6X6hqsmw0ze1eUn5SpNtpWmMsel7bO+BGhHqOts8TMk7s6m12OUZShUbPHi
         e7cTNex1STv3lok4QzDoHR48HZnHK24CIIYHX97dZJZVbTEnHEZ71ugMunzGdo5Q4dGt
         uXew==
X-Gm-Message-State: AOAM53367557hmcYVtBIWokpCdjJKkoLL0Rc7JncCAbDk8he1BF/enQB
        gOaLgRKdeumz/hygPwOXu/w=
X-Google-Smtp-Source: ABdhPJxo9xvvPQnxT2G58J1VqqjLAFw2iUfT9ZCyYHGrc488ZHkp0mfa18YQvhFhnklbsTYH+H4G6g==
X-Received: by 2002:a9d:74d4:: with SMTP id a20mr1327427otl.28.1624476113742;
        Wed, 23 Jun 2021 12:21:53 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w12sm140604oor.35.2021.06.23.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:21:53 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:21:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d389d015943_4290208ae@natae.notmuch>
In-Reply-To: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
Subject: RE: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> @@ -2243,7 +2253,6 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(=
GIT_VERSION):\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
>  	$(perllibdir_SQ)
>  define cmd_munge_script
> -$(RM) $@ $@+ && \
>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \

Any reason why the same isn't done for the $(BUILT_INS) target?

> @@ -2514,7 +2522,6 @@ endif
>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>  all:: compile_commands.json
>  compile_commands.json:
> -	@$(RM) $@
>  	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json >=
 $@+
>  	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
>  endif

What about these?

  $(REMOTE_CURL_ALIASES):
  $(LIB_FILE):
  $(XDIFF_LIB): =

  $(ETAGS_TARGET):
  tags:
  cscope:

-- =

Felipe Contreras=
