Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1F9203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 00:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcGVAhj (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 20:37:39 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34348 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbcGVAhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 20:37:39 -0400
Received: by mail-io0-f181.google.com with SMTP id q83so92025028iod.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 17:37:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lHZbYPye0IjBhtoHEayWXbeVCFRXFNhLo86nAlreVkI=;
        b=pBgYSG2odAKbGqHnnyxkVz1ZtypyefbN1eB7M/PyyP6+gaGRVYVjALhvwZrEcT4OTp
         i0Y0Fy31kieXhJLKQQhwgt9EDjha62fgFXBpjYBAWQL6ai8lYjL7Vi3ToUbCpxFfq4XX
         dkQhSuXQLSPg8X1OQGAv/VaxK2ExLj2lXj/I3vK5GD2RGr0fBEmGDEgq+e3Xs76BzwEA
         fprnh6doY+WYlMEJ138si2UrFctIbM/hn4raEFcSIakorKx3lRrXDKfD2h6a0gqKybSU
         Ga3v3g25TMNz3fCvVZhKk/N1k9vx/3BSJ4vYkyJ/4ZxSX/kAjl6Vy/GvsIaWgwLhorZw
         Lxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lHZbYPye0IjBhtoHEayWXbeVCFRXFNhLo86nAlreVkI=;
        b=HLjqk+QM3SH/x3dybB+Pjjml3SKLU3pl1Imf89vIceo6pR7gp3FiwQ0VrqwY7EoA6n
         oO811p8Lx5QrDlGia1yXXw9O2clDzj4DVRb5YdvWF52vm4dZpxA2NYPaLKn4Tqo2A/mx
         OBz0F6V9bVX+UknbYJS9mANxk4vlOFl0qMR3tRRXQk6jCm0QvjUFQconzzs2l6lwZN7r
         ndfKfave9+L9gW0bc9+Jnm/Pk9LcJazudwmJnvNAIih5S06vLu0MEAy2RGUkSO1Pjrhv
         dHKP1rM//e9Ejf6OZseIlKMLp+fpEfGonJF3/Ju/P1tPFUTLaSFMrK8qtapbqD/5YLqy
         sNMg==
X-Gm-Message-State: AEkoouu/+8ZqW8rhf2Ec4MiAU8kAY10x5AY3kWJQXI8zxIU9UcFZoyGXHkUP6AQbvhBMmiscdp8paUNFB6o4guk2
X-Received: by 10.107.174.99 with SMTP id x96mr1505806ioe.76.1469147858044;
 Thu, 21 Jul 2016 17:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 21 Jul 2016 17:37:37 -0700 (PDT)
In-Reply-To: <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 21 Jul 2016 17:37:37 -0700
Message-ID: <CAGZ79kZqHpnCKbcjqPUUtc2jS_HM4FAkyprd3L+y8-z_eVa7cg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

FYI: I started working on a series that decouples existence of a
submodule from the URL
as a preparatory series to this one. Then we can have the same URL in
all working trees, but
the existence is configured differently for each working tree.

I'll try to send it out tomorrow.

Thanks,
Stefan
