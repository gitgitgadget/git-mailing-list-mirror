Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72FC77B60
	for <git@archiver.kernel.org>; Mon,  1 May 2023 02:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjEACf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEACfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 22:35:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19AE41
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 19:35:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so2072141a91.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682908551; x=1685500551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ4+8XQt8hwX7R0akiH5XzcjHQKJHCb0evhvskWjbsw=;
        b=irB6IbtFxkimWFeS53HhXdt6vP4HaGKP383ApQLRp39P3NiO8ydaVqw4dlRl2BkWtY
         wpKjMqket5q9ms7xfEmcRxGdJFwyMW0kKKbfedxombRL1UPTSTYsH++hMt88FzgY1eum
         +HfKbM81M9/dc8v57Un64hduFntRv8UDQyHwmfDYy5+vjbASkNVSeuYvSg9FKp19+fnq
         iOLzoz5D/vXQqTyj+qeuaO1vwz8nKZGqJcVF/XSizt36w93wyxKmhG33m0XuMM8F8ccC
         OCHlaaebPSUPCIJvyakUA1bCmxMCAuj7m1UbOW65r3fQeIJuJU/Q2zCMz1hUqkwJ2I8e
         PI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682908551; x=1685500551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ4+8XQt8hwX7R0akiH5XzcjHQKJHCb0evhvskWjbsw=;
        b=d81AsVSQxhaTN+3UkD/mXi9cJ7mNTx3sy0VoD1PuzXFvfdqy6S75B0Iwjs9DBpolLs
         5aCOuklTej1e2EGl1hHvNaW6wnNpWdmQHXhtcmqGOCCM8L2Y/RcjucOcIuq53GP/VBHb
         MWL03IvbFkV0ppvYQRoL4oeOcqIpV0I3YNFk7zM9UODHUieClOlgT01JHXw9gu410w7e
         JemXMr7ENuUBYR/95kTP/yfjZVy8275aHT3ZNmCWieHs/Dv9s8iVj/nZUIRrC8pcVg7c
         5czei7+L4req9LK3Zh+pLo/ZBzgI7bT5/e1jkDCMbSwJdKIkKTzsnQANcK0whfnPqa41
         uvUg==
X-Gm-Message-State: AC+VfDxRgu50p/jBAY1UJ9B7SvvheVew8Mg+K4HCJi809QaDTTlWkdCE
        OVymZSyMZ7Zpq+F/mncblC7G9gttpUI=
X-Google-Smtp-Source: ACHHUZ7Q3EX6gNqvOzyUs853FEhXAWsG5841RIhYXZiRsww6BxIk01DrYOWLo4VNTqqmjjR6ZpM5oA==
X-Received: by 2002:a17:90b:218:b0:24b:3dea:d922 with SMTP id fy24-20020a17090b021800b0024b3dead922mr13345757pjb.20.1682908551441;
        Sun, 30 Apr 2023 19:35:51 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090a639000b0023d0c2f39f2sm18011394pjj.19.2023.04.30.19.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:35:50 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 0/1] docs: rewrite the documentation of the text and eol attributes
Date:   Sun, 30 Apr 2023 20:35:32 -0600
Message-Id: <20230501023533.35370-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:
- Correct incorrect statement in commit message about dependence of
  `eol` on `text`
- Use "normalize" to refer to conversion to LF, and "convert" for
  conversion from LF
- Add Helped-by line
- Reduce wordiness/redundancy
- Add Junio's suggested phrasing to introduce `eol`

Alex Henrie (1):
  docs: rewrite the documentation of the text and eol attributes

 Documentation/gitattributes.txt | 60 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 28 deletions(-)

Range-diff against v2:
1:  446fb632a5 ! 1:  3d5985bc28 docs: rewrite the documentation of the text and eol attributes
    @@ Commit message
         does not do anything to the line endings either.
     
         On top of that, in several places the documentation for the eol
    -    attribute sounds like it can force normalization on checkin and checkout
    -    all by itself, but eol doesn't control normalization on checkin and
    -    doesn't control normalization on checkout either unless accompanied by
    -    the text attribute.
    +    attribute sounds like it can turn on normalization on checkin, but eol
    +    only controls conversion on checkout. It also sounds like setting eol
    +    (or setting a config variable) is required to turn on conversion on
    +    checkout, but the text attribute can turn on conversion on checkout by
    +    itself if eol is unspecified.
     
         Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
         to be clear about how they are the same, how they are different, and in
    -    what cases normalization is performed.
    +    what cases conversion is performed.
     
    +    Helped-by: Torsten Bögershausen <tboegi@web.de>
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
      ## Documentation/gitattributes.txt ##
     @@ Documentation/gitattributes.txt: repository upon 'git add' and 'git commit'.
    @@ Documentation/gitattributes.txt: repository upon 'git add' and 'git commit'.
     -`core.eol` (see the definitions of those options in
     -linkgit:git-config[1]).
     +This attribute marks the path as a text file, which enables end-of-line
    -+normalization on checkin and possibly also checkout: When a matching
    -+file is added to the index, even if it has CRLF line endings in the
    -+working directory, the file is stored in the index with LF line endings.
    -+Conversely, when the file is copied from the index to the working
    -+directory, its line endings may be converted from LF to CRLF depending
    -+on the `eol` attribute, the Git config, and the platform (see
    -+explanation of `eol` below).
    ++conversion: When a matching file is added to the index, the file's line
    ++endings are normalized to LF in the index.  Conversely, when the file is
    ++copied from the index to the working directory, its line endings may be
    ++converted from LF to CRLF depending on the `eol` attribute, the Git
    ++config, and the platform (see explanation of `eol` below).
      
      Set::
      
      	Setting the `text` attribute on a path enables end-of-line
     -	normalization and marks the path as a text file.  End-of-line
     -	conversion takes place without guessing the content type.
    -+	normalization on checkin and checkout as described above.  Line
    -+	endings are normalized in the index the next time the file is
    -+	checked in, even if the file was previously added to Git with CRLF
    -+	line endings.
    ++	conversion on checkin and checkout as described above.  Line endings
    ++	are normalized to LF in the index every time the file is checked in,
    ++	even if the file was previously added to Git with CRLF line endings.
      
      Unset::
      
    @@ Documentation/gitattributes.txt: Unset::
      Unspecified::
      
     @@ Documentation/gitattributes.txt: unspecified.
    - This attribute sets a specific line-ending style to be used in the
    - working directory.  This attribute has effect only if the `text`
    - attribute is set or unspecified, or if it is set to `auto`, the file is
    + `eol`
    + ^^^^^
    + 
    +-This attribute sets a specific line-ending style to be used in the
    +-working directory.  This attribute has effect only if the `text`
    +-attribute is set or unspecified, or if it is set to `auto`, the file is
     -detected as text, and it is stored with LF endings in the index.  Note
     -that setting this attribute on paths which are in the index with CRLF
     -line endings may make the paths to be considered dirty unless
     -`text=auto` is set. Adding the path to the index again will normalize
     -the line endings in the index.
    -+detected as text, and it is stored with LF endings in the index.
    ++This attribute marks a path to use a specific line-ending style in the
    ++working tree when it is checked out.  This attribute has effect only if
    ++the `text` attribute is set or unspecified, or if it is set to `auto`,
    ++the file is detected as text, and it is stored with LF endings in the
    ++index.
      
      Set to string value "crlf"::
      
    @@ Documentation/gitattributes.txt: unspecified.
     -	checkin and prevents conversion to CRLF when the file is
     -	checked out.
     +	This setting uses the same line endings in the working directory as
    -+	in the index, whether they are LF or CRLF.  However, unless
    -+	`text=auto`, adding the file to the index again will normalize its
    -+	line endings to LF in the index.
    ++	in the index when the file is checked out.
     +
     +Unspecified::
     +
-- 
2.40.1

