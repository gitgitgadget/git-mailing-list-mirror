Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD9C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiCaSvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiCaSvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF416F04D
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so1000326wrh.11
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=OLFYzYoiKBRPdPN8Xb15o07QPKHKMLXN1jdk/4tqNBg=;
        b=CMybaw+mS/lZULlllgcRVQ9RPbuvQEMrCOvFLi41+Xsy4jxwwdDE+IExP2FEXk6KYH
         ouuK0DYU8jsPmnzIyg2wnZw6mzhAbb/9jOS2gr2COe3fXPJXnTkn9NFLS/f6GLa+d3qk
         dkBm8dUBpg/+NpX5qSBiOd+O4XJcfROOKflVCBO66eMpLUCXde6qkj8RNTz3Hp8wMV9k
         CwSMurk2JZS0l3S5wQ6nR/F24jiTtoS7OwPzwozVYYOEUVRcbGGW3TjKrqXXTA5W2niN
         gx1sCvqaLP1KTXAEI/1qYQqPM2LLbLuBuQ22JFk/gDRnMmO+OD3gTx/AbPV63gIC2oih
         G9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=OLFYzYoiKBRPdPN8Xb15o07QPKHKMLXN1jdk/4tqNBg=;
        b=fyxZ65JyDgYoOc4WtX6NkynxvZk6drEaGZJem+iX7BFVT7EwnRS+0qWHlCvW9IYgrN
         XwVlFv7LhaD3avu1yzyHlsrL4Y65gYP97RX16H2AWfUM8wlNKEgD/SPOnliYceezUP9b
         e8xD8jwDE06eooe/pVdW3jfk0UkgWaf6sIH/Bhbem9cSK/MiVuYrE4iDvECqpTMMOCNe
         gmoD+abaTPkGmayMlH5fysoB5Fjdzp0VNkNh128mPk/T5011AWQDuXDyOWHSc2eoJemd
         vBtOlFnzFrx/n6/HLGzUX8/BPXgpTy+3dDc1Iv1aiqAd+lFG0tg6XSEROee2BdKV9hOI
         qmqw==
X-Gm-Message-State: AOAM533dW591vA/G7gop6zQuPh0m+Lff6y+qz4BDK1m6iXfAIUEmTAHw
        WmRLV8swaoCWxMUKMxPtNd7vOTb24Og=
X-Google-Smtp-Source: ABdhPJxnGG+JK7RwJXP3TpyvFm4sMO4lxqa+2f2wCtXEHzKUDW56xEtpGld9p77R0L8Rc4LEBwPUxg==
X-Received: by 2002:adf:ee06:0:b0:203:d69f:ee6a with SMTP id y6-20020adfee06000000b00203d69fee6amr5156096wrn.376.1648752602763;
        Thu, 31 Mar 2022 11:50:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm62389wmc.25.2022.03.31.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:50:02 -0700 (PDT)
Message-Id: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 18:49:57 +0000
Subject: [PATCH v2 0/4] branch --recurse-submodules: Bug fixes and clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback, all. This version incorporates most of the
suggestions (which were pretty small anyway).

== Patch organization

Patches 1-2 are bugfixes, 3-4 are clean ups.

Patch 1 fixes a bug where "git branch --recurse-submodules" would not
propagate the "--track" option if its value was "--no-track" or
"--track=inherit".

Patch 2 fixes a bug where "git branch --recurse-submodules" would give
advice before telling the user what the problem is (instead of the other way
around).

Patch 3 fixes some old inconsistencies when "git branch --set-upstream-to"
gives advice and when it doesn't.

Patch 4 replaces exit(-1) with exit(1).

== Changes

Since v1:

 * Patch 1: reword the --track comments to be prescriptive
 * Patch 3: remove a now-unnecessary die(). I didn't include a suggestion to
   inline the advice string to save reviewers the trouble of proofreading
   (and the format string has no placeholders anyway, so I don't think we'd
   get much benefit out of typechecking). We can inline it in another
   series.

Glen Choo (4):
  branch: support more tracking modes when recursing
  branch: give submodule updating advice before exit
  branch --set-upstream-to: be consistent when advising
  branch: remove negative exit code

 branch.c                    | 47 +++++++++++++++++++++++++++----------
 builtin/submodule--helper.c |  7 +++---
 t/t3207-branch-submodule.sh | 38 +++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 16 deletions(-)


base-commit: abf474a5dd901f28013c52155411a48fd4c09922
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1190%2Fchooglen%2Fbranch%2Frecursive-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1190/chooglen/branch/recursive-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1190

Range-diff vs v1:

 1:  0b682c173c8 ! 1:  5e96a09199f branch: support more tracking modes when recursing
     @@ branch.c: static int submodule_create_branch(struct repository *r,
      +		strvec_push(&child.args, "--track=inherit");
      +		break;
      +	case BRANCH_TRACK_UNSPECIFIED:
     -+		/* Default for "git checkout". No need to pass --track. */
     ++		/* Default for "git checkout". Do not pass --track. */
      +	case BRANCH_TRACK_REMOTE:
     -+		/* Default for "git branch". No need to pass --track. */
     ++		/* Default for "git branch". Do not pass --track. */
      +		break;
      +	}
       
 2:  f21d283e5ad = 2:  74b839bfc4e branch: give submodule updating advice before exit
 3:  8e6ea3478b3 ! 3:  64d9b8e0f44 branch --set-upstream-to: be consistent when advising
     @@ Commit message
      
          [1] https://lore.kernel.org/git/211210.86ee6ldwlc.gmgdl@evledraar.gmail.com
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## branch.c ##
      @@ branch.c: static void dwim_branch_start(struct repository *r, const char *start_name,
     + 	real_ref = NULL;
       	if (get_oid_mb(start_name, &oid)) {
       		if (explicit_tracking) {
     - 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
     +-			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
      -				error(_(upstream_missing), start_name);
     -+				int code = die_message(_(upstream_missing),
     -+						       start_name);
     - 				advise(_(upstream_advice));
     +-				advise(_(upstream_advice));
      -				exit(1);
     -+				exit(code);
     - 			}
     - 			die(_(upstream_missing), start_name);
     +-			}
     +-			die(_(upstream_missing), start_name);
     ++			int code = die_message(_(upstream_missing), start_name);
     ++			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
     ++					  _(upstream_advice));
     ++			exit(code);
       		}
     + 		die(_("not a valid object name: '%s'"), start_name);
     + 	}
 4:  fb2b472d9ae = 4:  306858373cc branch: remove negative exit code

-- 
gitgitgadget
