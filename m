From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 21:59:37 +0200
Message-ID: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 22:00:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5KW4-0001eu-3i
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbaGJUAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:00:20 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54431 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbaGJUAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:00:17 -0400
Received: by mail-oa0-f52.google.com with SMTP id j17so96723oag.25
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3CdtKDxvH4WbSmU2GNmCSY38EHrTEWuJevlY/qokAwc=;
        b=B1Ia+lIE7n0F7/z8ReSNaGKbTU+xbyyYJdKjoA242xsN+wX5tE3zXJhPhLMjhyYgMw
         b5+m0LuSpbC+PtjSqvM5axy4+Cm+ADkx3pXcSGv5s1eRL1Iwbpc/wX6AxQ82W0BEQKCV
         VdULv7PP7LdgcqNJvQzB6zDFE+koe8tbvsTGRxHeq8ty4W9dFqRbBfykhbh9Si6/cYgA
         RQ/UjU+fm4ycFIecJJ/spdGHyZHVXrXKnJUBaoSH78p2FaLLlptY4vtx6sfozeKMre3S
         tCZIYxvehYmbFSc9WGtrg+BLlqCZNVLD3+jiYF6ZHZi5XA0SERAQTU9emZqknoTOaoCs
         KqlQ==
X-Received: by 10.182.142.69 with SMTP id ru5mr57857305obb.6.1405022417090;
 Thu, 10 Jul 2014 13:00:17 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 12:59:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253202>

The changes in 745224e0 don't seem to build here with gcc-4.9 on
linux x64_64. Any idea what's wrong?

    CC credential-store.o
In file included from /usr/lib/.../xmmintrin.h:31:0,
                 from /usr/lib/.../emmintrin.h:31,
                 from git-compat-util.h:708,
                 from cache.h:4,
                 from credential-store.c:1:
/usr/lib/.../mmintrin.h: In function '_mm_cvtsi32_si64':
/usr/lib/.../mmintrin.h:64:3: error: can't convert between vector
values of different size
   return (__m64) __builtin_ia32_vec_init_v2si (__i, 0);
   ^
/usr/lib/.../mmintrin.h: In function '_mm_cvtsi64_si32':
/usr/lib/.../mmintrin.h:107:10: error: incompatible type for argument
1 of '__builtin_ia32_vec_ext_v2si'
   return __builtin_ia32_vec_ext_v2si ((__v2si)__i, 0);
          ^

[...]

In file included from /usr/lib/.../emmintrin.h:31:0,
                 from git-compat-util.h:708,
                 from cache.h:4,
                 from credential-store.c:1:
/usr/lib/.../xmmintrin.h: In function '_mm_add_ss':
/usr/lib/.../xmmintrin.h:127:19: error: incompatible type for argument
1 of '__builtin_ia32_addss'
   return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
                   ^
/usr/lib/.../xmmintrin.h:127:3: note: expected '__vector(4) float' but
argument is of type '__m128'
   return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);
   ^
/usr/lib/.../xmmintrin.h:127:19: error: incompatible type for argument
2 of '__builtin_ia32_addss'
   return (__m128) __builtin_ia32_addss ((__v4sf)__A, (__v4sf)__B);

                   ^

[...]

/usr/lib/.../emmintrin.h:1455:3: error: incompatible type for argument
2 of '__builtin_ia32_movntpd'
   __builtin_ia32_movntpd (__A, (__v2df)__B);
   ^
/usr/lib/.../emmintrin.h:1455:3: note: expected '__vector(2) double'
but argument is of type '__m128d'
Makefile:1983: recipe for target 'credential-store.o' failed
make: *** [credential-store.o] Error 1
