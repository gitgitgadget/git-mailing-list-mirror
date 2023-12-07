Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imFCnDGw"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99910CC
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:06:51 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-59067f03282so176875eaf.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 22:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701929211; x=1702534011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9edAeXcJ+3KImCmTHpoYTLnkUWL8up1VXSKqbxoRdk=;
        b=imFCnDGwvLftt02tavuCqdPVL4LpUrwJxz+45DinlV1w0erTYiEZIiiulJePe2n18E
         mSMJoTFZmkFT+j5j72GOTs4ISaki2PLWcQDv3mlaURw7k9p40XIc0BDMllIKh76bv8Pu
         uhpmZ0//Vnxhg+uXBFzOSemmYIGxwAG4BSUPLFkjn58MHGkAQwQrmvhXBUw3iv/MwA4P
         kIBW9sDKTHJ1QvJQnHEDs5L3TEvUbS8o680iK9LhT4mImma3BRYYmE5Jo0/EVJafL7da
         3d1hxee9kjMbzge9H8362kF2LVbe4dgLVZC+Oee6v9CsIGA+z1ebOoLbjWdXSuZDtjyJ
         rBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701929211; x=1702534011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9edAeXcJ+3KImCmTHpoYTLnkUWL8up1VXSKqbxoRdk=;
        b=IkeVve1L7T3g1kygCBmjliiVo4TFwly5LTh5dBX/NdditHnhkugr46vXfXG5KQV6g3
         kgeajg0zm8wrDtQfZK1od19Yq9ecin877To0U//lqwi8po8aAevyMEM14xAHFMg0Xtdd
         1GKlV+SQNcpBZyj0iUVR6zUfLO0P5JlHxCknJ726PTTz29aOtq1MARS8Rf2V0RiqiJQR
         aOwua6m30bkM4XCx7t9/pIQBaHl1sxusNmphCc4cg3SGDDXcW39Ak7YmOCqGYFqKIE7Z
         zvgsqW+jTXcwS2x1fbf82foOd0mVGTwlRwrKgiWoqpKLhdJ8uS6QR4zWgtlzAl8IEvbS
         dZrA==
X-Gm-Message-State: AOJu0YyV1VLbgmOM9LTDUXGK5Zjzo1rmAIXVlNMJaUJfu6ityDmUhW9R
	ORIrQKPVIz+nApNsvuAjbpm8IM51qq0=
X-Google-Smtp-Source: AGHT+IGFnUF2qmVMcCvk6x0oIcj7VoKxGXWtHADn538YeOzNer7Nm2/7HHMwiL41wXMdCfTh8TCmFg==
X-Received: by 2002:a05:6358:260b:b0:170:7cd:4c5f with SMTP id l11-20020a056358260b00b0017007cd4c5fmr2764358rwc.10.1701929210856;
        Wed, 06 Dec 2023 22:06:50 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b005b82611378bsm449428pgv.52.2023.12.06.22.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Dec 2023 22:06:50 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH v2 0/2] completion: refactor and support reftables backend
Date: Wed,  6 Dec 2023 22:06:38 -0800
Message-ID: <cover.1701928891.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130202404.89791-1-stanhu@gmail.com>
References: <20231130202404.89791-1-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the review feedback:

1. Renames the '__git_ref_exists' helper to '__git_pseudoref_exists'.
2. cleans up the commit messages to refer to pseudorefs instead of 'special refs'.

Stan Hu (2):
  completion: refactor existence checks for pseudorefs
  completion: support pseudoref existence checks for reftables

 contrib/completion/git-completion.bash | 43 +++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.42.0

