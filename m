Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC3120193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910AbcHDPqq (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:46:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35949 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758733AbcHDPqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:46:44 -0400
Received: by mail-io0-f193.google.com with SMTP id y34so22489433ioi.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 08:46:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JJde5r89ZFll1/tmUAFdysXPkejZc1NQA4MSUX2388g=;
        b=jGIKpZVAAgGsvUPXiIfD7QP3UD8QJAKILWmwdye/vlQPFtrEQeZQr7X3hZhRp7Qo9G
         UZgJ3t29RfDrQBc2FmqB8WvpVOm8bgac49rrsNxb/2Tp/6YEq00Mjk0hKa0waS/NBX3m
         tPS7Xam0R4Loe86g8WWajw6WHnUWfMpekXFcE+0rOpujceNeO3asVCDahPHwHkU6tJxf
         C/dZz72hH95X8bY04+8hfsR24+t35LAdnbX0E65XEC6Eyz6wxRmKB9xeE0y3mpwy9a9g
         xwW8VifJnHNYlPnFja77frUnxaKGGfbsFSnW0cB7JuxuEKafX0+FMgSgRE4zsVIxQKBG
         57nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JJde5r89ZFll1/tmUAFdysXPkejZc1NQA4MSUX2388g=;
        b=ZKdw+jpKF8jtSbrxXFdmqdFjTNH6zgJfMZ+Nx8DuEqFuJ4fBCWwEKt0Myga4sreZ1L
         KHSEn7iuY8nWzxwDJEQcR/sZfQ7uy4SFKl5tEIBVrxeu9ZxTxQXcZu3ucTy0lCSZUJKv
         cVm5IQneM/EBb+lhqxGxCVu0RN0KD/N6TH3/LXLUM6Q03Ho2j3bgvz2PrM4dElJT6ETu
         WDMnuYveD7DqYENU7xgPDEjE6cuJ1TaZohQbinRn4Dks4/OshdhaF94JsMt4lWZLDYM5
         vGbKNnDQzA3ZdlXXcsaXjLly+0Bl28lfCvIQ9Nt5QV5290dautBB6+Pig+OQIGISklXR
         00jQ==
X-Gm-Message-State: AEkoouu5Hm/3U7aHNQ707LbVYx8DLztca8EfG4Y+JWD5U/9PtZNGIVbR16AhnnByrpf6lHjh/4MdJTDUFsJ7lA==
X-Received: by 10.107.159.147 with SMTP id i141mr71676786ioe.29.1470325603010;
 Thu, 04 Aug 2016 08:46:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Thu, 4 Aug 2016 08:46:12 -0700 (PDT)
In-Reply-To: <xmqqpopp8ycx.fsf@gitster.mtv.corp.google.com>
References: <20160803160536.15596-1-pclouds@gmail.com> <20160803174522.5571-1-pclouds@gmail.com>
 <CAPc5daU49iVYw14sYeshXDbHGE_nW4vWyM=2XSz-buACVLFwoA@mail.gmail.com> <xmqqpopp8ycx.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 4 Aug 2016 17:46:12 +0200
Message-ID: <CACsJy8AL9+uGni8huURb9LOktEXdX3HWi_GzdDQzTWFTVWn6_w@mail.gmail.com>
Subject: Re: [PATCH v3] t7063: work around FreeBSD's lazy mtime update feature
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 9:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you mean to tell the user "I won't describe it in detail, if you
>> really want to know,
>> go run blame yourself", spell it out like so. I was hoping that you
>> can summarize
>> in-line there to help the readers here.
>
> Here is a proposed fixup.

Great! Sorry I only have one or two hours these days and could not
propose something else quicker.

>  t/t7063-status-untracked-cache.sh | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index d31d080..e0a8228 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -4,12 +4,16 @@ test_description='test untracked cache'
>
>  . ./test-lib.sh
>
> -# On some filesystems (e.g. FreeBSD's ext2 and ufs) this and that
> -# happens when we do blah, which forces the untracked cache code to
> -# take the slow path.  A test that wants to make sure the fast path
> -# works correctly should call this helper to make mtime of the
> -# containing directory in sync with the reality after doing blah and
> -# before checking the fast path behaviour
> +# On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
> +# is updated lazily after contents in the directory changes, which
> +# forces the untracked cache code to take the slow path.  A test
> +# that wants to make sure that the fast path works correctly should
> +# call this helper to make mtime of the containing directory in sync
> +# with the reality before checking the fast path behaviour.
> +#
> +# See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
> +# more.
> +
>  sync_mtime () {
>         find . -type d -ls >/dev/null
>  }



-- 
Duy
