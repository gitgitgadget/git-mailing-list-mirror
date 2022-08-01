Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1778BC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiHAS2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHAS2u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:28:50 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0C313BF
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:28:49 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10e615a36b0so13128774fac.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tCb/FVDWh53Vw0ZWH9Fk/UDzNG669tscqqgoFjniLro=;
        b=VV44QUJKVAb29BWpMcfZxBh+F9gqKgoS90PTduKu44fbaUASrXy0oAA52N3qVvm6hg
         wl3HU8aDf+JHlGTjmVjl/6dMnejIeU80y2NAKxzGI2k4/m4P1HRMvuUV658xiqGlUBJB
         ADQdRwFsul4UIfeh4MY8bdYion/Ds84EDrVdRka2kTjSqmHfzK/gZL9w9b9vOcd1qnTB
         UE2kGP5OTfsWp6B6S3xoiayK9LwnmVBYpQ5ZTQy/x2HDJSu3lzSLTWWdnt7hh6QZYweF
         Cnvy7QKdQs08ZRSr0KfLPE8GSVnC7j1QBleUJ4VoKlfE0GDgCXIqG80Bq6etqENOWg+W
         9xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tCb/FVDWh53Vw0ZWH9Fk/UDzNG669tscqqgoFjniLro=;
        b=dOfOBo8yk5CRtqxY+e7/mXGESp0iX5QusY7aH6E7hk3Igq4VHZ4rQkb/v91muoNSf0
         p0gG9REuFsicMHr9pB2FDzs7gs1pO9VpNJ1GX9QL+4qrfvvmXRxXD/dqxpmOVJty2Y9v
         l0LbTh6iS17POJAwHIca91Tl6bko9yBmHdT4Pp1243cKRkCHMyf+zJuloY9iCEi+e24A
         O4sD7BCD12/tZS1GiadNKOIzyuNA0KTV0WsJnrb/IULXkURvtcv4vWEBXjGHr/N7FPmL
         WTgtJy1zAPwqHXKz3MTbfaztzN83D8UoVPOffQ8D2L6VuNpR8sOQeNY/FSXTFUsJjEYS
         NOrQ==
X-Gm-Message-State: AJIora9US22Y9sVKZR5I91ser2ZmKjn7H412+dg7bmvEj+pvjJXRTDRu
        b7QiwgdEZzpX4poI/NwHadqsbERBgxl4xhUxLDpp4mFdI+uWOQ==
X-Google-Smtp-Source: AGRyM1ukrxUgohYevXa03P7So2g2Zcu8XZp648fmm7U/s7l/zrtqaizjGeUqiJoKNhr0jfoBmw3ehyoavy/IHt8bN1I=
X-Received: by 2002:a05:6870:2191:b0:10e:75b6:fc3a with SMTP id
 l17-20020a056870219100b0010e75b6fc3amr7813630oae.236.1659378528971; Mon, 01
 Aug 2022 11:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-5-calvinwan@google.com> <xmqqk07v7qe4.fsf@gitster.g>
In-Reply-To: <xmqqk07v7qe4.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 1 Aug 2022 11:28:37 -0700
Message-ID: <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] serve: advertise object-info feature
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK.  Now we will no longer advertise a bare "object-info", but
> "object-info=size" (and possibly in the future things other than
> "size").  How would this change affect older clients who knows what
> to do with "object-info" but not "object-info=<values>" yet?

This was a tricky tradeoff that I definitely think I should have
discussed more in the commit message. The issue with how object
info is currently implemented is that it is very inflexible for adding
new parameters.

This is how object-info currently parses a client request:

while (packet_reader_read(request) == PACKET_READ_NORMAL) {
    if (!strcmp("size", request->line)) {
        info.size = 1;
        continue;
    }

    if (parse_oid(request->line, &oid_str_list))
        continue;

    packet_writer_error(&writer,
    "object-info: unexpected line: '%s'",
    request->line);
}

Object-info supports "size" right now but, let's say I want to add
"type" as a parameter. OK I add another if statement like:

if (!strcmp("type", request->line)) {
    info.type = 1;
    continue;
}

And we update the docs to say "type" is now supported by
object-info. If a user now attempts to request "size" and "type"
from a server that has not been updated to support "type",
then the user gets an error message "object-info: unexpected
line: 'type'", which is another situation that is a bad experience
for older clients. The client has no way of knowing that their
failure is caused by a server version issue.

Essentially I think at some point we have to bite the bullet and say
we need to rework some part of the object-info advertisement (or
if anyone has a better idea of achieving the same goal) so that we
can make future incremental changes to object-info. If the supported
parameters are posted in the advertisement, then the client doesn't
have to first make a request to find out that their requested
parameter isn't support by the server. While you noted that we can't
make the assumption now that nobody is using the current
object-info feature, I think the benefit of the change outweighs
the cost of affecting the possibly small amount of users of this
feature. (A quick search on stack overflow for "object-info" tagged
under [git] returned no questions about it so that's what I used as
a cursory estimate for how popular this feature is).

Curious to hear what your thoughts on this are Junio, since as
much as I'd like to create a seamless upgrade experience for
older clients, I'm out of ideas as to how I would do so.
