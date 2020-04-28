Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C8C83003
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03AF208FE
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1KtNPeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1ABS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgD1ABR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:01:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67BC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15so22674482ybp.16
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wC7FW5UG1VW7jkLUvs31w0iU8KswmH3tc2yWFkzoPUo=;
        b=W1KtNPeAChSsaqwI8/6cunGXXhHdlc0/DHjuAr5cLRjRnOHSFOQcgqcKsDriwheoiR
         y7JidBpa4HOhmjWA11AuK13Zr8RUIsxKG3Cd7E8q0TYcTlAG61mMeUO24wRovPnNYWuP
         WAJ+EuzDKp9+vQ3/pOe3BCZ0LvdEvgzs0hCpAfqIUAL84hc6EHYcY0MIvWBt2Bo2TiHe
         aqrpholyLKy1JG3WimOHRfnoaIEIO2XBzE0TriEP54MqOmM2r7XEbkQs79VolHjaB1fL
         W1rkCwzolNWJznn727mJhsw9sqESqLIEJIrgqoSURUZ7T6BZ6K5h1QyQFj4VWUH9KDEm
         aseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wC7FW5UG1VW7jkLUvs31w0iU8KswmH3tc2yWFkzoPUo=;
        b=U+tip10bdBREZZmi8tOJRAJ9y/Fes3rVuatByPhg6lUnwtk5w9lelipzTLUkBXnmwj
         aMmTd48ijFMwJSm6Wvkav1iMgpGjctEGgCiTZtmz2MrZJwWs68bShiH0wEa6gVZKhBFV
         Apc+vX0fK0qQBZK0CXqglQbTs3lqG8eZ8TlgVyI1pz4WfEjiSdghT1y6NtsxkWo9a4AA
         HhCUHjYZW3tO1Ol/eQvDnDc9sxKnc+HKgMzAGeF/EURrOrlfX+n+DuxpKYjViQHaVzXg
         E+sIbUQxoEN1mMLgsRxDP8BBCeQzau7Jez8zqAwbis0y78PvVqnxhz6i/O72MuV9lqP5
         FFHQ==
X-Gm-Message-State: AGi0PuZYq+52r82no/YkdE1aym79FhsHQdidmrUikSUdXT0Q3qrOAcdY
        jo5pH41Zv3/0JEBuRqYt6WeOclf1jb/0yuLwyGVbA56YA4k2quTe3f9ieAEgTNRn3b0aLdsJ08F
        rYlDN0zJ1nn2rTXS+GgBuNeBBIQbzZ25mXEyminO9WjfFLbGNbg7GCYFpnMp1mCD9wBrrRD5Du2
        QU
X-Google-Smtp-Source: APiQypJq9Q5TmKb77eNxSGF0UBz3LSPixLqqjs4Tw71zfBIwgJOGMUmmqSviTX5An2aGOy1cOCifDVX93BTPNO3hSygU
X-Received: by 2002:a25:b8f:: with SMTP id 137mr42408782ybl.21.1588032073814;
 Mon, 27 Apr 2020 17:01:13 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:01:07 -0700
In-Reply-To: <cover.1587775989.git.jonathantanmy@google.com>
Message-Id: <cover.1588031728.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 0/3] Protocol v2 in_vain fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure if Jonathan Nieder meant the enum-from-process_acks()
change should be in this patch set, but I've included it here anyway.
Also I've removed an extraneous debug "cp" from patch 2/3 (previously
patch 1/2).

Jonathan Tan (3):
  fetch-pack: return enum from process_acks()
  fetch-pack: in protocol v2, in_vain only after ACK
  fetch-pack: in protocol v2, reset in_vain upon ACK

 fetch-pack.c          | 49 +++++++++++++++++++++++++++++++++----------
 t/t5500-fetch-pack.sh | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 11 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

