Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DDD1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJaHXY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:23:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaHXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:23:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so190527wre.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4aGOazX129mttP4l+3WP0O36eFYM/15HcYF+XW/v7dY=;
        b=irZvxd52MJ6xhRatwVST1/LU//j8BGxTOcSam4kKB278GjiyqB8fs3aj0bU4Pz/3U7
         V3QzLwi5Jdp0FnuUed1HGAlCQtSUCr08tcMVjSVHdbNIXBp+vgDB+6Lrslc8T2/WeNj8
         E04W7Gs6ekosFd7IRJ/OeJaz0OZG4kNdiw5j99wITWL0Ka1sB9xNHNdoYqHwfCEwxSvr
         7UB91Egjjk9QD6PEC4kbS4L6hyY8MfGsoNPy0XXpoiPxO0grlfUWwTHRhbD2nt4hu++Z
         E1y8+/F2XWYIYQfPfdrkKp8rB72xQVjMfwmr5efK17n/4KTvhUfNB6ZhgFOYChjdJRyq
         lwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4aGOazX129mttP4l+3WP0O36eFYM/15HcYF+XW/v7dY=;
        b=kyTtQ5/26AaiwAjj8lQp5/C3ZcrBNT/NaxC5TPj7m5znpZO/HMD8u6vqaRRy+iQ7rV
         4OvZP02qJzTSP8cfrjGsaiadun+KgqEVwmS1RULGnOfPbhWkUHowGDfVrHIhpi/rBsx7
         TkpvHJxuhuZ+k0H/JBfuJMaJXPPjitdNAJmMNYhc15UsuIh+8nd+iGGw0Y0YxGnP1xs0
         UxsBs5xuIo6AyaVb8+klywIviTHT7xwL3c6NVVLRcr2mLU7AEWi+lEbD3onaqbS2XQVK
         QmuOFOFOAQO1MbV2oYgzHA+p3t7nL6XrctfXUUEfMFxlXY0q5NsMgU4ortMnghXw2thQ
         VAfg==
X-Gm-Message-State: AGRZ1gIqNSGQHcTsGGEzUe1mKnGSQ6R0k3QNi62+2R2VpMg5gT5Z/RJN
        E3GB/Dtc+8ikEJBtcHslLpg=
X-Google-Smtp-Source: AJdET5e+nP82vedT0RoAX4p7QnOwFdnbvSQYL2ZmQpAN+/GYcx1kj69H24E1zVCZqr7fIBs40zukDQ==
X-Received: by 2002:adf:ab50:: with SMTP id r16-v6mr451887wrc.62.1540938482905;
        Tue, 30 Oct 2018 15:28:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h96-v6sm6580348wrh.91.2018.10.30.15.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:28:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
        <878t2fkxrn.fsf@evledraar.gmail.com>
        <20181030213505.GA11319@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 07:28:00 +0900
In-Reply-To: <20181030213505.GA11319@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Oct 2018 17:35:05 -0400")
Message-ID: <xmqq4ld3134f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The problem isn't actually a sha1 mismatch, though that's what
> parse_object() will report. The issue is actually that the file is
> truncated. So zlib does not say "this is corrupt", but rather "I need
> more bytes to keep going". And unfortunately it returns Z_BUF_ERROR both
> for "I need more bytes" (in which we know we are truncated, because we
> fed the whole mmap'd file in the first place) as well as "I need more
> output buffer space" (which just means we should keep looping!).
>
> So we need to distinguish those cases. I think this is the simplest fix:
>
> diff --git a/sha1-file.c b/sha1-file.c
> index dd0b6aa873..a7ff5fe25d 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -2199,6 +2199,7 @@ static int check_stream_sha1(git_zstream *stream,
>  	 * see the comment in unpack_sha1_rest for details.
>  	 */
>  	while (total_read <= size &&
> +	       stream->avail_in > 0 &&
>  	       (status == Z_OK || status == Z_BUF_ERROR)) {
>  		stream->next_out = buf;
>  		stream->avail_out = sizeof(buf);

Hmph.  If the last round consumed the final input byte and needed
output space of N bytes, but only M (< N) bytes of the output space
was available, then it would have reduced both avail_in and
avail_out down to zero and yielded Z_BUF_ERROR, no?  Or would zlib
refrain from consuming that final byte (leaving avail_in to at least
one) and give us Z_BUF_ERROR in such a case?

> This works just by checking that we are making forward progress in the
> output buffer. I think that would _probably_ be OK for this case, since
> we know we have all of the input available. But in a case where we're
> feeding the input in a stream, it would not be. It's possible there that
> we would not create any output in one round, but would do so after
> feeding more input bytes.

Yes, exactly.

> I think the patch I showed above addresses the root cause more directly.
> I'll wrap that up in a real commit, but I think there may be some
> related work:
>
>   - "git show 19f9c827" does complain with "sha1 mismatch" (which isn't
>     strictly correct, but is probably good enough). However, "git
>     cat-file blob 19f9c827" exits non-zero without printing anything. It
>     probably should complain more loudly.
>
>   - the offending loop comes from f6371f9210. But that commit was mostly
>     cargo-culting other parts of sha1-file.c. I'm worried that this bug
>     exists elsewhere, too. I'll dig around to see if I can find other
>     instances.

Thanks.
