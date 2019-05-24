Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2861F462
	for <e@80x24.org>; Fri, 24 May 2019 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbfEXRhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 13:37:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54704 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391530AbfEXRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 13:37:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFB0168E5D;
        Fri, 24 May 2019 13:36:48 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=dFNhd/bGzHIk5
        jQb7ySt5oxDclk=; b=tA8WzJAwOz3WrZMGsdl1w/nO3ThYzWZbxqtarHXD2DT4R
        neVjeA8YC9GLuzPr4yZhE8U5PKBHdDcqcGKyASCa4bCtawcsARRraBSrt656B2eH
        iu6TDJWspkSACGAuPIC44w2pNu+IHgLEan5vLOmLt2/9frvskqZJOAyWhia2ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=xnUf5Be
        KKJP+nbZ5XntfLwRoQvSDZFlVIdIKfozMEt04VvU/4emtJXlLke3O2LjXUr3lQJE
        n3jb8y4v8CKv5CrWeYs3cThkJmdhvID2D/2sCt0x2OOrDNohI+3nHc3IDPNmQU7k
        IY9GDgLr2yEDLFGv4DnsXiNrpkbVfYVWUEPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E664668E5C;
        Fri, 24 May 2019 13:36:48 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 826A368E5B;
        Fri, 24 May 2019 13:36:45 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 24 May 2019 13:36:42 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        bturner@atlassian.com
Subject: Re: [PATCH 0/3] fix diff-parseopt regressions
Message-ID: <20190524173642.GQ3654@pobox.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 806E5620-7E4A-11E9-B851-B0405B776F7B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This should fix the diff tests failure on s360x. It's a serious problem
> and I plan to do something to prevent it from happening again.

Thanks for looking at this!

I applied this on top of master/2.22.0-rc1 and see a number
of compiler errors using gcc-9.1.1 with fedora's standard
compiler options for rpm builds.

Below are the compiler errors.  This was from an s390x
build, but other arches had the same errors.  The complete
build log is available here for a few weeks:
https://kojipkgs.fedoraproject.org//work/tasks/3166/35033166/build.log

cc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ creden=
tial-store.o -MMD -MP   -O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,=
-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-prot=
ector-strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-ha=
rdened-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=3D=
zEC12 -mtune=3Dz13 -fasynchronous-unwind-tables -fstack-clash-protection =
-I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALL=
OCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -D=
SHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cac=
he.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DS=
HA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOC=
K_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'=
  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAG=
ER_ENV=3D'"LESS=3DFRX LV=3D-c"'  credential-store.c
In file included from credential-store.c:5:
credential-store.c: In function 'cmd_main':
credential-store.c:156:25: warning: passing argument 1 of '_opt_string' f=
rom incompatible pointer type [-Wincompatible-pointer-types]
  156 |   OPT_STRING(0, "file", &file, "path",
      |                         ^~~~~
      |                         |
      |                         char **
parse-options.h:152:82: note: in definition of macro 'OPT_STRING_F'
  152 | #define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (=
l), _opt_string(v), (a), (h), (f) }
      |                                                                  =
                ^
credential-store.c:156:3: note: in expansion of macro 'OPT_STRING'
  156 |   OPT_STRING(0, "file", &file, "path",
      |   ^~~~~~~~~~
parse-options.h:132:42: note: expected 'const char **' but argument is of=
 type 'char **'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:139:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  139 | DEFINE_OPT_TYPE_CHECK(string, const char *)
      | ^~~~~~~~~~~~~~~~~~~~~
    * new link flags


cc -o apply.o -c -MF ./.depend/apply.o.d -MQ apply.o -MMD -MP   -O2 -g -p=
ipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIB=
CXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switche=
s -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=3D/usr/lib/rpm/=
redhat/redhat-annobin-cc1 -m64 -march=3DzEC12 -mtune=3Dz13 -fasynchronous=
-unwind-tables -fstack-clash-protection -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=
=3D"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -D=
SHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0=
 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_U=
BC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_=
DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPR=
OCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_=
STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"'  =
apply.c
In file included from apply.c:20:
apply.c: In function 'apply_parse_options':
apply.c:5002:26: warning: pointer targets in passing argument 1 of '_opt_=
int' differ in signedness [-Wpointer-sign]
 5002 |   OPT_INTEGER('C', NULL, &state->p_context,
      |                          ^~~~~~~~~~~~~~~~~
      |                          |
      |                          unsigned int *
parse-options.h:153:79: note: in definition of macro 'OPT_INTEGER_F'
  153 | #define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (=
l), _opt_int(v), N_("n"), (h), (f) }
      |                                                                  =
             ^
apply.c:5002:3: note: in expansion of macro 'OPT_INTEGER'
 5002 |   OPT_INTEGER('C', NULL, &state->p_context,
      |   ^~~~~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~


cc -o diff.o -c -MF ./.depend/diff.o.d -MQ diff.o -MMD -MP   -O2 -g -pipe=
 -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX=
_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -=
specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=3D/usr/lib/rpm/red=
hat/redhat-annobin-cc1 -m64 -march=3DzEC12 -mtune=3Dz13 -fasynchronous-un=
wind-tables -fstack-clash-protection -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D=
"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA=
1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -D=
SHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_=
CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV=
_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCF=
S_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STR=
LCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"'  dif=
f.c
In file included from diff.c:26:
diff.c: In function 'prep_parse_options':
diff.c:5278:37: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5278 |   OPT_BOOL('W', "function-context", &options->flags.funccontext,
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                     |
      |                                     unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5278:3: note: in expansion of macro 'OPT_BOOL'
 5278 |   OPT_BOOL('W', "function-context", &options->flags.funccontext,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5342:29: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5342 |   OPT_BOOL(0, "full-index", &options->flags.full_index,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                             |
      |                             unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5342:3: note: in expansion of macro 'OPT_BOOL'
 5342 |   OPT_BOOL(0, "full-index", &options->flags.full_index,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5400:37: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5400 |   OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_h=
arder,
      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
      |                                     |
      |                                     unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5400:3: note: in expansion of macro 'OPT_BOOL'
 5400 |   OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_h=
arder,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5405:31: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5405 |   OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               |
      |                               unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5405:3: note: in expansion of macro 'OPT_BOOL'
 5405 |   OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5469:25: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5469 |   OPT_BOOL('a', "text", &options->flags.text,
      |                         ^~~~~~~~~~~~~~~~~~~~
      |                         |
      |                         unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5469:3: note: in expansion of macro 'OPT_BOOL'
 5469 |   OPT_BOOL('a', "text", &options->flags.text,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5471:23: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5471 |   OPT_BOOL('R', NULL, &options->flags.reverse_diff,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                       |
      |                       unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5471:3: note: in expansion of macro 'OPT_BOOL'
 5471 |   OPT_BOOL('R', NULL, &options->flags.reverse_diff,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5473:28: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5473 |   OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5473:3: note: in expansion of macro 'OPT_BOOL'
 5473 |   OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5475:24: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5475 |   OPT_BOOL(0, "quiet", &options->flags.quick,
      |                        ^~~~~~~~~~~~~~~~~~~~~
      |                        |
      |                        unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5475:3: note: in expansion of macro 'OPT_BOOL'
 5475 |   OPT_BOOL(0, "quiet", &options->flags.quick,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5477:27: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5477 |   OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                           |
      |                           unsigned int *
parse-options.h:147:78: note: in definition of macro 'OPT_SET_INT_F'
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
            ^
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
diff.c:5477:3: note: in expansion of macro 'OPT_BOOL'
 5477 |   OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
      |   ^~~~~~~~
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5502:31: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5502 |   OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
      |                               ^~~~~~~~~~~~~~~~~~~~~~
      |                               |
      |                               unsigned int *
parse-options.h:143:70: note: in definition of macro 'OPT_BIT_F'
  143 | #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), _opt_=
int(v), NULL, (h), \
      |                                                                  =
    ^
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~
diff.c:5505:33: warning: pointer targets in passing argument 1 of '_opt_i=
nt' differ in signedness [-Wpointer-sign]
 5505 |   OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~
      |                                 |
      |                                 unsigned int *
parse-options.h:143:70: note: in definition of macro 'OPT_BIT_F'
  143 | #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), _opt_=
int(v), NULL, (h), \
      |                                                                  =
    ^
parse-options.h:132:42: note: expected 'int *' but argument is of type 'u=
nsigned int *'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                          ^
parse-options.h:137:1: note: in expansion of macro 'DEFINE_OPT_TYPE_CHECK=
'
  137 | DEFINE_OPT_TYPE_CHECK(int, int)
      | ^~~~~~~~~~~~~~~~~~~~~


cc -o parse-options.o -c -MF ./.depend/parse-options.o.d -MQ parse-option=
s.o -MMD -MP   -O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIF=
Y_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-str=
ong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc=
1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=3DzEC12 -mt=
une=3Dz13 -fasynchronous-unwind-tables -fstack-clash-protection -I. -DHAV=
E_SYSINFO -DGIT_HOST_CPU=3D"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H -DU=
SE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_IN=
IT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -=
DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK=
  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTON=
IC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFREAD=
_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D=
'"LESS=3DFRX LV=3D-c"'  parse-options.c
In file included from parse-options.c:2:
parse-options.h:140:43: warning: 'struct string_list' declared inside par=
ameter list will not be visible outside of this definition or declaration
  140 | DEFINE_OPT_TYPE_CHECK(string_list, struct string_list)
      |                                           ^~~~~~~~~~~
parse-options.h:132:36: note: in definition of macro 'DEFINE_OPT_TYPE_CHE=
CK'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                    ^~~~

cc -o parse-options-cb.o -c -MF ./.depend/parse-options-cb.o.d -MQ parse-=
options-cb.o -MMD -MP   -O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,=
-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-prot=
ector-strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-ha=
rdened-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=3D=
zEC12 -mtune=3Dz13 -fasynchronous-unwind-tables -fstack-clash-protection =
-I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALL=
OCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -D=
SHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cac=
he.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DS=
HA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOC=
K_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'=
  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAG=
ER_ENV=3D'"LESS=3DFRX LV=3D-c"'  parse-options-cb.c
In file included from parse-options-cb.c:2:
parse-options.h:140:43: warning: 'struct string_list' declared inside par=
ameter list will not be visible outside of this definition or declaration
  140 | DEFINE_OPT_TYPE_CHECK(string_list, struct string_list)
      |                                           ^~~~~~~~~~~
parse-options.h:132:36: note: in definition of macro 'DEFINE_OPT_TYPE_CHE=
CK'
  132 |  static inline void *_opt_ ## name(type *p) \
      |                                    ^~~~


cc -o imap-send.o -c -MF ./.depend/imap-send.o.d -MQ imap-send.o -MMD -MP=
   -O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2=
 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord=
-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=3D/=
usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -march=3DzEC12 -mtune=3Dz13 -f=
asynchronous-unwind-tables -fstack-clash-protection -I. -DHAVE_SYSINFO -D=
GIT_HOST_CPU=3D"\"s390x\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_=
IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH=
_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUST=
OM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PAT=
HS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GE=
TDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFREAD_READS_DIREC=
TORIES -DNO_STRLCPY -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX=
 LV=3D-c"'  imap-send.c
In file included from imap-send.c:29:
parse-options.h:316:37: error: initializer element is not constant
  316 |  { OPTION_CALLBACK, 'v', "verbose", _opt_int(var), NULL, N_("be m=
ore verbose"), \
      |                                     ^~~~~~~~
imap-send.c:51:2: note: in expansion of macro 'OPT__VERBOSITY'
   51 |  OPT__VERBOSITY(&verbosity),
      |  ^~~~~~~~~~~~~~
parse-options.h:316:37: note: (near initialization for 'imap_send_options=
[0].value')
  316 |  { OPTION_CALLBACK, 'v', "verbose", _opt_int(var), NULL, N_("be m=
ore verbose"), \
      |                                     ^~~~~~~~
imap-send.c:51:2: note: in expansion of macro 'OPT__VERBOSITY'
   51 |  OPT__VERBOSITY(&verbosity),
      |  ^~~~~~~~~~~~~~
parse-options.h:318:35: error: initializer element is not constant
  318 |  { OPTION_CALLBACK, 'q', "quiet", _opt_int(var), NULL, N_("be mor=
e quiet"), \
      |                                   ^~~~~~~~
imap-send.c:51:2: note: in expansion of macro 'OPT__VERBOSITY'
   51 |  OPT__VERBOSITY(&verbosity),
      |  ^~~~~~~~~~~~~~
parse-options.h:318:35: note: (near initialization for 'imap_send_options=
[1].value')
  318 |  { OPTION_CALLBACK, 'q', "quiet", _opt_int(var), NULL, N_("be mor=
e quiet"), \
      |                                   ^~~~~~~~
imap-send.c:51:2: note: in expansion of macro 'OPT__VERBOSITY'
   51 |  OPT__VERBOSITY(&verbosity),
      |  ^~~~~~~~~~~~~~
parse-options.h:147:69: error: initializer element is not constant
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
   ^~~~~~~~
parse-options.h:149:37: note: in expansion of macro 'OPT_SET_INT_F'
  149 | #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, =
f)
      |                                     ^~~~~~~~~~~~~
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
imap-send.c:52:2: note: in expansion of macro 'OPT_BOOL'
   52 |  OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with =
the IMAP server"),
      |  ^~~~~~~~
parse-options.h:147:69: note: (near initialization for 'imap_send_options=
[2].value')
  147 | #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l=
), _opt_int(v), NULL, \
      |                                                                  =
   ^~~~~~~~
parse-options.h:149:37: note: in expansion of macro 'OPT_SET_INT_F'
  149 | #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, =
f)
      |                                     ^~~~~~~~~~~~~
parse-options.h:167:37: note: in expansion of macro 'OPT_BOOL_F'
  167 | #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
      |                                     ^~~~~~~~~~
imap-send.c:52:2: note: in expansion of macro 'OPT_BOOL'
   52 |  OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with =
the IMAP server"),
      |  ^~~~~~~~

Thanks,

--=20
Todd
