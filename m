Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36E1F941C
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820931; cv=none; b=m5fIDwm+7AWZqBB0hT9794D0RHnKuwcz+zLAAnGqrLn3Pz++8BbTAl5KZWHn/RNXv1C6/d/5UZhuvUTi315wRs+mgfkswaGRIgG/JP3UtGbMuLCF+laM2jUuXnv5TGH8FA3hvR9Sh9ZqDhFx8ifUZ/22fB4MFe2LIEIMyw/f2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820931; c=relaxed/simple;
	bh=9mxRk6aXq6wVGvUXwxmtjaD9mworq6xKJdgNIsAH7f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBzUgdA4Zo3m4JDv50nhbfO+/LmX9HehbX0XSXlCwf/T80x1QCmh3PwGBCm6FvkpDH0daumWUg76lRfSoEL3jm+9c56A6EmQCkeyV9xN8/t1yrXXVLPv2TUS+IiKAKMf+rC8Pana8PYdb+th311rz7ftbEf3SHEBEnjn/hsgR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJMnj0Zq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJMnj0Zq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46c7855df10so66246901cf.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820926; x=1737425726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BJk2RDr0ibfWU5Rn+b7j3XrPL/p/FyZknc8C3O5hnM=;
        b=dJMnj0Zq0ds7gUQ3kRU8S5eXRvV9xdM9LthwDHZ+kEGMRxZMbUbeooMVEC9HGbSOKJ
         7X/OFriEjp2h9LEvJxfEHEAQIIFu8cop8epxfSFUSPhLJlcdrLXClbtVBR7yDOsDC49B
         qu6/jA9gIgcfv50brEw3NfBnJM7Ry8bdz0cYiXogWJD0UaHBep7KUTLrM/N5dl6BiFkg
         3SoKKmhHRCqPeye54zLiOEwVjo/18jxYysQk1PhDibt4+sg/wGsYOBVKwFbnEaayo81D
         bstuOgHjDrv9eEAKyXCt4efwjfVUXxeNLelU5c68ewfKPfS2sbyf2oBu7a8Jw1XxKSMP
         8NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820926; x=1737425726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BJk2RDr0ibfWU5Rn+b7j3XrPL/p/FyZknc8C3O5hnM=;
        b=BdgVecOD84Rlr//Abh8SCeH2qiG/ha5SwUSDad+5TmmmN8Z79Ab42PqluE7ZDOUoLc
         C/GugUSAgmfImHeNy4GpQ20ubJHmF0OMbJZDeVKJdzfFHiUwsXbHg7etUc2N1z2SzoEZ
         akeq/gEs7HgnKSoJ1NhuzQ9WuRVl9u2lSW7FXSAG74dv0SkKDCletEZgzVDVDq0cf/kO
         sfrFHbgce49OKgawCq2MxwW7IiyuFJvT30MSyQyIDGa6HeFDASr7E63CdEnlSJFoYjhA
         UeD4S1RZT3yL4uQPBA6p3/kKPhk7TG7ItIIjagnaqCdyQ3V7MoM7tLWKmPd/zMvCr/WS
         KtmQ==
X-Gm-Message-State: AOJu0YxY7ICV0jlKgkRJxzbHGI7Kbw0FoT6ZQV/i+tuZnOHGIHN6DQG6
	l7Cafn6pJOrBxNr6H5WETqXmeeuxRgZ+umAGi9Mj5a7zhp3ULebiQIK93rwx6+c=
X-Gm-Gg: ASbGnct+qPxPlYSwDQBiaY4NeF0goXVX1g+7v4RA+x5bsTv3iiFXvqSAMBkBxuR2E9B
	8zAPo1a+r+RPFAcukkq9KfuNzZtNk8Ir46Lq3Vxn5Kz8Aigczq/+6QPSm/nSMgpuUb9++gSzH+m
	yAk9ZtpaeZ3TovT3kM/ta5fcDQkfSY+gCePh49OT5xTsR7Pe1imixEdc4AyGSeY1ONeYCFL7Q7j
	T2vOEJxdmCsJASwJ0iKOvvXuFAA+qa6i9GeHxmsiS4Jdna9YJCsz3bzTq5da+cYFgvg7w8cDNar
	vifXvtw=
X-Google-Smtp-Source: AGHT+IEf5OM+ifyrsmLqXc6IJEh7jEzb8fMVFV9UtoVEVkUS0GCAwkFr6ZKYI6Fybvs85XdL2EzDPQ==
X-Received: by 2002:a05:622a:1a83:b0:467:5d0b:c750 with SMTP id d75a77b69052e-46c7100592amr391676081cf.22.1736820925762;
        Mon, 13 Jan 2025 18:15:25 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:25 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 0/8] cat-file: add remote-object-info to batch-command
Date: Mon, 13 Jan 2025 21:14:52 -0500
Message-ID: <20250114021502.41499-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Calvin Wan’s (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
command at [1].

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[2]. This patch series implement the client
option for it.

This patch series add the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported in this implementation.
The type (%(objecttype)) is not included in this patch series, as it is not yet
supported on the server side either. The plan is to implement the necessary
logic for both the server and client in a subsequent series.

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will terminate with an error.

Changes since V9
================
- Refactored documentation for improved clarity.
- Refactored commit messages to provide more detailed and relevant information.
- Revised comments to align with best practices and reduce potential confusion or misinterpretation.
- Fixed grammatical errors and typos throughout the code and documentation.
- Removed unused variables to improve code cleanliness and maintainability.

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (4):
  git-compat-util: add strtoul_ul() with error handling
  cat-file: add declaration of variable i inside its for loop
  t1006: split test utility functions into new "lib-cat-file.sh"
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt         |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 107 +++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  85 ++++
 fetch-object-info.h                    |  22 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 git-compat-util.h                      |  20 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 664 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 19 files changed, 1047 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v9:
1:  0a77ace719 ! 1:  a567de3dc6 git-compat-util: add strtoul_ul() with error handling
    @@ git-compat-util.h: static inline int strtoul_ui(char const *s, int base, unsigne
      	return 0;
      }
      
    -+// Converts a string to an unsigned long using the standard library's strtoul,
    -+// with additional error handling to ensure robustness.
    ++/*
    ++ * Convert a string to an unsigned long using the standard library's strtoul,
    ++ * with additional error handling to ensure robustness.
    ++ */
     +static inline int strtoul_ul(char const *s, int base, unsigned long *result)
     +{
     +	unsigned long ul;
2:  51a0a48d7b ! 2:  8d5140b111 cat-file: add declaration of variable i inside its for loop
    @@ Commit message
         in a for loop, not in any other logic outside the loop.
     
         Change the declaration of i to be inside the for loop for readability.
    +    While at it, we also change its type from "int" to "size_t" where the latter makes more sense.
     
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Eric Ju <eric.peijian@gmail.com>
3:  fa1d6678a0 ! 3:  42d0539e9b cat-file: split test utility functions into a separate library file
    @@ Metadata
     Author: Eric Ju <eric.peijian@gmail.com>
     
      ## Commit message ##
    -    cat-file: split test utility functions into a separate library file
    +    t1006: split test utility functions into new "lib-cat-file.sh"
     
         This refactor extracts utility functions from the cat-file's test
    -    t1006-cat-file.sh into a dedicated library file. The goal is to improve
    -    code reuse and readability, enabling future tests to leverage these
    -    utilities without duplicating code
    +    script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
    +    library file. The goal is to improve code reuse and readability,
    +    enabling future tests to leverage these utilities without duplicating
    +    code.
     
      ## t/lib-cat-file.sh (new) ##
     @@
    -+# Library of git-cat-file related tests.
    ++# Library of git-cat-file related test functions.
     +
    -+# Print a string without a trailing newline
    ++# Print a string without a trailing newline.
     +echo_without_newline () {
     +	printf '%s' "$*"
     +}
     +
    -+# Print a string without newlines and replaces them with a NULL character (\0).
    ++# Print a string without newlines and replace them with a NULL character (\0).
     +echo_without_newline_nul () {
     +	echo_without_newline "$@" | tr '\n' '\0'
     +}
     +
    -+# Calculate the length of a string removing any leading spaces.
    ++# Calculate the length of a string.
     +strlen () {
     +	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
     +}
4:  61dd598576 = 4:  8fdb2c6f81 fetch-pack: refactor packet writing
5:  106e776dda = 5:  7d5f53de6e fetch-pack: move fetch initialization
6:  fe9366b59d = 6:  17583ebcd9 serve: advertise object-info feature
7:  09646f6517 = 7:  22d5eb26d1 transport: add client support for object-info
8:  99c450fc7e ! 8:  0698aa3606 cat-file: add remote-object-info to batch-command
    @@ Metadata
      ## Commit message ##
         cat-file: add remote-object-info to batch-command
     
    -    Since the `info` command in cat-file --batch-command prints object info
    -    for a given object, it is natural to add another command in cat-file
    -    --batch-command to print object info for a given object from a remote.
    +    Since the `info` command in `cat-file --batch-command` prints object
    +    info for a given object, it is natural to add another command in
    +    `cat-file --batch-command` to print object info for a given object
    +    from a remote.
     
    -    Add `remote-object-info` to cat-file --batch-command.
    +    Add `remote-object-info` to `cat-file --batch-command`.
     
         While `info` takes object ids one at a time, this creates
    -    overhead when making requests to a server.So `remote-object-info`
    +    overhead when making requests to a server. So `remote-object-info`
         instead can take multiple object ids at once.
     
    -    cat-file --batch-command is generally implemented in the following
    -    manner:
    +    The `cat-file --batch-command` command is generally implemented in
    +    the following manner:
     
          - Receive and parse input from user
          - Call respective function attached to command
    @@ Commit message
                 - Get object info, print object info
     
         To summarize, `remote-object-info` gets object info from the remote and
    -    then loop through the object info passed in, printing the info.
    +    then loops through the object info passed in, printing the info.
     
    -    In order for remote-object-info to avoid remote communication overhead
    -    in the non-buffer mode, the objects are passed in as such:
    +    In order for `remote-object-info` to avoid remote communication
    +    overhead in the non-buffer mode, the objects are passed in as such:
     
         remote-object-info <remote> <oid> <oid> ... <oid>
     
    @@ Documentation/git-cat-file.txt: info <object>::
     +remote-object-info <remote> <object>...::
     +	Print object info for object references `<object>` at specified
     +	`<remote>` without downloading objects from the remote.
    -+	Error when the `object-info` capability is not supported by the server.
    -+	Error when no object references are provided.
    ++	Raise an error when the `object-info` capability is not supported by the remote.
    ++	Raise an error when no object references are provided.
     +	This command may be combined with `--buffer`.
     +
      flush::
    @@ Documentation/git-cat-file.txt: newline. The available atoms are:
     +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
     +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
     +WARNING: When "%(objecttype)" is supported, the default format WILL be unified, so
    -+DO NOT RELY on the current the default format to stay the same!!!
    ++DO NOT RELY on the current default format to stay the same!!!
      
      If `--batch` is specified, or if `--batch-command` is used with the `contents`
      command, the object information is followed by the object contents (consisting
    @@ Documentation/git-cat-file.txt: scripting purposes.
      -------
      
     +Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
    -+currently not supported by the `remote-object-info` command, we will error
    -+and exit when they are in the format string.
    ++currently not supported by the `remote-object-info` command, we will raise
    ++an error and exit when they appear in the format string.
     +
      Note that the sizes of objects on disk are reported accurately, but care
      should be taken in drawing conclusions about which refs or objects are
    @@ builtin/cat-file.c
      enum batch_mode {
      	BATCH_MODE_CONTENTS,
     @@ builtin/cat-file.c: struct batch_options {
    - 	char input_delim;
    - 	char output_delim;
    - 	const char *format;
    -+	int use_remote_info;
      };
      
      static const char *force_path;
    @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
     +	/*
     +	 * Change the format to "%(objectname) %(objectsize)" when
     +	 * remote-object-info command is used. Once we start supporting objecttype
    -+	 * the default format should change to DEFAULT_FORMAT
    ++	 * the default format should change to DEFAULT_FORMAT.
     +	*/
     +	if (!opt->format)
     +		opt->format = "%(objectname) %(objectsize)";
    @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
     +			die(_("Not a valid object name %s"), argv[i]);
     +		oid_array_append(&object_info_oids, &oid);
     +	}
    -+	if (object_info_oids.nr == 0) {
    ++	if (!object_info_oids.nr)
     +		die(_("remote-object-info requires objects"));
    -+	}
    ++
     +	gtransport = transport_get(remote, NULL);
     +	if (gtransport->smart_options) {
     +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +	if (get_remote_info(opt, count, argv))
     +		goto cleanup;
     +
    -+	opt->use_remote_info = 1;
     +	data->skip_object_info = 1;
     +	for (size_t i = 0; i < object_info_oids.nr; i++) {
     +		data->oid = object_info_oids.oid[i];
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +			batch_object_write(argv[i+1], output, opt, data, NULL, 0);
     +		}
     +	}
    -+	opt->use_remote_info = 0;
     +	data->skip_object_info = 0;
     +
     +cleanup:
-- 
2.47.1

