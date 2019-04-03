Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB3720248
	for <e@80x24.org>; Wed,  3 Apr 2019 07:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCHpN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 03:45:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33752 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDCHpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 03:45:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so4160008wmi.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2PaXQl9nXACihEJQ2g5c59uPG5Qb+s8SR5N3MQS3Cao=;
        b=bOL14fQevHnWlYDEUblfFtKhdzhPSovzzXl8RpY13BLazV2kwfaNoMDFE1PyOzf1xS
         LRhsY0Tn24fWGnCNzAtLmHOpgRi48FJgifGPhHccxRY+9zNbqe2krZu0Dnjo7tkdieEg
         oAHWULisqCUOrtuZJiaheMq+v6+5Gqow5zkW118wHW3Z1eP3N3tH3S/61Z5iSw7DGoDp
         PFXPACLrYtcLjTdTv0whi5bfc7U/XsfmDltVYtMlYinGOfNmjRvqtt/Qo0gJ/0jfPodv
         xlDRf0685slbAXm57c8ZYtbFhVDlW98zNWjbKIkbk4pYfCLH6YXIxEXbJG3Ww2kp0QXV
         cXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2PaXQl9nXACihEJQ2g5c59uPG5Qb+s8SR5N3MQS3Cao=;
        b=nzA87oPw2Wj0TdwW2suKhTAojXR9RSLvbM0aToLyG/E28Dwn4kxLT4rydg7kz8Z8os
         FrLGnWA9Waqh1qCLCDT/M3k4eviGa3v79TqtbpbHXAO6eUWgjMiFxc22N6Fx1m5PAwM7
         QUwqvfmcTpi3tXFhEaYWLg2VHSdqRIVNANJDKMqVNLbhxscaPb86g0SuduxXO4SRNbel
         /eD77cx1H0OsBEkzzbu1XH6JOYT782K1y2fjoSrZ5tSSzXdgg7JzJXQ04p+C63hxc0+h
         Jk7uizF6cZhOczG1sRhOJJ14+ZAbONptWQJaaczHn1tqC2aSWzZ0LWATc++7f4eJ+NGO
         xrcQ==
X-Gm-Message-State: APjAAAXPdBP6XsygFZZnpet6sOLP+128PuRqcJKw/HrtqW/YM+mReQsY
        jnNuCU6QeZFT02tdVLyP9MY=
X-Google-Smtp-Source: APXvYqxorkkPpsOqK8/980wu2CgFUFEM+opli7PGJh/kpCbf/yl37r5rwdScuR7KYteF7QmegZbxNg==
X-Received: by 2002:a1c:a103:: with SMTP id k3mr996783wme.8.1554277510852;
        Wed, 03 Apr 2019 00:45:10 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l21sm6830006wme.4.2019.04.03.00.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:45:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Kastrup <dak@gnu.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
References: <20190402115625.21427-1-dak@gnu.org>
Date:   Wed, 03 Apr 2019 16:45:09 +0900
In-Reply-To: <20190402115625.21427-1-dak@gnu.org> (David Kastrup's message of
        "Tue, 2 Apr 2019 13:56:25 +0200")
Message-ID: <xmqqv9zvsfay.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Kastrup <dak@gnu.org> writes:

> When a parent blob already has chunks queued up for blaming, dropping
> the blob at the end of one blame step will cause it to get reloaded
> right away, doubling the amount of I/O and unpacking when processing a
> linear history.
>
> Keeping such parent blobs in memory seems like a reasonable optimization
> that should incur additional memory pressure mostly when processing the
> merges from old branches.

Thanks for finding an age-old one that dates back to 7c3c7962
("blame: drop blob data after passing blame to the parent",
2007-12-11).

Interestingly, the said commit claims:

    When passing blame from a parent to its parent (i.e. the
    grandparent), the blob data for the parent may need to be read
    again, but it should be relatively cheap, thanks to delta-base
    cache.
            
but perhaps you found a case where the delta-base cache is not all
that effective in the benchmark?

Will queue.  Thanks.




>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  blame.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/blame.c b/blame.c
> index 5c07dec190..c11c516921 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1562,7 +1562,8 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
>  	}
>  	for (i = 0; i < num_sg; i++) {
>  		if (sg_origin[i]) {
> -			drop_origin_blob(sg_origin[i]);
> +			if (!sg_origin[i]->suspects)
> +				drop_origin_blob(sg_origin[i]);
>  			blame_origin_decref(sg_origin[i]);
>  		}
>  	}
