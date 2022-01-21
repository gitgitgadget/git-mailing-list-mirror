Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B9C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiAURpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381943AbiAURo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 12:44:56 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852FC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:44:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y17-20020a170902d65100b0014a17faf0bdso1844503plh.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ilw6zK3hagRiTtTk0dVtae/rEa2jPKcMRvDlLQm/Ugk=;
        b=J4sdhMGEg1argAEH5YxluH37xeioLue3HJ9OlneTLJCAhyJW5wGaRoZydcZdvugZW5
         g9g0J7e6tav4ImXMF6dHWWgw0aljSFZowL95YaMJ7eL/XMHsEN/krDbg2Yy0/hvP/QvI
         W8X+TwRvz4pbiasQYlisCmLjjvq8/rSKLdY4SSuoOjVYIKvaODC7qHCbKGIHcXQBV+6n
         8T2lTcjL08WpYQ1ahgZRoc/RvU3jjQ5jUIMqu2U93+7B4e5Tsh3T/iXvP7lgL9fEsaeg
         PGVKJQYjXgf+fIZ6n+HB9e9EHQ/BH7JFtYtm2kuiUfOPdlZMpcVcBgS+H2wi0Tm+n2uQ
         UdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ilw6zK3hagRiTtTk0dVtae/rEa2jPKcMRvDlLQm/Ugk=;
        b=PMpuv7ClcseGtXErXKSiwCuWhvgQs9VHKXkhlBxE2yZG/9w6zQq3SUY8DvlxDbw+fR
         Iy7cdSoCpR6d5mucFKoxNNFCOr/jgvHz5n6JV9SZ1IKbc9syOrf6UE/W2+yJ87V+3L3r
         MaFfWktquNRQh7R5VH8XRejz1uHROCsHskKlM4JbDi0rQ51SxhuEfHFrHthZSrAEKzNr
         WJCdYRKJvBbQPFcNQAgNP4YXu92XhrLRqiA4cTDRXvdDqBJa1pwLyQxKP4rttus/XJ8q
         qivraH1arGYQZLxt6LjQvsk1BxbbIHalrQrRgpJm8a8A1RM6TLWnHJOpNS/bnkYJSnei
         yKYg==
X-Gm-Message-State: AOAM532mGpCo9z4384CtNCj/z2dNmqO6vaWc5ocux/t36703zkFohjHi
        iBRiTxK7AyLeqT93jp3bMq5J3DFTK0mWBDzljEnorq9XhoAu++hykexjKCmeEeegTJWeAZ9Urit
        HeCsGX1NZllTqzjR8QFKlDcFQma+ZgxE6+wmACpUDX7NlVkXi9hwu2vdmoLATwoswkZw54vAd5Y
        /H
X-Google-Smtp-Source: ABdhPJxflHcAtzdzUPntxwvLSR/VpTSNIA3Oxx9wELQ8fCAzUNpuagbIlNSvLJ+iJEZ9aOyUaN1a/NELwySzYdXG24hF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:853:b0:4c0:3e77:22ea with
 SMTP id q19-20020a056a00085300b004c03e7722eamr4562643pfk.74.1642787095510;
 Fri, 21 Jan 2022 09:44:55 -0800 (PST)
Date:   Fri, 21 Jan 2022 09:44:41 -0800
In-Reply-To: <20220120185548.3648549-1-jonathantanmy@google.com>
Message-Id: <20220121174441.3991963-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220120185548.3648549-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2] sparse-checkout: create leading directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        avarab@gmail.com, jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating the sparse-checkout file, Git does not create the leading
directory, "$GIT_DIR/info", if it does not exist. This causes problems
if the repository does not have that directory. Therefore, ensure that
the leading directory is created.

This is the only "open" in builtin/sparse-checkout.c that does not have
a leading directory check. (The other one in write_patterns_and_update()
does.)

Note that the test needs to explicitly specify a template when running
"git init" because the default template used in the tests has the
"info/" directory included.

Helped-by: Jose Lopes <jabolopes@google.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:
 - made test simpler
 - added attribution to Jose Lopes for finding and making the first
   draft of this patch (after confirming with them)

=C3=86var mentioned "git sparse-checkout add" but I think that that is a
different problem - in the "git sparse-checkout init" case, we could get
into this case with a template that does not have .git/info, but in the
"git sparse-checkout add" case, the user would have had to explicitly
remove the info directory. So I'll limit this patch to the "init" case,
for now.
---
 builtin/sparse-checkout.c          | 3 +++
 t/t1091-sparse-checkout-builtin.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 679c107036..2b0e1db2d2 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -471,6 +471,9 @@ static int sparse_checkout_init(int argc, const char **=
argv)
 		FILE *fp;
=20
 		/* assume we are in a fresh repo, but update the sparse-checkout file */
+		if (safe_create_leading_directories(sparse_filename))
+			die(_("unable to create leading directories of %s"),
+			    sparse_filename);
 		fp =3D xfopen(sparse_filename, "w");
 		if (!fp)
 			die(_("failed to open '%s'"), sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-b=
uiltin.sh
index 42776984fe..3189d3da96 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -79,6 +79,12 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
=20
+test_expect_success 'git sparse-checkout init in empty repo' '
+	test_when_finished rm -rf empty-repo blank-template &&
+	git init --template=3D empty-repo &&
+	git -C empty-repo sparse-checkout init
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
--=20
2.35.0.rc0.227.g00780c9af4-goog

