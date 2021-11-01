Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF187C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 02:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10F760EBC
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 02:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKACQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhKACQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 22:16:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCEBC061714
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 19:14:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id np3so884731pjb.4
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY7QqMIpCDfZ/R2k63AKMpOxl5nJTLl0cpUeGxtsYg4=;
        b=SZja+tVxgnupNQ7HcON20O8q1M8UZCgemKh8r8ii3fk8IZJWypXP8IrV9uOSsr/z7h
         eeCC+YaH+2EbXZ9HksesK+EY7LK/ymCXvJcIQ/anfpeE7MGwKKnI/RE1vMSVf8km7KBi
         SkhP0o5jilYjXVLpRpgtY7577gEaSU8wuSG3k0f8nmvjxejfMrqFOngF0Kv4P1rjRXN1
         2Ab7vLmJ2FMzUrUUOfYUWTCvMWCwAS/sdSuacz8t4hucoMOmv8QPKAhjTOztXCmelRBc
         cuZPPQ70CdRpqGJshX+gSjlmwoSlq/MFcSG3oJr3Rhd1v7+oCoxnxlpkI8kgUIaO9Ph5
         WbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY7QqMIpCDfZ/R2k63AKMpOxl5nJTLl0cpUeGxtsYg4=;
        b=5s1/Am94G+JzHHnUHvEYIoKzg9COIyaWtSGo/3C+OGVwttoK/wzRTfjbGLRMOIENeO
         OYWd246ENyWwoXeSyyTV5eutWlt6QNN8zuJDL2e6tujhyV/NmyiXGBgq1eEu3F6Ybu7w
         WS2HtramZj+dBBnMazpEYaInJrKg7ub9VWscBi7ygnSjejlO/Il5d7cCDM4x+OjetMSN
         dnF5nuBL9XRdQhZHELEZItuXly1lzceAnSmAoNdZkM5xnOFacaq2IWXWpjPTAJlahBk+
         mnnxOVQNeWktHaake+XXnm8rZ1B7sQTkHZTny8JR/J3i/4LOkrfAPzMH25EAgUUbyhgZ
         55oA==
X-Gm-Message-State: AOAM531CFcuDXroaL0dwsh9M7OncRf65JMV2EkZKmHVcpfMtU8RRnizu
        fnGZmFQQRceXHEUjY3jHY3buxDjsAf1ZL+qw
X-Google-Smtp-Source: ABdhPJyqHegCLYH7X0a9SSBBTY+nh1VoIK9lpYK4OYEbpYU4zB0IIEk1G7Sew9cYupQ1eXAP47L4DQ==
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr13880557pjb.99.1635732863005;
        Sun, 31 Oct 2021 19:14:23 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x26sm13221388pff.25.2021.10.31.19.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 19:14:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2] i18n: fix typos found during l10n for git 2.34.0
Date:   Mon,  1 Nov 2021 10:14:17 +0800
Message-Id: <20211101021417.9549-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20211031052156.5237-1-worldhello.net@gmail.com>
References: <20211031052156.5237-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emir and Jean-Noël reported typos in some i18n messages when preparing
l10n for git 2.34.0.

* Fix unstable spelling of config variable "gpg.ssh.defaultKeyCommand"
  which was introduced in commit fd9e226776 (ssh signing: retrieve a
  default key from ssh-agent, 2021-09-10).

* Add missing space between "with" and "--python" which was introduced
  in commit bd0708c7eb (ref-filter: add %(raw) atom, 2021-07-26).

* Fix unmatched single quote in 'builtin/index-pack.c' which was
  introduced in commit 8737dab346 (index-pack: refactor renaming in
  final(), 2021-09-09)

[1] https://github.com/git-l10n/git-po/pull/567

Reported-by: Emir Sarı <bitigchi@me.com>
Reported-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/index-pack.c | 2 +-
 gpg-interface.c      | 2 +-
 ref-filter.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 15ae406e6b..c23d01de7d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1486,7 +1486,7 @@ static void rename_tmp_packfile(const char **final_name,
 		if (!*final_name)
 			*final_name = odb_pack_name(name, hash, ext);
 		if (finalize_object_file(curr_name, *final_name))
-			die(_("unable to rename temporary '*.%s' file to '%s"),
+			die(_("unable to rename temporary '*.%s' file to '%s'"),
 			    ext, *final_name);
 	} else if (make_read_only_if_same) {
 		chmod(*final_name, 0444);
diff --git a/gpg-interface.c b/gpg-interface.c
index 800d8caa67..68d2f29be7 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -775,7 +775,7 @@ static const char *get_default_ssh_signing_key(void)
 		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
 			default_key = strbuf_detach(keys[0], NULL);
 		} else {
-			warning(_("gpg.ssh.defaultKeycommand succeeded but returned no keys: %s %s"),
+			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
diff --git a/ref-filter.c b/ref-filter.c
index 282cdad103..08a3f839c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1037,7 +1037,7 @@ int verify_ref_format(struct ref_format *format)
 		     format->quote_style == QUOTE_TCL) &&
 		     used_atom[at].atom_type == ATOM_RAW &&
 		     used_atom[at].u.raw_data.option == RAW_BARE)
-			die(_("--format=%.*s cannot be used with"
+			die(_("--format=%.*s cannot be used with "
 			      "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
 		cp = ep + 1;
 
-- 
2.34.0.rc0.8.g1f511a9b56

