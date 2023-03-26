Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F11C6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 12:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCZMxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZMxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 08:53:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B27DA7
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 05:53:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so25301480edc.3
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679835188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm/119T+6QebRsvkRn2kGuFYu2sMCt+f8vMZSGEgnRk=;
        b=p9xXPCbYomJUMWR6JjA8vfEE5zeYI5J5dZ7TvSsGrFh6DmjqdYMvOup2XnXXwJ0rxD
         cemXhNOStROHldG3AiYHMyHi79Ja5cjFRSA1b3xOObcExx3dox67azeJICWUIW7R38FD
         KGIykF+cW9hzWIRXywnJI+Lc64DE+3XVQyVpN+VjBDWM1HD7DnQahgWOTPnZWuq6jBk0
         qF6LYPsaI1s+NZn6FtrcSiJwJ6heeSLSA1C7K+OXfgZfjzeWwdShi9n/fjdj/CWrepVE
         +TRCWJ+xFU7IPopqX4ZFOQn9QYxDcGHGndwnfAtefk9+shSKaXnrLMcVE8RzyrR6jknY
         WNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm/119T+6QebRsvkRn2kGuFYu2sMCt+f8vMZSGEgnRk=;
        b=O9bs20TlQlqFvwE1pYAqWmJGbg50llajrQhF8nxSvveeUzO1SFRd9PVVBDmdBjOvAK
         R/GEsAxxS0nymwK8vfvnhOyS1IzIiTpxLeT3L48drS73D/gXNIJm3SONRjQEPsXIbZgJ
         VG3CjHQZr65zg1i4UjAi7Tzo9APJTcul9bC66Pvafg3HUU69f695kA/VHV54gIwUebRk
         XkBf3XFt5rVEGispAXoxOklV28YIlDtagxPCDQxWAQpYjkG+zF9ke4711j9YDBqFDwrb
         p9px3VmQzHFnJ/n+GLiJx20Gx14+4Sd0QLxf9yskphzM2hOaSwvmLujnJuVCCOT1NPAk
         6HZA==
X-Gm-Message-State: AAQBX9frCFpCazOUM4xtau1W8N5qlkI2xinvAzsmxijdKQi5cKMq7GNi
        5O+5ISDkPhBqznctWehgR21y+HyrBcJ4/w==
X-Google-Smtp-Source: AKy350YrxIGNJuJHEG+YPkv6FFOuJs1VTRus9/A/C5iKjxmZV7euii4A0vPSEreIhOJOjMpRQ/7m2w==
X-Received: by 2002:a05:6402:8c4:b0:4fc:725:e670 with SMTP id d4-20020a05640208c400b004fc0725e670mr8594621edz.11.1679835188266;
        Sun, 26 Mar 2023 05:53:08 -0700 (PDT)
Received: from [10.10.18.214] ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b00501c96564b5sm9612102edc.93.2023.03.26.05.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 05:53:08 -0700 (PDT)
Message-ID: <5e53c8be-92b7-82e0-e204-a0cbfdffc529@gmail.com>
Date:   Sun, 26 Mar 2023 14:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] t5000: use check_mtime()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <233edbbe-35c1-9b5b-7578-4c70c6d24449@web.de>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <233edbbe-35c1-9b5b-7578-4c70c6d24449@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/2023 13:16, René Scharfe wrote:
> fd2da4b1ea (archive: add --mtime, 2023-02-18) added a helper function
> for checking the file modification time of an extracted entry.  Use it
> for the older mtime test as well to shorten the code and piggyback on
> the archive extraction done to validate file contents.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   t/t5000-tar-tree.sh | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 918a2fc7c6..f0bd70dbd6 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -185,6 +185,7 @@ test_expect_success 'git archive' '
>   '
> 
>   check_tar b
> +check_mtime b a/a 1117231200
> 
>   test_expect_success 'git archive --mtime' '
>   	git archive --mtime=2002-02-02T02:02:02-0200 HEAD >with_mtime.tar
> @@ -257,14 +258,6 @@ test_expect_success 'git archive --remote with configured remote' '
>   	test_cmp_bin b.tar b5-nick.tar
>   '
> 
> -test_expect_success 'validate file modification time' '
> -	mkdir extract &&
> -	"$TAR" xf b.tar -C extract a/a &&
> -	test-tool chmtime --get extract/a/a >b.mtime &&
> -	echo "1117231200" >expected.mtime &&
> -	test_cmp expected.mtime b.mtime
> -'
> -
>   test_expect_success 'git get-tar-commit-id' '
>   	git get-tar-commit-id <b.tar >actual &&
>   	git rev-parse HEAD >expect &&
> --
> 2.40.0

This patch looks good to me.

When reading check_mtime() I got confused by extra space in first parameter
to test_expect_success, but after running t5000 and reading check_tar, it'd
become obvious that the space is there to align together subtests related
to one invocation of git-archive:

     [...]
     ok 7 - remove ignored file
     ok 8 - git archive
     ok 9 -  extract tar archive
     ok 10 # skip  interpret pax headers (missing TAR_NEEDS_PAX_FALLBACK)
     ok 11 -  validate filenames
     ok 12 -  validate file contents
     ok 13 -  validate mtime of a/a
     ok 14 - git archive --mtime
     ok 15 -  extract tar archive
     ok 16 # skip  interpret pax headers (missing TAR_NEEDS_PAX_FALLBACK)
     ok 17 -  validate filenames
     ok 18 -  validate file contents
     ok 19 -  validate mtime of a/a
     ok 20 - git archive --prefix=prefix/
     [...]

The only tangentially related nitpick is to the function check_mtime(),
which doesn't follow the code style for Shell scripts -- a space is missing
before parentheses.  Same for almost all the other helper functions in test
files related to git-archive:

     $ git grep -E '^[a-z_]+[(][)]' t/t500*
     t/t5000-tar-tree.sh:get_pax_header() {
     t/t5000-tar-tree.sh:check_tar() {
     t/t5000-tar-tree.sh:check_added() {
     t/t5000-tar-tree.sh:check_mtime() {
     t/t5001-archive-attr.sh:test_expect_exists() {
     t/t5001-archive-attr.sh:test_expect_missing() {
     t/t5002-archive-attr-pattern.sh:test_expect_exists() {
     t/t5002-archive-attr-pattern.sh:test_expect_missing() {
     t/t5003-archive-zip.sh:check_zip() {
     t/t5003-archive-zip.sh:check_added() {
     t/t5004-archive-corner-cases.sh:make_dir() {
     t/t5004-archive-corner-cases.sh:check_dir() {
     t/t5004-archive-corner-cases.sh:build_tree() {

compare to:

     $ git grep -E '^[a-z_]+ [(][)]' t/t500*
     t/t5000-tar-tree.sh:tar_info () {
     t/t5001-archive-attr.sh:extract_tar_to_dir () {


Quote from Documentation/CodingGuidelines:

     - We prefer a space between the function name and the parentheses,
       and no space inside the parentheses. The opening "{" should also
       be on the same line.
    
            (incorrect)
            my_function(){
                    ...
    
            (correct)
            my_function () {
                    ...

