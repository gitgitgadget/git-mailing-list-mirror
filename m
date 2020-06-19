Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3CC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356D421556
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DKncPmBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbgFSTbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:31:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51440 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbgFSTa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10471CAA6C;
        Fri, 19 Jun 2020 15:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H94LFOAdnrjvGtwdr2St4gDaHO8=; b=DKncPm
        Bz7ngwP3m2v9RtlLZ5+SlXy62+5DAyPjDrxzlVfRsMYs+4DC2/IldvAkxztijBsZ
        o7A5a4Lta8UDLdFxoGL3d764HNe/59wlfmB8U3R/8gp+6AV+tH5tUsQGrQ7IZ52E
        Fs99fIWDxPlhOLJjFMLWojw/ZVvaKu4/rlFK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aZsU150KmslKp4q+aF436llrrWfJUB1f
        R4SGKLikvU4kGV7g46Xvl+56PMh3ClkxbRBMttCGmIcUMnKNTCgrdTkT9qrfdHQt
        yR1MbYwZ4MvSCrl3V3tA8BmcCqhA7JWpuMvo3wKaFuWRSx+mk5T8GlPEF9QECDdK
        uv/5pXdfQ5M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08479CAA6A;
        Fri, 19 Jun 2020 15:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E0F3CAA68;
        Fri, 19 Jun 2020 15:30:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 2/3] strbuf.c: remove unreferenced strbuf_write_fd method.
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
        <20200619150445.4380-3-randall.s.becker@rogers.com>
Date:   Fri, 19 Jun 2020 12:30:52 -0700
In-Reply-To: <20200619150445.4380-3-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 19 Jun 2020 11:04:44 -0400")
Message-ID: <xmqqeeqahmz7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 645A0C74-B263-11EA-AEE3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> strbuf_write_fd was only used in bugreport.c. Since that file now uses
> write_in_full, this method is no longer needed.

Yay!


> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  strbuf.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 2f1a7d3209..e3397cc4c7 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -556,11 +556,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>  }
>  
> -ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
> -{
> -	return sb->len ? write(fd, sb->buf, sb->len) : 0;
> -}
> -
>  #define STRBUF_MAXLINK (2*PATH_MAX)
>  
>  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
