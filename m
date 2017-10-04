Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757302036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdJDCj6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:39:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38604 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdJDCj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:39:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id y192so11791305pgd.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6s50Qy4FY8/bYyHCJixmAvQF6rJFm/2mXiwc0hre9U=;
        b=S5FoKCiIZVtYaFdpq+yKx1ZNur6sq4e5TxG6WsW9pJ4kLbwIu0TdvNAPyDG4A9Ku14
         LAfeqTqFpTxkmoIzY7DvX46AW/dIYYuDfGhWRJpPMjRLUbfW+7a1qe/fYsRpg+oCaQGz
         Uw6/T4WDUpEzZ4RiJkbiQ3V+RXJc01T66LOl+V3yT/QVEa9o2AdbmXTK/CMQG28QDcps
         OCxaupJAFtJuuLz3vVWIJCw9JKE6+s5GSBgK8wGDir3pAj9LI75qiyo1lhrq+pVl1DwL
         iYql14UMm/OPB66urqdEuu3yr4ANrtx7OOsh1hqpjRsMlAnff2B5DJY0cK8CO+fAy2fs
         /nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6s50Qy4FY8/bYyHCJixmAvQF6rJFm/2mXiwc0hre9U=;
        b=iLZ512eFeLXNUzMXyrzP5B0Ict6cQmwrYUBHVko/lbXN7kjBYnHrkzfGF+4xTaIeaV
         5kOcUOZGQ8pdW1pJfrIIbkqwtj0DcLkyXnOqAOAhELpFzzBIONNY+AE3dzZuSWoMJ8oh
         YtI2tzWTGdNI92JQE2OBALJPX6jzmxaxVvJPfI9kwNiK3iXnYqDCXnw/aw2hZNxGWzVH
         1QsbrrN2PwcnugC1IaflufsrRKw5ZjaU3tAD9lpeVTDtu/cOyheLkfIBe3hPynhfWMKh
         ISTz/7ftjhFRq54Ivl1J4pf3SlG+pTKeYJ0TiDaMwFkBYu9mCzjyEnyyUr8DEB0b7Nfw
         Emgw==
X-Gm-Message-State: AMCzsaXu5Eo2YhkFXWgQMKCxNzlLMwrhdF/2Js1CN8APxPO1b2J026yf
        O+bo/VUPqEGA5AwYMyHWYJ8=
X-Google-Smtp-Source: AOwi7QBWJ5k28TIRAvnXqIvqP+HWJ4CmFjF48RuilJ913PCwAsoB1LkU308YgZkQVh50B1eD8M8E0w==
X-Received: by 10.101.77.74 with SMTP id j10mr11020458pgt.324.1507084796557;
        Tue, 03 Oct 2017 19:39:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:e14c:b8fa:a887:14e1])
        by smtp.gmail.com with ESMTPSA id n76sm15133962pfk.96.2017.10.03.19.39.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 19:39:56 -0700 (PDT)
Date:   Tue, 3 Oct 2017 19:39:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] strbuf doc: reuse after strbuf_release is fine
Message-ID: <20171004023954.GK19555@aiede.mtv.corp.google.com>
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
 <20171003221740.26325-1-sbeller@google.com>
 <20171003222414.GC19555@aiede.mtv.corp.google.com>
 <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_release leaves the strbuf in a valid, initialized state, so
there is no need to call strbuf_init after it.

Moreover, this is not likely to change in the future: strbuf_release
leaving the strbuf in a valid state has been easy to maintain and has
been very helpful for Git's robustness and simplicity (e.g.,
preventing use-after-free vulnerabilities).

Document the semantics so the next generation of Git developers can
become familiar with them without reading the implementation.  It is
still not advisable to call strbuf_release too often because it is
wasteful, so add a note pointing to strbuf_reset for that.

The same semantics apply to strbuf_detach.  Add a similar note to its
docstring to make that clear.

Improved-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> I think it's actually OK to use the string buffer after this function.
> It's just an empty string.
>
> Perhaps we should be more explicit: this releases any resources and
> resets to a pristine, empty state. I suspect strbuf_detach() probably
> should make the same claim.

Like this?

Thanks,
Jonathan

 strbuf.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 7496cb8ec5..249df86711 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -82,8 +82,12 @@ extern char strbuf_slopbuf[];
 extern void strbuf_init(struct strbuf *, size_t);
 
 /**
- * Release a string buffer and the memory it used. You should not use the
- * string buffer after using this function, unless you initialize it again.
+ * Release a string buffer and the memory it used. After this call, the
+ * strbuf points to an empty string that does not need to be free()ed, as
+ * if it had been set to `STRBUF_INIT` and never modified.
+ *
+ * To clear a strbuf in preparation for further use without the overhead
+ * of free()ing and malloc()ing again, use strbuf_reset() instead.
  */
 extern void strbuf_release(struct strbuf *);
 
@@ -91,6 +95,9 @@ extern void strbuf_release(struct strbuf *);
  * Detach the string from the strbuf and returns it; you now own the
  * storage the string occupies and it is your responsibility from then on
  * to release it with `free(3)` when you are done with it.
+ *
+ * The strbuf that previously held the string is reset to `STRBUF_INIT` so
+ * it can be reused after calling this function.
  */
 extern char *strbuf_detach(struct strbuf *, size_t *);
 
-- 
2.14.2.920.gcf0c67979c

