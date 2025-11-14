Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5D2DCC05
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100277; cv=none; b=BgylvTRDCSiwgo/GgKN/h2BwXDRs2RepRNBQvs0nY8qf6q6SULcNsCJXfurctbtm8wOOjnBIjmJBhWWNlTyy8oHj6EuTidNG1A2WR8qc4rR4pLVQT7yTt1crgTKAKPXTaOxkohprXCUsBV0qCQeIz0t8x4Yf9FTktTs4xobkX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100277; c=relaxed/simple;
	bh=eSak1n3dNVyB+ydQT6I3Etoz617ZqqRQAMfN+TElSek=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JkWen32qyxlrOrd3FsFMDfDt8/mpqh3kpr9cViGP55Ztb5m4IfEZoeFgcXaZeR4mXPQpE6guXy/AiasjHFEoJpi7pjEx7Z9J1faiWIbkx2tYcDs5s5hA9yNbzLuYp5KoRSLxDY01OaLwdkfNfkVm3lVacuU70yjTuV2Ffub8eP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKMI5ml4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKMI5ml4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-882390f7952so16289196d6.3
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763100273; x=1763705073; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Iu7ZDA+Kg+H0OpTkDYEBZICnymPLi7Z3w8HphGT52c=;
        b=DKMI5ml4+4AbwMcZ2bxaOHtWNYPWIpbWhv5JUKWkgUAtEvQOlVDNpaW7mhCrPlxjb/
         TXjIbyn0Z1ydZDjKFg6RqKkU2TrMyusLRhVXR3Zhg9Ik4PV8egrEMyhqsHyCp9axLy3t
         MvhH1uI5keLSj1BS1pVSsLT0MI05roIPdAprDFLdU+pZSg/dAZEkPUm4ol5JxomkXRr+
         KTJO/y6lY1GRETi2sm0uMmDW3/X1ocNuf88rDTL9dQDw8TF10la0vsK4AZvpulIyHLxW
         oI8/3sQujM9jcFzLXqgrb5eQGyyMp76YWcVzqer/5vYr8qM0F0+GJvwQD6QHqKSSvkp1
         x3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100273; x=1763705073;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Iu7ZDA+Kg+H0OpTkDYEBZICnymPLi7Z3w8HphGT52c=;
        b=ZFhBFWG7qJEuPACvkHOFLcHzRYUX1jU857nbFA9hb2pyuqWYu6Im+RFoxI2NivuPS9
         xDnE1lnP5rgAqLLWOUhGwBkF5gS18c6XgmDxeMn87E3GTOohh8az756Jg4Caj5XfKKnK
         jZE4cxKyFDVGRgFI/nzaHmG70q3kdeC17BnfIilNY6YLqqpPyhZhrETkeDr7Wy1I08Ld
         JPMyZ5mGuR4kUX/PAGf1dSHmIkDlaFA1plaYpZGGCdjJxZiu0+bqNglgdE+/27EP8Gdx
         BTmIr1cyCd0PCfF0rVOwuICqulf8x5In503mq6fg1IAf6deZpdttP/dElXDRF8wLCAkw
         KOeg==
X-Gm-Message-State: AOJu0Yx3yRYTqXqWSwyoqbIMoycCE6Ggeu2m9ON1Iv+JC/1B+AkzCIFQ
	HPp3kIzUYqDsBTjUGttf+pkkQ+yH89yn9X3jN76HIH9OAYR6Kf766j/z3P6Rsg==
X-Gm-Gg: ASbGnctFYFSuy6XGNu8uqe9EJraIOBLRW0Ikj8QpKhTZNa/nBhOPiUordFDkFXALLod
	kshOpNndzAGXSUzOg8Ui1WB3n9NZDYsMbhOFCLnhLRKcKbIguaqVWh1nftrFvT7RPrsbd0O0QXR
	yO+5be/0nhI/UNWJIcIgLopjZyQ+oJKtrWwHZICX4XQ9xu8SDGD8NH8fmCraTmG/8fCTiG7h9VA
	QEuzodSK0FUOVcqsdFkEEjTQemsghKuFJNz83K1sSe56G3T7pvgTBArjNffyWMsRtnzEbqWvJbj
	/u3OrwYOz0yU7XFui7Lf+awQIRkQX6cgI1zGnW/mGGVmcKQ17c4L05FG64urrxzdbsjEHvmj88h
	5cCiGQJbOVno6AMdMtFmuy03sZbXqYp5hErfX8q11Mbk9F1vjWbUARm2XPj9riE3OrM4Dkmzrek
	RNO1Sq
X-Google-Smtp-Source: AGHT+IFoP1hNDCo0UJNYUHprE+EkAwc2z3yksieq8Os7dRk6HIgQk93krUpZKmLZfOI4jQK7fxbpXA==
X-Received: by 2002:a05:6214:230f:b0:882:4c0f:9607 with SMTP id 6a1803df08f44-882925ff803mr23658356d6.21.1763100273271;
        Thu, 13 Nov 2025 22:04:33 -0800 (PST)
Received: from [127.0.0.1] ([172.178.118.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828656ba3dsm25519536d6.45.2025.11.13.22.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:04:32 -0800 (PST)
Message-Id: <pull.1999.v2.git.1763100270949.gitgitgadget@gmail.com>
In-Reply-To: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
References: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 06:04:30 +0000
Subject: [PATCH v2] osxkeychain: avoid incorrectly skipping store operation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

git-credential-osxkeychain skips storing a credential if its "get"
action sets "state[]=osxkeychain:seen=1". This behavior was introduced
in e1ab45b2 (osxkeychain: state to skip unnecessary store operations,
2024-05-15), which appeared in v2.46.

However, this state[] persists even if a credential returned by
"git-credential-osxkeychain get" is invalid and a subsequent helper's
"get" operation returns a valid credential. Another subsequent helper
(such as [1]) may expect git-credential-osxkeychain to store the valid
credential, but the "store" operation is incorrectly skipped because it
only checks "state[]=osxkeychain:seen=1".

To solve this issue, "state[]=osxkeychain:seen" needs to contain enough
information to identify whether the current "store" input matches the
output from the previous "get" operation (and not a credential from
another helper).

Set "state[]=osxkeychain:seen" to a value encoding the credential output
by "get", and compare it with a value encoding the credential input by
"store".

[1]: https://github.com/hickford/git-credential-oauth

Reported-by: Petter Sælen <petter@saelen.eu>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: avoid incorrectly skipping store operation
    
    Changes since v1:
    
     * Use functions provided by wrapper.h and strbuf.h instead of
       self-defined ones.
     * Adjust Makefile and meson.build to use these functions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1999%2FKojiNakamaru%2Ffix%2Fosxkeychain-state-seen-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1999/KojiNakamaru/fix/osxkeychain-state-seen-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1999

Range-diff vs v1:

 1:  b14045b4de ! 1:  dd36d290ff osxkeychain: avoid incorrectly skipping store operation
     @@ Commit message
      
          Reported-by: Petter Sælen <petter@saelen.eu>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
     + ## contrib/credential/osxkeychain/Makefile ##
     +@@
     + # The default target of this Makefile is...
     + all:: git-credential-osxkeychain
     + 
     ++include ../../../config.mak.uname
     + -include ../../../config.mak.autogen
     + -include ../../../config.mak
     + 
     ++ifdef ZLIB_NG
     ++	BASIC_CFLAGS += -DHAVE_ZLIB_NG
     ++        ifdef ZLIB_NG_PATH
     ++		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
     ++		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
     ++        endif
     ++	EXTLIBS += -lz-ng
     ++else
     ++        ifdef ZLIB_PATH
     ++		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
     ++		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
     ++        endif
     ++	EXTLIBS += -lz
     ++endif
     ++ifndef NO_ICONV
     ++        ifdef NEEDS_LIBICONV
     ++                ifdef ICONVDIR
     ++			BASIC_CFLAGS += -I$(ICONVDIR)/include
     ++			ICONV_LINK = $(call libpath_template,$(ICONVDIR)/$(lib))
     ++                else
     ++			ICONV_LINK =
     ++                endif
     ++                ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
     ++			ICONV_LINK += -lintl
     ++                endif
     ++		EXTLIBS += $(ICONV_LINK) -liconv
     ++        endif
     ++endif
     ++ifndef LIBC_CONTAINS_LIBINTL
     ++	EXTLIBS += -lintl
     ++endif
     ++
     + prefix ?= /usr/local
     + gitexecdir ?= $(prefix)/libexec/git-core
     + 
     + CC ?= gcc
     +-CFLAGS ?= -g -O2 -Wall
     ++CFLAGS ?= -g -O2 -Wall -I../../.. $(BASIC_CFLAGS)
     ++LDFLAGS ?= $(BASIC_LDFLAGS) $(EXTLIBS)
     + INSTALL ?= install
     + RM ?= rm -f
     + 
     + %.o: %.c
     + 	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
     + 
     +-git-credential-osxkeychain: git-credential-osxkeychain.o
     ++git-credential-osxkeychain: git-credential-osxkeychain.o ../../../libgit.a
     + 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
     + 		-framework Security -framework CoreFoundation
     + 
     +@@ contrib/credential/osxkeychain/Makefile: install: git-credential-osxkeychain
     + 	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
     + 	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
     + 
     ++../../../libgit.a:
     ++	cd ../../..; make libgit.a
     ++
     + clean:
     + 	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
     + 
     +
       ## contrib/credential/osxkeychain/git-credential-osxkeychain.c ##
     +@@
     + #include <string.h>
     + #include <stdlib.h>
     + #include <Security/Security.h>
     ++#include "git-compat-util.h"
     ++#include "strbuf.h"
     ++#include "wrapper.h"
     + 
     + #define ENCODING kCFStringEncodingUTF8
     + static CFStringRef protocol; /* Stores constant strings - not memory managed */
      @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static CFStringRef username;
       static CFDataRef password;
       static CFDataRef password_expiry_utc;
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static CFStringRef
       
       static void clear_credential(void)
       {
     -@@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void die(const char *err, ...)
     - 	exit(1);
     - }
     +@@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void clear_credential(void)
       
     -+/*
     -+ * NOTE: We could use functions in strbuf.h and/or wrapper.h, but those
     -+ * introduce significant dependencies. Therefore, we define simplified
     -+ * versions here to keep this code self-contained.
     -+ */
     -+
     - static void *xmalloc(size_t len)
     - {
     - 	void *ret = malloc(len);
     -@@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void *xmalloc(size_t len)
     - 	return ret;
     - }
     + #define STRING_WITH_LENGTH(s) s, sizeof(s) - 1
       
     -+static void *xcalloc(size_t count, size_t size)
     -+{
     -+	void *ret = calloc(count, size);
     -+	if (!ret)
     -+		die("Out of memory");
     -+	return ret;
     -+}
     -+
     -+static void *xrealloc(void *ptr, size_t size)
     -+{
     -+	void *ret = realloc(ptr, size);
     -+	if (!ret)
     -+		die("Out of memory");
     -+	return ret;
     -+}
     -+
     -+static char *xstrdup(const char *str)
     -+{
     -+	char *ret = strdup(str);
     -+	if (!ret)
     -+		die("Out of memory");
     -+	return ret;
     -+}
     -+
     +-__attribute__((format (printf, 1, 2), __noreturn__))
     +-static void die(const char *err, ...)
     +-{
     +-	char msg[4096];
     +-	va_list params;
     +-	va_start(params, err);
     +-	vsnprintf(msg, sizeof(msg), err, params);
     +-	fprintf(stderr, "%s\n", msg);
     +-	va_end(params);
     +-	clear_credential();
     +-	exit(1);
     +-}
     +-
     +-static void *xmalloc(size_t len)
     +-{
     +-	void *ret = malloc(len);
     +-	if (!ret)
     +-		die("Out of memory");
     +-	return ret;
     +-}
     +-
       static CFDictionaryRef create_dictionary(CFAllocatorRef allocator, ...)
       {
       	va_list args;
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void write_i
       	putchar('\n');
       }
       
     -+struct sb {
     -+	char *buf;
     -+	int size;
     -+};
     -+
     -+static void sb_init(struct sb *sb)
     -+{
     -+	sb->size = 1024;
     -+	sb->buf = xcalloc(sb->size, 1);
     -+}
     -+
     -+static void sb_release(struct sb *sb)
     -+{
     -+	if (sb->buf) {
     -+		free(sb->buf);
     -+		sb->buf = NULL;
     -+		sb->size = 0;
     -+	}
     -+}
     -+
     -+static void sb_add(struct sb *sb, const char *s, int n)
     -+{
     -+	int len = strlen(sb->buf);
     -+	int size = sb->size;
     -+	if (size < len + n + 1) {
     -+		sb->size = len + n + 1;
     -+		sb->buf = xrealloc(sb->buf, sb->size);
     -+	}
     -+	strncat(sb->buf, s, n);
     -+	sb->buf[len + n] = '\0';
     -+}
     -+
     -+static void write_item_sb(struct sb *sb, const char *what, const char *buf, int n)
     ++static void write_item_strbuf(struct strbuf *sb, const char *what, const char *buf, int n)
      +{
      +	char s[32];
      +
     -+	sprintf(s, "__%s=", what);
     -+	sb_add(sb, s, strlen(s));
     -+	sb_add(sb, buf, n);
     ++	xsnprintf(s, sizeof(s), "__%s=", what);
     ++	strbuf_add(sb, s, strlen(s));
     ++	strbuf_add(sb, buf, n);
      +}
      +
     -+static void write_item_sb_cfstring(struct sb *sb, const char *what, CFStringRef ref)
     ++static void write_item_strbuf_cfstring(struct strbuf *sb, const char *what, CFStringRef ref)
      +{
      +	char *buf;
      +	int len;
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void write_i
      +	len = CFStringGetMaximumSizeForEncoding(CFStringGetLength(ref), ENCODING) + 1;
      +	buf = xmalloc(len);
      +	if (CFStringGetCString(ref, buf, len, ENCODING))
     -+		write_item_sb(sb, what, buf, strlen(buf));
     ++		write_item_strbuf(sb, what, buf, strlen(buf));
      +	free(buf);
      +}
      +
     -+static void write_item_sb_cfnumber(struct sb *sb, const char *what, CFNumberRef ref)
     ++static void write_item_strbuf_cfnumber(struct strbuf *sb, const char *what, CFNumberRef ref)
      +{
      +	short n;
      +	char buf[32];
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void write_i
      +		return;
      +	if (!CFNumberGetValue(ref, kCFNumberShortType, &n))
      +		return;
     -+	sprintf(buf, "%d", n);
     -+	write_item_sb(sb, what, buf, strlen(buf));
     ++	xsnprintf(buf, sizeof(buf), "%d", n);
     ++	write_item_strbuf(sb, what, buf, strlen(buf));
      +}
      +
     -+static void write_item_sb_cfdata(struct sb *sb, const char *what, CFDataRef ref)
     ++static void write_item_strbuf_cfdata(struct strbuf *sb, const char *what, CFDataRef ref)
      +{
      +	char *buf;
      +	int len;
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static void write_i
      +	if (!buf || strlen(buf) == 0)
      +		return;
      +	len = CFDataGetLength(ref);
     -+	write_item_sb(sb, what, buf, len);
     ++	write_item_strbuf(sb, what, buf, len);
      +}
      +
     -+static void encode_state_seen(struct sb *sb)
     ++static void encode_state_seen(struct strbuf *sb)
      +{
     -+	sb_add(sb, "osxkeychain:seen=", strlen("osxkeychain:seen="));
     -+	write_item_sb_cfstring(sb, "host", host);
     -+	write_item_sb_cfnumber(sb, "port", port);
     -+	write_item_sb_cfstring(sb, "path", path);
     -+	write_item_sb_cfstring(sb, "username", username);
     -+	write_item_sb_cfdata(sb, "password", password);
     ++	strbuf_add(sb, "osxkeychain:seen=", strlen("osxkeychain:seen="));
     ++	write_item_strbuf_cfstring(sb, "host", host);
     ++	write_item_strbuf_cfnumber(sb, "port", port);
     ++	write_item_strbuf_cfstring(sb, "path", path);
     ++	write_item_strbuf_cfstring(sb, "username", username);
     ++	write_item_strbuf_cfdata(sb, "password", password);
      +}
      +
       static void find_username_in_item(CFDictionaryRef item)
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static OSStatus fin
       	write_item("capability[]", "state", strlen("state"));
      -	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
      +	{
     -+		struct sb sb;
     ++		struct strbuf sb;
      +
     -+		sb_init(&sb);
     ++		strbuf_init(&sb, 1024);
      +		encode_state_seen(&sb);
      +		write_item("state[]", sb.buf, strlen(sb.buf));
     -+		sb_release(&sb);
     ++		strbuf_release(&sb);
      +	}
       
       out:
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static OSStatus add
       		return -1;
       
      +	if (state_seen) {
     -+		struct sb sb;
     ++		struct strbuf sb;
      +
     -+		sb_init(&sb);
     ++		strbuf_init(&sb, 1024);
      +		encode_state_seen(&sb);
      +		if (!strcmp(state_seen, sb.buf)) {
     -+			sb_release(&sb);
     ++			strbuf_release(&sb);
      +			return errSecSuccess;
      +		}
     -+		sb_release(&sb);
     ++		strbuf_release(&sb);
      +	}
      +
       	data = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, password);
     @@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: int main(int argc,
      +
       	return 0;
       }
     +
     + ## contrib/credential/osxkeychain/meson.build ##
     +@@
     + executable('git-credential-osxkeychain',
     +   sources: 'git-credential-osxkeychain.c',
     +   dependencies: [
     ++    libgit,
     +     dependency('CoreFoundation'),
     +     dependency('Security'),
     +   ],


 contrib/credential/osxkeychain/Makefile       |  41 +++++-
 .../osxkeychain/git-credential-osxkeychain.c  | 120 ++++++++++++++----
 contrib/credential/osxkeychain/meson.build    |   1 +
 3 files changed, 132 insertions(+), 30 deletions(-)

diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 9680717abe..c68445b82d 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,21 +1,55 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
+include ../../../config.mak.uname
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
+ifdef ZLIB_NG
+	BASIC_CFLAGS += -DHAVE_ZLIB_NG
+        ifdef ZLIB_NG_PATH
+		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
+		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
+        endif
+	EXTLIBS += -lz-ng
+else
+        ifdef ZLIB_PATH
+		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
+		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
+        endif
+	EXTLIBS += -lz
+endif
+ifndef NO_ICONV
+        ifdef NEEDS_LIBICONV
+                ifdef ICONVDIR
+			BASIC_CFLAGS += -I$(ICONVDIR)/include
+			ICONV_LINK = $(call libpath_template,$(ICONVDIR)/$(lib))
+                else
+			ICONV_LINK =
+                endif
+                ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
+			ICONV_LINK += -lintl
+                endif
+		EXTLIBS += $(ICONV_LINK) -liconv
+        endif
+endif
+ifndef LIBC_CONTAINS_LIBINTL
+	EXTLIBS += -lintl
+endif
+
 prefix ?= /usr/local
 gitexecdir ?= $(prefix)/libexec/git-core
 
 CC ?= gcc
-CFLAGS ?= -g -O2 -Wall
+CFLAGS ?= -g -O2 -Wall -I../../.. $(BASIC_CFLAGS)
+LDFLAGS ?= $(BASIC_LDFLAGS) $(EXTLIBS)
 INSTALL ?= install
 RM ?= rm -f
 
 %.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
 
-git-credential-osxkeychain: git-credential-osxkeychain.o
+git-credential-osxkeychain: git-credential-osxkeychain.o ../../../libgit.a
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
 		-framework Security -framework CoreFoundation
 
@@ -23,6 +57,9 @@ install: git-credential-osxkeychain
 	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
 	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
 
+../../../libgit.a:
+	cd ../../..; make libgit.a
+
 clean:
 	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
 
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 611c9798b3..b180267034 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -2,6 +2,9 @@
 #include <string.h>
 #include <stdlib.h>
 #include <Security/Security.h>
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "wrapper.h"
 
 #define ENCODING kCFStringEncodingUTF8
 static CFStringRef protocol; /* Stores constant strings - not memory managed */
@@ -12,7 +15,7 @@ static CFStringRef username;
 static CFDataRef password;
 static CFDataRef password_expiry_utc;
 static CFDataRef oauth_refresh_token;
-static int state_seen;
+static char *state_seen;
 
 static void clear_credential(void)
 {
@@ -48,27 +51,6 @@ static void clear_credential(void)
 
 #define STRING_WITH_LENGTH(s) s, sizeof(s) - 1
 
-__attribute__((format (printf, 1, 2), __noreturn__))
-static void die(const char *err, ...)
-{
-	char msg[4096];
-	va_list params;
-	va_start(params, err);
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s\n", msg);
-	va_end(params);
-	clear_credential();
-	exit(1);
-}
-
-static void *xmalloc(size_t len)
-{
-	void *ret = malloc(len);
-	if (!ret)
-		die("Out of memory");
-	return ret;
-}
-
 static CFDictionaryRef create_dictionary(CFAllocatorRef allocator, ...)
 {
 	va_list args;
@@ -112,6 +94,66 @@ static void write_item(const char *what, const char *buf, size_t len)
 	putchar('\n');
 }
 
+static void write_item_strbuf(struct strbuf *sb, const char *what, const char *buf, int n)
+{
+	char s[32];
+
+	xsnprintf(s, sizeof(s), "__%s=", what);
+	strbuf_add(sb, s, strlen(s));
+	strbuf_add(sb, buf, n);
+}
+
+static void write_item_strbuf_cfstring(struct strbuf *sb, const char *what, CFStringRef ref)
+{
+	char *buf;
+	int len;
+
+	if (!ref)
+		return;
+	len = CFStringGetMaximumSizeForEncoding(CFStringGetLength(ref), ENCODING) + 1;
+	buf = xmalloc(len);
+	if (CFStringGetCString(ref, buf, len, ENCODING))
+		write_item_strbuf(sb, what, buf, strlen(buf));
+	free(buf);
+}
+
+static void write_item_strbuf_cfnumber(struct strbuf *sb, const char *what, CFNumberRef ref)
+{
+	short n;
+	char buf[32];
+
+	if (!ref)
+		return;
+	if (!CFNumberGetValue(ref, kCFNumberShortType, &n))
+		return;
+	xsnprintf(buf, sizeof(buf), "%d", n);
+	write_item_strbuf(sb, what, buf, strlen(buf));
+}
+
+static void write_item_strbuf_cfdata(struct strbuf *sb, const char *what, CFDataRef ref)
+{
+	char *buf;
+	int len;
+
+	if (!ref)
+		return;
+	buf = (char *)CFDataGetBytePtr(ref);
+	if (!buf || strlen(buf) == 0)
+		return;
+	len = CFDataGetLength(ref);
+	write_item_strbuf(sb, what, buf, len);
+}
+
+static void encode_state_seen(struct strbuf *sb)
+{
+	strbuf_add(sb, "osxkeychain:seen=", strlen("osxkeychain:seen="));
+	write_item_strbuf_cfstring(sb, "host", host);
+	write_item_strbuf_cfnumber(sb, "port", port);
+	write_item_strbuf_cfstring(sb, "path", path);
+	write_item_strbuf_cfstring(sb, "username", username);
+	write_item_strbuf_cfdata(sb, "password", password);
+}
+
 static void find_username_in_item(CFDictionaryRef item)
 {
 	CFStringRef account_ref;
@@ -124,6 +166,7 @@ static void find_username_in_item(CFDictionaryRef item)
 		write_item("username", "", 0);
 		return;
 	}
+	username = CFStringCreateCopy(kCFAllocatorDefault, account_ref);
 
 	username_buf = (char *)CFStringGetCStringPtr(account_ref, ENCODING);
 	if (username_buf)
@@ -163,6 +206,7 @@ static OSStatus find_internet_password(void)
 	}
 
 	data = CFDictionaryGetValue(item, kSecValueData);
+	password = CFDataCreateCopy(kCFAllocatorDefault, data);
 
 	write_item("password",
 		   (const char *)CFDataGetBytePtr(data),
@@ -173,7 +217,14 @@ static OSStatus find_internet_password(void)
 	CFRelease(item);
 
 	write_item("capability[]", "state", strlen("state"));
-	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
+	{
+		struct strbuf sb;
+
+		strbuf_init(&sb, 1024);
+		encode_state_seen(&sb);
+		write_item("state[]", sb.buf, strlen(sb.buf));
+		strbuf_release(&sb);
+	}
 
 out:
 	CFRelease(attrs);
@@ -288,13 +339,22 @@ static OSStatus add_internet_password(void)
 	CFDictionaryRef attrs;
 	OSStatus result;
 
-	if (state_seen)
-		return errSecSuccess;
-
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return -1;
 
+	if (state_seen) {
+		struct strbuf sb;
+
+		strbuf_init(&sb, 1024);
+		encode_state_seen(&sb);
+		if (!strcmp(state_seen, sb.buf)) {
+			strbuf_release(&sb);
+			return errSecSuccess;
+		}
+		strbuf_release(&sb);
+	}
+
 	data = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, password);
 	if (password_expiry_utc) {
 		CFDataAppendBytes(data,
@@ -403,8 +463,9 @@ static void read_credential(void)
 							   (UInt8 *)v,
 							   strlen(v));
 		else if (!strcmp(buf, "state[]")) {
-			if (!strcmp(v, "osxkeychain:seen=1"))
-				state_seen = 1;
+			int len = strlen("osxkeychain:seen=");
+			if (!strncmp(v, "osxkeychain:seen=", len))
+				state_seen = xstrdup(v);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -443,5 +504,8 @@ int main(int argc, const char **argv)
 
 	clear_credential();
 
+	if (state_seen)
+		free(state_seen);
+
 	return 0;
 }
diff --git a/contrib/credential/osxkeychain/meson.build b/contrib/credential/osxkeychain/meson.build
index 3c7677f736..ec91d0c14b 100644
--- a/contrib/credential/osxkeychain/meson.build
+++ b/contrib/credential/osxkeychain/meson.build
@@ -1,6 +1,7 @@
 executable('git-credential-osxkeychain',
   sources: 'git-credential-osxkeychain.c',
   dependencies: [
+    libgit,
     dependency('CoreFoundation'),
     dependency('Security'),
   ],

base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
-- 
gitgitgadget
