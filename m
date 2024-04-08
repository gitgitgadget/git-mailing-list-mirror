Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B918C05
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617769; cv=none; b=lKvtArhm/dJhl1BeuOrn4B0qyhwo7udaXKS61L4NRIucL5btZzW6Wpc9sYElyo1pv7DziMwKIjblqRsGUDbUuNdy5xlIaT06jhYC3EQ9yPUi/rC1wtjTnJxE51mFvnqK2z3o4u+lOaXaNpYHOX2MkzlQo1q4HJb7Bfgmd2Jnvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617769; c=relaxed/simple;
	bh=sjNk/+KuFQt0bBqWL9Dwo+qg5DLx2IwrfJEGtVaFsRU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=OMp77tUdbrKgXJGq1fM7mULqh/9Sd7tOTon4NnZZ/IPciLHxBU3FDsse6tJvjMqgVEnJVbefRvVn2DJNLDRqUkUZ5WiJwtQbAyufna13I0aOFe4UXvpLRvknnDKylkQipCne6JahLi6W2FQQzxVkYeWmE34xJMg5uKNBidksuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwgYw2eO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwgYw2eO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41650de9743so12532565e9.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712617766; x=1713222566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVkVfYoOBh1LbOkGaGFQVF46xNsY8eoC5N+t6CDGY+o=;
        b=dwgYw2eOHQEuBPdWa+rIKYPFYOViupQsiJRKWk/KOrEuF3aKCQlLfGMEqRH49m2Jzz
         bPt0AQ9/8TdS8r5oVVz/k8der9XVPGiRTJfdQsktBVd4qASQuKPookKqEtpo/eZ6ocub
         oTeOr7pQXR80sdxWIe0k6L/4Y5HFolZw1WMBBNCCz5qPSCTBkQA9pJlMaSUd0k4m3LBe
         TnOgAfjdqkqz8Nc2iBZESq/a6FErM0GLx7fQmc1zXXWZ/Iq6aJ/ujDxRAU6rWYCoVbYO
         uxfTySynQfdlOp6UdpwBqTY25D249j/IkAR1DmOHN94Svk/1AgvY5FQcv5i4EoqBQ+N6
         kEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712617766; x=1713222566;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVkVfYoOBh1LbOkGaGFQVF46xNsY8eoC5N+t6CDGY+o=;
        b=cbyZ/8IK0Eto/OQMjyfRNC1WpCY9Goj1qMSvKt9NJD6xkDDAEpGQ67Bk7NhH5SZACP
         rqsihKb0Gx1eNPPezKt7vxZ45rS8zx+UUtOneNqP73teJfinqQn61+WblvFAx1Y3vs6a
         doFp5R18mhzsWHSZibvYrPh+be1H5FbUhl9dIxOmmg6kAVlAshSHOG7kk0/nV6K8eNWX
         SZBfKyStjHMzIu26uS08/Vp/eaOg2IJtIbRGnPDEXtHHlYv0576GD3PdHI//c2IqsekE
         HaLnLpB4qlcnDV53V7LKt7GSfQfAER1txNBp8TaB/MA9lBMlgxrs3Qh+3Ms136c5jown
         FjnQ==
X-Gm-Message-State: AOJu0YwSbBESBhrqBPImeHrIv+tw9k20GTMeQ4rabYxsbhg7Z72mElKD
	MQ7iRPph8PFD0PwH0cYshdI5hXMJ4lQ5qKC607SeqVwHI3u6oQR/dcUCS6C5
X-Google-Smtp-Source: AGHT+IF/g5RU3ZJ8i4KpLdhSMQCOxuqjg6SHPC/vymafwAJXGbiM2nx31tOu44lOFS25vX0Gm8XwCg==
X-Received: by 2002:a5d:6a50:0:b0:343:9292:b291 with SMTP id t16-20020a5d6a50000000b003439292b291mr7302566wrw.53.1712617765894;
        Mon, 08 Apr 2024 16:09:25 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id cg6-20020a5d5cc6000000b00345e730aa7csm2192290wrb.11.2024.04.08.16.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 16:09:25 -0700 (PDT)
Message-ID: <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
Date: Tue, 9 Apr 2024 01:09:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] launch_editor: waiting message on error
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
In-Reply-To: <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have the hint we're touching in this commit since abfb04d0c7
(launch_editor(): indicate that Git waits for user input, 2017-12-07).

Adding a new line after the hint when the editor returns error was
discussed in the list, but finally it was considered not necessary
because a shorter message is used [1].

However, even with a short message, feeding that LF makes the following
"error: There was a problem with the..." clearer, separating it from
possible messages that the editor could have printed.  So, add that LF.

While we're here, make the error message follow our CodingGuideLines.

 [1] https://public-inbox.org/git/20171127134716.69471-1-lars.schneider@autodesk.com/T/#u

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This v2 fixes some whitespaces I didn't notice.

Sorry for the mess.

 editor.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/editor.c b/editor.c
index b67b802ddf..8f224747d9 100644
--- a/editor.c
+++ b/editor.c
@@ -104,16 +104,26 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
+
+		if (print_waiting_for_editor && !is_terminal_dumb()) {
+			if (!ret)
+				/*
+				 * Erase the entire line to avoid wasting
+				 * the vertical space.
+				 */
+				term_clear_line();
+			else
+				/*
+				 * We don't want term_clear_line() here
+				 * because the editor could have written
+				 * some useful messages to the user.
+				 */
+				fprintf(stderr, "\n");
+		}
+
 		if (ret)
-			return error("There was a problem with the editor '%s'.",
+			return error("there was a problem with the editor '%s'",
 					editor);
-
-		if (print_waiting_for_editor && !is_terminal_dumb())
-			/*
-			 * Erase the entire line to avoid wasting the
-			 * vertical space.
-			 */
-			term_clear_line();
 	}
 
 	if (!buffer)
-- 
2.44.0.502.g3e6838d230
