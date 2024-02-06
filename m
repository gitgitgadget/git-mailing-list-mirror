Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74E745E6
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196365; cv=none; b=NvqUuCo60q+wDfE7nPCC3uNITGWcdk8v3h3YhqM6y4cjy4vubaVrIwar2X11Mj7JTxuF7oNWomM5uVdZNUXZvxsAThMjqzgXrw1NmDWAyB8gXndkaQG6PwWKj1Kjz1VtYOvILUa3mg1admPTM1Q0eC5bj1ipKq/eUuy7jW2zZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196365; c=relaxed/simple;
	bh=MAUZuXKcVV+ZwGP6aGQG2JUwVo4pOZNJXxi299Qu5Eo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kWDFByeypgBQsoD+dBIi8Q8N/o6jWtSZxLe7QmKKbXgUGuoqq03Dgl9QQSRpZ/k4DNjs0HU17rWgGY+bfw9X5/xFUaawzQk3o18HH5vr+WqKz16lIWIjM/LIIjm8Ezuiaaadx6OyveWD7omoBjvCBX7DTwMP3jHwgWxGxp+gt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeAayx6r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeAayx6r"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe282b8e2so1987125e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196361; x=1707801161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k8UYAywJQQ83aTCDk0e2w+uJAEUxmObItRX55s2ycs=;
        b=SeAayx6rS0zl0/lPzg6WBcnjc9wJwquavdKstG1UihqK5v0zXcn2mpJM6c9tAdPB4F
         Mtqah0fgg6l6/E7fKxu1da/vzE7gztfPvJAfnEh3qs1HMxqWuxb+KHkD0gx5XvMwpQC/
         IgfsxRA1y+xEP87SDxcMU4Leb7XahBEZiXfSgqsZrpVzeVsXL0Es+Z0Hpj2n6PfoGdr6
         bQdyygoMA5wEamv0iCrPxj8HFS42YAalC0sHpNhkGddahMNjsAPBxTaWfs5jof6npssI
         c9RDN37k0ZpQXHTEm33wGhHy/jIvLqYzMjgUBBp+duCAMxmd++CmNPtgj5PAAL0dbMLB
         glNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196361; x=1707801161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k8UYAywJQQ83aTCDk0e2w+uJAEUxmObItRX55s2ycs=;
        b=GFcooKBRAvGKPisHotDeeUk00gpeX2TIXoT16fj2aD8/ZXxPF7/UpRLeF253PRkfae
         hr+nucrFK0hhGH0f+sBZTx/gih9ALtPinrvbR6AXvfFgYr9YXC/PnvzfKQIrESAyt0BB
         v8A52baoBed1PDVKmkzPMrVUC9PMBtqAJCUeE2ubbTigot2DW+jjPbfNHTKnZWheG0ua
         yrzLmGimL8DeydW6VWw0L9eU8s/lwET90zYwdKVyzc4dtavt/tokr10vhkrmFk4MiiYy
         Wzs0r62KXr5hN9oQoVvcJqzYqygplNLc72lvNAKEVPmHfrtZsgHfAvHdMHI1KTafE2Mr
         LjCQ==
X-Gm-Message-State: AOJu0Ywh5VHkl5E/+v4y265m3fgYo+MjF7gSYtnyHBwg2DYQRw4Lx+f7
	+2tgFfPRi5h4htnrTBUJUX92FgfsZUo5ueiRIQFI1g5nz7dSiKP4599FUDby
X-Google-Smtp-Source: AGHT+IFKgA9VYjXrVrEhTxJcJ6m+TqsDwQeyK+do8lI6Lsh/Y3i9tyaGiyanA6oCTjCBE9u9e+Z/DA==
X-Received: by 2002:a05:600c:354b:b0:40e:befe:37f3 with SMTP id i11-20020a05600c354b00b0040ebefe37f3mr826076wmq.4.1707196361370;
        Mon, 05 Feb 2024 21:12:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKtZj5yJn0X+So1aRdSahTDUu92KmwLqUq6kN3Q75nGaKm167ELzrmaJUdOnDEBwpuWITZJPbSNh6on07hWaH1cA+GJLdlQjxEs8wBUKqnRiBFRDeKNnakaRVwZB/YIvy7f8cpdd9f1gwPeQKr9DB6xVItpVHy8D0vOv3dpyJZ+uZPDojXTOv5GiwSYT8p3M1QnPpARxsSJg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b0040fdb244485sm640761wms.40.2024.02.05.21.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:41 -0800 (PST)
Message-ID: <a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:12 +0000
Subject: [PATCH v4 12/28] format_trailer_info(): append newline for
 non-trailer lines
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This wraps up the preparatory refactors to unify the trailer formatters.

Two patches ago we made format_trailer_info() use trailer_item objects
instead of the "trailers" string array. The strings in the array
include trailing newlines, because the string array is split up with

    trailer_lines = strbuf_split_buf(str + trailer_block_start,
                                     end_of_log_message - trailer_block_start,
                                     '\n',
                                     0);

in trailer_info_get() and strbuf_split_buf() includes the terminator (in
this case the newline character '\n') for each split-up substring.

And before we made the transition to use trailer_item objects for it,
format_trailer_info() called parse_trailer() (which trims newlines) for
trailer lines but did _not_ call parse_trailer() for non-trailer lines.
So for trailer lines it had to add back the trimmed newline like this

    if (!opts->separator)
        strbuf_addch(out, '\n');

But for non-trailer lines it didn't have to add back the newline because
it could just reuse same string in the "trailers" string array (which
again, already included the trailing newline).

Now that format_trailer_info() uses trailer_item objects for all cases,
it can't rely on "trailers" string array anymore.  And so it must be
taught to add a newline back when printing non-trailer lines, just like
it already does for trailer lines. Do so now.

The test suite passes again, so format_trailer_info() is in better shape
supersede format_trailers(), which we'll do in the next patch.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 12cae5b73d2..0774a544c4f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1125,9 +1125,10 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 				strbuf_addbuf(out, opts->separator);
 			}
 			strbuf_addstr(out, item->value);
-			if (opts->separator) {
+			if (opts->separator)
 				strbuf_rtrim(out);
-			}
+			else
+				strbuf_addch(out, '\n');
 		}
 	}
 }
-- 
gitgitgadget

