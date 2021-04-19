Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2612C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4140560FE9
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 00:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhDSAPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 20:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDSAPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 20:15:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17709C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dp18so11502951qvb.5
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ag2q4W9d40wOo3o/k2xWwklmNKi3XSmyobEmkfdYgg4=;
        b=GI8EoXonofYjGXlszjIF6D1i4TMBZVXUbWANkK3fsSxtLJRrRZZ4eDOW6dvtIJtlno
         GxeGkYo3PGd6UKYJny89vrqIDrJNbMvhqz9eoCY80q3BYng7wndxErC973v+arHO6Ca8
         qIXdRCY98DehQdJ3PRLp6K6KBdwv2pKYbV+Z8EAGL3qehqfcWMMgTZiOtlX59DHp93W7
         Iob0u1cHANOLhJTItfYOcFjJUW8lELODjE770RdnUFLsY5wRJqHNcvWHsGpDyiWqE7or
         ZVhWaUrMLidMK7MsvliolrqGyxIhyNjBHW6lPVVToSHWz7Mx2RXPVK7x9lO4Ump5fKkX
         fvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ag2q4W9d40wOo3o/k2xWwklmNKi3XSmyobEmkfdYgg4=;
        b=e6u0p3N6px/0HjuHGgkfsvzvPKd+CqXlQCwrwT4GAc3XK+Dn0Un3Wrren7LVFVK+N6
         HdAjcxNFF7M9Nu2gvMFvu8MGO9LbkYyn7WV/3jpNWXY86RJPKNlgAqZuCUY9CWo4GEdc
         yGgOHSu/hPlZuu5C6RZB0xvL6JNh07F4ZKYmmNboC84Ma9wpH9Yff/EjM1aNEnW+KDBP
         Ulds/Egc3lnk8P84nEqSOOoQhm8g95IGHmxo9QK6Lotxh834jpz8CNn1mhaxVkWC+aO0
         +pOlNAfIOE2vctgOgLfihCQo7ql9CF+pcl802kEOm8HAoEVnRM+Hi9JpMXoZD3zAjON+
         o9YQ==
X-Gm-Message-State: AOAM531YUBs2z5G20f3Nj9m61AuZQQId1Hz0RJvUkHcMu0IjBCOgqhQ7
        44SmmS0jIqcMveKKX6Qu8PJhZw==
X-Google-Smtp-Source: ABdhPJyixrfxGQbvzOPHn01VdwPI425vHCkzvS2TYzsX0R4fYDerVX4jRgSYLJUFjTv9V0BqxUsaIA==
X-Received: by 2002:ad4:50cc:: with SMTP id e12mr18954741qvq.15.1618791305033;
        Sun, 18 Apr 2021 17:15:05 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f12sm8272062qti.63.2021.04.18.17.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 17:15:04 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v3 0/5] Parallel Checkout (part 2)
Date:   Sun, 18 Apr 2021 21:14:52 -0300
Message-Id: <cover.1618790794.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br>
References: <cover.1617893234.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three small changes since the last version: 

- In `write_pc_item_to_fd()`, renamed variable 'new_blob' to just 'blob'.

- In `write_pc_item_to_fd()`, used `ce->name` instead of `path` when
  reporting failure to read the object.

- Made `write_pc_item()` unlink() the file on a `write_pc_item_to_fd()`
  error. The reasoning for this is:

  Unlike sequential checkout, the parallel workers create each file
  *before* reading and converting the associated blob, so that they can
  detect path collisions as soon as possible in the process. This is
  important both to avoid unnecessary work reading and filtering
  objects that are not going to be written in parallel, and also to
  avoid reporting errors for colliding entries at the wrong time. These
  entries will be handled in a sequential phase later, and that will be
  the correct time to print any errors regarding their checkout.

  However, these logistics make us leave an empty file behind when we
  find an error after creating the file, e.g. a missing object. The
  added unlink() fix this case while maintaining the other important
  mechanics. The design doc was also adjusted to mention this.

Matheus Tavares (5):
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: add configuration options
  parallel-checkout: support progress displaying
  parallel-checkout: add design documentation

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/checkout.txt             |  21 +
 Documentation/technical/parallel-checkout.txt | 271 ++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/checkout--worker.c                    | 145 ++++
 entry.c                                       |  17 +-
 git.c                                         |   2 +
 parallel-checkout.c                           | 655 ++++++++++++++++++
 parallel-checkout.h                           | 111 +++
 unpack-trees.c                                |  19 +-
 12 files changed, 1241 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/parallel-checkout.txt
 create mode 100644 builtin/checkout--worker.c
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

Range-diff against v2:
1:  0506ac7159 ! 1:  7096822c14 unpack-trees: add basic support for parallel checkout
    @@ parallel-checkout.c (new)
     +	int ret;
     +	struct stream_filter *filter;
     +	struct strbuf buf = STRBUF_INIT;
    -+	char *new_blob;
    ++	char *blob;
     +	unsigned long size;
     +	ssize_t wrote;
     +
    @@ parallel-checkout.c (new)
     +		}
     +	}
     +
    -+	new_blob = read_blob_entry(pc_item->ce, &size);
    -+	if (!new_blob)
    ++	blob = read_blob_entry(pc_item->ce, &size);
    ++	if (!blob)
     +		return error("cannot read object %s '%s'",
    -+			     oid_to_hex(&pc_item->ce->oid), path);
    ++			     oid_to_hex(&pc_item->ce->oid), pc_item->ce->name);
     +
     +	/*
     +	 * checkout metadata is used to give context for external process
    @@ parallel-checkout.c (new)
     +	 * checkout, so pass NULL.
     +	 */
     +	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
    -+					 new_blob, size, &buf, NULL);
    ++					 blob, size, &buf, NULL);
     +
     +	if (ret) {
     +		size_t newsize;
    -+		free(new_blob);
    -+		new_blob = strbuf_detach(&buf, &newsize);
    ++		free(blob);
    ++		blob = strbuf_detach(&buf, &newsize);
     +		size = newsize;
     +	}
     +
    -+	wrote = write_in_full(fd, new_blob, size);
    -+	free(new_blob);
    ++	wrote = write_in_full(fd, blob, size);
    ++	free(blob);
     +	if (wrote < 0)
     +		return error("unable to write file '%s'", path);
     +
    @@ parallel-checkout.c (new)
     +	if (write_pc_item_to_fd(pc_item, fd, path.buf)) {
     +		/* Error was already reported. */
     +		pc_item->status = PC_ITEM_FAILED;
    ++		close_and_clear(&fd);
    ++		unlink(path.buf);
     +		goto out;
     +	}
     +
    @@ parallel-checkout.c (new)
     +	pc_item->status = PC_ITEM_WRITTEN;
     +
     +out:
    -+	/*
    -+	 * No need to check close() return at this point. Either fd is already
    -+	 * closed, or we are on an error path.
    -+	 */
    -+	close_and_clear(&fd);
     +	strbuf_release(&path);
     +}
     +
2:  0d65b517bd ! 2:  4526516ea0 parallel-checkout: make it truly parallel
    @@ parallel-checkout.c: static int write_pc_item_to_fd(struct parallel_checkout_ite
     +	 * be passed from the main process to the workers.
      	 */
      	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
    - 					 new_blob, size, &buf, NULL);
    + 					 blob, size, &buf, NULL);
     @@ parallel-checkout.c: static int close_and_clear(int *fd)
      	return ret;
      }
3:  6ea057f9c5 = 3:  ad165c0637 parallel-checkout: add configuration options
4:  0ac4bee67e = 4:  cf9e28dc0e parallel-checkout: support progress displaying
5:  087f8bdf35 ! 5:  415d4114aa parallel-checkout: add design documentation
    @@ Documentation/technical/parallel-checkout.txt (new)
     +Note that, when possible, steps W3 to W5 are delegated to the streaming
     +machinery, removing the need to keep the entire blob in memory.
     +
    -+Also note that the workers *never* remove any file. As mentioned
    -+earlier, it is the responsibility of the main process to remove any file
    -+that blocks the checkout operation (or abort if removing the file(s)
    -+would cause data loss and the user didn't ask to `--force`). This is
    -+crucial to avoid race conditions and also to properly detect path
    -+collisions at Step W1.
    ++If the worker fails to read the blob or to write it to the working tree,
    ++it removes the created file to avoid leaving empty files behind. This is
    ++the *only* time a worker is allowed to remove a file.
    ++
    ++As mentioned earlier, it is the responsibility of the main process to
    ++remove any file that blocks the checkout operation (or abort if the
    ++removal(s) would cause data loss and the user didn't ask to `--force`).
    ++This is crucial to avoid race conditions and also to properly detect
    ++path collisions at Step W1.
     +
     +After the workers finish writing the items and sending back the required
     +information, the main process handles the results in two steps:
-- 
2.30.1

