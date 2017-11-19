Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD22202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbdKSRcD (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:32:03 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:42791 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdKSRcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:32:02 -0500
Received: by mail-io0-f180.google.com with SMTP id u42so13475552ioi.9
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O095+AEuOz9K+GC2f4y7OZ0dSWFix34o7c4MMwCCfpU=;
        b=BL5/ufMTAeMr8Z7g+215IDBf4UcMzNp1BODJDssYC2CKAuxl7Hg7/eRB3evF69qunH
         i7iuRH+mbkJOBkxrzUANmQaezrXsYOZTyHAYepSePOKqwzcUWQigQuXXsl2VrDbLzoMr
         aLM3SjKmSFLsH6QNRa4sRsWhJqndzoTHe8uswGzLEjS0B3cFV4PmyUKgWYx9KOGQkorQ
         UkZXEev/s5RTJ46wLl4BVHNyV5nLtkl4coFQmbB76pBoS+AwvDrjb8bkfZnnZJf9a502
         ub/7RbdSAgcm8BsbOlpvqKcHbMKxfpIfA8ODWJSMS8/XgZdoGxPtV8n+2fy99jdZQZZc
         f3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O095+AEuOz9K+GC2f4y7OZ0dSWFix34o7c4MMwCCfpU=;
        b=du9833OUxpSbE0iWLneWvqmBoVVN0u0pVKxPkCn1HbvOUTFK6SnVS5V5vhm6iDEaZg
         B3ba4FSywj9+55FxYhFIyDmdT67goHyZq6/yukAarx3NGJOId8BcyZfCx0GN6qzk8yBx
         ON4W0N5M2PdCbOnCzmHIBOVczpsbollYQV/94Mu5FM/LaBjMgCHaOoEPkxpD3x99s2iK
         2xFryMOz3kEJI+tmVJ12HUOI8QV8FD+EwEfm5c8SJtlNVivw7TJGne9lWATz+N2iNFeX
         MC68v9Gq3JeaSprQKw/J4DToj/AaK3jLxBe3jjxqJX+RIH/bwJVEMc1luoAd3+GX9KBE
         euMg==
X-Gm-Message-State: AJaThX4jJZCnXJvnhvaio56RcgYVdWK7HJXF2rZ0UeseLVjzqOClMIU0
        BD5PdZB/DqMjrLRI6MqnId1I5mbm4gc=
X-Google-Smtp-Source: AGs4zMbix+C10iwiPFox+QX9G3xq2NkFBZxm1CSsh6whKnuL4REpHIp84RHgqoKxRyT/Ae2jCQd9Qg==
X-Received: by 10.107.185.197 with SMTP id j188mr11139853iof.221.1511112720608;
        Sun, 19 Nov 2017 09:32:00 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id h187sm438573ioe.17.2017.11.19.09.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:32:00 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>
Subject: [PATCH v2 0/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Sun, 19 Nov 2017 12:31:40 -0500
Message-Id: <20171119173141.4896-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.170.gd77a2c32b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous round:
- https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
- https://public-inbox.org/git/20171116170523.28696-2-dnj@google.com/

Junio,

Thanks for taking the time to review this patch. Responses inline:

> The "regardless of whether the user has overridden it" part sounded
> alarming and made me wince twice.  I think you meant...
>
> As I have multiple installations of various versions of Git, I find
> the latter somewhat disturbing.

That's an excellent point. You also raised other concerns farther down
with respect to PERL and gettext() environment variables having a similar
behavior of overriding explicit user values. I had regarded these
environment variables as internal, but if they are part of the user
interface then forcefully overriding them is probably unacceptable.

I took some time and restructured the patch to avoid leveraging
environment variables:

- For Git code, each ancillary tool will now just resolve its own
  executable path.
- For PERL code, this patch introduces "RUNTIME_PREFIX_PERL", which
  injects an alternative header into PERL tooling enabling it to resolve
  against its installation path.
- gettext() now resolves using system_path(), as it should have in the
  first place.

The net result of this is that this patch should no longer presume
ownership of environment variables, nor modify them any differently
than Git always has.

The PERL change is more significant now, so I defined a
"RUNTIME_PREFIX_PERL" flag that makes PERL specifically relocatable. I
moved the behavior of forcefullyl setting NO_PERL_MAKEMAKER from
RUNTIME_PREFIX (used by Git-for-Windows) to RUNTIME_PREFIX_PERL, so this
change should change how Git-for-Windows handles PERL anymore.

> We usually frown upon these because they often gets distracting, but
> I didn't find the ones in this patch too bad.

My apologies - I was emboldened by this line in "CodingGuidelines":

  "Fixing style violations while working on a real change as a
  preparatory clean-up step is good, but otherwise avoid useless code
  churn for the sake of conforming to the style."

I suppose "preparatory" probably means "in a preceding separate commit".

> I presume that this is because we may need to know where to find the
> locale stuff before calling git_setup_gettext(); makes sense.

Correct.

> OK, so that is a more appropriate name for the variable that is a
> logical successor of argv0_path.  I wonder if the file-scope static
> variable argv_exec_path we see above would want to move to somewhere
> closer to one of these "platform specific methods", though.

Looking into this, I realized that the method-local static
"cached_exec_path" variable and the global "argv_exec_path" are
redundant, and that "argv_exec_path" escaped my renaming sweep. I
consolidated the two and moved the new global, "exec_path_value",
closer to the only two methods that reference it.

> I think this is our first use of realpath(), which is XSI.

While looking for examples in the code, I ran into `strbuf_realpath`,
which is a Git-native implementation of "realpath". I switched over to
this, making "procfs" resolution more idiomatic and also slightly
simpler, and this patch no longer uses a new API!

> I wonder why argv0 (i.e. the full-path case) is not
> the first one to try, though---isn't that one the simplest?

I briefly covered this in the cover letter, but "argv[0]" is not reliable
on most (POSIX) systems, since "argv" is a user-supplied value to the
`execve` system call that launches a process. In many cases, "argv[0]"
will be the path of the executable, but in some it will just be the name
of the executable (shells do this when executing via PATH resolution)
and nothing is stopping an `execve` caller from supplying a completely
arbitrary value.

On Windows, "argv[0]" seems to always be the full path of the binary,
and this is something that Git-for-Windows relies on; however, on POSIX,
it is an unreliable source of information. The resolution sled falls
back onto it if all else fails, but strongly prefers a more
authoritative method when avaliable.

I've added some documentation to this effect to hopefully clarify the
rationale in the code.

> Also, I wonder if this caller gets simpler to read and understand if
> each of these "platform specific" ones are done like so[...]

I considered your idea, and while it does declutter the sled code, I
think it has a net detrimental effect because it also removes the
platform-specific context from the sled code: A cursory read of that
function would suggest that every resolution method is attempted on all
platforms, and I think that this is the wrong impression to give.

I've added some comments and formatting around that code to hopefully
address the clutter. I'm not opposed to restructuring it (e.g., use a
resolution function vector), but I thought I'd try formatting first.
Let me know what you think!

===

Changes in "v1" from previous version:

- Added comments and formatting to improve readability of
  platform-sepecific executable path resolution sleds in
  `git_get_exec_path`.

- Consolidated "cached_exec_path" and "argv_exec_path" globals
  into "exec_path_value".

- Use `strbuf_realpath` instead of `realpath` for procfs resolution.

- Removed new environment variable exports. Git with RUNTIME_PREFIX no
  longer exports or consumes any additional environment information.

  - Updated PERL script resolution strategy: rather than having Git export
    the relative executable path to the PERL scripts, they now resolve
    it independently when RUNTIME_PREFIX_PERL is enabled.

  - Updated resolution strategy for "gettext()": use system_path() instead
    of special environment variable.

  - Added `sysctl` executable resolution support for BSDs that don't
    mount "procfs" by default (most of them).

Dan Jacques (1):
  exec_cmd: RUNTIME_PREFIX on some POSIX systems

 .gitignore       |   1 +
 Makefile         |  88 +++++++++++++++++---
 cache.h          |   1 +
 common-main.c    |   4 +-
 config.mak.uname |   7 ++
 exec_cmd.c       | 239 +++++++++++++++++++++++++++++++++++++++++++++++--------
 exec_cmd.h       |   4 +-
 gettext.c        |   8 +-
 git.c            |   2 +-
 9 files changed, 304 insertions(+), 50 deletions(-)

-- 
2.15.0.448.gf294e3d99a-goog

