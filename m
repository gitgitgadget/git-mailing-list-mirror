Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C439C01D
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353689; cv=none; b=MCibjUETZL/0WcrABCppF8QLDXdhexq8XmwCmTTpXcSGnNhm5CFcsAcTN0puo5cFcjCxPx0wsMV7SQdx1vcw0z1RxRkOzur3ZGwNglnsbbfkcyYKRR2ySz3PheFNoKJNo7TcvbQAcX6D5hx7iGl2TZeqIe8d6DCYhKj9J6JVBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353689; c=relaxed/simple;
	bh=NgK8fSNNp8cxQAljpYD2j5JR/snkTJVCKyRCiSxZwQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWqI0sL8M1AbZuQLfi+lYew7/XlrbusfVRgLAW+uSy/thBOZcH5vwUzyTpHhH878Ycb7Z7o1z4rnf+3VpvBZdguHHrJbpHs4+IZsrcU4AjYCYrZcJ23xbM11XCErFfDUxgdeOkKlImJLQTCrjcPhgDEtfuOZNQ2FrTR5hQg8moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=DXeKLG70; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="DXeKLG70"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/+HT/Y6li5swUxuY80tCMPqZP8WVmTsz6R5EguNWyfA=; b=DXeKLG70DQLLqspBMhuarXVUh3
	aYHDmTmzpQVuzCFzUyXuGirH4aZ4E67dK8JlniedD3nIEHnIxFO+Qpm4j1vPiDgpqjZ9889KDA2Vp
	V3kjMQw6Vb2UQnkrvZ2cla+Lj1AUqtCg4+Ty0DL7vUKgTuK5RHoI8VxqidMIjHoN0OIO0HKzOJMc6
	uSQ3QR9Nb+T206drgMJTc+S0nG4FerpowmVkhUs/xhj77TB5d0BZzQzRq/NWewRscCQTNPa7w8pH4
	S+j4qTSrAtL+s+UfyasmbeshiZWfqY16cLESFmI3AiZ5P8KqmuRnTBwE88Bm3epK8ugstgXBvBtVo
	GoFQQJgw==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT0-0000000740i-45Fn;
	Sat, 13 Jun 2026 14:28:02 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=localhost.localdomain)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT0-00000001VX9-2nFp;
	Sat, 13 Jun 2026 14:28:02 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v4 0/3] compat/posix.h: enable UNUSED warning messages for Clang
Date: Sat, 13 Jun 2026 14:27:08 +0200
Message-ID: <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
References: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

This series enables the intended UNUSED warning message with Clang by
adding a dedicated Clang version check. It also cleans up the nearby
GIT_GNUC_PREREQ() and UNUSED macros.

Changes since v3:
- split style-only cleanups into their own patch
- fix the UNUSED preprocessor indentation style
- simplify the GIT_GNUC_PREREQ() comparison commit message
- keep the Clang-specific note in the patch that adds GIT_CLANG_PREREQ()

Thanks,
 Dominik

Dominik Loidolt (3):
  compat/posix.h: enable UNUSED warning messages for Clang
  compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED
  compat/posix.h: simplify GIT_GNUC_PREREQ() comparison

 compat/posix.h | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

Range-diff against v3:
1:  62f5bce297 ! 1:  9ec87cd815 compat/posix.h: enable UNUSED warning messages for Clang
    @@ Commit message
         Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>

      ## compat/posix.h ##
    +@@
    +  *   ... code requiring gcc 2.8 or later ...
    +  *  #endif
    +  *
    ++ * Note that Clang and other compilers define __GNUC__ for compatibility; use
    ++ * GIT_CLANG_PREREQ() to check for specific Clang versions.
    ++ *
    +  * This macro of course is not part of POSIX, but we need it for the UNUSED
    +  * macro which is used by some of our POSIX compatibility wrappers.
    + */
     @@
       #define GIT_GNUC_PREREQ(maj, min) 0
      #endif
2:  a8fe5047a4 ! 2:  1a695af9ca compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
    @@ Metadata
     Author: Dominik Loidolt <dominik.loidolt@univie.ac.at>

      ## Commit message ##
    -    compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
    +    compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED

    -    Replace the glibc-style bit-shift version comparison with an explicit
    -    major/minor comparison. This is easier to read and is consistent with
    -    the format already used by GIT_CLANG_PREREQ() and many BSD
    -    <sys/cdefs.h> headers.
    +    Fix the preprocessor indentation of the GIT_GNUC_PREREQ() and UNUSED
    +    macros according to the CodingGuidelines, without changing their
    +    behavior.

    -    This has no runtime impact, as the macro is evaluated at compile time.
    -    It is also more future-proof, as it no longer assumes that GCC version
    -    components stay below 65536.
    +    Adjust the spelling in the GIT_GNUC_PREREQ() comment block.

         Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>

      ## compat/posix.h ##
     @@
    - #define _FILE_OFFSET_BITS 64

      /*
    -- * Derived from Linux "Features Test Macro" header
    +  * Derived from Linux "Features Test Macro" header
     - * Convenience macros to test the versions of gcc (or
     - * a compatible compiler).
     + * Convenience macros to test the versions of GCC (or a compatible compiler).
    @@ compat/posix.h
     + *   ... code requiring GCC 2.8 or later ...
       *  #endif
       *
    -+ * Note that Clang and other compilers define __GNUC__ for compatibility; use
    -+ * GIT_CLANG_PREREQ() to check for specific Clang versions.
    -+ *
    +  * Note that Clang and other compilers define __GNUC__ for compatibility; use
    +@@
    +  *
       * This macro of course is not part of POSIX, but we need it for the UNUSED
       * macro which is used by some of our POSIX compatibility wrappers.
     -*/
     + */
      #if defined(__GNUC__) && defined(__GNUC_MINOR__)
      # define GIT_GNUC_PREREQ(maj, min) \
    --	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
    -+	((__GNUC__ > (maj)) || \
    -+	 (__GNUC__ == (maj) && __GNUC_MINOR__ >= (min)))
    + 	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
      #else
     - #define GIT_GNUC_PREREQ(maj, min) 0
     +# define GIT_GNUC_PREREQ(maj, min) 0
      #endif

      /* Similar for Clang. */
    +@@
    +  * compilation, consider using MAYBE_UNUSED instead.
    +  */
    + #if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
    +-#define UNUSED __attribute__((unused)) \
    +-	__attribute__((deprecated ("parameter declared as UNUSED")))
    ++# define UNUSED __attribute__((unused)) \
    ++	__attribute__((deprecated("parameter declared as UNUSED")))
    + #elif defined(__GNUC__)
    +-#define UNUSED __attribute__((unused)) \
    ++# define UNUSED __attribute__((unused)) \
    + 	__attribute__((deprecated))
    + #else
    +-#define UNUSED
    ++# define UNUSED
    + #endif
    +
    + #ifdef __MINGW64__
-:  ---------- > 3:  289b7d9f8e compat/posix.h: simplify GIT_GNUC_PREREQ() comparison

base-commit: a89346e34a937f001e5d397ee62224e3e9852040
--
2.54.0

