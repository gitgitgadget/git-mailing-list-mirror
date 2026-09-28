Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907232B135
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627130; cv=none; b=YKhBmPdvqhKyDdeyCnCstg/prW8Wp00EKtMp/eiA/zVpcJh+Za+onuMPokMCChlZ9j8MzNnX8Fqt1QNLfO0yeuPhotrp3r4OSv7gBE/f3tRgooHMeCE96bzQMyMrLo53f02P9wvsQRy0QItUHTUET+lxpAFl3BpYmdfSjYKYi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627130; c=relaxed/simple;
	bh=8bEyJII+ztBUyazUjrwv2GZRA7YBOOWtdtOzNUnKEQ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eRVgDHJqAhS0qyufJWYNypz5FvIa1U6hw+0P8nfxThm6zdc/6X2AKNpJNkoWNxSWMYBSalYESYZHcXTJpKRbST077crEP42X+UMrXrFvqkD6RO+WitbxQNjjYEsGbe5iUvlj+XAeR2Hylp+ySUmDSYwja0ESVP8/33Dr0ZoTxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T25evnCW; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T25evnCW"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad20d4so416952385a.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790627127; x=1791231927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hX/g5qqr+7O0UmmKjXJ1JPscVgtvnSwpEi6jCYobYaM=;
        b=T25evnCWpHEUphAFCcaYcwG5svoGHOvCm6+xYg8LySacT3zqe1MuSAhjSGw49YTpdM
         NbyIjVSbeQKTDefjOqhBL/++d5FYxCEfwuyFDwCjuftRbuhOE52whfaFpT1D+iaLquv1
         sFvluP/uvfFuYzzguqerixMY6qL0uEE5z8R2pd1xa0JpoHWsGXH9etAmFJwJcMwzd48I
         /7ICa9a4AiF49BUWTDpOr2FqPg8qDRo6SNn75VorYkggYIc67ZtexEFSVL3nUyPsXmCm
         3hbA0sBqHBWRvHRHozfrGVGYYnVfrdBWAX7PQu02doF+7QAFJmg/0baMpT056gM11I1d
         cP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627127; x=1791231927;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hX/g5qqr+7O0UmmKjXJ1JPscVgtvnSwpEi6jCYobYaM=;
        b=ddseYE0DtP1Kp+7hGC5NOmUyHnlm/QHn+7G7iF8wlza8JX6qAE1HZ0uk+eSqa4PpUc
         6CtGHmhsPfhlHXA6Q7iQwoMZuPC5DAGhbZGC6YYWFlcjV/Kob6lGy9ycNtd5tEbzIXxR
         92TQATAZ97k3ocRYZfEo2dJB3+ThxJo3MMz0eXyHoklQ9nTtJPwxHFqBnIMrzz+NCy3D
         //fKbe94IRqUBpDhTSUTG6f4ZONSxsZ42B2xCNja5nnZpFuH/gcnlFlt2MeGDeW9LdZe
         /e7LM9OKeacs+ulfFW+BKrH5+vaYdATyZHnMWfIgn3GBD3UfFcd2Ceuv/D2Hkcs80LSq
         rzmw==
X-Gm-Message-State: AFuF++m+xFsYqWDK3q2CWD72yhBZLG789hYAtfEwkquDsCocYjeLFXrk
	qCO+ptD0zsshgFO9XGQb4yLtkSOL18hig3gGxvErWUPSryxBUwbaxlR3jF3P2w==
X-Gm-Gg: AYBFou0Uf/2GImxobo7YlYk3RcZPLrYJzShCqkJXAjCJDyPy8DXGl/IVxM62ytupn9Z
	Tw7aCYcRitzoIvwVLqvYYSbUlLQXUTH5kCQApvdwVRZbFH+JatdIXOBsNlVul3RRW6gKnpeRYUq
	uVwqULi/Y/bDVV/Jyj3cR16yWzSSiEQL3EPjatAJ77lDoGWoBI4+iCsRX4JfBbvFR0Ug8qertlQ
	pesJjqutESr8tOjhM/Jsi7B2v/9t8/FQ6NlPWJJjkRRBGtSay+2unxhphdlG12PQ2S9bWoc2DkG
	S2ESPP1fHzZ363OhmWqJGM0d60bbbOA3mAn5rSd/BoeUp5kGEfKwVBd26SiOgS7rRi8U4XYOy/m
	SnQlZ43q3Ouxq3ElKWcyKBT7PccaWTeIIQHlW+cz9+gu7Yp8DsiuzZL8XiRuMKargbM0G0QF7G8
	6qG25aBWK1PBraLDIpCRJwFvSXeC2UljaRzpHNrf+uvt+oKlqmGleBoamaeBIInX1qV/ENzLI5
X-Received: by 2002:a05:620a:40d6:b0:932:ddff:1241 with SMTP id af79cd13be357-93c4738cc70mr2183227385a.26.1790627126986;
        Mon, 28 Sep 2026 13:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.79.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c81598783sm230830285a.46.2026.09.28.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:25:26 -0700 (PDT)
Message-Id: <017ca1346d40e386abf943c9f22ccc365bbf4d7a.1790627122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 20:25:22 +0000
Subject: [PATCH 3/3] [doc] Delete translations of gittutorial-2 description
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

The tutorial has been deleted so we don't need the translations anymore.

Deleted them with sed like this to try to avoid making mistakes by
deleting them manually, and then cleaned up the comments by hand
sed -I '' '/msgid "A tutorial introduction to Git: part two"/,+2d' po/*.po

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 command-list.txt | 1 -
 po/bg.po         | 3 ---
 po/ca.po         | 4 ----
 po/de.po         | 3 ---
 po/el.po         | 4 ----
 po/es.po         | 3 ---
 po/fr.po         | 3 ---
 po/ga.po         | 3 ---
 po/id.po         | 3 ---
 po/it.po         | 4 ----
 po/ko.po         | 3 ---
 po/pl.po         | 3 ---
 po/pt_PT.po      | 4 ----
 po/ru.po         | 3 ---
 po/sv.po         | 3 ---
 po/tr.po         | 3 ---
 po/uk.po         | 3 ---
 po/vi.po         | 3 ---
 po/zh_CN.po      | 4 ----
 po/zh_TW.po      | 4 ----
 20 files changed, 64 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..5c649c882e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -244,7 +244,6 @@ gitrepository-layout                    userinterfaces
 gitrevisions                            userinterfaces
 gitsubmodules                           guide
 gittutorial                             guide
-gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
 scalar                                  mainporcelain
diff --git a/po/bg.po b/po/bg.po
index e11e536182..fae7ca2c71 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -17097,9 +17097,6 @@ msgstr "Монтиране на едно хранилище в друго"
 msgid "A tutorial introduction to Git"
 msgstr "Въвеждащ урок за Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Въвеждащ урок за Git: втора част"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Уеб интерфейс на Git"
 
diff --git a/po/ca.po b/po/ca.po
index e8cfa5e925..73f071f048 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -20846,10 +20846,6 @@ msgstr "Muntant un repositori dins un altre"
 msgid "A tutorial introduction to Git"
 msgstr "Un tutorial d'introducció al Git"
 
-#: command-list.h
-msgid "A tutorial introduction to Git: part two"
-msgstr "Un tutorial d'introducció al Git: segona part"
-
 #: command-list.h
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Interfície web del Git (interfície web pels repositoris Git)"
diff --git a/po/de.po b/po/de.po
index 6b65bb6180..abf37baa43 100644
--- a/po/de.po
+++ b/po/de.po
@@ -15263,9 +15263,6 @@ msgstr "Einbinden eines Repositories in ein anderes"
 msgid "A tutorial introduction to Git"
 msgstr "eine einführende Anleitung zu Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "eine einführende Anleitung zu Git: Teil zwei"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Git Web Interface (Web-Frontend für Git-Repositories)"
 
diff --git a/po/el.po b/po/el.po
index 703f46d0c7..5809b434ee 100644
--- a/po/el.po
+++ b/po/el.po
@@ -19747,10 +19747,6 @@ msgstr ""
 msgid "Specifying revisions and ranges for Git"
 msgstr ""
 
-#: command-list.h:206
-msgid "A tutorial introduction to Git: part two"
-msgstr ""
-
 #: command-list.h:207
 msgid "A tutorial introduction to Git"
 msgstr ""
diff --git a/po/es.po b/po/es.po
index aa1bb9bf90..dcdcbf5360 100644
--- a/po/es.po
+++ b/po/es.po
@@ -14046,9 +14046,6 @@ msgstr "Montar un repositorio dentro de otro"
 msgid "A tutorial introduction to Git"
 msgstr "Un tutorial de introducción a Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Un tutorial de introducción a Git: parte dos"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Interfaz web Git (interfaz web para repositorios Git)"
 
diff --git a/po/fr.po b/po/fr.po
index f9613e793f..2e020cedf6 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -16698,9 +16698,6 @@ msgstr "Montage d'un dépôt dans un autre dépôt"
 msgid "A tutorial introduction to Git"
 msgstr "Une introduction pratique à Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Une introduction pratique à Git : deuxième partie"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Interface web de Git"
 
diff --git a/po/ga.po b/po/ga.po
index 3d04a3bc51..b023d7fb3f 100644
--- a/po/ga.po
+++ b/po/ga.po
@@ -16521,9 +16521,6 @@ msgstr "Stóra amháin a chur isteach taobh istigh de cheann"
 msgid "A tutorial introduction to Git"
 msgstr "Réamhrá teagaisc ar Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Réamhrá teagaisc ar Git: cuid a dara"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Comhéadan gréasáin Git (tosaigh gréasáin chuig stórais Git)"
 
diff --git a/po/id.po b/po/id.po
index 381db5a4bf..4176009e8f 100644
--- a/po/id.po
+++ b/po/id.po
@@ -20476,9 +20476,6 @@ msgid "A tutorial introduction to Git"
 msgstr "Tutorial perkenalan Git"
 
 #: command-list.h
-msgid "A tutorial introduction to Git: part two"
-msgstr "Tutorial perkenalan Git: bagian dua"
-
 #: command-list.h
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Antarmuka web Git (tampilan depan web untuk repositori Git)"
diff --git a/po/it.po b/po/it.po
index b5ccd8c731..d180be5e88 100644
--- a/po/it.po
+++ b/po/it.po
@@ -24498,10 +24498,6 @@ msgstr "Come specificare revisioni e intervalli in Git"
 msgid "Mounting one repository inside another"
 msgstr "Monto un repository dentro un altro"
 
-#: command-list.h:215
-msgid "A tutorial introduction to Git: part two"
-msgstr "Un tutorial introduttivo per Git: seconda parte"
-
 #: command-list.h:216
 msgid "A tutorial introduction to Git"
 msgstr "Un tutorial introduttivo per Git"
diff --git a/po/ko.po b/po/ko.po
index 7a6847f023..a930084b5b 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -15972,9 +15972,6 @@ msgid "Specifying revisions and ranges for Git"
 msgstr "깃의 리비전 및 범위를 지정하기"
 
 #: command-list.h:204
-msgid "A tutorial introduction to Git: part two"
-msgstr "깃 따라하기 안내서: 2부"
-
 #: command-list.h:205
 msgid "A tutorial introduction to Git"
 msgstr "깃 따라하기 안내서"
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14c..9e75518503 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -25581,9 +25581,6 @@ msgid "Mounting one repository inside another"
 msgstr "Montowanie jednego repozytorium w drugim"
 
 #: command-list.h:216
-msgid "A tutorial introduction to Git: part two"
-msgstr "Samouczek wprowadzenia do Gita: część druga"
-
 #: command-list.h:217
 msgid "A tutorial introduction to Git"
 msgstr "Samouczek wprowadzenia do Gita"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 32142531bb..875671179a 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -25857,10 +25857,6 @@ msgstr ""
 msgid "A tutorial introduction to Git"
 msgstr "Um tutorial de introdução a Git"
 
-#: command-list.h:217
-msgid "A tutorial introduction to Git: part two"
-msgstr "Um tutorial de introdução a Git: parte dois"
-
 #: command-list.h:218
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Interface web de Git (frontend web para repositórios Git)"
diff --git a/po/ru.po b/po/ru.po
index e8845ca2c0..6cad41bc00 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -13866,9 +13866,6 @@ msgstr ""
 msgid "A tutorial introduction to Git"
 msgstr "Обучающее введение в Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Обучающее введение в Git: часть вторая"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Веб интерфейс Git (веб-интерфейс для Git репозиториев)"
 
diff --git a/po/sv.po b/po/sv.po
index 3856426319..df6508317e 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -16194,9 +16194,6 @@ msgstr "Monterar ett arkiv inuti ett annat"
 msgid "A tutorial introduction to Git"
 msgstr "Introduktion till Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Introduktion till Git: del två"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Git-webbgränssnitt (webbframända för Git-arkiv)"
 
diff --git a/po/tr.po b/po/tr.po
index 5e992e1a04..79ca735d17 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -16319,9 +16319,6 @@ msgstr "Bir depoyu bir başkasının içine bağlama"
 msgid "A tutorial introduction to Git"
 msgstr "Git'e giriş için bir öğretici"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Git'e giriş için bir öğretici: Bölüm 2"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Git web arabirimi (Git depoları için web ön ucu)"
 
diff --git a/po/uk.po b/po/uk.po
index 7d0451933c..824d6b0137 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -16509,9 +16509,6 @@ msgstr "Монтування одного сховища всередині ін
 msgid "A tutorial introduction to Git"
 msgstr "Навчальний вступ до Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Навчальний вступ до Git: частина друга"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Веб-інтерфейс Git (веб-фронтенд до сховищ Git)"
 
diff --git a/po/vi.po b/po/vi.po
index f91a7de810..b7c353352b 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -15606,9 +15606,6 @@ msgstr "Gắn một kho chứa vào trong một cái khác"
 msgid "A tutorial introduction to Git"
 msgstr "Hướng dẫn cách dùng Git"
 
-msgid "A tutorial introduction to Git: part two"
-msgstr "Hướng dẫn cách dùng Git: phần hai"
-
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Giao diện Git trên nền web (ứng dụng web chạy trên kho Git)"
 
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 9baf2bf7a6..40e7359b8a 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -20237,10 +20237,6 @@ msgstr "将一个仓库挂载到另一个仓库中"
 msgid "A tutorial introduction to Git"
 msgstr "Git 入门教程"
 
-#: command-list.h
-msgid "A tutorial introduction to Git: part two"
-msgstr "Git 入门教程：第二部分"
-
 #: command-list.h
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Git Web 界面（Git 仓库的 Web 前端）"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 87a8faca93..18e079ef1f 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -20095,10 +20095,6 @@ msgstr "在某個版本庫掛載某個版本庫"
 msgid "A tutorial introduction to Git"
 msgstr "一個 Git 教學"
 
-#: command-list.h
-msgid "A tutorial introduction to Git: part two"
-msgstr "一個 Git 教學：第二部分"
-
 #: command-list.h
 msgid "Git web interface (web frontend to Git repositories)"
 msgstr "Git web 介面（Git 版本庫的 web 前端）"
-- 
gitgitgadget
