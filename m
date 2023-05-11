Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A87C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjEKVTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjEKVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8D2D5A
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063208beedso8710080f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839977; x=1686431977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5RseNApQA9vx71N0/1IO2iJmgskKormW8qPjYj4SeY=;
        b=iA5uz2nlHziHB1HJdDwXINjm7VZ+jqXN+UaXuCVnUxsdQGP2F3T90Kx0nPCT+ShIsJ
         rjsZVLQTs0hk2ec0LbwRqY9ov8Iiw+xN3byvJXP6JNFea+kXkboXgK82Djx6ilQVmJ54
         gUdLhFWBsBe1zmmdYEPmFBDng6GDjBr+lMiewGZULX5ZMJGa0XwncfEmfTYoMZ0muJfQ
         9maMXNjW/xF9G3eTCxzDDTjwfvTCFUeqje4oa/Pln/Zb85r4y0yguQ4youOoA6ZV+/t8
         UFfsFVyReG74em9AatTpefduEr6ZIOlQn5vhZq/cfnKUDR4BVfKr3EoJCO2lX9QTO0O2
         4JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839977; x=1686431977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5RseNApQA9vx71N0/1IO2iJmgskKormW8qPjYj4SeY=;
        b=SmBp5ykDgByNn4VlYsVV/1mJiYBCgguMaTmHCA47qwXCBKbq0fsXEneSbU95VrfYw+
         zKUBM/Re2LHbu51KthGpNbFFt12JIKvH2G3RSW9wSO/d5eE6NBM/zRmCWrQ1vkb7lpzt
         4iodS+JeQL7fkZMlfarjxOnjcXSGK2Bzm2m5knOogWoux8edyrWh82yGqtUtaDM50TpQ
         aGDVIo0FHrNJxdtqjICj9Z1Wj9yJNhcTdnUqXoWCoAYVRKkm+4N0ru9vsrOayBQdW0fZ
         /MpdU9T4pz29oWW1zBHbkjJharHHicIehw9qeDm4mpOE0K0u0qhAPR01RHTWwGNhAtVN
         NFow==
X-Gm-Message-State: AC+VfDxwcK3vYuNxsY+Dc+d1qvnJ1siFqeVgMMBjPalUFtTKvOzAm85W
        aHJvs4EgniiqJjdFjsV6JJXUuthD2QQ=
X-Google-Smtp-Source: ACHHUZ6F6CGt8N4d/S/CknKW2KLH7lV/Yn8eStWBCv28g0VgOVjbsPU8kb71js446bVFY4OTTMLVhA==
X-Received: by 2002:adf:dd87:0:b0:307:a52c:26b4 with SMTP id x7-20020adfdd87000000b00307a52c26b4mr7202220wrl.66.1683839976855;
        Thu, 11 May 2023 14:19:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d6650000000b003062c0ef959sm21282974wrw.69.2023.05.11.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:36 -0700 (PDT)
Message-Id: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:26 +0000
Subject: [PATCH v2 0/9] docs: interpret-trailers: reword and add examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes some small improvements to the docs for
git-interpret-trailers. The intent is to make it easier to read for
beginners who have never used this command before.


Changes from v1
===============

In order of significance:

 * The phrase "commit message part" has been removed.
 * The word "message" is always used as part of the bigger phrase "commit
   message".
 * Deprecation language for trailer.<token>.command has been updated to
   minimize whitespace churn, while also tweaking the 2nd paragraph to
   reduce duplication.
 * The phrase "Lorem ipsum..." is always only used to stand in for the body
   paragraph(s) of a commit message.
 * Grammar fixes have been squashed together (01+06 previously).

Linus Arver (9):
  doc: trailer: fix grammar
  doc: trailer: swap verb order
  doc: trailer: drop "commit message part" phrasing
  doc: trailer: examples: avoid the word "message" by itself
  doc: trailer: remove redundant phrasing
  doc: trailer: use angle brackets for <token> and <value>
  doc: trailer.<token>.command: emphasize deprecation
  doc: trailer: mention 'key' in DESCRIPTION
  doc: trailer: add more examples in DESCRIPTION

 Documentation/git-interpret-trailers.txt | 124 +++++++++++++----------
 1 file changed, 72 insertions(+), 52 deletions(-)


base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1506/listx/doc-trailer-v2
Pull-Request: https://github.com/git/git/pull/1506

Range-diff vs v1:

  1:  12d4850a9ab !  1:  65e6fbdec92 doc: trailer: fix grammar
     @@ Documentation/git-interpret-trailers.txt: SYNOPSIS
       DESCRIPTION
       -----------
      -Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
     -+Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
     ++Parse or add 'trailer' lines that look similar to RFC 822 e-mail
       headers, at the end of the otherwise free-form part of a commit
       message.
       
     +@@ Documentation/git-interpret-trailers.txt: for the same <token>, 'trailer.<token>.cmd' is used and
     + 'trailer.<token>.command' is ignored.
     + 
     + trailer.<token>.cmd::
     +-	This option can be used to specify a shell command that will be called:
     ++	This option can be used to specify a shell command that will be called
     + 	once to automatically add a trailer with the specified <token>, and then
     +-	each time a '--trailer <token>=<value>' argument to modify the <value> of
     +-	the trailer that this option would produce.
     ++	called each time a '--trailer <token>=<value>' argument is specified to
     ++	modify the <value> of the trailer that this option would produce.
     + +
     + When the specified command is first called to add a trailer
     + with the specified <token>, the behavior is as if a special
  2:  b7717424437 !  2:  82353471831 doc: trailer: swap verb order
     @@ Documentation/git-interpret-trailers.txt: SYNOPSIS
       
       DESCRIPTION
       -----------
     --Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
     -+Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
     +-Parse or add 'trailer' lines that look similar to RFC 822 e-mail
     ++Add or parse 'trailer' lines that look similar to RFC 822 e-mail
       headers, at the end of the otherwise free-form part of a commit
       message.
       
  3:  ad2d669eb0a <  -:  ----------- doc: trailer: --no-divider: more precise language
  4:  0c10e40794d <  -:  ----------- doc: trailer: explain "commit mesage part" on first usage
  -:  ----------- >  3:  5fabe166714 doc: trailer: drop "commit message part" phrasing
  -:  ----------- >  4:  783a0b1e003 doc: trailer: examples: avoid the word "message" by itself
  5:  5bad365c786 =  5:  dd7e29fcc21 doc: trailer: remove redundant phrasing
  6:  8e36d1bd1f0 <  -:  ----------- doc: trailer: trailer.<token>.cmd: add missing verb phrase
  7:  ab11527ca58 !  6:  96cb4ae2965 doc: trailer: use angle brackets for <token> and <value>
     @@ Commit message
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     -@@ Documentation/git-interpret-trailers.txt: space or the end of the line). Such three minus signs start the patch
     - part of the message. See also `--no-divider` below.
     +@@ Documentation/git-interpret-trailers.txt: non-whitespace lines before a line that starts with '---' (followed by a
     + space or the end of the line).
       
       When reading trailers, there can be no whitespace before or inside the
      -token, but any number of regular space and tab characters are allowed
     @@ Documentation/git-interpret-trailers.txt: space or the end of the line). Such th
       with each subsequent line starting with at least one whitespace, like
       the "folding" in RFC 822.
       
     +@@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
     + 	This option behaves in the same way as 'trailer.<token>.cmd', except
     + 	that it doesn't pass anything as argument to the specified command.
     + 	Instead the first occurrence of substring $ARG is replaced by the
     +-	value that would be passed as argument.
     ++	<value> that would be passed as argument.
     + +
     + The 'trailer.<token>.command' option has been deprecated in favor of
     + 'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
  8:  59804321793 !  7:  4e234110ffd doc: trailer.<token>.command: refer to existing example
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    doc: trailer.<token>.command: refer to existing example
     +    doc: trailer.<token>.command: emphasize deprecation
     +
     +    This puts the deprecation notice up front, instead of leaving it to the
     +    next paragraph.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.ifmissing::
       	that option for trailers with the specified <token>.
       
       trailer.<token>.command::
     --	This option behaves in the same way as 'trailer.<token>.cmd', except
     --	that it doesn't pass anything as argument to the specified command.
     --	Instead the first occurrence of substring $ARG is replaced by the
     --	value that would be passed as argument.
     -+	This option behaves in the
     -+	same way as 'trailer.<token>.cmd', except that it doesn't pass anything as
     -+	argument to the specified command. Instead the first occurrence of substring
     -+	$ARG is replaced by the <value> from the trailer. See the
     -+	'trailer.see.command' trailer example in the "EXAMPLES" section below.
     ++	Deprecated in favor of 'trailer.<token>.cmd'.
     + 	This option behaves in the same way as 'trailer.<token>.cmd', except
     + 	that it doesn't pass anything as argument to the specified command.
     + 	Instead the first occurrence of substring $ARG is replaced by the
     + 	<value> that would be passed as argument.
     + +
     +-The 'trailer.<token>.command' option has been deprecated in favor of
     +-'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
     ++Note that $ARG in the user's command is
     + only replaced once and that the original way of replacing $ARG is not safe.
       +
     - The 'trailer.<token>.command' option has been deprecated in favor of
     - 'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
     + When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
  9:  1ac58b0b07c <  -:  ----------- doc: trailer.<token>.command: emphasize deprecation
 10:  2c04a5ba7f0 =  8:  8aaf9e27d98 doc: trailer: mention 'key' in DESCRIPTION
 11:  ea483b364b4 !  9:  7e95198894b doc: trailer: add more examples in DESCRIPTION
     @@ Commit message
       ## Documentation/git-interpret-trailers.txt ##
      @@ Documentation/git-interpret-trailers.txt: DESCRIPTION
       -----------
     - Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
     + Add or parse 'trailer' lines that look similar to RFC 822 e-mail
       headers, at the end of the otherwise free-form part of a commit
      -message.
      +message. For example, in the following commit message
     @@ Documentation/git-interpret-trailers.txt: DESCRIPTION
      +------------------------------------------------
      +subject
      +
     -+message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      +
      +Signed-off-by: Alice <alice@example.com>
      +Signed-off-by: Bob <bob@example.com>
     @@ Documentation/git-interpret-trailers.txt: DESCRIPTION
      +
      +the last two lines starting with "Signed-off-by" are trailers.
       
     - This command reads some patches or commit messages from either the
     - <file> arguments or the standard input if no <file> is specified. If
     + This command reads commit messages from either the
     + <file> arguments or the standard input if no <file> is specified.
      @@ Documentation/git-interpret-trailers.txt: When reading trailers, there can be no whitespace before or inside the
       between the <token> and the separator. There can be whitespaces before,
       inside or after the <value>. The <value> may be split over multiple lines
     @@ Documentation/git-interpret-trailers.txt: When reading trailers, there can be no
      +the "folding" in RFC 822. Example:
      +
      +------------------------------------------------
     -+token: Lorem ipsum dolor sit amet, consectetur
     -+  adipiscing elit.
     ++token: This is a very long value, with spaces and
     ++  newlines in it.
      +------------------------------------------------
       
       Note that trailers do not follow (nor are they intended to follow) many of the

-- 
gitgitgadget
