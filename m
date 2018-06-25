Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092691F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeFYSxi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:53:38 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36654 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964861AbeFYSxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:53:37 -0400
Received: by mail-it0-f74.google.com with SMTP id d70-v6so8740261itd.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SgwCf8MLD5CgT6j3EVh3MxyxirIQkzYNvoE7xvlhD1w=;
        b=Ae7baBptKea3vbaadQGXYyx9rMNkcq39UvlFyAN2W77a3eQf+AHNkN26CEBNSZjXW3
         hpU1Uf8V6LH1M0YEbhg8s2fgbb2e9okfwKdXxCQ6bv8O9lf+4KFx0u3l63vc+3TPj6/L
         xLTXLYtFurmBDUX4eGZKqihemeVVRUFrhvUijghzIEdQMVNSUA4KyZunWfdnCUGrzvoC
         CR8HeHF+DOjQdDE+EB4vF/S+3J/RqGQy31BOSyI2TIU8bdWk2Npl+G0o0yF2VUaqnRzs
         kZIrKuGQi8+Io8C/BQmaBCYdrhALsi8nVJwZ4nkXw0TXMtN+dtEoO4yClSutbzdv5iwW
         CgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SgwCf8MLD5CgT6j3EVh3MxyxirIQkzYNvoE7xvlhD1w=;
        b=bPp1VVc1Amq5VoCP1izpBfx1zUeUEUWS4997shwWnMy/4SIMbmp1wy8Fv0YqUtf05x
         2YTaGvq6DuVQnHipOmJeTFxkwRs/n8GbdMf5D2Ju0WSnzuzu9kw6t0gwtYt4fObVWJE/
         XkUrT2uRFO7gFfnsUap05hFSmyevuszo6wjzUvqIW8kVpUwKWQxf0VMPVIiaoxmM9jv6
         YvGHHUWII+KnedRretKmM4D9fe9s0gw8TML2sVcYFJw8DAuEcnVYVVieoS5Pzf9V18+N
         stpYTgKu64Sg0mzWoFnVN0fZoPaDuYH1+7x6JQJZUkq34XJcVCYYjlHjd8zDSMNw2YnC
         s/2w==
X-Gm-Message-State: APt69E0mRUcHE4iZk3T5JaL/kIh0cf9psOlv5vbLPQm5HEd/gYmPRF1r
        x8zwFxWfCRKQe9Ih0dmUIJnjS1aqhT8VXEJ3j+guwp0mIOa8B4YgcxJ24fTYNUrYvCMCvipQ9OK
        ikAZd7fZcvLSKoG2x8FvFcR4P1mlEi8Xv0ZON+5GkmXc2IIHw05C5jpTSDw==
X-Google-Smtp-Source: AAOMgpfHpt7mtqTnwrBLgn9Hy76Y+sobrSONxx0kceugjCEQuG64fkmWEmEi1zrl+IhnsQcu2Lfh3H2zHtE=
MIME-Version: 1.0
X-Received: by 2002:a24:7a05:: with SMTP id a5-v6mr873471itc.19.1529952817005;
 Mon, 25 Jun 2018 11:53:37 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:53:24 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180625185332.164142-1-bmwill@google.com>
References: <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v4 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v4 are fairly minor.  There are a few documentation changes,
commit message updates, as well as a few small style tweaks based on
reviewer comments.

Brandon Williams (8):
  test-pkt-line: add unpack-sideband subcommand
  upload-pack: implement ref-in-want
  upload-pack: test negotiation with changing repository
  fetch: refactor the population of peer ref OIDs
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in output parameter
  fetch-pack: implement ref-in-want

 Documentation/config.txt                |   7 +
 Documentation/technical/protocol-v2.txt |  28 ++-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 135 ++++++++-----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  50 ++++-
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  33 ++++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/one-time-sed.sh             |  16 ++
 t/t5703-upload-pack-ref-in-want.sh      | 245 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 +++-
 transport.h                             |   3 +-
 upload-pack.c                           |  66 +++++++
 18 files changed, 574 insertions(+), 75 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.18.0.rc2.346.g013aa6912e-goog

