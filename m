Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C27C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 03:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7E611C0
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 03:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhKKDF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 22:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKKDF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 22:05:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B962CC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:03:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so4388921pfb.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2IgsUkvfE6ssAjSvMlSqKWzvSVos0X+jc6bgERBi9E=;
        b=mXO3ferN7aRvhL4wmUMUKz7M+5ZGA0+7bOUiEv2KDsPt2uwovqNXKqEeRjZnAfuZCD
         H3mGGJZ1FvzwVupqDNUbL2fU3K9RyWHP8B8QzN7xHKk16rMZYNoYe1Al/WftwHfm5u0i
         hJ/8uxez+lZMp+xfR1/80+vGsEJhLMJ3gNGNe5LLyrxZ4MLuwrbGPyxZzkxZoHYXOjVS
         VwEqoI10rHIwvPx7kBh4tOZavLopN8XVBzIBNU0iJCjoFnXMpk2E0vDt/nAp4jwPAYOO
         H850+pKr8S6Uzw54d5KyKIRPmIIEUFdxcCpZwNEF5FUUf7MpqgvePvYycvqNiDLXOXHf
         J2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2IgsUkvfE6ssAjSvMlSqKWzvSVos0X+jc6bgERBi9E=;
        b=CrtjBo79duL7BtR/TIoMtqyfLaCXQyHVU1+K21IoLwV5peKi9BNBXOE9D7PvxpHnOH
         +MK7YGfqVnQLcRVhN0p0rxnJEDGVdjXAdvDB3Mk7jkKTrGIjUBQdfrx33FRDlP0ktAXu
         MVX6RI/gGJwpqcE3+SRAWWVAA9j+YcYBnE/udcKK8GNOlpIyGSK25EIHl8IzeC3eDzkR
         PczL2Rx8eYKYxldMj6Lhk7XX/FB27ZJSkqioESldDmgfwPbVIZm+jpWgUI00J6NmHjsb
         hvn+J9btUcV63aGN/65vIAwn6C31dD1AyzpPd1WFEnFz2GyFmZEWia/ze6F8t4lXS0uH
         5ldQ==
X-Gm-Message-State: AOAM531VD5C5rteUIee3UOUepjd8jCrojSe/37lvXiGhVk+IFWMXXKxo
        tZ69pYa4KJv0JJRUDf1tVFM=
X-Google-Smtp-Source: ABdhPJxY3GJXNkWTL01Hz5+r/5EqDQmpoHpzOnsZnHa516eiXTV5vJwrxIP488VFJLdUz9CToTo+Gw==
X-Received: by 2002:a62:5b47:0:b0:480:69a9:29cd with SMTP id p68-20020a625b47000000b0048069a929cdmr3676837pfb.40.1636599787194;
        Wed, 10 Nov 2021 19:03:07 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id x18sm959801pfh.210.2021.11.10.19.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 19:03:06 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
X-Google-Original-From: Han Xin <hanxin.hx@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        me@ttaylorr.com, peff@peff.net, rybak.a.v@gmail.com
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
Date:   Thu, 11 Nov 2021 11:03:02 +0800
Message-Id: <20211111030302.75694-1-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
References: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
...
> diff --git a/object-file.c b/object-file.c
> index fe95285f405..49561e31551 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1084,9 +1084,11 @@ void *xmmap(void *start, size_t length,
> * the streaming interface and rehash it to do the same.
> */
> int check_object_signature(struct repository *r, const struct object_id *oid,
> - void *map, unsigned long size, const char *type)
> + void *map, unsigned long size, const char *type,
> + struct object_id *real_oidp)
> {
> - struct object_id real_oid;
> + struct object_id tmp;
> + struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
> enum object_type obj_type;
> struct git_istream *st;
> git_hash_ctx c;
> @@ -1094,8 +1096,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
> int hdrlen;
>
> if (map) {
> - hash_object_file(r->hash_algo, map, size, type, &real_oid);
> - return !oideq(oid, &real_oid) ? -1 : 0;
> + hash_object_file(r->hash_algo, map, size, type, real_oid);
> + return !oideq(oid, real_oid) ? -1 : 0;
> }
>
> st = open_istream(r, oid, &obj_type, &size, NULL);
> @@ -1120,9 +1122,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
> break;
> r->hash_algo->update_fn(&c, buf, readlen);
> }
> - r->hash_algo->final_oid_fn(&real_oid, &c);
> + r->hash_algo->final_oid_fn(real_oid, &c);
> close_istream(st);
> - return !oideq(oid, &real_oid) ? -1 : 0;
> + return !oideq(oid, real_oid) ? -1 : 0;
> }
>
> int git_open_cloexec(const char *name, int flags)
> @@ -2572,6 +2574,7 @@ static int check_stream_oid(git_zstream *stream,
>
> int read_loose_object(const char *path,
> const struct object_id *expected_oid,
> + struct object_id *real_oid,
> void **contents,
> struct object_info *oi)
> {
> @@ -2582,8 +2585,6 @@ int read_loose_object(const char *path,
> char hdr[MAX_HEADER_LEN];
> unsigned long *size = oi->sizep;
>
> - *contents = NULL;
> -

Deleting "*contents = NULL;" here will cause a memory free error.
When reading a large loose blob ( large than big_file_threshold), it will enter the following block and *content will not be set:

	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
			goto out;
	} else {
		...
	}


This test case can illustrate this problem:

test_expect_success 'fsck large loose blob' '
	blob=$(echo large | git hash-object -w --stdin) &&
	git -c core.bigfilethreshold=4 fsck
'

git(73697,0x1198f1e00) malloc: *** error for object 0x36: pointer being freed was not allocated
git(73697,0x1198f1e00) malloc: *** set a breakpoint in malloc_error_break to debug
./test-lib.sh: line 947: 73697 Abort trap: 6           git -c core.bigfilethreshold=4 fsck

> map = map_loose_object_1(the_repository, path, NULL, &mapsize);
> if (!map) {
> error_errno(_("unable to mmap %s"), path);
> @@ -2613,9 +2614,7 @@ int read_loose_object(const char *path,
> goto out;
> }
> if (check_object_signature(the_repository, expected_oid,
> - *contents, *size, oi->type_name->buf)) {
> - error(_("hash mismatch for %s (expected %s)"), path,
> - oid_to_hex(expected_oid));
> + *contents, *size, oi->type_name->buf, real_oid)) {
> free(*contents);
> goto out;
> }
...
