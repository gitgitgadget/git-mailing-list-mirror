Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82053C5CFC2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F0613C4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhGORrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhGORrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:47:31 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328FC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a18-20020a056a000c92b02903282ac9a232so4856757pfv.6
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=lmg7QpqhuqMm2UWK2qaVaj01nbON/Qw9sNHc2ytwyYo=;
        b=OjsSkj5lSopLdrP631+XWsgE1K4yPmWTqdl2xPqJHGyloeGaryKqDPe8xaBQLxd2zG
         bsk5v5wc/c2O57Mws8bjlO0GkHFTYV9nYVWE6CxHOxA6N/jxUakd5WvdkUq2JwV5prrJ
         NL3VKHv2HzWEsBhUo7SOWptjVuxO2un8e9pFFyyJpTTMNg5NlkSlvPY2rl49NRYW6cmv
         KWhbTbO/sNHjfi3QdKoFeAnXOSq8ZrzQoV59TqI63Ux5uP2OamN8V75p3cGCpqWh2Pdl
         hrr5bZp+LDCqFreEPDUBGDWQkSBIw8lBy1DR+ukcwWoIDa6X6xnZWqn50FY3Lc+y4+O7
         IKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=lmg7QpqhuqMm2UWK2qaVaj01nbON/Qw9sNHc2ytwyYo=;
        b=Rb60+MrVjoPTsrkam5gKFrD+VnukyzOhE2m24xicGa7w7+Nv5TwWXN7bBsm8PAhN66
         19cF9eyzVI3hZFbXzheZ6s4iEMrpIIx69gR11gjJQkJK7sB601ogNb0L4yl13pXoQKFg
         FCUjpcPtkec6G0jSfBewJ6XhFpaflJAxK/QRHXcgfsE74ugI0yIX9+6+72xAgbZAmPmh
         4SZhpA4DTj1qIkjja+2m2TN9wD5jKQNm1pki/GJhDMEF52C2p2mlGZRghUiuaGuzjRxb
         iRIONXPdlbPCnvMq+L1HYLPmyC2glT7k/eZZB9q7cVqILYV8KzIenhRYX27lkeHAaZQk
         jVfA==
X-Gm-Message-State: AOAM5301AN7a1uJer+tfUCq7ipk+fFIJbN6rjUeG4TEs7WbEW3rqWHTP
        x87BitAwGJkh4Q6xPmW9x6/zcXI9sPbSX90zVPfAVIcuMvsDwU36YM7M9Yr3eq5Yicd/4bEorPf
        AWFaXySU+8MSke9dlG8LxHcNeulwFDLFq+Q5YbgKoXwgqNh05usNxYEN9PKHYNtkxhcvjrsurCz
        NB
X-Google-Smtp-Source: ABdhPJwx24EPxnrBAHWYUEwWSQOTOTfrrFKTr17ywcTfLeg9KH40EUpwvKXWq7QHMr12ibxvwRY/htM0DwxLYLT0OPQ6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4b08:: with SMTP id
 lx8mr5539955pjb.66.1626371077605; Thu, 15 Jul 2021 10:44:37 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:44:29 -0700
In-Reply-To: <cover.1624486920.git.jonathantanmy@google.com>
Message-Id: <cover.1626370766.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 0/3] Push negotiation fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Emily and =C3=86var for your reviews. There are no changes to C cod=
e
in this version of the patch set, but the tests have been updated
following both your comments.

I have ended up splitting up the HTTP tests away from t5516 into its own
file. I had to use the number 5549 because it was the next available
one. There is one Bash function that is duplicated - I don't foresee
many such functions being duplicated, but if that happens, I guess we
can always created a helper script somewhere else.

Jonathan Tan (3):
  send-pack: fix push.negotiate with remote helper
  send-pack: fix push nego. when remote has refs
  fetch: die on invalid --negotiation-tip hash

 builtin/fetch.c            |  4 ++-
 builtin/send-pack.c        |  1 +
 send-pack.c                |  6 ++--
 t/t5510-fetch.sh           | 13 +++++++
 t/t5516-fetch-push.sh      |  4 ++-
 t/t5549-fetch-push-http.sh | 72 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100755 t/t5549-fetch-push-http.sh

Range-diff against v1:
1:  eb0dce9f49 < -:  ---------- send-pack: fix push.negotiate with remote h=
elper
-:  ---------- > 1:  af40bee611 send-pack: fix push.negotiate with remote h=
elper
2:  3bf6921d96 ! 2:  c841693303 send-pack: fix push nego. when remote has r=
efs
    @@ t/t5516-fetch-push.sh: test_expect_success 'push with negotiation pr=
oceeds anywa
      	git -C testrepo config receive.hideRefs refs/remotes/origin/first_co=
mmit &&
      	GIT_TEST_PROTOCOL_VERSION=3D0 GIT_TRACE2_EVENT=3D"$(pwd)/event" \
      		git -c push.negotiate=3D1 push testrepo refs/heads/main:refs/remote=
s/origin/main 2>err &&
    -@@ t/t5516-fetch-push.sh: test_expect_success 'http push with negotiat=
ion' '
    - 	# Without negotiation
    - 	test_create_repo "$SERVER" &&
    - 	test_config -C "$SERVER" http.receivepack true &&
    -+	test_commit -C "$SERVER" unrelated_commit &&
    - 	git -C client push "$URI" first_commit:refs/remotes/origin/first_com=
mit &&
    - 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_c=
ommit &&
    - 	GIT_TRACE2_EVENT=3D"$(pwd)/event" git -C client -c protocol.version=
=3D2 \
    -@@ t/t5516-fetch-push.sh: test_expect_success 'http push with negotiat=
ion' '
    - 	rm -rf "$SERVER" &&
    - 	test_create_repo "$SERVER" &&
    +@@ t/t5516-fetch-push.sh: test_expect_success 'denyCurrentBranch and w=
orktrees' '
    + 	git -C cloned push origin HEAD:new-wt &&
    + 	test_must_fail git -C cloned push --delete origin new-wt
    + '
    +-
    + test_done
    +
    + ## t/t5549-fetch-push-http.sh ##
    +@@ t/t5549-fetch-push-http.sh: setup_client_and_server () {
    + 	git init "$SERVER" &&
    + 	test_when_finished 'rm -rf "$SERVER"' &&
      	test_config -C "$SERVER" http.receivepack true &&
     +	test_commit -C "$SERVER" unrelated_commit &&
      	git -C client push "$URI" first_commit:refs/remotes/origin/first_com=
mit &&
    - 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_c=
ommit &&
    - 	GIT_TRACE2_EVENT=3D"$(pwd)/event" git -C client -c protocol.version=
=3D2 -c push.negotiate=3D1 \
    + 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_c=
ommit
    + }
3:  1453a1b4e5 ! 3:  476da85859 fetch: die on invalid --negotiation-tip has=
h
    @@ builtin/fetch.c: static void add_negotiation_tips(struct git_transpo=
rt_options *
     -				die("%s is not a valid object", s);
     +				die(_("%s is not a valid object"), s);
     +			if (!has_object(the_repository, &oid, 0))
    -+				die(_("%s is not a valid object"), s);
    ++				die(_("the object %s does not exist"), s);
      			oid_array_append(oids, &oid);
      			continue;
      		}
    @@ t/t5510-fetch.sh: test_expect_success '--negotiation-tip understands=
 abbreviated
     +		--negotiation-tip=3Dalpha_1 \
     +		--negotiation-tip=3D$(test_oid zero) \
     +		origin alpha_s beta_s 2>err &&
    -+	test_i18ngrep "is not a valid object" err
    ++	cat >fatal-expect <<-EOF &&
    ++	fatal: the object $(test_oid zero) does not exist
    ++EOF
    ++	grep fatal: err >fatal-actual &&
    ++	test_cmp fatal-expect fatal-actual
     +'
     +
      . "$TEST_DIRECTORY"/lib-httpd.sh
--=20
2.32.0.93.g670b81a890-goog

