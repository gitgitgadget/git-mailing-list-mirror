From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 00/94] libify apply and use lib in am
Date: Wed, 11 May 2016 15:16:11 +0200
Message-ID: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U27-0001XZ-2k
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbcEKNS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:18:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36023 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEKNS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9340817wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wx79wUZTnNQsxvLMjEcmdKocVO+gkIXpFGRL7ml2m9U=;
        b=dEZEukNEin80h0AdiwtcnkPA6hS+7MevQA4uKaA23ytuNQECraRIxVExKOWjjv3B88
         5R8jZrIRY0tvvCZI+zDnj6MbQNUrnKZ1RlpXJL9OqiEq2J1ZDMXVXjl4EAJpBEYQIXAY
         5oFcTD/4U9WNi2620rpqAy2stbjVR69sgx/WqKeLGvjQY+Kn3uLUoq2PHi7uv1cF+7/o
         Vfd4sHlCmSiDuebHsxL/nYo8L4pSkrtf9uo+OL256Ysh5K6OCqChevzCk9wyinhMsTA+
         6AntTfKkX7Gvk+pZYDH8cCqsyl9YpF9LV3AYe7FagPJuVlZPWgEigwOgICXE8ezZgklN
         uXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wx79wUZTnNQsxvLMjEcmdKocVO+gkIXpFGRL7ml2m9U=;
        b=CCwWNoXrLVeNp99O2KizhJN7KuIZM8p3Y0gocs+Vn+TFIDhOOyFZz+CTkPboJmcEuX
         I+P8NhUlZE1nCdCAETLiLSROHzUOORVvTT+0CuJX0BygeOsmSsh5Pq+lmgFIbqU3UROv
         n8SYFJbNW1jaf0ZCvUlvEI3CTJJdCFvowte/VbQGuMBzYWL/et5rigepV6FrR1Qomzm1
         Ezz+9osL541K60wW2mHNmwlpcnxCa3WHLuxHuWRDJK0UBimwaYNsK21LlpClrL1KYFlV
         XZiQ++8a+ssXygHszF+iKD3cIcEKkh7Oe+NV1aDZzHZJxp0YSvwy/n8Lg7obNxiDu3N8
         3EqA==
X-Gm-Message-State: AOPr4FV/5Hws6Kb+mpCljRs+SE6SvEJWh9YcpseU/daFy6GeycQ7mUfNHfXDjHgKnGtOCg==
X-Received: by 10.194.87.72 with SMTP id v8mr4241836wjz.68.1462972704709;
        Wed, 11 May 2016 06:18:24 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294248>

Goal
~~~~

This is a patch series about libifying `git apply` functionality, and
using this libified functionality in `git am`, so that no 'git apply'
process is spawn anymore. This makes `git am` significantly faster, so
`git rebase`, when it uses the am backend, is also significantly
faster.

Previous discussions and patches series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This has initially been discussed in the following thread:

  http://thread.gmane.org/gmane.comp.version-control.git/287236/

Then a RFC patch series was sent:

  http://thread.gmane.org/gmane.comp.version-control.git/288489/

Then v1 was sent:

  http://thread.gmane.org/gmane.comp.version-control.git/292324/

Highlevel view of the pqtches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This new patch series is built on top of the above previous work.

  - Patches 1/94 to 47/94 are here from the RFC patch series.

They get rid of most of the global variables in builtin/apply.c by
moving the variables into a new 'struct apply_state', and they
refactor the code around a bit.

They haven't changed much since v1. There are mostly variables that
have been moved around inside 'struct apply_state' or inside
match_fragment(), new lines that have removed in 'struct apply_state'
and function parameters that have been renamed.

  - Patches 48/94 to 84/94 were new in v1.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}. And they use this
libified functionality in git am so that it doesn't launch git apply
processes any more.

There are many changes in these patches, as there were a lot of great
suggestions from many reviewers to improve on v1:

      - Lockfile management changes as suggested by Junio.
      - Many memory leaks were fixed as suggested by Eric.
      - A patch was splitted into two as suggested by Duy.
      - Some file descriptors have been closed as suggested by Dscho.
      - Some early return were moved up as suggested by Eric.
      - Many commit messages were improved.

I am not very happy that I added some gotos, but it looked like a not
too bad way to make sure that the memory and file descriptor cleanups
were done before returning from some functions.

  - Patches 85/94 to 94/94 are new and can be considered RFC.

They implement a way to make the libified apply silent. It is a new
feature in the libified apply functionality.

I consider that the apply functionality is properly libified before
these patches, and that they should be in a separate series, but
unfortunately using the libified apply in "git am" unmasks the fact
that "git am", since it was a shell script, has been silencing the
apply functionality by "futzing with file descriptors". And
unfortunately this makes some reviewers unhappy.

The last patch 94/94 adds a --silent command line option to git apply.
This is not necessary, but some scripts could perhaps use it, and it
could make it easier to test the new silent feature.

By the way there are no tests yet for this new feature, and I am not
sure at all that "--silent" and "be_silent" are good names. Also I
will perhaps be asked to move or merge this part of this series, to
remove the "futzing with file descriptors" earlier in the former
patches. That's why this part of the series can be considered RFC.

General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is long. I can split it into two or more
series if it is prefered.

I can also send diffs between this version and the previous one, but
for now I'd rather not send them in this email, as it would make it
very long.

The benefits are not just related to not creating new processes. When
`git am` launched a `git apply` process, this new process had to read
the index from disk. Then after the `git apply`process had terminated,
`git am` dropped its index and read the index from disk to get the
index that had been modified by the `git apply`process. This was
inefficient and also prevented the split-index mechanism to provide
many performance benefits.

Using this series as rebase material, Duy explains it like this:

 > Without the series, the picture is not so surprising. We run git-app=
ly
 > 80+ times, each consists of this sequence
 >
 > read index
 > write index (cache tree updates only)
 > read index again
 > optionally initialize name hash (when new entries are added, I guess=
)
 > read packed-refs
 > write index
 >
 > With this series, we run a single git-apply which does
 >
 > read index (and sharedindex too if in split-index mode)
 > initialize name hash
 > write index 80+ times

(See: http://thread.gmane.org/gmane.comp.version-control.git/292324/foc=
us=3D292460)

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/libify-apply-use-in-am54

The previous version, v1, is available here:

https://github.com/chriscool/git/commits/libify-apply-use-in-am25=20

Performance numbers
~~~~~~~~~~~~~~~~~~~

Only tests on Linux have been performed. It could be interesting to
test on other platforms especially Windows and perhaps OSX too.

  - Around mid April =C3=86var did a huge many-hundred commit rebase on=
 the
    kernel with untracked cache.

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

=C3=86var used his Debian laptop with SSD.

  - Around mid April I tested rebasing 13 commits in Booking.com's
    monorepo on a Red Hat 6.5 server with split-index and
    GIT_TRACE_PERFORMANCE=3D1.

With Git v2.8.0, the rebase took 6.375888383 s, with the git am
command launched by the rebase command taking 3.705677431 s.

With this series on top of next, the rebase took 3.044529494 s, with
the git am command launched by the rebase command taking 0.583521168
s.


Christian Couder (94):
  builtin/apply: make gitdiff_verify_name() return void
  builtin/apply: avoid parameter shadowing 'p_value' global
  builtin/apply: avoid parameter shadowing 'linenr' global
  builtin/apply: avoid local variable shadowing 'len' parameter
  builtin/apply: extract line_by_line_fuzzy_match() from
    match_fragment()
  builtin/apply: move 'options' variable into cmd_apply()
  builtin/apply: move 'read_stdin' global into cmd_apply()
  builtin/apply: introduce 'struct apply_state' to start libifying
  builtin/apply: move 'state' init into init_apply_state()
  builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
  builtin/apply: move 'check' global into 'struct apply_state'
  builtin/apply: move 'check_index' global into 'struct apply_state'
  builtin/apply: move 'apply_in_reverse' global into 'struct
    apply_state'
  builtin/apply: move 'apply_with_reject' global into 'struct
    apply_state'
  builtin/apply: move 'apply_verbosely' global into 'struct apply_state=
'
  builtin/apply: move 'update_index' global into 'struct apply_state'
  builtin/apply: move 'allow_overlap' global into 'struct apply_state'
  builtin/apply: move 'cached' global into 'struct apply_state'
  builtin/apply: move 'diffstat' global into 'struct apply_state'
  builtin/apply: move 'numstat' global into 'struct apply_state'
  builtin/apply: move 'summary' global into 'struct apply_state'
  builtin/apply: move 'threeway' global into 'struct apply_state'
  builtin/apply: move 'no_add' global into 'struct apply_state'
  builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
  builtin/apply: move 'line_termination' global into 'struct
    apply_state'
  builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
  builtin/apply: move 'p_context' global into 'struct apply_state'
  builtin/apply: move 'apply' global into 'struct apply_state'
  builtin/apply: move 'patch_input_file' global into 'struct
    apply_state'
  builtin/apply: move 'limit_by_name' global into 'struct apply_state'
  builtin/apply: move 'has_include' global into 'struct apply_state'
  builtin/apply: move 'p_value' global into 'struct apply_state'
  builtin/apply: move 'p_value_known' global into 'struct apply_state'
  builtin/apply: move 'root' global into 'struct apply_state'
  builtin/apply: move 'whitespace_error' global into 'struct
    apply_state'
  builtin/apply: move 'whitespace_option' into 'struct apply_state'
  builtin/apply: remove whitespace_option arg from
    set_default_whitespace_mode()
  builtin/apply: move 'squelch_whitespace_errors' into 'struct
    apply_state'
  builtin/apply: move 'applied_after_fixing_ws' into 'struct
    apply_state'
  builtin/apply: move 'ws_error_action' into 'struct apply_state'
  builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
  builtin/apply: move 'max_change' and 'max_len' into 'struct
    apply_state'
  builtin/apply: move 'state_linenr' global into 'struct apply_state'
  builtin/apply: move 'fn_table' global into 'struct apply_state'
  builtin/apply: move 'symlink_changes' global into 'struct apply_state=
'
  builtin/apply: move 'state' check into check_apply_state()
  builtin/apply: move applying patches into apply_all_patches()
  builtin/apply: rename 'prefix_' parameter to 'prefix'
  builtin/apply: move 'lock_file' global into 'struct apply_state'
  builtin/apply: move 'newfd' global into 'struct apply_state'
  builtin/apply: make apply_patch() return -1 instead of die()ing
  builtin/apply: read_patch_file() return -1 instead of die()ing
  builtin/apply: make find_header() return -1 instead of die()ing
  builtin/apply: make parse_chunk() return a negative integer on error
  builtin/apply: make parse_single_patch() return -1 on error
  apply: move 'struct apply_state' to apply.h
  builtin/apply: make parse_whitespace_option() return -1 instead of
    die()ing
  builtin/apply: make parse_ignorewhitespace_option() return -1 instead
    of die()ing
  builtin/apply: move init_apply_state() to apply.c
  apply: make init_apply_state() return -1 instead of exit()ing
  builtin/apply: make check_apply_state() return -1 instead of die()ing
  builtin/apply: move check_apply_state() to apply.c
  builtin/apply: make apply_all_patches() return -1 on error
  builtin/apply: make parse_traditional_patch() return -1 on error
  builtin/apply: make gitdiff_*() return 1 at end of header
  builtin/apply: make gitdiff_*() return -1 on error
  builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
  builtin/apply: make build_fake_ancestor() return -1 on error
  builtin/apply: make remove_file() return -1 on error
  builtin/apply: make add_conflicted_stages_file() return -1 on error
  builtin/apply: make add_index_file() return -1 on error
  builtin/apply: make create_file() return -1 on error
  builtin/apply: make write_out_one_result() return -1 on error
  builtin/apply: make write_out_results() return -1 on error
  builtin/apply: make try_create_file() return -1 on error
  builtin/apply: make create_one_file() return -1 on error
  builtin/apply: rename option parsing functions
  apply: rename and move opt constants to apply.h
  Move libified code from builtin/apply.c to apply.{c,h}
  apply: make some parsing functions static again
  run-command: make dup_devnull() non static
  apply: roll back index lock file in case of error
  environment: add set_index_file()
  builtin/am: use apply api in run_apply()
  write_or_die: use warning() instead of fprintf(stderr, ...)
  apply: add 'be_silent' variable to 'struct apply_state'
  apply: make 'be_silent' incomatible with 'apply_verbosely'
  apply: don't print on stdout when be_silent is set
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when be_silent is set
  am: use be_silent in 'struct apply_state' to shut up applying patches
  run-command: make dup_devnull() static again
  builtin/apply: add a cli option for be_silent

 Makefile                   |    1 +
 builtin/apply.c =3D> apply.c | 1750 ++++++++--------
 apply.h                    |  146 ++
 builtin/am.c               |   91 +-
 builtin/apply.c            | 4762 +-----------------------------------=
--------
 cache.h                    |    1 +
 environment.c              |   10 +
 git-compat-util.h          |    3 +
 run-command.c              |    2 +-
 t/t4012-diff-binary.sh     |    4 +-
 t/t4254-am-corrupt.sh      |    2 +-
 usage.c                    |   15 +
 write_or_die.c             |    6 +-
 13 files changed, 1324 insertions(+), 5469 deletions(-)
 copy builtin/apply.c =3D> apply.c (73%)
 create mode 100644 apply.h
 rewrite builtin/apply.c (98%)

--=20
2.8.2.490.g3dabe57
