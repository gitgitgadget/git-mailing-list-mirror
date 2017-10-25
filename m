Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10749203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbdJYStR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:49:17 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:47528 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbdJYStP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:49:15 -0400
Received: by mail-pg0-f51.google.com with SMTP id r25so683402pgn.4
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9r9SqYeuYHBCFuVsSf2fbKAehH6jZB+dkBT541Ngr50=;
        b=rDqwkfc2BlP85MR/KjTf8752YzSpbwVJzIHM8Fr15ybBka2u+xg9WJrEdoVp6cZ5St
         w1X0k1cMw6W21PQg7VnRQwYFtGe02bDbC7Xj6pSdanFgT/Sn39X/5xwr2w1+cVsyQEHX
         guUG/SZcRN+jW6ywO6aq3+WJN1wb4KgKKKCD3aor6HkeLBCD2idW8ycynuWMs0sA011j
         zuZNlZb1AnvTxcWKrlsCO1er1vBi63D7COeW9TTLXaAGzC9PftKPqKzTZsu3k1ix1gNC
         uUE8Y1cQC/ge5thTIhv3uxmiGpDLVZHAGC+i5UIUyXJf4VAlvycVPohoD8DufUaC/GyQ
         c5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9r9SqYeuYHBCFuVsSf2fbKAehH6jZB+dkBT541Ngr50=;
        b=G3hN3XM6U++CrtYb08CcC0j4hO3RujN65014p+1gXHsu6PKV1UukEm+5uTmyMNd3+t
         FEp+Th8uP3oGAqme0QaxqG0yXnIGtlo45V0a8CsY/S84MO+kqj95M6mBz+WCAE/RV5ZM
         j/bt/GsVqJ1XL/puIDNU0L2M8CxgCUg3ep9LUXAmJ9PzilBcpRE/UTy+lnBG6Ttv/cMz
         kopD3O1cJ8Is/81BfLdHRbdgJanavIBQaBd78hTxSPYKViGubYY2nbpp+QMiVThEnbAx
         nWSIOhvpFXUbshLwDKw0nDU1w6Ne5PGbW2lQELM7qhcvB56fCfr0HDZyNdG+/w0qisJK
         65gw==
X-Gm-Message-State: AMCzsaU7bti0YoA8sPGZ67rcJk7GbLjr0g5YBfaT8rKDVCEEopxM1nca
        eWkfAfFW0mb/SDfDUoy5on0w3Wom0mA=
X-Google-Smtp-Source: ABhQp+TGf7bXy1IZV4W6qWOMXzDmzwpwYJla85wk/bo3IFz0zOZ+iPV59ZSj5P/Cd89IlbrzUmu6yw==
X-Received: by 10.98.214.76 with SMTP id r73mr3005929pfg.261.1508957354539;
        Wed, 25 Oct 2017 11:49:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id x1sm6061308pfh.113.2017.10.25.11.49.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:49:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        peff@peff.net, sbeller@google.com
Subject: [PATCHv3 0/2] (x)diff cleanup: remove duplicate code
Date:   Wed, 25 Oct 2017 11:49:10 -0700
Message-Id: <20171025184912.21657-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V3:
* changed parameter names back to xdiff standard

v2:
* I realized that we don't have to change the hashing function of xdiff;
  we can rather change the hashing function for the move detection,
  which is less fundamental.
  (That way I can shrink the series down to 2 patches)
* commented and renamed function parameters in the exposed xdiff functions.
* applies on top of jk/diff-color-moved-fix.

Thanks,
Stefan

v1:
Junio wrote:

>  * I was hoping that the next_byte() and string_hash() thing, once
>    they are cleaned up, will eventually be shared with the xdiff/
>    code at the lower layer, which needs to do pretty much the same
>    in order to implement various whitespace ignoring options.  I am
>    not sure how well the approach taken by the WIP patch meshes with
>    the needs of the lower layer.

This series does exactly this; although I chose to reuse the code in
xdiff/xutils.c instead of the new fancy next_byte/string_hash, as that
code has seen more exercise already (hence I assume it has fewer bugs
if any as well as its performance implications are well understood).

However to do so, we need to pollute xdiff/xutils.c and include
hashmap.h there (which also requires cache.h as that header has
an inline function using BUG()), which I find a bit unfortunate but
worth the trade off of using better tested code.

Thanks,
Stefan

Stefan Beller (2):
  xdiff-interface: export comparing and hashing strings
  diff.c: get rid of duplicate implementation

 diff.c            | 82 +++----------------------------------------------------
 xdiff-interface.c | 12 ++++++++
 xdiff-interface.h | 16 +++++++++++
 3 files changed, 32 insertions(+), 78 deletions(-)

-- 
2.15.0.rc2.6.g953226eb5f

