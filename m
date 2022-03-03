Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE12C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 14:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiCCOJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiCCOJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 09:09:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4E108BE5
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 06:08:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n14so8040102wrq.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 06:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MMZcJmYZaGDKjA2u+tajN/cuBKsvi718A6JmXScBl5Y=;
        b=jp+XN0l4d9402G3D59K8DV7qKFY66ZXmmunOxJWm6U3M0nl2NxdNI/jGWJ7Dt3dh+Z
         tUsQmHyXUHpfgeEyAas4T15o4JQwMYtHyNwWhUxbLwzj0Q8ul8YU5ezoib11m2gcCf/9
         wr9qP62IWlrHVMj3ErQygS6G2utMA/8RkZ4+Fq0SywEZZr8nYa8p2p36DS9frXDvth1+
         jmpOYxFCquKKeeIirumo2+nyC0k3YHdaSqIulVk7Z+qHcKzvZlG0Nl5AB9PVOANxqnNK
         /B8YSzpvJvM2gfqzPkwUinEG2ehEVTXLbStZtk3Klxn/fQKHax941YaocQDsQOc7gnn+
         YKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MMZcJmYZaGDKjA2u+tajN/cuBKsvi718A6JmXScBl5Y=;
        b=2y5PxhCvN4wDLJAPTa1KfI49mlTmoEO2ALbN2J5fA8eVJkY13ajTY6rTKm7ZarePMZ
         T/6ieNv0e9gFA+9els3jJgPfp4ycAm5ZpGFTtbX0+Yt6N8CYZLGXBi9teRW8fE+ZscBo
         VLggE/0hhvk76kMNclt3y8lZSLtehtkJTyKGWrgLHXw0gyhpsbIIET6YKgwAka7GagmD
         OpFexmdo4VGh5B0BiHZdOYW36xBkt1zOnih7H4txUW2whhxNrfZOXlWf0lbOwoiNf1zo
         E/0cBFgWgx+rLIxnCN3jwI6llPSsZY/Q1QpDK0hM64NaqK3zbd5kgIannA9MDBybu4PW
         VB6g==
X-Gm-Message-State: AOAM530rl2uuVs/S18Fg6heY9wB7EpiJeNqOGDS5wxES5o/o8HtFPWYn
        xltmytP2Eiu5fS1tcWFOyTE=
X-Google-Smtp-Source: ABdhPJy8d0Y0UJ/z7KZTD/+RO4m5X8W9A/hAFXA1CqMYqZeCGTNeb/OqJo8CTI1um8VG9wkX/bC9Rw==
X-Received: by 2002:adf:fbc4:0:b0:1e7:2060:d65 with SMTP id d4-20020adffbc4000000b001e720600d65mr26333963wrs.583.1646316526407;
        Thu, 03 Mar 2022 06:08:46 -0800 (PST)
Received: from [192.168.1.201] (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.googlemail.com with ESMTPSA id r15-20020a05600c35cf00b003808165fbc2sm2513081wmq.25.2022.03.03.06.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 06:08:46 -0800 (PST)
Message-ID: <d75f5bed-ce2e-19fd-5913-b6272132a6cb@gmail.com>
Date:   Thu, 3 Mar 2022 14:08:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/9] Makefile: optimize noop runs, add shared.mak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2022 12:49, Ævar Arnfjörð Bjarmason wrote:
> As the v1 notes (among other things):
> https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com/
> 
>      This speeds up noop runs of "make" by a lot. After a "make" running a
>      "make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
>      as fast with "make -j1 NO_TCLTK=Y" (the TCL part takes a lot of time,
>      but that's another matter).
> 
> This v4 re-roll (for v3, see
> https://lore.kernel.org/git/cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com/):
> 
>   * The "all" boilerplate goes first now, before "include"
>   * Elaborated on DELETE_ON_ERROR ina commit message.
>   * No longer change a ":=" to "=" while moving code.
>   * Rephrased other commit messages (one of which referred to a
>     function from another future series)
>   * Typo fix in commit message.
> 
> Ævar Arnfjörð Bjarmason (9):
>    scalar Makefile: use "The default target of..." pattern
>    Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
>    Makefile: disable GNU make built-in wildcard rules
>    Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
>    Makefile: move ".SUFFIXES" rule to shared.mak
>    Makefile: move $(comma), $(empty) and $(space) to shared.mak
>    Makefile: add "$(QUIET)" boilerplate to shared.mak
>    Makefile: use $(wspfx) for $(QUIET...) in shared.mak
>    Makefiles: add and use wildcard "mkdir -p" template
> 
>   Documentation/Makefile    |  63 ++------------------
>   Makefile                  | 118 ++++++++++++--------------------------
>   config.mak.uname          |   1 -
>   contrib/scalar/Makefile   |  20 ++-----
>   contrib/scalar/t/Makefile |   3 +
>   shared.mak                | 109 +++++++++++++++++++++++++++++++++++
>   t/Makefile                |   3 +
>   t/interop/Makefile        |   3 +
>   t/perf/Makefile           |   3 +
>   templates/Makefile        |   8 +--
>   10 files changed, 171 insertions(+), 160 deletions(-)
>   create mode 100644 shared.mak
> 
> Range-diff against v3:
>   1:  2404c4d8b96 <  -:  ----------- scalar Makefile: set the default target after the includes
>   -:  ----------- >  1:  26c6bb897cf scalar Makefile: use "The default target of..." pattern
>   2:  96a490bec54 !  2:  74692458b70 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
>      @@ Commit message
>           .DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
>           ".DELETE_ON_ERROR" flag.
>       
>      -    This does have the potential downside that if e.g. templates/Makefile
>      -    would like to include this "shared.mak" in the future the semantics of
>      -    such a Makefile will change, but as noted in the above commits (and
>      -    GNU make's own documentation) any such change would be for the better,
>      -    so it's safe to do this.
>      +    I.e. this changes the behavior of existing rules in the altered
>      +    Makefiles (except "Makefile" & "Documentation/Makefile"). I'm
>      +    confident that this is safe having read the relevant rules in those
>      +    Makfiles, and as the GNU make manual notes that it isn't the default
>      +    behavior is out of an abundance of backwards compatibility
>      +    caution. From edition 0.75 of its manual, covering GNU make 4.3:
>       
>      -    This also doesn't introduce a bug by e.g. having this
>      +        [Enabling '.DELETE_ON_ERROR' is] almost always what you want
>      +        'make' to do, but it is not historical practice; so for
>      +        compatibility, you must explicitly request it.
>      +
>      +    This doesn't introduce a bug by e.g. having this
>           ".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
>           have no such scoping semantics.

I think this is much clearer now,

Best Wishes

Phillip

>      +    It does increase the danger that any Makefile without an explicit "The
>      +    default target of this Makefile is..." snippet to define the default
>      +    target as "all" could have its default rule changed if our new
>      +    shared.mak ever defines a "real" rule. In subsequent commits we'll be
>      +    careful not to do that, and such breakage would be obvious e.g. in the
>      +    case of "make -C t".
>      +
>      +    We might want to make that less fragile still (e.g. by using
>      +    ".DEFAULT_GOAL" as noted in the preceding commit), but for now let's
>      +    simply include "shared.mak" without adding that boilerplate to all the
>      +    Makefiles that don't have it already. Most of those are already
>      +    exposed to that potential caveat e.g. due to including "config.mak*".
>      +
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## Documentation/Makefile ##
>      @@ Documentation/Makefile: doc-l10n install-l10n::
>       
>        ## Makefile ##
>       @@
>      -+# Import tree-wide shared Makefile behavior and libraries
>      -+include shared.mak
>      -+
>        # The default target of this Makefile is...
>        all::
>        
>      ++# Import tree-wide shared Makefile behavior and libraries
>      ++include shared.mak
>      ++
>      + # Define V=1 to have a more verbose compile.
>      + #
>      + # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
>       @@ Makefile: shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>        strip: $(PROGRAMS) git$X
>        	$(STRIP) $(STRIP_OPTS) $^
>      @@ Makefile: shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>       
>        ## contrib/scalar/Makefile ##
>       @@
>      + # The default target of this Makefile is...
>      + all::
>      +
>       +# Import tree-wide shared Makefile behavior and libraries
>       +include ../../shared.mak
>       +
>      - QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
>      - QUIET_SUBDIR1  =
>      -
>      + include ../../config.mak.uname
>      + -include ../../config.mak.autogen
>      + -include ../../config.mak
>       
>        ## contrib/scalar/t/Makefile ##
>       @@
>   3:  9392e3c3e97 !  3:  0fbdeeffc7b Makefile: disable GNU make built-in wildcard rules
>      @@ Commit message
>           contents from RCS or SCCS. See [1] for an old mailing list discussion
>           about how to disable these.
>       
>      -    The speed-up may wary. I've seen 1-10% depending on the speed of the
>      +    The speed-up may vary. I've seen 1-10% depending on the speed of the
>           local disk, caches, -jN etc. Running:
>       
>               strace -f -c -S calls make -j1 NO_TCLTK=Y
>   4:  07cf9daa9d6 =  4:  ea6b835308a Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
>   5:  16f2e3ff35b =  5:  c2339694cf7 Makefile: move ".SUFFIXES" rule to shared.mak
>   6:  1b6ecb27f02 !  6:  741fdfd48e2 Makefile: move $(comma), $(empty) and $(space) to shared.mak
>      @@ Metadata
>        ## Commit message ##
>           Makefile: move $(comma), $(empty) and $(space) to shared.mak
>       
>      -    Move these variables over to the shared.max, we'll make use of them in
>      -    a subsequent commit. There was no reason for these to be "simply
>      -    expanded variables", so let's use the normal lazy "=" assignment here.
>      +    Move these variables over to the shared.mak, we'll make use of them in
>      +    a subsequent commit.
>      +
>      +    Note that there's reason for these to be "simply expanded variables",
>      +    i.e. to use ":=" assignments instead of lazily expanded "="
>      +    assignments. We could use "=", but let's leave this as-is for now for
>      +    ease of review.
>       
>           See 425ca6710b2 (Makefile: allow combining UBSan with other
>           sanitizers, 2017-07-15) for the commit that introduced these.
>      @@ shared.mak
>       +
>       +## comma, empty, space: handy variables as these tokens are either
>       +## special or can be hard to spot among other Makefile syntax.
>      -+comma = ,
>      -+empty =
>      -+space = $(empty) $(empty)
>      ++comma := ,
>      ++empty :=
>      ++space := $(empty) $(empty)
>   7:  471067deefc !  7:  a723cbce270 Makefile: add "$(QUIET)" boilerplate to shared.mak
>      @@ config.mak.uname: vcxproj:
>        
>       
>        ## contrib/scalar/Makefile ##
>      -@@
>      - # Import tree-wide shared Makefile behavior and libraries
>      - include ../../shared.mak
>      +@@ contrib/scalar/Makefile: include ../../config.mak.uname
>      + -include ../../config.mak.autogen
>      + -include ../../config.mak
>        
>       -QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
>       -QUIET_SUBDIR1  =
>      @@ contrib/scalar/Makefile
>       -endif
>       -endif
>       -
>      - include ../../config.mak.uname
>      - -include ../../config.mak.autogen
>      - -include ../../config.mak
>      + TARGETS = scalar$(X) scalar.o
>      + GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
>      +
>       
>        ## shared.mak ##
>       @@
>      - comma = ,
>      - empty =
>      - space = $(empty) $(empty)
>      + comma := ,
>      + empty :=
>      + space := $(empty) $(empty)
>       +
>       +### Quieting
>       +## common
>   8:  510306d2219 !  8:  3733b0c8df1 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
>      @@ Commit message
>           Makefile: use $(wspfx) for $(QUIET...) in shared.mak
>       
>           Change the mostly move-only change in the preceding commit to use the
>      -    $(wspfx) variable for defining the QUIET padding, to guarantee that
>      -    it's consistent with the "TRACK_template" template.
>      +    $(wspfx) variable for defining the QUIET padding. This refactoring
>      +    will make it easier to emit that exact amount of padding in functions
>      +    that we might add to shared.mak in the future.
>       
>      -        $ make CFLAGS=-I$RANDOM grep.o wspfx='$(space)->'
>      -         -> GIT-CFLAGS PARAMETERS (changed)
>      -         -> CC grep.o
>      +    Such a function is not part of this patch series, but a
>      +    "TRACK_template" that I'd like to add as a follow-up to it makes use
>      +    of this. Let's make this change now while modifying these QUIET rules
>      +    is fresh in our minds.
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## shared.mak ##
>      -@@ shared.mak: comma = ,
>      - empty =
>      - space = $(empty) $(empty)
>      +@@ shared.mak: comma := ,
>      + empty :=
>      + space := $(empty) $(empty)
>        
>       +## wspfx: the whitespace prefix padding for $(QUIET...) and similarly
>       +## aligned output.
>   9:  85bb74aa32f =  9:  4cc4aeabb20 Makefiles: add and use wildcard "mkdir -p" template

