Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36FC433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 05:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D59160F55
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 05:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJaFYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 01:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhJaFYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 01:24:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C2C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 22:22:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m21so14028513pgu.13
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7f+70QFWcOZ1+nUfwTM0RSF9MLBPRJ9v+e76D4hrjPY=;
        b=kySbfUEEZOyx18ZW12Hfy8t5QJY7VWp4vT2qEbMR0wZ63V2b51E9/eSZC3qW6383e0
         vhehxCvzNJbkO/oHLFAbHWWa/D58AvUMjhAhB1fgBZtYw17QzHddzcJxSB0IH9jYUQ5K
         dX1q+uXXLYpkkDt3NSb+SS8sGp1W31jJBFvI+nfa1l0tLDGTVCuvQ3nPvn6teQ6zhVB5
         6UOnSgHi4jvG5yQgRnXEvLKqQrnOM1XgeK6Cy/Ggdqb74am4ze1gniu/fNTxZ+WMDonZ
         YJwGZxY46OsMfHYRrNbWPmZjhlzi7pKY4M0zcl71VqFoJ/ZB2+adCeQ7T1K3iyaVRiNE
         ZWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7f+70QFWcOZ1+nUfwTM0RSF9MLBPRJ9v+e76D4hrjPY=;
        b=Wl44EKu5BdBX+yUf2ZKd58I1bZOa/W8YNX8WAnMzmv6xFwW26apoWnH4izBmof4nDu
         Z3/Ge4eFVY6H70gpCjJapx/Nj57EhtBo2rQd7lbrIcHnF+wOotdMwcT8LdlwHuECKJrp
         TUcgLQUNqYgArN9KVZPxGFAN+3nP9eEuzcm+XDQtMeamux47yeWuhaMvKVP1A8isNz/r
         4gDwyK5w2UNdoHSH0tguD3Gmk4+Ec5wd/hNNE0oNFdtcKGkotcYj20iaMXvfL2f90Doc
         M8bBzIxwf4CAg2uvc/OkYpmQTX1lUGTnBtaIqJP3hb+VW+Pcv54dEc7eSATqZmSCSfVF
         u2Zw==
X-Gm-Message-State: AOAM531pCAemTduWt6wjsXFnQcbU4SdT/iYp6ki5lNVt8e+ogIxFIZlN
        J3ENlGmZtwQotJ+qw3f3RRGzwuR9hfSK4N3T
X-Google-Smtp-Source: ABdhPJwDlBE36g0L/DY6umw0tjYKTaPS7Wz3ZvmVtpA0YjVdCvW5E1ezfa3KL5BhgU+pfSznV0jWCQ==
X-Received: by 2002:aa7:90d0:0:b0:44d:b8a:8837 with SMTP id k16-20020aa790d0000000b0044d0b8a8837mr20918531pfk.47.1635657720611;
        Sat, 30 Oct 2021 22:22:00 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l4sm12534593pfc.121.2021.10.30.22.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 22:22:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
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
Subject: [PATCH] i18n: fix typos found during l10n for git 2.34.0
Date:   Sun, 31 Oct 2021 13:21:56 +0800
Message-Id: <20211031052156.5237-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20211030020917.32132-1-worldhello.net@gmail.com>
References: <20211030020917.32132-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emir reported typos in some i18n messages in the pull request[1] of
Turkish language l10n for git 2.34.0.

* Use stable spelling for config variable "gpg.ssh.defaultKeyCommand".
* Add missing space between "with" and "--python".

[1] https://github.com/git-l10n/git-po/pull/567

Reported-by: Emir Sarı <bitigchi@me.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 gpg-interface.c | 2 +-
 ref-filter.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

