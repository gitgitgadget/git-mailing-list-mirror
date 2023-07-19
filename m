Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A629C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGSQYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSQYp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:24:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199AB6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so5302762b3a.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689783882; x=1692375882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QVc5PwQ2JlR4AU25J4nq3JcJerxvDfNExj/O9QNGjs=;
        b=H+0O0pOgGu1nRIoO6vZp3EuRrrMz38wzupzufFF6jlNNOUw1ReO/K9BMuk8KYnYqAb
         3GwGX0aWWLj4llw96LWdSK4coWNaKaICdxEW+Fla2h29+w+xNmuIc9cxfJPtkdHboUQF
         iOuwmrN8zxTjzsQPvF5rlkCgviR9rxaHcoe+VFgj7uoXrTOfO037Jjc6dzmkDxWIlc7O
         Ouqxfa/WId1oeuUMft9prW02jZhRYlGntYrWSDNnwYTh/xUo7VNWGmtheWoKToq36CVd
         TnjssZWUlB6VsvHqXRTjJbRN7A0zI0i6FD4S8ctLycpRzQNWkeMmPGhPK61+aKUx3FPx
         Couw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783882; x=1692375882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QVc5PwQ2JlR4AU25J4nq3JcJerxvDfNExj/O9QNGjs=;
        b=dbaW/m7s5GoO6l2osrkyYOX/bA4/qt9w/SRqNqXFHaCXBBoJMdK3sl7/Fx8hjzx9tJ
         hrIflGikoBtgYsqG/2ZkprJdas727Edtzw1wV6BAy4sponoYsCGzzHwXm7abd3w/yTt6
         7UErtN6f9E6H5gETvpbQiXsToy8D0f/6KCmj1dTMnCm7BmiTMTyPvklERmUwdXL4p53d
         Otr7XMdm/XwI3qK0IEfcUPdbxG17Je8gW6wq7ulB2hCGsQhXav/6Qg711dX1x0gYwObB
         ZvuWHlFOkq/n4SZTMyiJ/DxTYzAsRgbn/SBMU0MFEiVBZrH9ruWs8MWOCn+n4YVZut/l
         TCmA==
X-Gm-Message-State: ABy/qLY6DuF+MW7m8viayUVDrJLKpDnG/TNl8skGzp8ARLFUvfdvMGLS
        kxNBAiXyhpWlruHGRGqZarXCUgYDKF9d/sxx
X-Google-Smtp-Source: APBJJlEaDkyXbgdg3GiwuDxAz5+udDlDpICN5I8CxvSZYNtAOzdFvf6nef7q9MuU1e32t4Colvhe7A==
X-Received: by 2002:a05:6a00:3981:b0:668:8705:a456 with SMTP id fi1-20020a056a00398100b006688705a456mr6373974pfb.23.1689783882354;
        Wed, 19 Jul 2023 09:24:42 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.156.16])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0067b643b814csm3484907pfb.6.2023.07.19.09.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:24:41 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v3 0/2] Add new "describe" atom 
Date:   Wed, 19 Jul 2023 21:45:04 +0530
Message-ID: <20230719162424.70781-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.378.g42703afc1f.dirty
In-Reply-To: <20230714194249.66862-1-five231003@gmail.com>
References: <20230714194249.66862-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks Junio for the review on the previous version of this series. I
have made the changes according to the comments left.

PATCH 1/2 - Left unchanged expect for small changes in the commit
	    message for more clarity.

PATCH 2/2 - We now parse the arguments in a seperate function
	    `describe_atom_option_parser()` call this in
	    `describe_atom_parser()` instead to populate
	    `atom->u.describe_args`. This splitting of the function
	    helps err at the right places.

	    I've also squashed the third commit in the previous version
	    into this commit.

Kousik Sanagavarapu (2):
  ref-filter: add multiple-option parsing functions
  ref-filter: add new "describe" atom

 Documentation/git-for-each-ref.txt |  23 ++++
 ref-filter.c                       | 189 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 114 +++++++++++++++++
 3 files changed, 326 insertions(+)

Range-diff against v2:

1:  50497067a3 ! 1:  08f3be1631 ref-filter: add multiple-option parsing functions
    @@ Commit message
                 match_placeholder_arg_value()
                 match_placeholder_bool_arg()
     
    -    were added in pretty (4f732e0fd7 (pretty: allow %(trailers) options
    -    with explicit value, 2019-01-29)) to parse multiple options in an
    +    were added in pretty 4f732e0fd7 (pretty: allow %(trailers) options
    +    with explicit value, 2019-01-29) to parse multiple options in an
         argument to --pretty. For example,
     
                 git log --pretty="%(trailers:key=Signed-Off-By,separator=%x2C )"
     
         will output all the trailers matching the key and seperates them by
    -    commas per commit.
    +    a comma followed by a space per commit.
     
         Add similar functions,
     
                 match_atom_arg_value()
                 match_atom_bool_arg()
     
    -    in ref-filter. A particular use of this can be seen in the subsequent
    -    commit where we parse the options given to a new atom "describe".
    +    in ref-filter.
    +
    +    There is no atom yet that can use these functions in ref-filter, but we
    +    are going to add a new %(describe) atom in a subsequent commit where we
    +    parse options like tags=<bool-value> or match=<pattern> given to it.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Hariom Verma <hariom18599@gmail.com>
2:  f6f882884c ! 2:  742a79113c ref-filter: add new "describe" atom
    @@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
     
      ## ref-filter.c ##
     @@
    - #include "alloc.h"
    + #include "git-compat-util.h"
      #include "environment.h"
      #include "gettext.h"
     +#include "config.h"
    @@ ref-filter.c: enum atom_type {
        ATOM_BODY,
        ATOM_TRAILERS,
     @@ ref-filter.c: static struct used_atom {
    -           struct email_option {
    -                   enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
    -           } email_option;
    -+          struct {
    -+                  enum { D_BARE, D_TAGS, D_ABBREV,
    -+                         D_EXCLUDE, D_MATCH } option;
    -+                  const char **args;
    -+          } describe;
    +                   enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
    +                          S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
    +           } signature;
    ++          const char **describe_args;
                struct refname_atom refname;
                char *head;
        } u;
    @@ ref-filter.c: static int contents_atom_parser(struct ref_format *format, struct
        return 0;
      }
      
    ++static int describe_atom_option_parser(struct strvec *args, const char **arg,
    ++                                 struct strbuf *err)
    ++{
    ++  const char *argval;
    ++  size_t arglen = 0;
    ++  int optval = 0;
    ++
    ++  if (match_atom_bool_arg(*arg, "tags", arg, &optval)) {
    ++          if (!optval)
    ++                  strvec_push(args, "--no-tags");
    ++          else
    ++                  strvec_push(args, "--tags");
    ++          return 1;
    ++  }
    ++
    ++  if (match_atom_arg_value(*arg, "abbrev", arg, &argval, &arglen)) {
    ++          char *endptr;
    ++
    ++          if (!arglen)
    ++                  return strbuf_addf_ret(err, -1,
    ++                                         _("argument expected for %s"),
    ++                                         "describe:abbrev");
    ++          if (strtol(argval, &endptr, 10) < 0)
    ++                  return strbuf_addf_ret(err, -1,
    ++                                         _("positive value expected %s=%s"),
    ++                                         "describe:abbrev", argval);
    ++          if (endptr - argval != arglen)
    ++                  return strbuf_addf_ret(err, -1,
    ++                                         _("cannot fully parse %s=%s"),
    ++                                         "describe:abbrev", argval);
    ++
    ++          strvec_pushf(args, "--abbrev=%.*s", (int)arglen, argval);
    ++          return 1;
    ++  }
    ++
    ++  if (match_atom_arg_value(*arg, "match", arg, &argval, &arglen)) {
    ++          if (!arglen)
    ++                  return strbuf_addf_ret(err, -1,
    ++                                         _("value expected %s="),
    ++                                         "describe:match");
    ++
    ++          strvec_pushf(args, "--match=%.*s", (int)arglen, argval);
    ++          return 1;
    ++  }
    ++
    ++  if (match_atom_arg_value(*arg, "exclude", arg, &argval, &arglen)) {
    ++          if (!arglen)
    ++                  return strbuf_addf_ret(err, -1,
    ++                                         _("value expected %s="),
    ++                                         "describe:exclude");
    ++
    ++          strvec_pushf(args, "--exclude=%.*s", (int)arglen, argval);
    ++          return 1;
    ++  }
    ++
    ++  return 0;
    ++}
    ++
     +static int describe_atom_parser(struct ref_format *format UNUSED,
     +                          struct used_atom *atom,
     +                          const char *arg, struct strbuf *err)
     +{
    -+  const char *describe_opts[] = {
    -+          "",
    -+          "tags",
    -+          "abbrev",
    -+          "match",
    -+          "exclude",
    -+          NULL
    -+  };
    -+
     +  struct strvec args = STRVEC_INIT;
    ++
     +  for (;;) {
     +          int found = 0;
    -+          const char *argval;
    -+          size_t arglen = 0;
    -+          int optval = 0;
    -+          int opt;
    ++          const char *bad_arg = NULL;
     +
    -+          if (!arg)
    ++          if (!arg || !*arg)
     +                  break;
     +
    -+          for (opt = D_BARE; !found && describe_opts[opt]; opt++) {
    -+                  switch(opt) {
    -+                  case D_BARE:
    -+                          /*
    -+                           * Do nothing. This is the bare describe
    -+                           * atom and we already handle this above.
    -+                           */
    -+                          break;
    -+                  case D_TAGS:
    -+                          if (match_atom_bool_arg(arg, describe_opts[opt],
    -+                                                  &arg, &optval)) {
    -+                                  if (!optval)
    -+                                          strvec_pushf(&args, "--no-%s",
    -+                                                       describe_opts[opt]);
    -+                                  else
    -+                                          strvec_pushf(&args, "--%s",
    -+                                                       describe_opts[opt]);
    -+                                  found = 1;
    -+                          }
    -+                          break;
    -+                  case D_ABBREV:
    -+                          if (match_atom_arg_value(arg, describe_opts[opt],
    -+                                                   &arg, &argval, &arglen)) {
    -+                                  char *endptr;
    -+                                  int ret = 0;
    -+
    -+                                  if (!arglen)
    -+                                          ret = -1;
    -+                                  if (strtol(argval, &endptr, 10) < 0)
    -+                                          ret = -1;
    -+                                  if (endptr - argval != arglen)
    -+                                          ret = -1;
    -+
    -+                                  if (ret)
    -+                                          return strbuf_addf_ret(err, ret,
    -+                                                          _("positive value expected describe:abbrev=%s"), argval);
    -+                                  strvec_pushf(&args, "--%s=%.*s",
    -+                                               describe_opts[opt],
    -+                                               (int)arglen, argval);
    -+                                  found = 1;
    -+                          }
    -+                          break;
    -+                  case D_MATCH:
    -+                  case D_EXCLUDE:
    -+                          if (match_atom_arg_value(arg, describe_opts[opt],
    -+                                                   &arg, &argval, &arglen)) {
    -+                                  if (!arglen)
    -+                                          return strbuf_addf_ret(err, -1,
    -+                                                          _("value expected describe:%s="), describe_opts[opt]);
    -+                                  strvec_pushf(&args, "--%s=%.*s",
    -+                                               describe_opts[opt],
    -+                                               (int)arglen, argval);
    -+                                  found = 1;
    -+                          }
    -+                          break;
    -+                  }
    -+          }
    -+          if (!found)
    ++          bad_arg = arg;
    ++          found = describe_atom_option_parser(&args, &arg, err);
    ++          if (found < 0)
    ++                  return found;
    ++          if (!found) {
    ++                  if (bad_arg && *bad_arg)
    ++                          return err_bad_arg(err, "describe", bad_arg);
     +                  break;
    ++          }
     +  }
    -+  atom->u.describe.args = strvec_detach(&args);
    ++  atom->u.describe_args = strvec_detach(&args);
     +  return 0;
     +}
     +
    @@ ref-filter.c: static void append_lines(struct strbuf *out, const char *buf, unsi
     +
     +          if (!!deref != (*name == '*'))
     +                  continue;
    -+          if (deref)
    -+                  name++;
    -+
    -+          if (!skip_prefix(name, "describe", &name) ||
    -+              (*name && *name != ':'))
    -+                      continue;
    -+          if (!*name)
    -+                  name = NULL;
    -+          else
    -+                  name++;
     +
     +          cmd.git_cmd = 1;
     +          strvec_push(&cmd.args, "describe");
    -+          strvec_pushv(&cmd.args, atom->u.describe.args);
    ++          strvec_pushv(&cmd.args, atom->u.describe_args);
     +          strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
     +          if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
     +                  error(_("failed to run 'describe'"));
    @@ ref-filter.c: static void grab_values(struct atom_value *val, int deref, struct
                break;
        case OBJ_COMMIT:
                grab_commit_values(val, deref, obj);
    -           grab_sub_body_contents(val, deref, data);
    +@@ ref-filter.c: static void grab_values(struct atom_value *val, int deref, struct object *obj, s
                grab_person("author", val, deref, buf);
                grab_person("committer", val, deref, buf);
    +           grab_signature(val, deref, obj);
     +          grab_describe_values(val, deref, obj);
                break;
        case OBJ_TREE:
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
        test_cmp expected.bare actual
      '
      
    -+test_expect_success 'describe atom vs git describe' '
    -+  test_when_finished "rm -rf describe-repo" &&
    -+
    ++test_expect_success 'setup for describe atom tests' '
     +  git init describe-repo &&
     +  (
     +          cd describe-repo &&
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
     +          git tag tagone &&
     +
     +          test_commit --no-tag two &&
    -+          git tag -a -m "tag two" tagtwo &&
    ++          git tag -a -m "tag two" tagtwo
    ++  )
    ++'
     +
    -+          git for-each-ref refs/tags/ --format="%(objectname)" >obj &&
    ++test_expect_success 'describe atom vs git describe' '
    ++  (
    ++          cd describe-repo &&
    ++
    ++          git for-each-ref --format="%(objectname)" \
    ++                  refs/tags/ >obj &&
     +          while read hash
     +          do
     +                  if desc=$(git describe $hash)
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
     +'
     +
     +test_expect_success 'describe:tags vs describe --tags' '
    -+  test_when_finished "git tag -d tagname" &&
    -+  git tag tagname &&
    -+  git describe --tags >expect &&
    -+  git for-each-ref --format="%(describe:tags)" refs/heads/ >actual &&
    -+  test_cmp expect actual
    ++  (
    ++          cd describe-repo &&
    ++          git describe --tags >expect &&
    ++          git for-each-ref --format="%(describe:tags)" \
    ++                          refs/heads/master >actual &&
    ++          test_cmp expect actual
    ++  )
     +'
     +
     +test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
    -+  test_when_finished "git tag -d tagname" &&
    -+
    -+  # Case 1: We have commits between HEAD and the most
    -+  #         recent tag reachable from it
    -+  test_commit --no-tag file &&
    -+  git describe --abbrev=14 >expect &&
    -+  git for-each-ref --format="%(describe:abbrev=14)" \
    -+          refs/heads/ >actual &&
    -+  test_cmp expect actual &&
    -+
    -+  # Make sure the hash used is atleast 14 digits long
    -+  sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
    -+  test 15 -le $(wc -c <hexpart) &&
    -+
    -+  # Case 2: We have a tag at HEAD, describe directly gives
    -+  #         the name of the tag
    -+  git tag -a -m tagged tagname &&
    -+  git describe --abbrev=14 >expect &&
    -+  git for-each-ref --format="%(describe:abbrev=14)" \
    -+          refs/heads/ >actual &&
    -+  test_cmp expect actual &&
    -+  test tagname = $(cat actual)
    ++  (
    ++          cd describe-repo &&
    ++
    ++          # Case 1: We have commits between HEAD and the most
    ++          #         recent tag reachable from it
    ++          test_commit --no-tag file &&
    ++          git describe --abbrev=14 >expect &&
    ++          git for-each-ref --format="%(describe:abbrev=14)" \
    ++                  refs/heads/master >actual &&
    ++          test_cmp expect actual &&
    ++
    ++          # Make sure the hash used is atleast 14 digits long
    ++          sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
    ++          test 15 -le $(wc -c <hexpart) &&
    ++
    ++          # Case 2: We have a tag at HEAD, describe directly gives
    ++          #         the name of the tag
    ++          git tag -a -m tagged tagname &&
    ++          git describe --abbrev=14 >expect &&
    ++          git for-each-ref --format="%(describe:abbrev=14)" \
    ++                  refs/heads/master >actual &&
    ++          test_cmp expect actual &&
    ++          test tagname = $(cat actual)
    ++  )
     +'
     +
     +test_expect_success 'describe:match=... vs describe --match ...' '
    -+  test_when_finished "git tag -d tag-match" &&
    -+  git tag -a -m "tag match" tag-match &&
    -+  git describe --match "*-match" >expect &&
    -+  git for-each-ref --format="%(describe:match="*-match")" \
    -+          refs/heads/ >actual &&
    -+  test_cmp expect actual
    ++  (
    ++          cd describe-repo &&
    ++          git tag -a -m "tag foo" tag-foo &&
    ++          git describe --match "*-foo" >expect &&
    ++          git for-each-ref --format="%(describe:match="*-foo")" \
    ++                  refs/heads/master >actual &&
    ++          test_cmp expect actual
    ++  )
     +'
     +
     +test_expect_success 'describe:exclude:... vs describe --exclude ...' '
    -+  test_when_finished "git tag -d tag-exclude" &&
    -+  git tag -a -m "tag exclude" tag-exclude &&
    -+  git describe --exclude "*-exclude" >expect &&
    -+  git for-each-ref --format="%(describe:exclude="*-exclude")" \
    -+          refs/heads/ >actual &&
    -+  test_cmp expect actual
    ++  (
    ++          cd describe-repo &&
    ++          git tag -a -m "tag bar" tag-bar &&
    ++          git describe --exclude "*-bar" >expect &&
    ++          git for-each-ref --format="%(describe:exclude="*-bar")" \
    ++                  refs/heads/master >actual &&
    ++          test_cmp expect actual
    ++  )
    ++'
    ++
    ++test_expect_success 'deref with describe atom' '
    ++  (
    ++          cd describe-repo &&
    ++          cat >expect <<-\EOF &&
    ++
    ++          tagname
    ++          tagname
    ++          tagname
    ++
    ++          tagtwo
    ++          EOF
    ++          git for-each-ref --format="%(*describe)" >actual &&
    ++          test_cmp expect actual
    ++  )
     +'
     +
      cat >expected <<\EOF
3:  a5122bf5e2 < -:  ---------- t6300: run describe atom tests on a different repo

-- 
2.41.0.378.g42703afc1f.dirty

