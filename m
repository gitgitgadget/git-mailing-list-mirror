Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA8C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 23:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhLGX13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhLGX12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 18:27:28 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46EC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 15:23:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so463432pjl.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=yfiVTaaUTBBNbZdsJE/EjeXfB1iNx6EP012/8G9mNXE=;
        b=pzKIgMYpl2NH1iJ2UglOfI8TN09pcOoN+oUd4EpTFPfnD0bad/8IE+7JfvFdzxVqHF
         pmlZwkZY0YQbzKB2YlLm2QCHv+6UlTG/Rjv4vKM+MmgYnPn5omGc7/YatGfTRU/PFlPU
         6nLC4T52GCJLHRffxqV/yWx34bX6FYstUgRwJDS0XoBPUpMZKnkpOXM7KvrtCEaV6vLH
         18DloQMIO2NOqbnAjftwmgrsBbMloOY4vRoSJPoxvQqGqMt96romvTN7J6N5x+0fcqpC
         JVVQ5qglEjFPZxY8bg8Cd2DDIOWNG3zd5C9fKFhGF5dkVEFrOmzxc/3LJ7FnE3HF51gs
         s1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=yfiVTaaUTBBNbZdsJE/EjeXfB1iNx6EP012/8G9mNXE=;
        b=BlWFBdJoi6/ewPyUlMe59Nd9ILYz37wMaix2HIqmhgjUh7OlmzXBEyEXBZ/7O0LKPo
         aum3+D5mMPzey22RgraHIAyIY6bMbeMkzV2vIBAMvGfEVvUS/VXDGJZiddY+cBX4Zmuw
         BYpcZhTQ0tnSklup1NJj6uLpepP+hRJXWSULNxiYby4e5fvbTEYJNITaXf4OnR8khYlB
         JsXWdcIeWO65Ekoowyh+YJyI77JQKQA9aTfZWtE1B6NXTTR0QTxrrYvmtvydgMOkDHCf
         1UB2Jw8WeKuDCfDzkaD/0pXvmTMJ3MSZQ+gIlfg2YS4cbL2KLxxVUlFAmzAnP4FsLsn3
         1npQ==
X-Gm-Message-State: AOAM5328BXvtX33vlF9TbEVAgdt9DGjCPxV9ZO7ozPWwEhhBayrUcBja
        iXY/FdsOHFooucSZO6+nlOTVwU1LR4iOroAJzV27Obl9r890vntFsmmfO3w1VMOzxDgLLNGPHqL
        E18i9y9vq8jQouCxposOBVU1t2YvlkbQ2j/73H7h4repT2Fr4oLFavHR14nj82GFMjLe3TGxTde
        ce
X-Google-Smtp-Source: ABdhPJzUr0KU0BNK0yoXiQqKk5pVg8IPJX1cJH0jdluANW+rAJsJtsYXmGcvwrrZH0XTaOVQi7DnH1+V+XCx93/GKUUk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:88d3:0:b0:49f:baac:9b51 with
 SMTP id k19-20020aa788d3000000b0049fbaac9b51mr2156240pff.44.1638919436700;
 Tue, 07 Dec 2021 15:23:56 -0800 (PST)
Date:   Tue,  7 Dec 2021 15:23:50 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1638919346.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v6 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a reroll addressing =C3=86var's comments about needless $(pwd) and
separating out include_by_remote_url() to make things more consistent.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  16 +++++
 config.c                 | 133 ++++++++++++++++++++++++++++++++++++---
 config.h                 |  46 ++++----------
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
 4 files changed, 272 insertions(+), 41 deletions(-)

Range-diff against v5:
1:  b2dcae03ed =3D 1:  b2dcae03ed config: make git_config_include() static
2:  d3b8e00717 ! 2:  de2be06818 config: include file if remote URL matches =
a glob
    @@ config.c: static int include_by_branch(const char *cond, size_t cond=
_len)
     +	return found;
     +}
     +
    ++static int include_by_remote_url(struct config_include_data *inc,
    ++		const char *cond, size_t cond_len)
    ++{
    ++	if (inc->opts->unconditional_remote_url)
    ++		return 1;
    ++	if (!inc->remote_urls)
    ++		populate_remote_urls(inc);
    ++	return at_least_one_url_matches_glob(cond, cond_len,
    ++					     inc->remote_urls);
    ++}
    ++
     +static int include_condition_is_true(struct config_include_data *inc,
      				     const char *cond, size_t cond_len)
      {
     +	const struct config_options *opts =3D inc->opts;
     =20
    --	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
    -+	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len)) {
    + 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
      		return include_by_gitdir(opts, cond, cond_len, 0);
    --	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_l=
en))
    -+	} else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond=
_len)) {
    +@@ config.c: static int include_condition_is_true(const struct config_=
options *opts,
      		return include_by_gitdir(opts, cond, cond_len, 1);
    --	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_l=
en))
    -+	} else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond=
_len)) {
    + 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_l=
en))
      		return include_by_branch(cond, cond_len);
    -+	} else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:"=
, &cond,
    -+				   &cond_len)) {
    -+		if (inc->opts->unconditional_remote_url)
    -+			return 1;
    -+		if (!inc->remote_urls)
    -+			populate_remote_urls(inc);
    -+		return at_least_one_url_matches_glob(cond, cond_len,
    -+						     inc->remote_urls);
    -+	}
    ++	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", =
&cond,
    ++				   &cond_len))
    ++		return include_by_remote_url(inc, cond, cond_len);
     =20
      	/* unknown conditionals are always false */
      	return 0;
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --f=
ixed-value'
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    -+	cat >"$(pwd)"/include-this <<-\EOF &&
    ++	cat >include-this <<-\EOF &&
     +	[user]
     +		this =3D this-is-included
     +	EOF
    -+	cat >"$(pwd)"/dont-include-that <<-\EOF &&
    ++	cat >dont-include-that <<-\EOF &&
     +	[user]
     +		that =3D that-is-not-included
     +	EOF
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --f=
ixed-value'
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    -+	cat >"$(pwd)"/include-two-three <<-\EOF &&
    ++	cat >include-two-three <<-\EOF &&
     +	[user]
     +		two =3D included-config
     +		three =3D included-config
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --f=
ixed-value'
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    -+	printf "[user]\ndss =3D yes\n" >"$(pwd)/double-star-start" &&
    -+	printf "[user]\ndse =3D yes\n" >"$(pwd)/double-star-end" &&
    -+	printf "[user]\ndsm =3D yes\n" >"$(pwd)/double-star-middle" &&
    -+	printf "[user]\nssm =3D yes\n" >"$(pwd)/single-star-middle" &&
    -+	printf "[user]\nno =3D no\n" >"$(pwd)/no" &&
    ++	printf "[user]\ndss =3D yes\n" >double-star-start &&
    ++	printf "[user]\ndse =3D yes\n" >double-star-end &&
    ++	printf "[user]\ndsm =3D yes\n" >double-star-middle &&
    ++	printf "[user]\nssm =3D yes\n" >single-star-middle &&
    ++	printf "[user]\nno =3D no\n" >no &&
     +
     +	cat >>hasremoteurlTest/.git/config <<-EOF &&
     +	[remote "foo"]
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --f=
ixed-value'
     +	git init hasremoteurlTest &&
     +	test_when_finished "rm -rf hasremoteurlTest" &&
     +
    -+	cat >"$(pwd)"/include-with-url <<-\EOF &&
    ++	cat >include-with-url <<-\EOF &&
     +	[remote "bar"]
     +		url =3D bar
     +	EOF
--=20
2.34.1.400.ga245620fadb-goog

