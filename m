Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C857C93
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441204; cv=none; b=HzfC6MST7Y8u2bKo8hNRQjLO9oEcippgvDQJpI6AGH+VH+DrVNbNcwm0PZRMdi14W+O0OnZR+8KGqCeojopvEfYIOd9Ca8CPcbUMNagGHVH7t6CYHYuVvRfAJUeqX0xcTtHZHo4YC/tg3tUqvAuwHYywVY2FEoVnjMLjpR08KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441204; c=relaxed/simple;
	bh=qekrhJNJktCe+tN+YVZ9+jspO8PNQ4GrO1t36Jg30uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koQCDoPIYD5px3rqKTSPAuHXzeMUGgYQS9jCKzw7a5VKypRbdUQWEqJyTmtxK7kBnGX/9Qo2T/E7Wb8HXyeuGdOJrFEdhsnraTWzSnTN+d8eg8zkopNTaTTB1Lyd6HLDefgAu9ZTZAmHB6I5L2UiBWGYaz9TjNGbczuPuRX4Bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXu8+Txk; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXu8+Txk"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb8db8ae9aso1327266b6e.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441201; x=1739046001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTzRxBwQGFHARlGRgnAYpfQCNwWG3JQzdotsnJ27cPU=;
        b=IXu8+TxkyJEwWc3Z9oG7AJ14O8gRjb6uZxBFvCJ0M98wj95mt1PX8LnsgAA8SQRcEW
         ofdtC00OzchtwVdBlnNKxoIZBhrz2LEtbNX8bvwzuwr0Im3ZMc8/T/cSyL2TRbAUwlDp
         OBlTjuuRww0mysuPiYfX8kkifR5etkW5lFq9xgPP8+OMbCZG4AYzK0Fb/giOi6pUsV9S
         LhF0EstqCaoGvmnA5AIexMGGfo2dHwt/xX0FoCZ6uuo9sbXe8GoWDdkXdhXnEy9i2tDs
         uDLh1JUm+ZMdbH8Yz9V1WLOqRnW1YSw7KI0pUCdA4xYI0zL/IZHNTiGpaH5gWykS1d+9
         FENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441201; x=1739046001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTzRxBwQGFHARlGRgnAYpfQCNwWG3JQzdotsnJ27cPU=;
        b=bLY0i3IeeVxQkgeq/0J5ftLVm5fP7cyiypRSbp9MfutCgag56LbzIg6n3GMTs3EbKc
         TzXIDABAvRzT1ucKzsqo1BBAq/H+9H1oVR0qePMgNtxoPcwfd9U5F0hDsEO9pm5bOsbi
         DFKJtPRQxT9FQAMpIyZ2bAPKDFwNM2DEtfs73CO9F2xmX9sOCSEB3Bc5oLjCsucZIoW0
         T3t/8mabTO1Zc3klkwaq4vsqswZ2jJG3CQ1i2l4FxQsafM42RgHUj6QkEyYSlle5jTYE
         9KyWP+h3GEBaO7lsEAbMCeSOyR6o+71Hwykcr136gvsEBCwXRGzWBe3PcRw2CjrmVK71
         YWCg==
X-Gm-Message-State: AOJu0YxryfTmUVUQmaW6M3T6nRdZZbaTiuWuPmsu8VMbA82oBf7gKkgX
	fyrEtcvidMq/a02/cUtEx3adClg8TCZbPTa6kgInaOHakUmwR3RN4E3H9w==
X-Gm-Gg: ASbGncvYGHKFRrHEDpW4L+nNUmUF4rmiHQxDd/UJ1ce/lBglmTwxDIP1aaJLawud+2l
	iZv479EfAKcHRo0DOWPDdoINEh2O/ZvYw78eEIcvhBNEK2wa/V7vRrags4lfCvnIwu27xFl9Vp0
	lvNZDB97qTXTYkR6DAG0BcDYtnhbHj59x9bXaXjbhVa8wrQT6S9JuE5AC2Wx9LEKnGOGBCdoRzs
	1pHpqXHkR4BXfrBx38rcjO4rgZtY6e/ZLI3hDesTHOlD9AdxUvtUOoDufMAGRlbenMBcWHfkTk+
	OOnyAeo3+VJ26p/spodefHo=
X-Google-Smtp-Source: AGHT+IEf6fdsCbdqEraW3rqMASwgACsPc83gV3FGpXXyy8brMeRSfKXo1X7NI1iP/+Z12VdCUK9RsQ==
X-Received: by 2002:a05:6808:164b:b0:3eb:777c:184e with SMTP id 5614622812f47-3f323a1645amr10697917b6e.13.1738441201003;
        Sat, 01 Feb 2025 12:20:01 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm1588336b6e.0.2025.02.01.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 12:20:00 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/4] rev-list: print additional missing object information
Date: Sat,  1 Feb 2025 14:16:54 -0600
Message-ID: <20250201201658.11562-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250110053417.2602109-2-jltobler@gmail.com>
References: <20250110053417.2602109-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

It is possible to configure git-rev-list(1) to print the OID of missing
objects by setting the `--missing=print` option. While it is useful
knowing about these objects, it would be nice to have even more context
about the objects that are missing. Luckily, from an object containing
the missing object, it is possible to infer additional information the
missing object. For example, if the tree containing a missing blob still
exists, the tree entry for the missing object should contain path and
type information.

This series aims to provide git-rev-list(1) with a new `print-info`
missing action for the `--missing` option that, when set, behaves like
the existing `print` action but also prints other potentially
interesting information about the missing object.

Missing object info is printed in the form `?<oid> [<token>=<value>]...`
where multiple `<token>=<value>` pairs may be specified each separated
from each other with a SP. Values that contain SP or LF characters are
expected to be encoded in a manner such that these problematic bytes are
handled. For missing object path information this is handled by quoting
the path in the C style if it contains SP or special characters.

One concern I currently have with this quoting approach is that it is a
bit more challenging to machine parse compared to something like using a
null byte to delimit between missing info. One option is, in a followup
series, introduce a git-for-each-ref(1) style format syntax. Maybe
something like: `--missing=print-info:%(path)%00%(type)`. I'm curious if
anyone may have thoughts around this. My goal is to ensure that there is
an easy to use machine parsable interface to get this information. I
could see something like `?<oid> path="foo \"bar" type=blob`, being a
bit complex.

The series is set up as follows:

- Pathes 1 and 2 provide the `quote_c_style` and `quote_path` functions
  with a way print consistent output regardless of how core.quotePath is
  set.

- Patch 3 introduces the `print-info` missing action and supports
  printing missing object path information.

- Patch 4 extends the `print-info` missing action to also print object
  type information about the missing object.

Changes in V3:

- This missing info is provided once again through an explicit
  `--missing=print-info` action instead of combining the
  `--missing=print` and `--missing-info` flag. This was done to make the
  interface a bit straightforward to use and not introduce a flag and is
  dependent on another.

- Added flag to `quote_path()` to disable core.quotePath from impacting
  quoted output and use it when print missing object path info.

- Update documentation to not use the term "attribute" which could be
  confused with gitattributes.

Due to all rearranging/changes in this version, I opted not to include a
range-diff.

Thanks,
-Justin

Justin Tobler (4):
  quote: add c quote flag to ignore core.quotePath
  quote: add quote_path() flag to ignore config
  rev-list: add print-info action to print missing object path
  rev-list: extend print-info to print missing object type

 Documentation/rev-list-options.txt |  19 +++++
 builtin/rev-list.c                 | 107 ++++++++++++++++++++++++-----
 quote.c                            |  27 +++++---
 quote.h                            |   6 +-
 t/t6022-rev-list-missing.sh        |  53 ++++++++++++++
 5 files changed, 184 insertions(+), 28 deletions(-)


base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.48.1.157.g3b0d05c4a7

