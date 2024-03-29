Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5185C6C
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740372; cv=none; b=l3413KQiA9tfHVYZ7Zo1e+UEki79X0ZKuIdVtgp0qjFIJdRn+oKBTsnUUqNV6+T63/vPnCJxoFO08V8avR1Rj3KmJZGnl0zoLOsrk/tz3y7ZWbAhD5NqRy1LjqpaOGgpP9zUR4/mEBq0U/7MmrvAnBZdaQvf7sVHY6Qdez2tW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740372; c=relaxed/simple;
	bh=surx152QzaVQ8Ym5zWcvnRQyKElNVaVOWP0z2uk0bnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNoTO8OUrTtmBNzmKWboy8nCXO5JYvgv+YAgQqp3Ma7tWenP/BnnxqYV1ns4HvzRlx5JcdQ4kuU2z1h61Tmh60SCbU/8ppa3IefqByrk8VD8kH6we3NDzV2YP+AGQJ/3+2kcRinSYJJznBT7uKQZJvZZbMgw++REq2mTkPtpT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAlrtwlr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAlrtwlr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so4392665e9.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711740368; x=1712345168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxLZOF3+k23rFWZiJ2C5X7pdC8mzHoyVYjBfq0qqLQA=;
        b=HAlrtwlr/HCFDA7X2FuzXz0yps+YfoN+i7aQOwQZ+5i1JRng4Sr1uxKDL0QHoePAsh
         Kgvznyp+4h4BIciWiG5EhSkeiVM9PfisGoJEbOOTTHjbdLdsOm8kn5kJF6KcKdltlKuw
         pU5VKdmdP7OQvu23rAbbv/zRcX0s5x1I/lUdbWhnUub4pYnSokXpai6BjU7Ou9eXU/GT
         FLped6WnETjct9Gzqb7+DFJYmZAK0hUVgTDwXeEN4t5/quIJc3UcJ0yGDJsBKxPbl4Ca
         aWVvY23oHDHNbZvHWa49veZHXleDTUme7wNYdXhhyeb9rNXKsQaTvL6KXTuNkPx/yDfc
         gbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740368; x=1712345168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxLZOF3+k23rFWZiJ2C5X7pdC8mzHoyVYjBfq0qqLQA=;
        b=BmnqHB7vHm4ojtSqzp+iMd8KUQavgiYhIocKK43giOKVesGTezz93gC5vUS870VD72
         UfQvm//sPCh0/ko7zFg39gC+a3Gz2ADhTKBHbb4kCMz8WaaS13GrQNKm71u0oKdy3+Gi
         pM+GdIyhq6SzmtqdWIqRCGmkwo7ettCMD/59kmmcY0OfnfwxOH96kmbuqzbrAMafjLA4
         EqKeH1bB63GvxFFrfS0FVZ3g4bgJ+AJTkf/Z6mgBY7zNzLUtgiV25HK+bCMpPR9hWs/E
         VJ8yJ4WzL9q3SvuycwL4iBn5je0Gg2it2dvDdz/Andgg8ldYNKMMXFGPOTW+a7Pn1PEG
         EFBg==
X-Forwarded-Encrypted: i=1; AJvYcCXoMBPggakOIVTc3oY1Q7Y5Jt5kc1YwcnpaFEmAjaGFdV7xlqkefvPVJzfVJq4dqVNz+LBRmk4WxhkdKCpkh/5AAmhG
X-Gm-Message-State: AOJu0Yx8GvDJ+Qv/ORpjf1VVuj02UkKbaqHfWzOS27/qPvxXniOA2gcx
	HEqNEvoCH2QYpRGXj3FtX+uxEzwkGKmmLILlXZ2JlQmoM6XKy5Hv
X-Google-Smtp-Source: AGHT+IFa0WRba9Gefge0XxyESfCJmT1ywuuLAjyVmwdOSHZwKGQR6pBUiBsChVQvRILtUngZ5c0Uog==
X-Received: by 2002:a05:600c:2814:b0:415:572f:9c07 with SMTP id m20-20020a05600c281400b00415572f9c07mr168592wmb.40.1711740368525;
        Fri, 29 Mar 2024 12:26:08 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0041543b57ca2sm6302860wmq.21.2024.03.29.12.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:26:08 -0700 (PDT)
Message-ID: <c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
Date: Fri, 29 Mar 2024 20:26:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
 <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com> <xmqqcyrgajrp.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyrgajrp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 12:13:46PM -0700, Junio C Hamano wrote:

> > On Tue, Mar 26, 2024 at 08:31:41AM -0700, Junio C Hamano wrote:
> >
> >> 'r'edisplay may work well (and I wonder "r | less" or
> >> piping the hunk display to anything in general would be a useful
> >> future enhancement).
> >
> 
> It would be more like tweaking fputs() of a strbuf that
> was filled by render_hunk() to instead spawn a pager and feed the
> same strbuf to it, or something.  IOW, we already have the payload
> to show.  We just want a pager involved in its showing so that users
> with a huge hunk that does not fit on a page can use "less" on it.

I do not plan to address this in this series, but while the topic is
warm;  Perhaps?:

--- >8 ---
diff --git a/add-patch.c b/add-patch.c
index 778f168298..cb74fe84f5 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
@@ -1450,7 +1451,7 @@ static int patch_update_file(struct add_p_state *s,
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
 				render_hunk(s, hunk, 0, colored, &s->buf);
-				fputs(s->buf.buf, stdout);
+				fputs_to_pager(s->buf.buf);
 				rendered_hunk_index = hunk_index;
 			}
 
diff --git a/pager.c b/pager.c
index b8822a9381..f00fc87a67 100644
--- a/pager.c
+++ b/pager.c
@@ -264,3 +264,30 @@ int check_pager_config(const char *cmd)
 		pager_program = data.value;
 	return data.want;
 }
+
+void fputs_to_pager(const char* s)
+{
+	struct child_process process;
+	FILE* pager_stdin;
+	const char *pager = git_pager(isatty(1));
+
+	if (!pager) {
+		fputs(s, stdout);
+		return;
+	}
+
+	child_process_init(&process);
+
+	prepare_pager_args(&pager_process, pager);
+	pager_process.in = -1;
+	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
+	if (start_command(&pager_process))
+		return;
+
+	pager_stdin = fdopen(pager_process.in, "w");
+	fputs(s, pager_stdin);
+	fflush(pager_stdin);
+
+	close(pager_process.in);
+	finish_command(&pager_process);
+}
diff --git a/pager.h b/pager.h
index b77433026d..dcccfa632b 100644
--- a/pager.h
+++ b/pager.h
@@ -11,6 +11,7 @@ void term_clear_line(void);
 int decimal_width(uintmax_t);
 int check_pager_config(const char *cmd);
 void prepare_pager_args(struct child_process *, const char *pager);
+void fputs_to_pager(const char* s);
 
 extern int pager_use_color;
 
