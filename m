Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38222C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKISa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKISa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 13:30:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1B388E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 10:30:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so27036943wrt.12
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zuB2w0WYV03SMHIh05QVY0LogjFyEasV3T96Pbo8PdE=;
        b=OO0u5XQzBzVPdpuI/MJcRgeJhUDVaQoRkKz/L+CyuEFhdudkBggKSIHqoh63mtynRR
         wn1u6m1dFfptQrfmvFj2lEd05gF58NkUGPfZNir2P5WXor6EphcURZYEWAXbvQW4tw63
         ZGtBxksDQgKeHLB13svrAmwXbZiQ7WhGsvoos+vlnrZj2yj44oyAH4P+COtixooM8unV
         5jEiLiQ/YnJwhuu3TyqEPISWA8rkJo2QQqsHjqmxs00nj6odBwpdHvoFUYiX2ghHJjhT
         Mzci6APkYvU35iQcH6jU41qF3ucq6pcs3v8tOUQ/M0iQ4XOUfkLSAGvXHg/A1lrFEfA7
         QkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuB2w0WYV03SMHIh05QVY0LogjFyEasV3T96Pbo8PdE=;
        b=mJq/Os1pWH4JmFu3abUzzYhSIkzDQq2CcZU2lkol2Goq47ThFgeQOswXWWP6CB/Bhu
         lHsB5jIkiecdmizwK2/CnPAxqoAAD/p2xv3kbW2YlUxS9pUdl1xGeI4OArQ1aA8Ir6jo
         AdWDMUzR2L0V+biyH0u0JspyZE4Ib71XtvHRvr+5xZ1E19lhG2KKaix/x+KvOZPTTkhB
         tmZpgOatToQewmlU+MjCEawHEIT5czrXiv9NXy3oFI6hQv6h5vXvZGT+ZupgB5GMhEXT
         RwhmgyAqPX1f5TJs1yIrXhHeG3DHKK3oRQMhvtIS02FUyPtRPxGlwY4T143x4MH6hf/+
         t7TQ==
X-Gm-Message-State: ACrzQf2UvjksBOpsIb+eWRlB0kwgNqbboO0/ibyUpoX3/Jfg+u7xonmW
        NZpNBgOs0i2PODlpvoE9SkdWUP2kirU=
X-Google-Smtp-Source: AMsMyM4VCTwB0SV146l9YKtIbq2G+RRet+J4DrQEjneu2eXI81IM0cZkjPQMCAfTgKezNFmOjo3TQQ==
X-Received: by 2002:a5d:5410:0:b0:236:5e78:b1af with SMTP id g16-20020a5d5410000000b002365e78b1afmr880096wrv.266.1668018622471;
        Wed, 09 Nov 2022 10:30:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c4d9000b003a6a3595edasm2275347wmp.27.2022.11.09.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:30:21 -0800 (PST)
Message-Id: <pull.1308.git.git.1668018620148.gitgitgadget@gmail.com>
From:   "Max Coplan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 18:30:17 +0000
Subject: [PATCH] po: use `switch` over `checkout` in error message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Max Coplan <mchcopl@gmail.com>,
        =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
         =?UTF-8?q?an?= <mchcopl@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
 =?UTF-8?q?an?= <mchcopl@gmail.com>

Small change.  Since `switch` is suggested for changing branches over
`checkout`, this commit updates an error message to use `switch` as the
default

Signed-off-by: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>
---
    po: use switch over checkout in error message
    
    Small change. Since switch is suggested for changing branches over
    checkout, this commit updates an error message to use switch as the
    default

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1308%2Fvegerot%2Fupdate-error-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1308/vegerot/update-error-message-v1
Pull-Request: https://github.com/git/git/pull/1308

 builtin/checkout.c | 2 +-
 po/bg.po           | 4 ++--
 po/ca.po           | 4 ++--
 po/de.po           | 4 ++--
 po/el.po           | 4 ++--
 po/es.po           | 4 ++--
 po/fr.po           | 4 ++--
 po/id.po           | 4 ++--
 po/it.po           | 4 ++--
 po/pl.po           | 4 ++--
 po/pt_PT.po        | 2 +-
 po/ru.po           | 2 +-
 po/sv.po           | 4 ++--
 po/tr.po           | 4 ++--
 po/vi.po           | 4 ++--
 po/zh_CN.po        | 4 ++--
 po/zh_TW.po        | 4 ++--
 17 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29c74f898bf..51f9f928113 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1222,7 +1222,7 @@ static const char *parse_remote_branch(const char *arg,
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
-			     "    git checkout --track origin/<name>\n"
+			     "    git switch --track origin/<name>\n"
 			     "\n"
 			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 			     "one remote, e.g. the 'origin' remote, consider setting\n"
diff --git a/po/bg.po b/po/bg.po
index 934784fe523..8ebb06c15d6 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -3883,7 +3883,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3892,7 +3892,7 @@ msgstr ""
 "Ако искате да изтеглите клона от конкретно хранилище, напр. „origin“,\n"
 "изрично го укажете към опцията „--track“:\n"
 "\n"
-"    git checkout --track origin/ИМЕ_НА_КЛОН\n"
+"    git switch --track origin/ИМЕ_НА_КЛОН\n"
 "\n"
 "Ако искате винаги да се предпочита конкретно хранилище при нееднозначно\n"
 "ИМЕ_НА_КЛОН, напр. „origin“, задайте следната настройка в конфигурационния\n"
diff --git a/po/ca.po b/po/ca.po
index 80c430df454..a39fa23c2e7 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -3679,7 +3679,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3688,7 +3688,7 @@ msgstr ""
 "Si voleu agafar una branca de seguiment remota, p. ex. «origin», podeu\n"
 "fer-ho especificant el nom complet amb l'opció --track:\n"
 "\n"
-"    git checkout --track origin/<nom>\n"
+"    git switch --track origin/<nom>\n"
 "\n"
 "Si voleu que en agafar un branca amb un <nom> ambigu s'usi una branca\n"
 "remota, p. ex. «origin» al remot, considereu configurar l'opció\n"
diff --git a/po/de.po b/po/de.po
index 76d6d3bea7c..5fa798e86f4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3676,7 +3676,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3687,7 +3687,7 @@ msgstr ""
 "können Sie das tun, indem Sie den vollständig qualifizierten Namen mit der\n"
 "--track Option angeben:\n"
 "\n"
-"    git checkout --track origin/<Name>\n"
+"    git switch --track origin/<Name>\n"
 "\n"
 "Falls Sie beim Auschecken mit mehrdeutigen <Namen> immer ein Remote-"
 "Repository\n"
diff --git a/po/el.po b/po/el.po
index 703f46d0c7c..7fbfdb4b35c 100644
--- a/po/el.po
+++ b/po/el.po
@@ -9448,7 +9448,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -9464,7 +9464,7 @@ msgstr ""
 "'origin',\n"
 "μπορείτε να το κάνετε ορίζοντας ολογράφως το όνομα με την επιλογή --track:\n"
 "\n"
-"    git checkout --track origin/<όνομα>\n"
+"    git switch --track origin/<όνομα>\n"
 "\n"
 "Αν θα θέλατε οι εξαγωγές από ένα αμφίσημο <όνομα> να προτιμούν πάντα\n"
 "έναν απομακρυσμένο εξυπηρετητή, π.χ. το απομακρυσμένο 'origin', σκεφτείτε να "
diff --git a/po/es.po b/po/es.po
index b2190476799..1156a6be09e 100644
--- a/po/es.po
+++ b/po/es.po
@@ -3612,7 +3612,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3621,7 +3621,7 @@ msgstr ""
 "Si querías hacer un check out a una rama rastreada remota, como 'origin',\n"
 "puedes hacerlo proporcionando el nombre completo con la opción --track:\n"
 "\n"
-"    git checkout --track origin/<nombre>\n"
+"    git switch --track origin/<nombre>\n"
 "\n"
 "Si quisieras que siempre los checkouts de nombres ambiguos prefieran\n"
 "un remoto particular, como 'origin', considera configurar\n"
diff --git a/po/fr.po b/po/fr.po
index f601f406363..44f8e175676 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -3712,7 +3712,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3721,7 +3721,7 @@ msgstr ""
 "Si vous souhaitiez extraire une branche de suivi distant sur 'origin',\n"
 "par exemple, qualifiez-la complètement avec l'option --track :\n"
 "\n"
-"    git checkout --track origin/<nom>\n"
+"    git switch --track origin/<nom>\n"
 "\n"
 "Si vous souhaitez privilégier un distant particulier lorsque <nom> est\n"
 "ambigu, vous pouvez positionner checkout.defaultRemote=origin dans\n"
diff --git a/po/id.po b/po/id.po
index 794bf8f1c56..c65c06386e8 100644
--- a/po/id.po
+++ b/po/id.po
@@ -4422,7 +4422,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -4431,7 +4431,7 @@ msgstr ""
 "Jika maksud Anda check out cabang pelacak remote, seperti 'origin',\n"
 "Anda bisa lakukan dengan kualifikasi penuh nama dengan opsi --track:\n"
 "\n"
-"    git checkout --track origin/<nama>\n"
+"    git switch --track origin/<nama>\n"
 "\n"
 "Jika Anda ingin checkout <nama> ambigu selalu memilih satu remote,\n"
 "seperti remote 'origin', pertimbangkan untuk menyetel\n"
diff --git a/po/it.po b/po/it.po
index c31560834d8..abf65d8d91f 100644
--- a/po/it.po
+++ b/po/it.po
@@ -12097,7 +12097,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -12107,7 +12107,7 @@ msgstr ""
 "puoi farlo usando la versione completamente qualificata del nome\n"
 "con l'opzione --track:\n"
 "\n"
-"    git checkout --track origin/<nome>\n"
+"    git switch --track origin/<nome>\n"
 "\n"
 "Se preferisci che i checkout di un <nome> ambiguo siano sempre risolti\n"
 "rispetto a un particolare remoto, ad es. 'origin', potresti voler\n"
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14cc..96814cac6ab 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -12668,7 +12668,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -12677,7 +12677,7 @@ msgstr ""
 "Jeśli chodziło o wybranie gałęzi śledzącej, np. na „origin”,\n"
 "możesz to zrobić podając pełną nazwę z opcją --track:\n"
 "\n"
-"    git checkout --track origin/<nazwa>\n"
+"    git switch --track origin/<nazwa>\n"
 "\n"
 "Jeśli chcesz, żeby wybrania wszystkich niejednoznacznych\n"
 "<nazw> preferowały jedno zdalne repozytorium, rozważ ustawienie\n"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 32142531bbd..271199ce50e 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -12919,7 +12919,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
diff --git a/po/ru.po b/po/ru.po
index 803208c4d52..56c6a1d2420 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -3570,7 +3570,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
diff --git a/po/sv.po b/po/sv.po
index 56db2f1bb19..554987110e5 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -3572,7 +3572,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3581,7 +3581,7 @@ msgstr ""
 "Om du menade checka ut en spårad fjärrgren på t.ex \"origin\", kan du\n"
 "göra det genom att ange hela namnet med flaggan --track:\n"
 "\n"
-"    git checkout --track origin/<namn>\n"
+"    git switch --track origin/<namn>\n"
 "\n"
 "Om du alltid vill att utcheckningar med tvetydiga <namn> ska\n"
 "föredra en fjärr, t.ex fjärren \"origin\" kan du ställa in\n"
diff --git a/po/tr.po b/po/tr.po
index 1e1d0318fd9..3c84df99891 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -3645,7 +3645,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3654,7 +3654,7 @@ msgstr ""
 "Eğer bir uzak izleme dalını çıkış yapmak istediyseniz örn. 'origin',\n"
 "bunu adı --track seçeneği ile tam olarak nitelendirip yapabilirsiniz.\n"
 "\n"
-"\tgit checkout --track origin/<ad>\n"
+"\tgit switch --track origin/<ad>\n"
 "\n"
 "Eğer her zaman belirsiz <ad> çıkışlarının bir uzak konumu tercih etmesini\n"
 "isterseniz, örn. 'origin', yapılandırmanızda checkout.defaultRemote=origin\n"
diff --git a/po/vi.po b/po/vi.po
index d673745ac5b..9d74557b08e 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -3589,7 +3589,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -3598,7 +3598,7 @@ msgstr ""
 "Nếu ý bạn là lấy ra nhánh máy chủ được theo dõi, ví dụ “origin”,\n"
 "bạn có thể làm như vậy bằng cách chỉ định đầy đủ tên với tùy chọn --track:\n"
 "\n"
-"    git checkout --track origin/<tên>\n"
+"    git switch --track origin/<tên>\n"
 "\n"
 "Nếu bạn muốn luôn lấy ra từ một <tên> một máy chủ ưa thích\n"
 "chưa rõ ràng, ví dụ máy chủ “origin”, cân nhắc cài đặt\n"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 7de9c72d564..353cf308742 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -4500,7 +4500,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -4509,7 +4509,7 @@ msgstr ""
 "如果您想要检出一个远程跟踪分支，例如在 'origin' 上的，您可以使用分支\n"
 "全名和 --track 选项：\n"
 "\n"
-"    git checkout --track origin/<名称>\n"
+"    git switch --track origin/<名称>\n"
 "\n"
 "如果您总是喜欢使用模糊的简短分支名 <名称>，而不喜欢如 'origin' 的远程\n"
 "名称，可以在配置中设置 checkout.defaultRemote=origin。"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 2f7d01c3031..1cbc7da479d 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -4362,7 +4362,7 @@ msgid ""
 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 "you can do so by fully qualifying the name with the --track option:\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 "one remote, e.g. the 'origin' remote, consider setting\n"
@@ -4371,7 +4371,7 @@ msgstr ""
 "如果您想要簽出一個遠端追蹤分支，例如 'origin'，您可以\n"
 "使用 --track 選項寫出全名：\n"
 "\n"
-"    git checkout --track origin/<name>\n"
+"    git switch --track origin/<name>\n"
 "\n"
 "如果您總是喜歡使用模糊的簡短分支名 <name>，而不喜歡如 'origin' 的遠端\n"
 "版本庫名，可以在設定中設定 checkout.defaultRemote=origin。"

base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
-- 
gitgitgadget
