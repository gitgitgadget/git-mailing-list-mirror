Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE2C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJUXUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUXUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:20:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2E19ABE5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:20:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u10so2449094ilm.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1bR4KLNcfJfbt7bRiu7K77OpwRUiF8sm7glZXebr6Q=;
        b=o7BwQfOIOk5oFKvfYc3/A/m087r+tcbybl8gKJBnNqBImxBcrucUQY0j0Yy5mCNpnD
         q787Xymul0caWpNmt79+SAfOEW00NyiBVWpWsBrIZ1maeOrpMBlXsOuq5R3gYxmsZALY
         n/01P2XglsFq23b+THgUhR6uMp0YelsmZk4l5/MWbx4T+JWPkDHoZQuFeSnu+Ya9v2Ih
         y8C7aMa7YzNfjOIitEkIatzHuR2PYbfX3rfssz3WsLUj0mo7bHSkhd/bjid7tZQSApU4
         IT+Dz3LVPYXR4+6vLnkl/qqFwncd2s5q7u8I8bIf8b1iUAOECKEPRwHbjrPSDW5USXle
         SEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1bR4KLNcfJfbt7bRiu7K77OpwRUiF8sm7glZXebr6Q=;
        b=y9cq5wz5DfbhZ3oRXH2YG2IKl85HdSXXHaPaGZebnyLfEaYh0C/0Vy2NUlAQd/EzlA
         C7PmW5DQH8hWryQmgnAzdBqxYDcUuYyu+zXqNHDcTNvwtCnWA6TSNzuPGLIoxQ0/QGvr
         S9cLhfCbLbDJPA1UR577ePB/srIz15QZU6sJMec8u0s6Jr8AcuqW+te4gbfhU/eqUuuR
         JPI8vFBJAe4WF8DCQ8VhKiwKayi+XWrbC7Q/2wyQuVgfr8exQuNpYjV3ZikeLg9GG0Zn
         MQLLKVkN3ZnAK8pb2t8u2pua7WqkBJuOKk4/SDIl/9kAGcnyri1fPmYkMxlnf7/r4H9r
         a49g==
X-Gm-Message-State: ACrzQf3s5WBs1dXVuFPa61ZaLOhgtyjk7UCfkZtDgqVNlqMU7rq/yqct
        kH9tSZ5AXXk13P7RhruJC0UHg2bnVd3qYiZo
X-Google-Smtp-Source: AMsMyM4B/xzgXv3NhMuXXirMMs6YmhYjDI1eZkUJoccWjqhgTOvamPWfRaVr0ePUegohHAJQlYatFg==
X-Received: by 2002:a05:6e02:19c8:b0:2fa:a5c2:f837 with SMTP id r8-20020a056e0219c800b002faa5c2f837mr16030288ill.1.1666394449735;
        Fri, 21 Oct 2022 16:20:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p8-20020a92d688000000b002fa40226722sm4460236iln.84.2022.10.21.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:20:49 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:20:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 2/4] repack: populate extension bits incrementally
Message-ID: <Y1MpUHBQtq8uP5Uy@nand.local>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSkubbDBh0Ma1G@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MSkubbDBh0Ma1G@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 05:43:46PM -0400, Jeff King wrote:
> There are two small problems with this:
>
>   - repack_promisor_objects() may have added entries to "names", and
>     already called populate_pack_exts() for them. This is mostly just
>     wasteful, as we'll stat() the filename with each possible extension,
>     get the same result, and just overwrite our bits. But it makes the
>     code flow confusing, and it will become a problem if we try to make
>     populate_pack_exts() do more things.

Hmm. I agree with you that repack_promisor_objects() calling
populate_pack_exts() itself is at best weird, and at worst wasteful.
>
>   - it would be nice to record the generated filenames as soon as
>     possible. We don't currently use them for cleaning up from a failed
>     operation, but a future patch will do so.

That said, I think that it's worth having a single spot within
cmd_repack() that is responsible for populating the generated pack
extensions, since it protects against a caller forgetting to do so (and
then tricking repack into thinking that we didn't generate *any* of the
corresponding extensions).

But I'm sure future patch you're referring to cares about knowing
these as soon as possible, since that's the point of this series ;-).

I think a reasonable middle ground here is to do something like the
following on top of this patch:

--- >8 ---
diff --git a/builtin/repack.c b/builtin/repack.c
index b5bd9e5fed..16a941f48b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1002,6 +1002,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			return ret;
 	}

+	for_each_string_list_item(item, &names) {
+		if (!item->util)
+			BUG("missing generated_pack_data for pack %s",
+			    item->string);
+	}
+
 	string_list_sort(&names);

 	close_object_store(the_repository->objects);
--- 8< ---

which still lets you eagerly keep track of the generated pack extensions
while also protecting against forgetful callers. Obviously we're relying
on a runtime check which is going to be somewhat weaker. But I think

The patch itself looks good.

Thanks,
Taylor
