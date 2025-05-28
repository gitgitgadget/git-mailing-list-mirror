Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07E220680
	for <git@vger.kernel.org>; Wed, 28 May 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463461; cv=none; b=sdAuFN9NUxiWwTLFnSHU8LaCwyTdoYIvVCr6Hrh5kMyCX4R8GC4kRUFb8Yq15Y6+L8IypIjbA4VhqGa3/d3KmOwB4Shd9RvdVeReun1jnSzdDUshDv2qpwPZD28AaXmR5u2A6ucvKBwyjV9VvQNofcYH9X1EuwgBnTjpXe1DjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463461; c=relaxed/simple;
	bh=ynDccjEle7fOrCeyZnpRlTzlZuc4dRRmYi52tyYSihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM518udAfdJqjMdCXRf5EpQSUVKEHIS/I+J23K1+kHCerc6cas4CbCaSD9YLOCeS+9Xy3VkI35QgVcQpFxCzPVxjz8FN2qvcHZ9mQy7APWvn7rzm4bASAclTmhajXfH+GHbUzeAe0k369QxLhUNUcmaOB4nMEz7dosuldrww124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fMPMuevq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMPMuevq"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fa980d05a8so2427616d6.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748463459; x=1749068259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGOf2G0sG3VClCGuey4+m7CWiycEn6Nh4qQAvVRlDDM=;
        b=fMPMuevqBkL6vfaTkqv3BSyN1GjO3DatRpM6LjomkrqWfHkk1FA5LmEGVdYZn/Ow4P
         7svCvP0dYOrH2CVmYwz1Gtm1p6uSQCkPQl8G4HHsw7xzO72/u0vIvviWnFW2TDVOCuhG
         /FO8olGUOIijAzn8w3IxVu480o5zXF322xOGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463459; x=1749068259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGOf2G0sG3VClCGuey4+m7CWiycEn6Nh4qQAvVRlDDM=;
        b=u13yLj6mU0xOLMIXwbIGClD3JctONgzSmeQgpsbU5XAQoyQjkjlMqqd7rv2asWxKtU
         2ak2e7jIFK5WScMBPGvXwGhH6F3YLcPlwcBtNLxPP2+OzuVo2TuY9GHL/x8N5zdLB/7b
         2LcnBTeDXP0jL9WGM+S67hw9vKqjU6MfkbsYWGq+RO62JCdjtG52P/OWboPo0J4jBTob
         M2V85iwV1b67EhfRRFXGNaht64ZmMoBcd9M3bvLvL9OknG3jGPtjTdNEV52gDtfrdTi3
         uZxHQc18EBdfxIuAxPT+l99OnuUR3ZlLPqoHOu7pE8PbzvpKPQ6QGRBHTh1iBYZl0skZ
         X/yA==
X-Gm-Message-State: AOJu0Yz1xfuUPYbxFH/LEHJvyrjNvMdM744Ph3dc/B6v903e7zt04CGp
	JfF0PSwK2Q8I6bd08ajWuKI9QW1fJKWj+55ciYs9nNem6l9aCn1P1sXZ+Zla0HW9yiygIEyvJOr
	NUbwn9A==
X-Gm-Gg: ASbGncvzBPOsp7clRZpG0yzL/CXdM4VzQtppxjew0LuLHqiw75/kNy1bYqUh07XDTBA
	XshBfiECn53t5ZCi0jcdmOnmnkCbWfnF5DV5A1KNWE4pc+HsUfGoIgOfPAvYosizv8Lg+DZ9ExJ
	6FRR1ZtOTTTXunIOXCKcM5wMl0k3DrLmRjHutArihHlgwB6KTU+xs1nJyu+7Lj18s6dzNRNMjZE
	jsPbTH3LJC3w4VAmeDy3xOsKj3AzF8ZkRdXAub4RxNGNpqk+7Q5ar3Gg0cOfscvKAL+BcdfWvtK
	SK4UpdyYl3VVfl/rCbor44EHubPvbFSDXXE1bSOkF1clghse78tVbaO4CnMFfhTvEijqJ85IaKo
	B4nYeWg==
X-Google-Smtp-Source: AGHT+IEM9GO8jsLuIKKq1pVbf2shVc+ujcYvj4D/3lClN3T1uJ6Rmggt6uEq0FNQO4E+lLsHaJfkug==
X-Received: by 2002:ad4:5ae5:0:b0:6e8:f166:b19c with SMTP id 6a1803df08f44-6fabf335904mr48754496d6.41.1748463458697;
        Wed, 28 May 2025 13:17:38 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:c5c6:b960:da32:f378])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bb9c3fsm10453796d6.80.2025.05.28.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:17:38 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] t: run tests from a normalized working directory
Date: Wed, 28 May 2025 16:17:37 -0400
Message-ID: <20250528201737.55268-1-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523193722.68344-1-mark@chromium.org>
References: <20250523193722.68344-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some tests make git perform actions that produce observable pathnames,
and have expectations on those paths. Tests run with $HOME set to a
$TRASH_DIRECTORY, and with their working directory the same
$TRASH_DIRECTORY, although these paths are logically identical, they do
not observe the same pathname canonicalization rules and thus might not
be represented by strings that compare equal. In particular, no pathname
normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
change their working directory with `cd -P`, which normalizes the
working directory's path by fully resolving symbolic links.

t7900's macOS maintenance tests (which are not limited to running on
macOS) have an expectation on a path that `git maintenance` forms by
using abspath.c strbuf_realpath() to resolve a canonical absolute path
based on $HOME. When t7900 runs from a working directory that contains
symbolic links in its pathname, $HOME will also contain symbolic links,
which `git maintenance` resolves but the test's expectation does not,
causing a test failure.

Align $TRASH_DIRECTORY and $HOME with the normalized path as used for
the working directory by resetting them to match the working directory
after it's established by `cd -P`. With all paths in agreement and
symbolic links resolved, pathname expectations can be set and met based
on string comparison without regard to external environmental factors
such as the presence of symbolic links in a path.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index af722d383d9b..92d0db13d742 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1577,6 +1577,8 @@ fi
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
+TRASH_DIRECTORY=$(pwd)
+HOME="$TRASH_DIRECTORY"
 
 start_test_output "$0"
 

Range-diff against v1:
1:  95491c294c1e ! 1:  496e490a6462 t7900: use pwd -P in macOS maintenance test
    @@ Metadata
     Author: Mark Mentovai <mark@chromium.org>
     
      ## Commit message ##
    -    t7900: use pwd -P in macOS maintenance test
    +    t: run tests from a normalized working directory
     
    -    $pfx is the basis for the expectation that launchd plist paths formed by
    -    `git maintenance start` will be compared against. These paths are formed
    -    in `git maintenance` by builtin/gc.c launchctl_service_filename(), which
    -    calls path.c interpolate_path() with real_home = 1, causing abspath.c
    -    strbuf_realpath() to resolve a canonical absolute path. Since $pfx is
    -    not determined according to the same realpath semantics, when t7900 is
    -    run from a working directory that contains a symbolic link in its path,
    -    the realpath operation will produce a different path than $pfx contains,
    -    although both paths logically reference the same directory. The test
    -    fails in this case.
    +    Some tests make git perform actions that produce observable pathnames,
    +    and have expectations on those paths. Tests run with $HOME set to a
    +    $TRASH_DIRECTORY, and with their working directory the same
    +    $TRASH_DIRECTORY, although these paths are logically identical, they do
    +    not observe the same pathname canonicalization rules and thus might not
    +    be represented by strings that compare equal. In particular, no pathname
    +    normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
    +    change their working directory with `cd -P`, which normalizes the
    +    working directory's path by fully resolving symbolic links.
     
    -    Base $pfx on the physical working directory (pwd -P), with all symbolic
    -    links fully resolved, so that the path that the test expects matches
    -    what `git maintenance` generates, even when running from a working
    -    directory whose path contains a symbolic link.
    +    t7900's macOS maintenance tests (which are not limited to running on
    +    macOS) have an expectation on a path that `git maintenance` forms by
    +    using abspath.c strbuf_realpath() to resolve a canonical absolute path
    +    based on $HOME. When t7900 runs from a working directory that contains
    +    symbolic links in its pathname, $HOME will also contain symbolic links,
    +    which `git maintenance` resolves but the test's expectation does not,
    +    causing a test failure.
     
    +    Align $TRASH_DIRECTORY and $HOME with the normalized path as used for
    +    the working directory by resetting them to match the working directory
    +    after it's established by `cd -P`. With all paths in agreement and
    +    symbolic links resolved, pathname expectations can be set and met based
    +    on string comparison without regard to external environmental factors
    +    such as the presence of symbolic links in a path.
    +
    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Mark Mentovai <mark@chromium.org>
     
    - ## t/t7900-maintenance.sh ##
    -@@ t/t7900-maintenance.sh: test_expect_success 'stop preserves surrounding schedule' '
    + ## t/test-lib.sh ##
    +@@ t/test-lib.sh: fi
    + # Use -P to resolve symlinks in our working directory so that the cwd
    + # in subprocesses like git equals our $PWD (for pathname comparisons).
    + cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
    ++TRASH_DIRECTORY=$(pwd)
    ++HOME="$TRASH_DIRECTORY"
      
    - test_expect_success 'start and stop macOS maintenance' '
    - 	# ensure $HOME can be compared against hook arguments on all platforms
    --	pfx=$(cd "$HOME" && pwd) &&
    -+	pfx=$(cd "$HOME" && pwd -P) &&
    + start_test_output "$0"
      
    - 	write_script print-args <<-\EOF &&
    - 	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
-- 
2.49.0

