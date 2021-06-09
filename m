Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D9C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AC561285
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhFIN5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:57:37 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:41901 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhFIN5f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:57:35 -0400
Received: by mail-wm1-f43.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so4314495wmq.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wG/w35u3EOZYI0XoPXayo2ICdelEA3iHm7axAAgQ+zM=;
        b=lmola7qdlkd6f+0gcenkCYpohx6Rj0FsvhCVWPu866DaHbSu2j7Dkrz9pHXmrnxKv6
         Nrc5qniLWo9CNmFHU+JdL3TjhsVPAEEl6Gck0mk1eH6n/yjHfxEJppeHBTlNJlLnaKd4
         dt7UpxtuDITpAFYHUDqBs+KckWvief8I2i/p4aR8TP1Kfy8wEQce5hgUCRucd5aLpbQx
         o+S3rKZmgHPBgtS6WPEikjruWjvSDZyQLPZ4BeJy+AC0eCy2X/zk1yl6eYqxxpuMWfCC
         PDMp6BpT8FuZo6IfwhC9hmFpD0I2lvFtwnIKdqxLllBnDV4y+otdNFO06eNOikvP0rIr
         KBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wG/w35u3EOZYI0XoPXayo2ICdelEA3iHm7axAAgQ+zM=;
        b=Pj7zUYJ1L6RPhtrv3Uh1y/LAMHZMCGcOIAnSvUsOcgbGQKGgXll+/JHdfg+HYyfMLi
         9YGf9ohGSgtEX37lPy3P4HxGEuYc4Ki438AcRtZK2c3JaoCiJ2WwpJ1Tp1DnXwJCzlp3
         AM8eM2GHXsnkJF7wEMW49u7sqJTqOPl/LgqxNtPTPFscwO3uFotqO+yPMbjVXl7TuSHk
         RDadBCr/6qRU0gpuA4AqLlwDyHxgMYcKqachCkPuWFU8wfTjsKhje7TWOUrXab8gWNLd
         gfEO2ULGLxTcBBK47Wu3q7ip4jaqGS9gRNgWtZCt5zjmg7TElUgBrsSN5mdRLyDRPY0P
         /Oyw==
X-Gm-Message-State: AOAM531O48+ngj5wA3C6DxN4d0wAtU5fOYkMXioO41iA54bt2NqXGo6q
        AatVMenRKs/8d7A33O+/5mSvWMwUYYc=
X-Google-Smtp-Source: ABdhPJx0mTq4BzS7JcSfj+kM7VZ1bmhxn7Ft5cRuwNbbRXWfy3z9RJa1V3+mp8XJpvHcbXz7J8jc4g==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr10228242wmq.4.1623246880281;
        Wed, 09 Jun 2021 06:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm17266802wmq.14.2021.06.09.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:54:39 -0700 (PDT)
Message-Id: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 13:54:34 +0000
Subject: [PATCH v2 0/4] Use singular "they" when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In another topic, I claimed [1] that singular "they" was better than
"he/she" for gender neutrality.

[1]
https://lore.kernel.org/git/44d937a0-e876-e185-f409-a4fd61eae580@gmail.com/

The fact that singular "they" is less awkward to write and read seemed
obvious to me, so I did not back up my statement with any references or
reasons. The ensuing discussion did include reasons, especially brian m.
carlson's thoughtful message [2].

[2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/

This patch series officially adopts singular "they" as a contributor
guideline; see Patch 4 for the change to the guidelines and the reasoning
for the change. Before modifying the guidelines, documentation and comments
are updated to not use gendered pronouns, which provides examples of how to
use it.

I would appreciate ACKs in support on patch 4.


Updates in v2
=============

 * Some edits were removed because they were in contrib/ or
   Documentation/howto/ and these are now listed as exclusions in the
   message of Patch 4.

 * Several recommendations to improve the edits in the documentation and
   code comments were incorporated. Those who recommended these edits are
   credited with "Helped-by" tags.

 * The URLs in Patch 4 had overlapping citation numbers. This is fixed.

Thanks, -Stolee

Derrick Stolee (4):
  Documentation: use singular they when appropriate
  *: use singular they in comments
  *: fix typos
  CodingGuidelines: recommend singular they

 Documentation/CodingGuidelines  | 7 +++++++
 Documentation/SubmittingPatches | 8 ++++----
 Documentation/git-push.txt      | 4 ++--
 Documentation/user-manual.txt   | 2 +-
 commit.c                        | 2 +-
 config.c                        | 2 +-
 config.h                        | 2 +-
 date.c                          | 2 +-
 pathspec.h                      | 2 +-
 strbuf.h                        | 2 +-
 t/t9300-fast-import.sh          | 2 +-
 wt-status.c                     | 2 +-
 12 files changed, 22 insertions(+), 15 deletions(-)


base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-975%2Fderrickstolee%2Fthey-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-975/derrickstolee/they-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/975

Range-diff vs v1:

 1:  afc51c5e6ede ! 1:  fb7a7573782a Documentation: use singular they when appropriate
     @@ Commit message
          Replace these uses with "they/them" to ensure that these documentation
          examples apply to all potential users without exception.
      
     +    Helped-by: Richard Kerry <richard.kerry@atos.net>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/SubmittingPatches ##
      @@ Documentation/SubmittingPatches: If you like, you can put extra tags at the end:
     +   the patch attempts to fix.
       . `Acked-by:` says that the person who is more familiar with the area
         the patch attempts to modify liked the patch.
     - . `Reviewed-by:`, unlike the other tags, can only be offered by the
     +-. `Reviewed-by:`, unlike the other tags, can only be offered by the
      -  reviewer and means that she is completely satisfied that the patch
     -+  reviewer and means that they are completely satisfied that the patch
     -   is ready for application.  It is usually offered only after a
     -   detailed review.
     +-  is ready for application.  It is usually offered only after a
     +-  detailed review.
     ++. `Reviewed-by:`, unlike the other tags, can only be offered by a
     ++  reviewer when they are completely satisfied with the patch.  It is
     ++  offered only after reviews by reviewers who are known to be experts
     ++  in the affected area by the community members.
       . `Tested-by:` is used to indicate that the person applied the patch
     +   and found it to have the desired effect.
     + 
      
       ## Documentation/git-push.txt ##
      @@ Documentation/git-push.txt: Imagine that you have to rebase what you have already published.
     @@ Documentation/git-push.txt: Imagine that you have to rebase what you have alread
       This option allows you to say that you expect the history you are
       updating is what you rebased and want to replace. If the remote ref
      
     - ## Documentation/howto/using-signed-tag-in-pull-request.txt ##
     -@@
     - From: Junio C Hamano <gitster@pobox.com>
     - Date: Tue, 17 Jan 2011 13:00:00 -0800
     - Subject: Using signed tag in pull requests
     --Abstract: Beginning v1.7.9, a contributor can push a signed tag to her
     -- publishing repository and ask her integrator to pull it. This assures the
     -+Abstract: Beginning v1.7.9, a contributor can push a signed tag to their
     -+ publishing repository and ask their integrator to pull it. This assures the
     -  integrator that the pulled history is authentic and allows others to
     -  later validate it.
     - Content-type: text/asciidoc
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: How to use a signed tag in pull requests
     - ========================================
     - 
     - A typical distributed workflow using Git is for a contributor to fork a
     --project, build on it, publish the result to her public repository, and ask
     --the "upstream" person (often the owner of the project where she forked
     --from) to pull from her public repository. Requesting such a "pull" is made
     -+project, build on it, publish the result to their public repository, and ask
     -+the "upstream" person (often the owner of the project where they forked
     -+from) to pull from their public repository. Requesting such a "pull" is made
     - easy by the `git request-pull` command.
     - 
     - Earlier, a typical pull request may have started like this:
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: followed by a shortlog of the changes and a diffstat.
     - 
     - The request was for a branch name (e.g. `for-xyzzy`) in the public
     - repository of the contributor, and even though it stated where the
     --contributor forked her work from, the message did not say anything about
     -+contributor forked their work from, the message did not say anything about
     - the commit to expect at the tip of the for-xyzzy branch. If the site that
     - hosts the public repository of the contributor cannot be fully trusted, it
     - was unnecessarily hard to make sure what was pulled by the integrator was
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: integrator, using Git v1.7.9 or later.
     - A contributor or a lieutenant
     - -----------------------------
     - 
     --After preparing her work to be pulled, the contributor uses `git tag -s`
     -+After preparing their work to be pulled, the contributor uses `git tag -s`
     - to create a signed tag:
     - 
     - ------------
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: to justify why it is worthwhile for the integrator to pull it, as this
     - message will eventually become part of the final history after the
     - integrator responds to the pull request (as we will see later).
     - 
     --Then she pushes the tag out to her public repository:
     -+Then they push the tag out to their public repository:
     - 
     - ------------
     -  $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: The contributor then prepares a message to request a "pull":
     - 
     - The arguments are:
     - 
     --. the version of the integrator's commit the contributor based her work on;
     --. the URL of the repository, to which the contributor has pushed what she
     --  wants to get pulled; and
     --. the name of the tag the contributor wants to get pulled (earlier, she could
     -+. the version of the integrator's commit the contributor based their work on;
     -+. the URL of the repository, to which the contributor has pushed what they
     -+  want to get pulled; and
     -+. the name of the tag the contributor wants to get pulled (earlier, they could
     -   write only a branch name here).
     - 
     - The resulting msg.txt file begins like so:
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: command, the reader should notice that:
     - 
     - The latter is why the contributor would want to justify why pulling her
     - work is worthwhile when creating the signed tag.  The contributor then
     --opens her favorite MUA, reads msg.txt, edits and sends it to her upstream
     -+opens their favorite MUA, reads msg.txt, edits and sends it to their upstream
     - integrator.
     - 
     - 
     -@@ Documentation/howto/using-signed-tag-in-pull-request.txt: In the editor, the integrator will see something like this:
     - 
     - Notice that the message recorded in the signed tag "Completed frotz
     - feature" appears here, and again that is why it is important for the
     --contributor to explain her work well when creating the signed tag.
     -+contributor to explain their work well when creating the signed tag.
     - 
     - As usual, the lines commented with `#` are stripped out. The resulting
     - commit records the signed tag used for this validation in a hidden field
     - so that it can later be used by others to audit the history. There is no
     --need for the integrator to keep a separate copy of the tag in his
     -+need for the integrator to keep a separate copy of the tag in their
     - repository (i.e. `git tag -l` won't list the `frotz-for-xyzzy` tag in the
     --above example), and there is no need to publish the tag to his public
     -+above example), and there is no need to publish the tag to their public
     - repository, either.
     - 
     --After the integrator responds to the pull request and her work becomes
     -+After the integrator responds to the pull request and their work becomes
     - part of the permanent history, the contributor can remove the tag from
     --her public repository, if she chooses, in order to keep the tag namespace
     --of her public repository clean, with:
     -+their public repository, if they choose, in order to keep the tag namespace
     -+of their public repository clean, with:
     - 
     - ------------
     -  $ git push example.com:/git/froboz.git :frotz-for-xyzzy
     -
       ## Documentation/user-manual.txt ##
      @@ Documentation/user-manual.txt: A fast-forward looks something like this:
       
 2:  b36e3f99716b ! 2:  f611603718ab *: use singular they in comments
     @@ Commit message
          Replace these uses with "they/them" which universally includes all
          potential readers.
      
     +    Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit.c ##
     @@ commit.c: static void handle_signed_tag(struct commit *parent, struct commit_ext
       	 * We could verify this signature and either omit the tag when
       	 * it does not validate, but the integrator may not have the
      -	 * public key of the signer of the tag he is merging, while a
     -+	 * public key of the signer of the tag they are merging, while a
     ++	 * public key of the signer of the tag being merged, while a
       	 * later auditor may have it while auditing, so let's not run
       	 * verify-signed-buffer here for now...
       	 *
     @@ config.h: void git_configset_init(struct config_set *cs);
        */
       int git_configset_add_file(struct config_set *cs, const char *filename);
      
     - ## contrib/hooks/multimail/git_multimail.py ##
     -@@ contrib/hooks/multimail/git_multimail.py: class GitoliteEnvironmentLowPrecMixin(
     -     def get_repo_shortname(self):
     -         # The gitolite environment variable $GL_REPO is a pretty good
     -         # repo_shortname (though it's probably not as good as a value
     --        # the user might have explicitly put in his config).
     -+        # the user might have explicitly put in their config).
     -         return (
     -             self.osenv.get('GL_REPO', None) or
     -             super(GitoliteEnvironmentLowPrecMixin, self).get_repo_shortname()
     -@@ contrib/hooks/multimail/git_multimail.py: def get_pusher(self):
     -                 # __submitter into an RFC 2822 string already.
     -                 return re.match(r'(.*?)\s*<', self.__submitter).group(1)
     -             else:
     --                # Submitter has no configured email, it's just his name.
     -+                # Submitter has no configured email, it's just their name.
     -                 return self.__submitter
     -         else:
     -             # If we arrive here, this means someone pushed "Submit" from
     -
       ## date.c ##
      @@ date.c: int parse_expiry_date(const char *date, timestamp_t *timestamp)
       		/*
 3:  c40ad4a058a7 = 3:  feecbd7a0c6e *: fix typos
 4:  d2c079264955 ! 4:  065e2fdeb151 CodingGuidelines: recommend singular they
     @@ Commit message
      
          To futher justify singular "they" as an acceptable grammatical concept,
          I include the careful research of brian m. carlson who collected their
     -    thoughts on this matter [2] (lightly edited):
     +    thoughts on this matter [4] (lightly edited):
      
            Singular "they" has been used by native English speakers as part of
            the language for over half a millennium and is widely used and
     -      understood. This usage is specified in Merriam Webster[3]:
     +      understood. This usage is specified in Merriam Webster[5]:
      
              The use of they, their, them, and themselves as pronouns of
              indefinite gender and indefinite number is well established in
              speech and writing, even in literary and formal contexts.
      
     -      Wiktionary notes[4] (references omitted):
     +      Wiktionary notes[6] (references omitted):
      
              Usage of they as a singular pronoun began in the 1300s and has been
              common ever since, despite attempts by some grammarians, beginning
     @@ Commit message
            linguists, we should probably consider using the language that most
            people will use in this context.
      
     -    [2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
     -    [3] https://www.merriam-webster.com/dictionary/they
     -    [4] https://en.wiktionary.org/wiki/they
     +    [4] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
     +    [5] https://www.merriam-webster.com/dictionary/they
     +    [6] https://en.wiktionary.org/wiki/they
     +
     +    Since singular "they" might be unfamiliar to some, we also list an
     +    option to rephrase writing to use singular "you" or plural "they". We
     +    can use singular "you" to refer to the reader instead of an abstract
     +    user. Plural "they" works if we refer to multiple abstract users instead
     +    of one. The English language does not have gendered versions of these
     +    terms.
      
          If we refer to a specific person, then using a gendered pronoun is
     -    appropriate. Examples within the Git codebase include:
     +    appropriate. There can also be other cases where it is inappropriate for
     +    us to update the existing examples within the Git codebase, such as:
      
          * References to real people (e.g. Linus Torvalds, "the Git maintainer").
            Do not misgender real people. If there is any doubt to the gender of a
     @@ Commit message
            modifying the license this way is not within the scope of the Git
            project.
      
     +    * Literal email messages in Documentation/howto/ should not be edited
     +      for grammatical concerns such as this, unless we update the entire
     +      document to fit the standard documentation format. If such an effort is
     +      taken on, then the authorship would change and no longer refer to the
     +      exact mail message.
     +
     +    * External projects consumed in contrib/ should not deviate solely for
     +      style reasons. Recommended edits should be contributed to those
     +      projects directly.
     +
          Other cases within the Git project were cleaned up by the previous
          changes.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/CodingGuidelines ##
     @@ Documentation/CodingGuidelines: Writing Documentation:
        the former, the part that should not get substituted must be
        quoted/escaped.
      +
     -+ When referring to an anonymous user, use singular "they/them" pronouns
     -+ as opposed to choosing between "he/him" and "she/her". Do not use more
     -+ complicated constructs such as "he or she" or "s/he". This recommendation
     -+ also applies to code comments and commit messages.
     ++ Refer to an anonymous user in a gender neutral way. Singular "they/them"
     ++ pronouns are preferred over "he/him" and "she/her". Do not use more
     ++ complicated constructs such as "he or she" or "s/he". When in doubt about
     ++ how to use this pronoun, then change your sentence to use singular "you"
     ++ (e.g. "When you want to do X, do Y") or plural "they" (e.g. "When users
     ++ want to do X, they can do Y.").

-- 
gitgitgadget
