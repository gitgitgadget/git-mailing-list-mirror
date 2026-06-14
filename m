Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA63B42FF
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781446580; cv=none; b=mmfd20fh086eFAA8yIg2yV4+PONOD3Fo0vAyQLb39k+kR6JXn2uD3srguKpZcmoC8ICWRwnpLY4xAh/2gafnMIx1X6ER0NopmTtHobO6k3uCQgIGtSbL4fxhSngOt2Q3mMp3auw+K7RcWZTsIDs9hs6YiAOinyT3Zx4h6pa36M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781446580; c=relaxed/simple;
	bh=0Ob+oLHb2ELdqWub2hVVn0Maiqsoxkb84LpEtZDmjw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsqo2gv4RJAs3v9UKtUCZM175lsi4bMyHu1QrxfUu+6jw8iQT0G7Z7JM8ow5TTazCuxYx7REmwICnJNXrC8cE15j9m/nXz4Q8BIiTFr5fhcicC7QBNU5LQOdG4yIBBwuLEXOY7KsAPLvFW4z+HKar57U0ss2hnoIhPARvkIoGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seRxcA7O; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seRxcA7O"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423efad617so1555393b3a.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781446578; x=1782051378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2H0MHPE4TFenwXtH3Trbcj9hTiB/yNvMAuGqS5MQFI=;
        b=seRxcA7OxDna31aXoojTFD9IAWgxTN/P7tteGNgU1s9xNiYdKTNaI7WxO+SWpDGz9N
         vt8jlvovb2r0YGFMoB6DGwD7a2xIq2KPw4HLJZ8LXbuMaURMT/tYY/1uFKATxLNAHKjF
         X8pU0o/yyO6W9hLc5qQ9j1OshuGjWV9Lb6T1ciPLtYyeBrI5vS6S2k9RmCBuKm98fYyc
         bVAhULOAMogoEjL+TiOYupW7ao+EN5gX8w91+xHHdOgh510Ig3+41BOwN9Yw5HQQyW89
         Jtns+IsFpRVYHBYO7Jop82DIq9W//sK1ZoXIcMdxLMCzsx4aXZHoVVTkUYJWZISfGh7T
         FoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781446578; x=1782051378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2H0MHPE4TFenwXtH3Trbcj9hTiB/yNvMAuGqS5MQFI=;
        b=DZhCfzW3x8/SYnWircgbMh965X03vYSgoUE6Vv+qssKNpJ8TFeMKn0/SJHBqGWoXsv
         IgskdfpnuhEX4m7uIZH4YhhoFodKGqSW8blLj190l9BZebfX4uxHLf8PVAKI3/glbC6W
         QzJfS0P37h7HBpjWrPpBeH0MT89P7FsTlq3rSW79rr5N5tdKj/QtjbVjzDfuzmapGS/s
         4MJVMeLobOPUwWDgQWKcolI1tooWOXaicFDVUgCSza1zjX3f4Pm6P5a/IYhrDsVdkMLC
         tzD824xint4n01uOTYbO1X2eD4mHSaQ2diB/QSIDS1hNcdUADDnUfSeQNoZDKmCfnDSG
         gkzg==
X-Gm-Message-State: AOJu0YwPmwzdW3bSEqBRdMIL/PjZq33HP9O2pYssl5YyXXfDqLmtBe6X
	dZLCXCUPxYp0ReikxQZrRvxQ3b/dCv4pcdGPxM7fQuAOuzpFwbo8vIvt81vYBA==
X-Gm-Gg: Acq92OFOAA3oSPAY1VBfVlrmuPGd/XqH5MI7G2+LXdHBB+5ag6dfm3V5o/v9AiW7QBJ
	nSmDmgq+FlGB8pLH7yI1WrW5cqPhNduNXtPqfsC+nuc4UoFpicG0hOVuTWJtKnBPoiWZESi7XHN
	upMmP+NyqPvycv78dt3SaJljOJijCxiBGRexeyqCS+hN6nINlLRtlNviOa4UYzkFZOfil8Rj7G9
	dFrBVHGxtpt9oxmWSBFBkJj7O43/eCJfSOz2CY29oAPx+9sbqa1Uch406KmHOtXacqMajiRdJMZ
	HqjJC25RXtmnUZ0+47hcsriv0Dx3JsOU4cc0EEtcv9DkuDSymX7//9osgeyQszyrtDneiEyVJgT
	HZN5EiFIYo6apnU4ZvWjzOdI7lyD+GgIihxQ9eh0VkpND2OM9RADMewfH4pcWlAn71f1S8+aYx2
	6x03h5mbD+lUARKG8qWqpZHBZWL1XLcQXphxvIgdY=
X-Received: by 2002:a05:6a00:993:b0:839:9ad:ee31 with SMTP id d2e1a72fcca58-8434cdcadcfmr11598745b3a.8.1781446577995;
        Sun, 14 Jun 2026 07:16:17 -0700 (PDT)
Received: from HOGWARTS.localdomain ([171.79.53.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9cf01sm7321638b3a.11.2026.06.14.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:16:17 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] builtin/history: unuse the commit buffer after use
Date: Sun, 14 Jun 2026 14:15:40 +0000
Message-ID: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While running `git history reword` using a Git built with `SANITIZE` flag set
to `address,leak`, we could observe the following leak being reported:

-- 8< --

=================================================================
==7156==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 1813 byte(s) in 1 object(s) allocated from:
    #0 0x79a3d1d2b60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x612e2bb8c2e9 in do_xmalloc /path/to/git/wrapper.c:55
    #2 0x612e2bb8c3f7 in do_xmallocz /path/to/git/wrapper.c:89
    #3 0x612e2bb8c48f in xmallocz_gently /path/to/git/wrapper.c:102
    #4 0x612e2b8dc28e in unpack_compressed_entry /path/to/git/packfile.c:1744
    #5 0x612e2b8dd12a in unpack_entry /path/to/git/packfile.c:1897
    #6 0x612e2b8daae2 in cache_or_unpack_entry /path/to/git/packfile.c:1535
    #7 0x612e2b8db1f6 in packed_object_info_with_index_pos /path/to/git/packfile.c:1617
    #8 0x612e2b8dc1c4 in packed_object_info /path/to/git/packfile.c:1732
    #9 0x612e2b8def05 in packfile_store_read_object_info /path/to/git/packfile.c:2228
    #10 0x612e2b889cb0 in odb_source_files_read_object_info odb/source-files.c:58
    #11 0x612e2b8805e9 in odb_source_read_object_info odb/source.h:326
    #12 0x612e2b885cf0 in do_oid_object_info_extended /path/to/git/odb.c:572
    #13 0x612e2b886fe4 in odb_read_object_info_extended /path/to/git/odb.c:710
    #14 0x612e2b887584 in odb_read_object /path/to/git/odb.c:756
    #15 0x612e2b68d6e4 in repo_get_commit_buffer /path/to/git/commit.c:399
    #16 0x612e2b91a7d4 in repo_logmsg_reencode /path/to/git/pretty.c:716
    #17 0x612e2b3de7da in commit_tree_ext builtin/history.c:127
    #18 0x612e2b3dee9f in commit_tree_with_edited_message builtin/history.c:183
    #19 0x612e2b3e2c4d in cmd_history_reword builtin/history.c:717
    #20 0x612e2b3e53b6 in cmd_history builtin/history.c:998
    #21 0x612e2b27ae97 in run_builtin /path/to/git/git.c:506
    #22 0x612e2b27b9ae in handle_builtin /path/to/git/git.c:782
    #23 0x612e2b27c240 in run_argv /path/to/git/git.c:865
    #24 0x612e2b27cd94 in cmd_main /path/to/git/git.c:986
    #25 0x612e2b5c4267 in main /path/to/git/common-main.c:9
    #26 0x79a3d182a600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #27 0x79a3d182a717 in __libc_start_main_impl ../csu/libc-start.c:360
    #28 0x612e2b276124 in _start (/path/to.local/bin/git+0x211124) (BuildId: 8da3d640a944e21b895fc4802d7942b1505be663)

SUMMARY: AddressSanitizer: 1813 byte(s) leaked in 1 allocation(s).

-- >8 --

A deeper investigation on this reveals the following as the root cause.

As part of rewording a commit in `git history`, we get the commit message
buffer in the `commit_tree_ext` function. This in turn obtains the buffer
from `repo_logmsg_reencode`. Given how `commit_tree_ext` is invoking the
function with the last two parameters as NULL, we are clearly not expecting
a reencode to happen. In this case, the buffer that we receive from
`repo_logmsg_reencode` ends up always being obtained from a call to
`repo_get_commit_buffer`.

This buffer is expected to be released with an accompanying call to
`repo_unuse_commit_buffer` which takes care of freeing it. This call
is missing in the `commit_tree_ext` flow thus resulting in the leak.

Fix this by ensuring we call `repo_unuse_commit_buffer` on the
original_message buffer.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
I must mention that I also noticed the following comment in `commit_tree_ext`:

»       /* We retain authorship of the original commit. */
»       original_message = repo_logmsg_reencode(repo, commit_with_message, NULL, NULL);

... but I'm not quite sure why we don't unuse the buffer after its purpose is
done. Kindly englighten me in case I missed something.


 builtin/history.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..0e9259b5d7 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -154,6 +154,7 @@ static int commit_tree_ext(struct repository *repo,
 	free_commit_extra_headers(original_extra_headers);
 	strbuf_release(&commit_message);
 	free(original_author);
+	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
 	return ret;
 }
 
-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

