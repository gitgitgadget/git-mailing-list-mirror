Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62A13FEA
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708761534; cv=none; b=upjOHfo/uqCCUQrfLYmxhBPlrHB0iv5r4ylpj4g7v+nO8enV69d5bAI+m/kOnWQ4ixL8GsH+W8Txp/HMa7uK4l+s55J4tYf1i/xtfuFenYJGnwty984VFAsdiNwS/XtKCdM0S/aUpN8TSCKlVxgoK5BIV1qkGnYeDoD4t9rjK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708761534; c=relaxed/simple;
	bh=WhDnskvfkplvQVMnb7gJowI4MUx15DDVe+W/k7l47xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0jDL81alxFy4iTQDOaEHkHFqrm10jaYVGkzRYh771uKE6/VJk9ADsIQSYI1agd24CEvflphgGHceftZWJj5fsZ0NcOZOTdIqFXbz5uCJnqMnt6Vhb66by0UACMbMusHfZsCV0nkZrbWQ9q6D9lBC+eJF6pzrqEQfWW3tzejBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CaJIx+Tq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CaJIx+Tq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 83C4427BAA;
	Sat, 24 Feb 2024 02:58:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WhDnskvfkplvQVMnb7gJowI4MUx15DDVe+W/k7
	l47xI=; b=CaJIx+TquuzchMp0H8njXz6K19wmv0Tt0roWyu83APREI87XsKVfH+
	FJo2fs/Kdh6Uaxo02dZw6xSTlqjPLkRirxvukbz5nLYZMBWKaL8Kar5mWBCH9zNb
	nl/k5kdBIih1FOAt0Tfue9U40v7pLhKAKbaqVWXBkRlQEdm308j0g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FB4627BA9;
	Sat, 24 Feb 2024 02:58:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00CE727BA8;
	Sat, 24 Feb 2024 02:58:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
In-Reply-To: <CAO_smVh6PyxbnXfo0K1aDjEFPc3jTF4X_grerkxNZJdQe8V3sg@mail.gmail.com>
	(Kyle Lippincott's message of "Fri, 23 Feb 2024 17:33:02 -0800")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-2-calvinwan@google.com>
	<CAO_smVh6PyxbnXfo0K1aDjEFPc3jTF4X_grerkxNZJdQe8V3sg@mail.gmail.com>
Date: Fri, 23 Feb 2024 23:58:42 -0800
Message-ID: <xmqqv86eqonh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87F4E0B8-D2EA-11EE-8A0D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> As far as I can tell, we need pager.h because of the `pager_in_use`
> symbol. We need that symbol because of its use in date.c's
> `parse_date_format`. I wonder if we can side step the `#include
> <stdint.h>` concerns by splitting pager.h into pager.h and
> pager_in_use.h, and have pager.h include pager_in_use.h instead. This
> way pager.h (and its [unused] forward declarations) aren't part of
> git-std-lib at all.

Step back a bit.  Why do you even need to touch pager.h in the first
place?  Whatever thing that needs to define a mock version of
pager_in_use() would need to be able to find out that it is supposed
to take nothing as arguments and return an integer, and it can
include <pager.h> without modification.  Just like everybody else,
it has to include <git-compat-util.h> so that the system header that
gives us uintmax_t gets include appropriately in platform-dependent
way, no?  Why do we even need to butcher pager.h into two pieces in
the first place?

If you just include <git-compat-util.h> and then <pager.h> in
stubs/pager.c and you're OK, no?

If anything, as I already said, I think it is more reasonable to
tweak what <git-compat-util.h> does.  For example, it might be
unwieldy for gitstdlib's purpose that it unconditionally overrides
exit(), in which case it may be OK to introduce some conditional
compilation macros to omit that override when building stub code.
Or even split parts of the <git-compat-util.h> that both Git's use
and gitstdlib's purpose are OK with into a separate header file
<git-compat-core.h>, while leaving (hopefully a very minor) other
parts in <git-compat-util.h> *and* include <git-compat-core.h> in
<git-compat-util.h>.  That way, the sources of Git can continue
including <git-compat-util.h> while stub code can include
<git-compat-core.h>, and we will get system library symbols and
system defined types like uintmax_t in a consistent way, both in Git
itself and in gitstdlib.

But once such a sanitization is done on the compat-util header,
other "ordinary" header files that should not have to care about
portability (because they can assume that inclusion of
git-compat-util.h will give them access to system types and symbols
without having to worry about portability issues) and should not
have to include system header files themselves.

At least, that is the idea behind <git-compat-util.h> in the first
place.  Including any system headers directly in ordinary headers,
or splitting ordinary headers at an arbitrary and artificial
boundary, should not be necessary.  I'd have to say that such
changes are tail wagging the dog.

I do not have sufficient cycles to spend actually splitting
git-compat-util.h into two myself, but as an illustration, here is
how I would tweak cw/git-std-lib topic to make it build without
breaking our headers and including system header files directly.

 git-compat-util.h | 2 ++
 pager.h           | 2 --
 stubs/misc.c      | 4 ++--
 stubs/pager.c     | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index 7c2a6538e5..981d526d18 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -1475,12 +1475,14 @@ static inline int is_missing_file_error(int errno_)
 
 int cmd_main(int, const char **);
 
+#ifndef _GIT_NO_OVERRIDE_EXIT
 /*
  * Intercept all calls to exit() and route them to trace2 to
  * optionally emit a message before calling the real exit().
  */
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
+#endif
 
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
diff --git c/pager.h w/pager.h
index 015bca95e3..b77433026d 100644
--- c/pager.h
+++ w/pager.h
@@ -1,8 +1,6 @@
 #ifndef PAGER_H
 #define PAGER_H
 
-#include <stdint.h>
-
 struct child_process;
 
 const char *git_pager(int stdout_is_tty);
diff --git c/stubs/misc.c w/stubs/misc.c
index 8d80581e39..d0379dcb69 100644
--- c/stubs/misc.c
+++ w/stubs/misc.c
@@ -1,5 +1,5 @@
-#include <assert.h>
-#include <stdlib.h>
+#define _GIT_NO_OVERRIDE_EXIT
+#include <git-compat-util.h>
 
 #ifndef NO_GETTEXT
 /*
diff --git c/stubs/pager.c w/stubs/pager.c
index 4f575cada7..04517aad4c 100644
--- c/stubs/pager.c
+++ w/stubs/pager.c
@@ -1,3 +1,4 @@
+#include <git-compat-util.h>
 #include "pager.h"
 
 int pager_in_use(void)


