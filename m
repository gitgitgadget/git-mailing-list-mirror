Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F0C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjAaLyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjAaLyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 06:54:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C889612073
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 03:54:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n6so11500814edo.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 03:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWYjYG3YK5R5HkK4cuhWCvFwW2rsvKyqxtQi2jUF8O0=;
        b=gojz/mAfoJKeoa1YMV7Jvx7d008EQ+x5pljwg2Mg+hRqWjKvAwQNIqAWo0NKd6896I
         VdJszu5Riv4ZVHTaXm/ywsX87Myul5897pXtJwLrkFyK+qRo/yBaF8RzYC0Hbb2ZIa4T
         n5qv5rKZrshm5GDGHdQtjGTzFIYKYgNjJ4WncBn5iHvzM53ot8+9pSldm5hRukgHz3l6
         x4txcUHWGdlvqF2v0ej58LmJ7MIyLZ+ekwiE1XSLvOuIiIK3cWAYsMAKEFx97h72PHwV
         huUSctH5pwX4ZfDp998d2mrp0YidJhCwuFJcq8TGCS64H0gg9CqT3W4nBBCZKpkq1AJK
         3gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWYjYG3YK5R5HkK4cuhWCvFwW2rsvKyqxtQi2jUF8O0=;
        b=wTXey9hefxZlVDlxiBr9SHOJp/DjHV2Z0p2TbAQVY3QbKi2Pp/fd3qExY2GvjeTQ+/
         J5e3xcFiMzoymYwW9XY91AfF5aKoHn/yyLd9f5U4PvdCv2yclhsDtMpKYxYk1sRyE7gS
         nscr0f8l7XYD/mcHOmbtDuZEBvTVJyJFdhP9BWb0Tk12FrNDPyo7qiQ5UAwH7bL5aUn4
         +51hsVY3TCpW4bO+tWckNt7KO5NYlhcER2sgjZZhnDe9ddbdz7ki+40auQDGtHS4ZD2f
         m+5rITosgqhkSD4Y11i9PNBkn/0ucPUytoNTF0Fmfof/ihi8cbLarAc9Q414/cvDfElR
         A9PA==
X-Gm-Message-State: AO0yUKUW/1yUk/sBE4nJMJd/5opysgHEhYuRDyP+QJ7fo/4ICJ2eIAz9
        x0ZKnCbefJYLI8SXv/HhrSEmfO4llWFlpw==
X-Google-Smtp-Source: AK7set/ojwAZhkLZdOtLNLtiYVw193OF2MhxFBdmtJMIyl1aGLxXwdvpGXqkZ/g53QpLN4tMb02PHw==
X-Received: by 2002:a05:6402:43cc:b0:49e:a0f7:9a75 with SMTP id p12-20020a05640243cc00b0049ea0f79a75mr3367431edc.12.1675166043194;
        Tue, 31 Jan 2023 03:54:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id dn10-20020a05640222ea00b00482b3d0e1absm8199796edb.87.2023.01.31.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:54:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMpD8-0021hy-0E;
        Tue, 31 Jan 2023 12:54:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Tue, 31 Jan 2023 12:31:43 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
Message-ID: <230131.86tu06rkbp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 31 2023, brian m. carlson wrote:

> Part of the reason I think this is valuable is that once SHA-1 and
> SHA-256 interoperability is present, git archive will change the
> contents of the archive format, since it will embed a SHA-256 hash into
> the file instead of a SHA-1 hash, since that's what's in the repository.
> Thus, we can't produce an archive that's deterministic in the face of
> SHA-1/SHA-256 interoperability concerns, and we need to create a new
> format that doesn't contain that data embedded in it.

I don't see why a format change would be required in this context.

If a repository were to switch over to SHA-256 wouldn't a better
solution to this be to disambiguate whether you're requesting a SHA-1 or
SHA-256 derived archive in the URL? E.g. to never serve up an archive
with a SHA-256 embedded in the header at:

	https://github.com/git/git/archive/refs/tags/v2.39.1.tar.gz

But require a URL like:

	https://github.com/git/git/archive-sha256/refs/tags/v2.39.1.tar.gz

If you did that then existing archives would continue to have the same
byte-for-byte content (assuming that the result of this discussion is
that we support that forever), but they'd always be generated with "-c
extensions.objectFormat=sha1". For always-SHA256 repos such a URL would
fail to generate anything.

But for repos that used to be SHA-1 but are now SHA-256 either URL would
work, but the PAX header would be different, referring to the SHA-1 or
SHA-256 commit, respectively.

Whereas your proposal seems to be that we should omit that SHA-(1|256)
from the "comment" entirely. That would seem to require either a one-off
change of all existing archives, or some cut-off date (or other marker).

If you've got a cut-off, you could also just use it to decide whether to
generate a SHA-1 or SHA-256 archive, and without that you'd be back to
the one-off breakage.

I also find it very useful that we've got the commit OID in the archive,
as it allows for round-tripping from archives back to the relevant
repository commit. Losing that entirely for SHA-1<->SHA-256 interop
would be unfortunate, especially if it turns out we could have easily
kept it

> Having said that, I don't think this should be based on the timestamp of
> the file, since that means that two otherwise identical archives
> differing in timestamp aren't ever going to be the same, and we do see
> people who import or vendor other projects.

Yes, I agree that doing this by that sort of heuristic would be bad.

> Nor do I think we should
> attempt to provide consistent compression, since I believe the output of
> things like zlib has changed in the past, and we can't continually carry
> an old, potentially insecure version of zlib just because the output
> changed.  People should be able to implement compression using gzip,
> zlib, pigz, miniz_oxide, or whatever if they want, since people
> implement Git in many different languages, and we won't want to force
> people using memory-safe languages like Go and Rust to explicitly use
> zlib for archives.

As I noted in the side-thread I think an acceptable solution would be to
push the problem of the consistent compressor downstream. I.e. if a site
like GitHub wants to maintain a potentially old version of GNU gzip that
should be up to them.

But I think it's a valid concern that we should guarantee the stability
of the archive format.
