Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2883201A7
	for <e@80x24.org>; Sat, 20 May 2017 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbdETRds (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 13:33:48 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35263 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdETRdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 13:33:47 -0400
Received: by mail-lf0-f52.google.com with SMTP id a5so411299lfh.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QG1V1RkX7+3ayUftylP8FcGaWU6U8JZjXeRHiOSauR4=;
        b=JxGPOzmyjAp27dwI5LdIOvNmWoSOaLiFakCRr7TYYcVAwugkhYgmeQI8n+0Z0wACtR
         k3fG6c1YmzhNNFUpWp+zMLtNc5B2oJNVM/+3k3nCtsC8yxML/ohvGyn+7p4qsQ0+x8EV
         zWr+R3dnkvJRWZpXuOczjvekMQLRpQeHzhQYVLJc/Dv4RXrsg7buEedu3kUYd4LKFtNX
         WWW/u+8duBnsllePKiLZak3ZmBVwAvIymCtVXfzVDBjHDhkbzKb/sBNTAt6svh037nN7
         5R43BHd0CKF7WSwgLumVJk1rGOvA0TOGX+ix/coCmQq9PmRFQeeLjC8QHUGAMpDTbL+q
         fFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QG1V1RkX7+3ayUftylP8FcGaWU6U8JZjXeRHiOSauR4=;
        b=OVNTuy39poF6+6uhN/huV6nzRJvCdE7mvLQZrMu8doJm/6A9qRO1+oXLjuhTGzPLsc
         xyOzi5ZXMfBU+NnFKkiyxEZQp/2/RT6TJBw+lxQaK+jPlzYHlbhc1Zbt6dFNIQ14uir3
         iYaxN7yj2x+i4VP8pUfMF1NIeSRCsnrZEJlsiRBvroSONgo4tqGL/OCksX+JorbtvAJ9
         HT9D7f0PTIYf83Zl/Z7PVNiuFME92DjyHzAt2gNS+zd0S5uTngNljWBJrNDI9c6Trz5f
         wuipPTB8TycMPtZTGY/G5N0bdJEd5pvOKhvGtGCy0zyXI7jWbR03074Nkgqi3SITB121
         0jfg==
X-Gm-Message-State: AODbwcDZg9RYjVs92DViLVRZl01cqat8D8zYhvZw5VPSzLHIqKXtgtdc
        5+XFjQ/qiJRQNxy2xdTzhR2Z0OqzUQ==
X-Received: by 10.25.160.75 with SMTP id j72mr3813490lfe.97.1495301626011;
 Sat, 20 May 2017 10:33:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Sat, 20 May 2017 10:33:25 -0700 (PDT)
In-Reply-To: <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com> <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Sat, 20 May 2017 10:33:25 -0700
X-Google-Sender-Auth: bVE6ejkUsj3ubQ1HJXk3gUnFM5U
Message-ID: <CACpkpxmGzz0hUsypX5ORX7FLB3rh_xbyPOKz4SUt-zrjSjCq_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manish Goregaokar <manishearth@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, you are right (on both counts).

One thing which I think hasn't been covered yet is the rebase
ORIG_HEAD. I'll see if that's still a problem on `pu` and make a patch
for it if so.

(I recall `git prune` during a rebase messing up repo state, though
it's really my fault for trying that in the first place. Would be nice
if it worked, though)
-Manish Goregaokar


On Sat, May 20, 2017 at 3:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> manishearth@gmail.com writes:
>
>> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
>> +{
>> +     int i, flag, retval = 0;
>> +     struct object_id oid;
>> +     struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
>> +     struct commit* commit;
>> +     for (i = 0; worktrees[i]; i++) {
>> +             if ((commit = lookup_commit_reference(worktrees[i]->head_sha1))) {
>> +                     oid = commit->object.oid;
>> +                     if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
>> +                             if ((retval = fn("HEAD", &oid, flag, cb_data)))
>> +                                     return retval;
>> +                     }
>> +             }
>> +     }
>> +     return retval;
>> +}
>
> I would have expected for-each-worktree-ref to iterate over all the
> refs in a given worktree, but that is not what this does.  This
> instead iterates over worktrees and shows only their HEAD ref, no
> other refs.  This helper is somewhat misnamed.
>
> By the way, doesn't nd/prune-in-worktree topic that has been cooking
> in 'pu' supersede this change?  It not just protects the commit at
> the tip of HEAD in each worktree, it also makes sure the ones in
> HEAD's reflog are not prematurely pruned.
>
> Thanks.
>
