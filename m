Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D41F0E5C
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263855; cv=none; b=ZUrZSMTqvQztxOEz6xP/G0K3fGLH5UuLJtxIDWzckHOGt+u9TKWAgDrwL8R3ovebhKhPpkFvZdK8V4Osu8tiuKihQhCmT4Yx8FKjlGwFRPi7dAi3jrgRyQGOpDAaqzR7Lw7BJKTfFeNgLzINQLVvf7x0iVT6vFF5wlezXpbp1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263855; c=relaxed/simple;
	bh=65jF1Kbg8pmJoPHIj9oX2H0kaQiQ1E4nXq89L/GPzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbJuVWkGuSyxV4VrljBIQEXDxNpFMbLzZr0uG4QVt2n0NtY8cuUDZ1/l0uiCoXUYvcQX0b121eBM2Bl04irv3wKQCRXTxEiUdB2YGvZvyxidqIMLgHcAedby9iyDa6bx62y2eSFeubupnHaY+AGi128aNzaUnZ9osUWssiC0SOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGxRKKgy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxRKKgy"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so8121387a91.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263853; x=1739868653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUVxVdfdEGtwV6OWjbDz6WqfhYfQoLL9SeacMktxfpA=;
        b=CGxRKKgyDBhOcarxcUuAu5ds1tR/CWVsm1U7XZbwyNSOOAwohAeGDkI0GtYBlyS70D
         YE9e+cmBPYZCsmHJ7jN2XL1dO2vnGX6KYrXw/IemUOXD9D59uXHJtIEhhwtovtRyrZ3D
         CRJsea+OZDpmI8vETIjWo7rtzxifEIaRHwRq0H+EUhcrxu0wbUcBbgKfnNOzQsWFJl2U
         K4vDkWWS7Cmg56CiPN1qploATAYQtVAaXJPAd+Of0ihJXIcmAd6F7iowybNGiw5a1XJ9
         QZ/dgYG2NLeAZYS+VNNZfNnbiWTgkagwi708t0JitM1Vvx0O44fmIgRHhShuVWkO5r2F
         Y9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263853; x=1739868653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUVxVdfdEGtwV6OWjbDz6WqfhYfQoLL9SeacMktxfpA=;
        b=YdZjTycWUAn+wfEeD1fG6e+rXSXEEt9CuEomrNRPY6oh+MYm2wKxmhp4Hr6eQKiIQv
         upw/snfjMiM5w/cSYsYjpITmo7gwefW8AA77u5LOu9wK292o3bhGyoj4fTdWuNZa4hn2
         TmPyNxYaF/I3QyLmMPj19ZYcBDnLOxoO3sGNUAfOLpciAW9COiflVXFYNOAauxfVd8iS
         4FWpZWQafwIV0Kfnu1pMGd0edDZ+tcu6to71USJjwHxAWCOP1TLyzQ03ulFGOVdCkzAW
         AcWLs9MGLRp1rR4jIMM02cSoG0eHCC3RWHDEFIm9wbg/9KNEPRIu1ba0UyzLeVgnb7tV
         /1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV+V/UfrivGmcGx9N34fW0YZ+qpar2LpZrMJypUGdIgcg0lyh2OyA9pPRVxYIi1lyQ7+Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVfcY/6GnQ+gydmdJ8yYc2b6tfsbo1RPpYE5HXh/hcO4Ikeep
	kVvUQl3h5Fh+adwMLHMCzUCc0S3RpbNlvH8e82j2OQG5gzcxwc61
X-Gm-Gg: ASbGncuWrgeBsDI5zNVux9/oQ+1qk5qYvDuCw83XVjY/BMB8d1twwcrM9EAE9+dKXn1
	4Y5RlzRSk4JlnrBcEzchNXFQlLZ+hceiQ8h47dO7WFjPXCcOeaH/WbQ3OjD3/Yx3x5nFlfjHnIH
	wzTH3vboungIx1xfhbPAqMWL5BT9eOz/7uW1rdUFX5oJULoH7+mUG4wqo502b7EZHjouL+QkZFR
	nbxxlismk4nQFrmmKTv2z51IwWxLU/9Unb6ZHUEuAHFKfdwJXDI1SSeVSYyU9QSQl6UGUzaH97N
	7iAQObz+H6Bl+RFlDoA4BIbMcBhxqJtzIGBE49s=
X-Google-Smtp-Source: AGHT+IGyCDGGUN+WVCFChNziMxg5bdr/ReMXAFmXj0cu+gMW68GwmAk39RxLSMrh6nli7AwfYOlZ5Q==
X-Received: by 2002:a17:90b:1946:b0:2ee:a04b:92ce with SMTP id 98e67ed59e1d1-2fa243ee3f5mr22154665a91.32.1739263852905;
        Tue, 11 Feb 2025 00:50:52 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:52 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 02/10] diff: -G description: Correct copy/paste error
Date: Tue, 11 Feb 2025 00:50:14 -0800
Message-ID: <20250211085028.3923875-3-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current description for -G is incorrect, seems like it was copied from
the description for -S.
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 019fb..bd9db 100644
--- a/diff.c
+++ b/diff.c
@@ -5866,7 +5866,7 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("look for differences that change the number of occurrences of the specified string"),
 			       0, diff_opt_pickaxe_string),
 		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
-			       N_("look for differences that change the number of occurrences of the specified regex"),
+			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
 			  N_("show all changes in the changeset with -S or -G"),
-- 
2.45.2

