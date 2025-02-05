Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D415224FA
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716310; cv=none; b=UNwvKbMlrXURCKDqUJDJKpHDHt78s4A2XZtkRBpThGKGLPHyxKKtZ3XAPUytABf2bPRoHYr6+mbcNlLHb6Qm191dArvQLMyMLB5V2qDoJHlmkxt/9WaHs+Ne0bl6T1uOYxfIjdG7sMzvHOMXWC3Md2klq1WiUm58emgnyJ9aXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716310; c=relaxed/simple;
	bh=D1uJGeTJBmn9zX8CHuZmuuVYt3+8nE5D5wkhCK7SxPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVKVlJyNWPLmxFhcvbl1ZJM1nGnQwssyGTaS5I59t4W63rKe9yDdQmf7zlJgOZAs+P0G8lXcVIAEe1UJwu6h2R538KkU7Vtk+u1ioLcoY3xZ/STc6bhucmC/E7nvdKQ+HrgiDyKfEgzlnXhTn/bEktL7BkLKMKkMYZ+rNG23P+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb86F0Hn; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb86F0Hn"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b7f4ed0468so489127fac.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 16:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738716307; x=1739321107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw0jqzyW9erIFyYp3S0yw25NjSWaWqYlXorsfTrmTps=;
        b=Kb86F0HnI94q8qHpFeD/4H8bfu54yfnSmYeFJ+9D5hQ1Doml62tKge1pKEqGhAWKhp
         dA59gKJMnWvU3TvxRypuBm7wABwcTyIS26IG3Q/AOUfzMwsUtuHRMloPR6ZC1CIU3gFs
         0B8SR3X4N5U1VXgvPDJG9jP7YXYqsVqwzYTtP+pE4CpQlvq7Y760CWuQDc92Nill1tXK
         fws9DNDl/VFBplB8OgvTxAc9dXIECVoE9C4SZJdNBtit+2KqOnqiAmR97sv67aPnWzjR
         6A+ucSGsuAFLHUiMim4bAg2kyk84oqhL9nbBxv4RWi7lxv1ws5/GM7zxxkWgpkBYCm8R
         a5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716307; x=1739321107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw0jqzyW9erIFyYp3S0yw25NjSWaWqYlXorsfTrmTps=;
        b=scAgRWyjrQx6vhIRL5d+cbw8OJv74yMwja/mDoSfKB2Y+YCejTm6ZvFmdUh1nJdxoy
         i9vKfwrn3gqt5gq3fesqvNXB/HLn8nGSHBQjZkfB6qp/KaaOjjuprEA3Glao2xm1Zd2V
         ESVzssxh5ZgTxZz+dgihzE0Kt+2pVSPDRwVrjWNqTBQHeurPGQ/f6nwH25IZjw0Yt74I
         uKXZaHSxakHtV/jRP+y15JO3Wms4ZCHOv7gPW3ONyX1DePZzb/AfSShbU7kdyGfjgUeZ
         ExdQXMUVImo+lCx6yHaCy/yVPyIsxUkRxqMeCg1W+d7IHYY93WUyEiFUH/kRUvn6Pq1G
         p5YA==
X-Gm-Message-State: AOJu0YxesohUWBfmi+0MFPVeYk+pOjsP1RUtpw4E+jrreMZcGN5Yl4wY
	taxPiUMfTUH9g1tNMy+FdnRg71BkxR5KRTRrXx/ly0NtwhZ/IMG0VfdTbA==
X-Gm-Gg: ASbGncuKAEZ0yCg36yggrmbNAobcl/QzO0a0yZYVI2Z++EznUoQ/wBLbmEQTg3MsOIF
	6aZp0LhNIYBUjSULhPmwP5tQptPurkG2UvCuPd3fuJXJ5ru1IidPooH/XbJOV+FrbvTL73piUoT
	cvlonXOq0rZSh8+cUh9v1mAu/1jKZTJZKaCSFzgTyZwZfk0r8ps+2FAtJBihB8xpOWG1CLH8x9t
	d9DTcscjkEgbaSk0gRYMfC7qPozpyEY475skupdIwTNMzztx615Q1CjJ/1NwXhsIax5hvdNwhVf
	vRCOFomZu2nVI1LdTO3lMnc=
X-Google-Smtp-Source: AGHT+IFTWwg/6cgN21TKJ/HbYTwxaVIEdT6+XgtrpyIRrQlz7fS1IipifVf68EENvQTJHVKgmrxzIQ==
X-Received: by 2002:a05:6870:56a7:b0:29e:27bd:69ef with SMTP id 586e51a60fabf-2b80514c670mr689649fac.30.1738716306824;
        Tue, 04 Feb 2025 16:45:06 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356643beesm4429451fac.41.2025.02.04.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:45:06 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/2] rev-list: print additional missing object information
Date: Tue,  4 Feb 2025 18:41:45 -0600
Message-ID: <20250205004147.887106-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
References: <20250201201658.11562-1-jltobler@gmail.com>
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

- Patch 1 introduces the `print-info` missing action and supports
  printing missing object path information.

- Patch 2 extends the `print-info` missing action to also print object
  type information about the missing object.

Changes in V4:

- The core.quotePath behavior is no longer force enabled for the missing
  info values. Consequently the first two patches from the previous
  version are dropped.

Thanks,
-Justin

Justin Tobler (2):
  rev-list: add print-info action to print missing object path
  rev-list: extend print-info to print missing object type

 Documentation/rev-list-options.txt |  19 ++++++
 builtin/rev-list.c                 | 106 ++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        |  53 +++++++++++++++
 3 files changed, 161 insertions(+), 17 deletions(-)

Range-diff against v3:
1:  f628728300 < -:  ---------- quote: add c quote flag to ignore core.quotePath
2:  53a3811d8f < -:  ---------- quote: add quote_path() flag to ignore config
3:  fe7a3da8de ! 1:  e3d5295b4d rev-list: add print-info action to print missing object path
    @@ builtin/rev-list.c: static off_t get_object_disk_usage(struct object *obj)
     +		struct strbuf path = STRBUF_INIT;
     +
     +		strbuf_addstr(&sb, " path=");
    -+		quote_path(entry->path, NULL, &path,
    -+			   QUOTE_PATH_QUOTE_SP | QUOTE_PATH_IGNORE_CONFIG);
    ++		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
     +		strbuf_addbuf(&sb, &path);
     +
     +		strbuf_release(&path);
4:  788b497d00 = 2:  6aa71444d3 rev-list: extend print-info to print missing object type

base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.48.1.157.g3b0d05c4a7

