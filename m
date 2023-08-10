Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54040C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjHJUj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjHJUjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D22733
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf9252eddso188718166b.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699992; x=1692304792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xll3ttnJ7Sp3nAwkR5sXlixwZZJ4Xijwy7S0Mq57Mm8=;
        b=Yro8Up5JuKTlCm3xJLFpzXWRPGbjJfPd26Y8QRwxjRrP33Fr4Qehfxnd+6chU6Vrn3
         KB1GdgfpkyJ+rb617lJebJR044N2Z8Pp0Xx7ylj7RfPpMXD7s9OvsTf9d+86DpRS9VCe
         sheWR59IdL3kcj63d0tCzV/jVsXD2sRjlZHHSINxjgwRsM4aZbdfwHYbewwPE5pOashd
         stPuDzJLpOD+GGAqTXInnodbJJw9igvV7fljgl1j+a0zy+d1T8y6rwygTfl4wePEC+wC
         2/GNDp1q1Z4JuDYU/4RtkBA5fcqkWoteXaF7jWe3hhqmCVVPokjmbNfXi/YWN01760WL
         bhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699992; x=1692304792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xll3ttnJ7Sp3nAwkR5sXlixwZZJ4Xijwy7S0Mq57Mm8=;
        b=fnjTOP2OkWgwfh354NYUdNGYJXSOa82WoahzO3zCs7s487NfkjUdEb6DYsDWqambI1
         9ZOmsmekJJOdkazx8caz/YQ5GATpukbY8DVMylJ4G9luiPYy3JO2Ohm5U6zaw9xOgxL5
         NFEw8iHKqfvtWwOgGIgDyJZrYIjgEGNPl3Fhja+LiGapQx66MATyAXicXwa1qcqM/mWX
         d6JUcO8PX3uSi4WTJPQfBQa++6Ndnc2BUV38s8RPvxi7gQK08+80uSxRJzdhU1WLpOmW
         UEnn9a8uDeOdhnpgAlZOFGNZHtzEecL8Woa/M3fCMnhcIfZdp4LUwPhh/vR6S7iCjybU
         mfOw==
X-Gm-Message-State: AOJu0YxR5hPyOXPCOzb0L/ngsgxkCwofoycUlkulcTzB61tGNLnxpGuO
        qErx2sjd2D3K975strkclMtEMQ/HOnE=
X-Google-Smtp-Source: AGHT+IEqXqO1aCAEvBx+AVMP4+6SgOMcu3U5Hq+tOP34RDLU0c7UrL4cHAa06cr8ZyW0WWxAUJcozA==
X-Received: by 2002:a17:906:308d:b0:993:d7cf:f58 with SMTP id 13-20020a170906308d00b00993d7cf0f58mr4283ejv.2.1691699991825;
        Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20-20020a1709061b1400b0098ce63e36e9sm1384071ejg.16.2023.08.10.13.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
Message-ID: <b291e6f7aec3a651f9366fac8eea0903f939d767.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:43 +0000
Subject: [PATCH v2 4/8] maintenance: use random minute in cron scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_random_minute() method was created to allow maintenance
schedules to be fixed to a random minute of the hour. This randomness is
only intended to spread out the load from a number of clients, but each
client should have an hour between each maintenance cycle.

Add this random minute to the cron integration.

The cron schedule specification starts with a minute indicator, which
was previously inserted as the "0" string but now takes the given minute
as an integer parameter.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 78924bb32c6..ef8bb772c38 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2174,6 +2174,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	FILE *cron_list, *cron_in;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *tmpedit = NULL;
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&crontab_list.args, cmd);
@@ -2228,11 +2229,11 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 			"# replaced in the future by a Git command.\n\n");
 
 		strbuf_addf(&line_format,
-			    "%%s %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
 			    exec_path, exec_path);
-		fprintf(cron_in, line_format.buf, "0", "1-23", "*", "hourly");
-		fprintf(cron_in, line_format.buf, "0", "0", "1-6", "daily");
-		fprintf(cron_in, line_format.buf, "0", "0", "0", "weekly");
+		fprintf(cron_in, line_format.buf, minute, "1-23", "*", "hourly");
+		fprintf(cron_in, line_format.buf, minute, "0", "1-6", "daily");
+		fprintf(cron_in, line_format.buf, minute, "0", "0", "weekly");
 		strbuf_release(&line_format);
 
 		fprintf(cron_in, "\n%s\n", END_LINE);
-- 
gitgitgadget

