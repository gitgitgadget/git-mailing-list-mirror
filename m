Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F05C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiGUJH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGUJHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:07:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F42F641
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u5so1324839wrm.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1+BQ5GMy4JVPeFHTXYhceQjAziCNEo/WfOGP9G215w4=;
        b=A777EqH1nt3Rc4HhCVSF3K06VCz2xF8g7KDd8F1xSEYuZlx47OJ1aXgkuTV4+CqKTB
         4LSkquhcwjsn5EWS1FaizDUiNW+kpthe5iv62UTBTreIES34eVMe3qoYom3wrZosIfn1
         A2gFYZiha6JQeiFCIfTQoUZwamtW0BzDdD0XbumO+NQg62oLMue/jgp/ridddTkuXiiK
         QUB7yliGpgL3NAuRCfSJXDDt1D2Urxj1nVYpOm8/Pz0SxdpITSkM/wtlMyIKsYJmY93n
         mss9eQQVwJ/lOeU33iNU+kABSRwL4qChq/1KeXymIYHl/xKJOjAAw5cg5r7lwsyyaLbD
         IjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1+BQ5GMy4JVPeFHTXYhceQjAziCNEo/WfOGP9G215w4=;
        b=n/hWVIE8R680NDG0c+x6ro6CIBr+wAyUcXljy9GwaYWipR0hdQUIeN4eCu1hrumkE8
         K6uXxL6LbvhmJO5p/3AAVylp5xoIdLgnEdsik/p82QWJIq/kuS9Mum0npueEFytkWe5a
         tdf1M4jCtlZUXKQdEFI0GQIP4EQu1gdbl2671v3aW8RZibFaHGPkbwDg4hY15g3EBL7P
         pFFdk3KuCnztS76FlUcYDZS29y35/LNvbOxncM93jebobcnIxdP8/eY3ZbDXkyuTD7vB
         2UPEMONkNe6DYFXbIjhuH6TDH46YTqyS2TnpV/Lbmy5k/vKKlhvgruTFnZUOw5PFFGAz
         hvkQ==
X-Gm-Message-State: AJIora/pYo+LMvqjZXg77g1Bds+EJtQLGTukL+5f6yu3Au78zub3AvxU
        gC5HMPLfXI9HNn5wHdf+c5vuuM5iDDg=
X-Google-Smtp-Source: AGRyM1uhDViN8w3PQog+2JpAqn3QQC6ltYMAmSPz6bOyoovLEkFIewxZAILXB16F9UAFD7bqbBh7SA==
X-Received: by 2002:adf:d1e8:0:b0:21d:ddc1:3701 with SMTP id g8-20020adfd1e8000000b0021dddc13701mr23351982wrd.153.1658394442132;
        Thu, 21 Jul 2022 02:07:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm1195614wme.17.2022.07.21.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:07:21 -0700 (PDT)
Message-Id: <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
References: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
From:   "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:07:18 +0000
Subject: [PATCH v3 0/2] git-p4: Fix bug with encoding of P4 client name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Kilian Kilger <kkilger@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kilian Kilger (2):
  git-p4: fix bug with encoding of p4 client name
  git-p4: refactoring of p4CmdList()

 git-p4.py | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1285%2Fcohomology%2Fmaint-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1285/cohomology/maint-v3
Pull-Request: https://github.com/git/git/pull/1285

Range-diff vs v2:

 -:  ----------- > 1:  87e7809b75a git-p4: fix bug with encoding of p4 client name
 1:  3280a9579bc ! 2:  4a81423f0e8 git-p4: fix bug with encoding of p4 client name
     @@ Metadata
      Author: Kilian Kilger <kkilger@gmail.com>
      
       ## Commit message ##
     -    git-p4: fix bug with encoding of p4 client name
     +    git-p4: refactoring of p4CmdList()
      
     -    The Perforce client name can contain arbitrary characters
     -    which do not decode to UTF-8. Use the fallback strategy
     -    implemented in metadata_stream_to_writable_bytes() also
     -    for the client name.
     +    The function p4CmdList executes a Perforce command and
     +    decodes the marshalled python dictionary. Special care has to be
     +    taken for certain dictionary values which contain non-unicode characters.
     +    The old handling contained separate hacks for each of the corresponding
     +    dictionary keys. This commit tries to refactor the coding to handle the
     +    special cases uniformely.
      
          Signed-off-by: Kilian Kilger <kkilger@gmail.com>
      
     @@ git-p4.py: def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=F
                   if bytes is not str:
      -                # Decode unmarshalled dict to use str keys and values, except for:
      -                #   - `data` which may contain arbitrary binary data
     --                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
     +-                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
      -                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
      +                # Decode unmarshalled dict to use str keys and values. Special cases are handled below.
                       decoded_entry = {}
                       for key, value in entry.items():
                           key = key.decode()
     --                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
     +-                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
      +                    if isinstance(value, bytes) and p4KeyWhichCanBeDirectlyDecoded(key):
                               value = value.decode()
                           decoded_entry[key] = value
     @@ git-p4.py: def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=F
                           continue
      -            if 'desc' in entry:
      -                entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
     +-            if 'client' in entry:
     +-                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
      -            if 'FullName' in entry:
      -                entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
      +            for key in p4KeysContainingNonUtf8Chars():

-- 
gitgitgadget
