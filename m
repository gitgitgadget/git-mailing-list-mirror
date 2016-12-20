Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E8D1FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 09:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbcLTJrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 04:47:53 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33892 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbcLTJrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 04:47:51 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so11310326pgc.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 01:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x27qQJmeQHDM6QRB5aLI30Tsyrf0KNkahqBwFSFFRNM=;
        b=DGCKvzBNua5C/qt2mBv5EcAfj9XOZukkK/1wEKgJAhKwyIbwt6+OpOcOawVkggByQ0
         nc5HRZQULCn8qcyV/7IkVxwy5hQCW9VHfDrffnBR6ax3tk042qOAtiEqTfIh+JD+co+s
         K4+5WLWFeWD7V4hM/i8RaTvMBq00pm3tMhWJOBemMRt8lM0jeqGlalfFmoFPW1jTuwkQ
         jhtor0r1xkqqicVb9PNqbqtUSKnVtZqEIMEpYOc4nIqBMKTImk3aTX2G/JM4xJwPL5GE
         Rq/U6VvOZP8/oiMyQAr475IoLN76YprGQqLLc6Sdya6YIQ9OGAWuLaSrF/9wH4BoV/+1
         VGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x27qQJmeQHDM6QRB5aLI30Tsyrf0KNkahqBwFSFFRNM=;
        b=AjvK9CjOjB5NWSY1iaycAgIqH5DnDSxlzGeMSbUSPWC5gGiSp6qbL6sTvRtU0NAiKt
         UBygzBGpj5qT0cKwGDW1ky2ujemNA1oGx1RAXa/XURdQneRR0ClnkNqInXNt1bGZahy5
         SuihwB7pMCBbprm2aD6goGgQPYE3kYA5IrEQ4sVgayZ97X0Vo+UhOVFDonbWO6hTc7kd
         bMmYJ/JXgMX3ShQ3WtF/o7dcPCqPZRc8PWvld2RzBwPlGUn2kjC6swRaB6s4dOqANZt7
         TWiyY8jq2t15hDYLu9lK4DoGQAfIUzEIViYew8ANCU1Zq7OdophgCC6fHpU3NW8p//Rq
         E5xQ==
X-Gm-Message-State: AKaTC02ERZ77KVVXu6ntzfBU5CDZSnoGMkwE9sEYa+QQJsEr4BfUVD1YeOiAfA5OjjFKEw==
X-Received: by 10.99.250.69 with SMTP id g5mr34673951pgk.15.1482227270871;
        Tue, 20 Dec 2016 01:47:50 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id k25sm37572263pfg.84.2016.12.20.01.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 01:47:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 20 Dec 2016 16:47:46 +0700
Date:   Tue, 20 Dec 2016 16:47:46 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, josharian@gmail.com
Subject: Re: [PATCH] config.c: handle error case for fstat() calls
Message-ID: <20161220094746.GA3917@ash>
References: <CAFAcib_cY8FeLFkW1=MfR+P7xoupGK9DFegNY5boExHSRppAmg@mail.gmail.com>
 <20161219092155.20359-1-pclouds@gmail.com>
 <xmqqtw9zpz0c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw9zpz0c.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 10:14:27AM -0800, Junio C Hamano wrote:
> Shouldn't the error-return path in the second hunk rollback the
> lockfile to clean after itself?  The existing "Oh, we cannot chmod
> to match the original" check that comes immediately after shares the
> same issue, so this is not a new problem, but making an existing one
> worse.

OK. How about two more patches on top (or bottom, does not matter)?
The second one should fix this. The first is sort of "good to do".

[PATCH 1/2] config.c: rename label unlock_and_out
[PATCH 2/2] config.c: handle lock file in error case in git_config_rename_...
--
Duy
