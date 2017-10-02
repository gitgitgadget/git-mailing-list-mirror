Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0CF20281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdJBXA5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:00:57 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45325 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdJBXA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:00:56 -0400
Received: by mail-qt0-f177.google.com with SMTP id b21so4018826qte.2
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6c850NeD+oGlWxoN1DH73ri5uX+M97aTzQBGCn9kE1I=;
        b=dHbgJDNqu+lJeZBwox6851dzk9iw0bgAJZHweM+T5yVJ+unk54g246y7Gu0/1Hy8tc
         /fQOaB2FmQ6mYFZ21dOH0kNnYLnf2zyIitslA38EH6l/RLQOnc3z/dhRM1TMWqrEQW7b
         nPNftlzVkhadvyt9HykFXbVMeo/tpa30ZqfK6qshFVWYwWKNueG/8MFUyJ7ASeOgpKJq
         Ro3gD2Es+W5hVDWRdDPS0TZi7D1VPcr+PnMLr1JZ7esV+1HRdQCJn8gIs9oKjvxLHx85
         3ozXFkwnZAmZwaOE+RVI8YmmWZp9u1jjs3q0goXQ2oWHx7uRJGLzWPSXYsHXsAW5aAHW
         6zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6c850NeD+oGlWxoN1DH73ri5uX+M97aTzQBGCn9kE1I=;
        b=DSaZodeYDTCUo5ePMWkCNE9APaqPbYykMcIkIpx2/CZxmUEREndF0OuJeBizi2bnu/
         FiAhqtA0dZ96s6UaVJE55lxyga88GCuZLN/jr2KmSRpNSTT+AxrRNIWyjb1rL/KifVv+
         ATgOJxKVgncMqBvJnPAlFQnOu68xGZFF4tsXbtT6DrGZRnfovbfiffoWiMOKxxPamJTS
         YqTsdbmA0XRssXGU80mTJWDkWwKgSfJ1pHDNxOqtIanbMO7GwctGAotiWszg1/DivMZ9
         YENUxa9u8FmV1z/9kq5nWPWcp88QKSqcT9gLwc0GPxJNsu6fAHT1xNbW+gkPbMttvkLH
         Ogww==
X-Gm-Message-State: AMCzsaXBs+cQGFMbKXjfhDjJq0tgqH9F2+No+XsTcAIkFxCT/79Miyu9
        es3i/7+dtjBPtXWEmsvfNmTiZSHcQ2t2oLVFrmZrKDtEkX4=
X-Google-Smtp-Source: AOwi7QCG0kCKYjqGlvA84hqGqUAbkgsNipT8/e7MeKcLeknOA7EFGGp+Z0Fuzlhf+tTora5PbdhGgcCNKw6VoHGaJZ4=
X-Received: by 10.200.17.23 with SMTP id c23mr8576338qtj.198.1506985255369;
 Mon, 02 Oct 2017 16:00:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 16:00:54 -0700 (PDT)
In-Reply-To: <20171001220831.214705-7-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net> <20171001220831.214705-7-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 16:00:54 -0700
Message-ID: <CAGZ79kb1WjUUKV5aUoPf=x=nFqMhJssKudtHm+_LxY5=ky6r4A@mail.gmail.com>
Subject: Re: [PATCH 06/24] Convert check_connected to use struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2017 at 3:08 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Convert check_connected and the callbacks it takes to use struct
> object_id.
>

> diff --git a/connected.c b/connected.c
> index f416b05051..4a47f33270 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -16,13 +16,13 @@
>   *
>   * Returns 0 if everything is connected, non-zero otherwise.
>   */
> -int check_connected(sha1_iterate_fn fn, void *cb_data,
> +int check_connected(oid_iterate_fn fn, void *cb_data,
>                     struct check_connected_options *opt)
>  {
>         struct child_process rev_list = CHILD_PROCESS_INIT;
>         struct check_connected_options defaults = CHECK_CONNECTED_INIT;
> -       char commit[41];
> -       unsigned char sha1[20];
> +       char commit[GIT_MAX_HEXSZ + 1];
> +       struct object_id oid;
>         int err = 0;
>         struct packed_git *new_pack = NULL;
>         struct transport *transport;

> @@ -77,7 +77,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
>
>         sigchain_push(SIGPIPE, SIG_IGN);
>
> -       commit[40] = '\n';
> +       commit[GIT_SHA1_HEXSZ] = '\n';

While we are using SHA1, this and below is correctly using
GIT_SHA1_HEXSZ, but the array is defined as GIT_MAX_HEXSZ.

Upon switching the hash function, we would plug in the
GIT_NEWHASH_HEXSZ here, or if we do it dynamically
(using a vtable for hash functions, to switch at run time)
we'd need to make the decision based on the hash function.

Makes sense.

>         do {
>                 /*
>                  * If index-pack already checked that:
> @@ -87,17 +87,17 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
>                  * are sure the ref is good and not sending it to
>                  * rev-list for verification.
>                  */
> -               if (new_pack && find_pack_entry_one(sha1, new_pack))
> +               if (new_pack && find_pack_entry_one(oid.hash, new_pack))
>                         continue;
>
> -               memcpy(commit, sha1_to_hex(sha1), 40);
> -               if (write_in_full(rev_list.in, commit, 41) < 0) {
> +               memcpy(commit, oid_to_hex(&oid), GIT_SHA1_HEXSZ);
> +               if (write_in_full(rev_list.in, commit, GIT_SHA1_HEXSZ + 1) < 0) {
>                         if (errno != EPIPE && errno != EINVAL)
>                                 error_errno(_("failed write to rev-list"));
>                         err = -1;
>                         break;
>                 }
