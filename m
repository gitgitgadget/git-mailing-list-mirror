Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F24A1F516
	for <e@80x24.org>; Sat, 23 Jun 2018 02:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934741AbeFWCmw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 22:42:52 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38557 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934625AbeFWCmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 22:42:51 -0400
Received: by mail-wr0-f169.google.com with SMTP id e18-v6so8354539wrs.5
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 19:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=OtmEb32+7pOtw50e6snu2BY16TegoqQ0eaQVPvUTMpA=;
        b=M+XmB2LXS6Fh9ShjEB7KwHVH9LolEyWJ0v5cE7nBnABx1QeHslm8yTh26iyKfIOWTZ
         54hrFrQQTQTJOV+G2nt9wQaWmvZQwwVg8zeunmy9bdt7js1e+AtXJc9SeYsBKGZvL6eZ
         VqcfEeDPbFXKaFAOe7xBMSzAbwjtUMGtkkTClZfBhtGDtMehGgo3HdP92WeHHv3Keam8
         JaZZMHyUQIRKZStcEQL06J+uHFcfBqJirf+jLFdSW2eKXSGV2BvpDa6VnpNHuR8qP5p7
         cXKYrpDZLI76DQBiDxEPP+uKFtkPW6ySPTDkscwIPhYACW8Q1NedtdxmSYN8rEhGoPaq
         gKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OtmEb32+7pOtw50e6snu2BY16TegoqQ0eaQVPvUTMpA=;
        b=tAKqs5t6gQf5d15Q4v28i1sroEqcS+hxEf2eYO9Qi1u3Pf1afrSYxVAaQrDzIsomiz
         fiRuxJ7QRCkd4b7DQlq6yO1ZyTdbHCI6UR2utxq2kBsd+GEAMOiw3lLU8WGltWM8uEcI
         EHcL7IbzEGZZGrIinoj8BPwg786QBfeHIybt2kfLiyXmztjmYgWBJCKASgb7OQRnjmM0
         aj/bPpjAwgc1wu8el7rbizS5n1oJCQj4uT1qKouDPuQvAOs8VDP8NGg4XNCmTdSi06Jb
         l4cQm0v38kz58lyfo1inst6P4+tBl6AI9nUEewYC+H5ZFaHW8TaRGWotUN0A6Vf85YGr
         hCfA==
X-Gm-Message-State: APt69E3WHHKGB+R7hncbNw3zjzZ4gxh7GQqi8RZmnEyBjl23yKO/dqcG
        npVHK1N1p6x15pkmpZA3a/jjCA+DjEoDLA5SazOoh+ry
X-Google-Smtp-Source: AAOMgpfJ9z2IGPfKqF6bnevm9ueaDqfmbprK4yELNatuQyxpBSy15crLkfD0EG3cMPMLReyY2S5IF8S1SoyinD7GZhY=
X-Received: by 2002:adf:de82:: with SMTP id w2-v6mr3657123wrl.88.1529721769983;
 Fri, 22 Jun 2018 19:42:49 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Fri, 22 Jun 2018 19:42:38 -0700
Message-ID: <CA+dzEB=RNqpduF+hx-y6HMeQYpSKJrBqx_pSu_MS3yDa7JHsww@mail.gmail.com>
Subject: ^D to credentials prompt results in "fatal: ... Success"
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bit of an amusing edge case.

I'm not exactly sure the correct approach to fix this but here's my
reproduction, triage, and a few potential options I see.

Note that after the username prompt, I pressed ^D

$./prefix/bin/git --version
git version 2.18.0
$ PATH=$PWD/prefix/bin:$PATH git clone
https://github.com/asottile/this-does-not-exist-i-promise
Cloning into 'this-does-not-exist-i-promise'...
Username for 'https://github.com': fatal: could not read Username for
'https://github.com': Success

Looking at `prompt.c`, it's hitting this bit of code:

        if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
            r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
            err = strerror(errno);
        } else {
            err = "terminal prompts disabled";

        }
        if (!r) {
            /* prompts already contain ": " at the end */
            die("could not read %s%s", prompt, err);
        }

From `git_terminal_prompt` (compat/terminal.c):

    r = strbuf_getline_lf(&buf, input_fh);
    if (!echo) {
        putc('\n', output_fh);
        fflush(output_fh);
    }

    restore_term();
    fclose(input_fh);
    fclose(output_fh);

    if (r == EOF)
        return NULL;
    return buf.buf;


in the `EOF` case, this is returning `NULL`, but `errno = 0` at this
point causing the error string to be "Success"

I see a couple of options here:

1. special case EOF in `git_terminal_prompt` / `git_prompt` and
produce an error message such as:

fatal: could not read Username for 'https://github.com': EOF

(I tried returing `EOF` directly from `git_terminal_prompt` and was
able to get this messaging to work, however `r == EOF` is a
pointer-int comparison so this approach didn't really seem like a good
idea -- changing the signature of `git_terminal_prompt` to set a
special flag for EOF is another option, but seems a lot of work for a
case that probably doesn't happen all too often)

I also couldn't find an appropriate errno to set in the EOF case either

2. treat EOF less specially

The function this is replacing, `getpass` simply returns an empty
string on `EOF`.  This patch would implement that:

diff --git a/compat/terminal.c b/compat/terminal.c
index fa13ee672..8bd08108e 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -122,7 +122,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
        fputs(prompt, output_fh);
        fflush(output_fh);

-       r = strbuf_getline_lf(&buf, input_fh);
+       strbuf_getline_lf(&buf, input_fh);
        if (!echo) {
                putc('\n', output_fh);
                fflush(output_fh);
@@ -132,8 +132,6 @@ char *git_terminal_prompt(const char *prompt, int echo)
        fclose(input_fh);
        fclose(output_fh);

-       if (r == EOF)
-               return NULL;
        return buf.buf;
 }


however then the output is a bit strange for ^D (note I pressed ^D twice):

$ PATH=$PWD/prefix/bin:$PATH git clone
https://github.com/asottile/this-does-not-exist-i-promise
Cloning into 'this-does-not-exist-i-promise'...
Username for 'https://github.com': Password for 'https://github.com':
remote: Repository not found.
fatal: Authentication failed for
'https://github.com/asottile/this-does-not-exist-i-promise/'

Anthony
