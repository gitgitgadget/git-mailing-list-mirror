Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37F2FE07B
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339886; cv=none; b=YLX656fKk4qfA/Ck7DZb75I8QipY0JdHbRLbOtlBohs5zTgkTV892tKwFVvOK7k0RJq5Gh9OgQOEVLlclBFvmpMfqf8UMF8SuNfITTZi89tTmSzZSJvDCWxB+d2yE6HqI2g+I0gUJ3DC6LlG9Xfe0LdVpcc+48eOUAhjODL60jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339886; c=relaxed/simple;
	bh=pTirsInLc3KSzRE0Cg6mr3nlClCAXN9s4L9C4r7kMbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctYQxhXEH7b+yFlQP/FZhNkjNeoc+pVPXZFKB22UEfVk3VvZVf/oXKYsskWHySs6WL/x7xIYZRcgQijcwQFfsA9wuYqSJTcKXzNfa9PZJ7R5vMhn7CZlk0cqnTR1AqLO7PKvNBPzRRMwxSCziRVyPW1CWXjuFWAs9RVSl2yeR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEjZkvYm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEjZkvYm"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b50645ecfbbso504345866b.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761339883; x=1761944683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Jt6opp0mgjkzjDkDriJXte8kDqYNSIZrl+RMSreSY=;
        b=KEjZkvYm92MB9kYuZRC1+wEWYbLTnmyeaOzwLCv/Z3cPDVoLlZenUjGq3CLzacVToV
         Z8W+osfhjMl/RXr7IMoyc3WpCvjBzxZAJi0kmLkiVvRhyUk0edKDGzWZf/sC2JYqFm6O
         6aELB44Vsb+yICyMSyvjAboA9DJ5j2vXBrknJeblh3goJ9vfANz/3Z9WSe0l0seMQbmT
         xoo8jeZ8NT2mue490IqohPVYRbUIo84MNophk7FfmTRhwore/D4d+sEHop867hTg+hrj
         FvPrDpUntdQhdlkMvV6zUhBi02NF/UW33QEJmQNgZEmZNSacv0Xjz1EvhaXuTXrnpxQC
         xmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339883; x=1761944683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8Jt6opp0mgjkzjDkDriJXte8kDqYNSIZrl+RMSreSY=;
        b=fnIG+a+bNcyUfUk7jC78JbXgNYOtCqJLcfIxs9ABpb79Iuf1whOBw5Qy6kGUwO+DJn
         1gTUMDYjJ3SVMQSwufhBdo4SXrDkquJD/lboF49KKBwi7NtmHbt3n3ZvwQ1AziKdqO30
         uRnORXeaHyMuQH+cV1caTe7kHTuLQO3uN2LYapw7RuLZboahRmItJI/sWsUm9HJnZSWR
         xpWPTwYY9y0UyE4+P6cuVHSNqrBh5Ut974lvT6HEwaDN9TFzxjelmQ2ygIMWTSoaBt0e
         um1OzLFkJLMjjRH2XCFLic1+GT2GPU8+U166ejHygCcv8h1ii8I/e+JdcgfgyPxTZ2Er
         amkA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6i1AGzCZee+D1DLoyhxT1ZdoWTubulH6FU99h7wVuaWHk6LesxQg6I/A92hQ2S2p7n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyyBUZ+QlkZKXt6uuK2HmVl7TPYmVe4Xwny6o4Q4nzdy4sDGD
	4xmaGG0/lX+nWi4AroRsKYnyK6Bvbdbd0TIgIANCNy3qgA+YUrKMU/J3
X-Gm-Gg: ASbGncvRPnCY8nYkd+jEP9ACMs1I/TtX+WT564Wkn701jT0ITY1kNtwLdFiyuHWEDHq
	ZyDvL4U+YaaRxH4EbJ0QZQAwPyW6ObSczrSg1hjmWYaARC+o/SiMX9ePxHTiSdDqxqv+3ul4ATt
	czMVqp0Zz8gUnnlPp9dh1d/gaDXBe54thXhzig3B7c+BRyPUsnPIyZ9dbtQ7Y45xgl2KkqEuX2/
	tPwtSQyJa6H0KJV7jv/2Ved0T5jJFoUAOntGArEgHjHikBWj46QpIY7wJDACnLZxXeN3QB6gSVW
	+fdXqBMknUSs5YbvWKoIp08v93SP3cy6p1P0nMOxHZPjRwVMKnCq3MA2swLCse12dU07+F/Ao3u
	adPK6quRIj6Qx2nGaZOIG1WV3xirjhgwMitOZZQ9msOj74H6fT8N9wrwWXHjUQMvpeE/bM7E6fo
	l2EV18mvsz38kcb8/EDdC2stgBPmAFHkN8+AG5
X-Google-Smtp-Source: AGHT+IGKw0d1kPTmM+XStAWJsQNDdCvidk3cBkg/vwgb1sec8RcYMxU/piBCl0zKOZBaprwkXVfKxw==
X-Received: by 2002:a17:907:3e21:b0:b3e:c7d5:4cc2 with SMTP id a640c23a62f3a-b647494100fmr3619345666b.38.1761339882950;
        Fri, 24 Oct 2025 14:04:42 -0700 (PDT)
Received: from QueenJ-PC ([105.113.70.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cc6sm16701066b.12.2025.10.24.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:04:42 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: gitster@pobox.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	qjessa662@gmail.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2] MyFirstContribution: add note on confirming patches
Date: Fri, 24 Oct 2025 22:04:33 +0100
Message-ID: <20251024210433.2033-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
In-Reply-To: <xmqqwm4kp9t7.fsf@gitster.g>
References: <xmqqwm4kp9t7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note after the `git send-email` section explaining how
contributors can confirm that their patches reached the mailing
list by checking https://lore.kernel.org/git/.

Signed-off-by: QueenJcloud <qjessa662@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..6e7f3036bb 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1153,11 +1153,17 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
 
+NOTE: After sending your patches, you can confirm that they reached the mailing
+list by visiting https://lore.kernel.org/git/. Use the search bar to find your
+name or the subject of your patch. If it appears, your email was successfully
+delivered.
+
 After you run the command above, you will be presented with an interactive
 prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
 press `y` or `a` at these prompts your emails will be sent! Congratulations!
 
+
 Awesome, now the community will drop everything and review your changes. (Just
 kidding - be patient!)
 
-- 
2.51.0.573.gb660e2dcb9

