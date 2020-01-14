Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDDC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551AA24672
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMbAhp5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANTDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:03:44 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43679 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgANTDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:03:43 -0500
Received: by mail-pf1-f202.google.com with SMTP id x199so9312728pfc.10
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vIzmArIgyV54b1C+nCes/DBaBx+O0LOJTiYsfK1ggCo=;
        b=nMbAhp5PjT8SJVEDHW9/Xupq/1EsH9PEUX6u4w0qtCmy8cG+PTDIBLTPjWB9krVHbc
         +BsMbRjmUjsNCBeWRCpoA6tI7A/8fSVLKlTpTZW6Ka2Bx6xmpbxG/MCzPNQ+SVi3X9qJ
         onZ4bloCafeCLubFjD2DfmHz3QJoQT0YAtc/h0acaOVUrjWbF7Pk0OSjF4/v33VqT40O
         LyY41btvTafF7r3jCpJJXoSOMd2cSfKy2CJSFYXHWSwklpcbjwxeAEoEKKq7g+8PyHg1
         Wjr4b+MFA34+Suf8RmeC2YSV/goDcTLwZ27O6jG3gwgSubnRXqxE613XLL/dRm7m22uq
         grZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vIzmArIgyV54b1C+nCes/DBaBx+O0LOJTiYsfK1ggCo=;
        b=Q18Bxp4Gr8AkpLTTId9RtT3Pb9QDaHl4SnYQV9lBEhEfTAbnTWKquL50jDoVzr9jKl
         /ZeOcXo1jL36WazTmLfC7LG3a37ZD+l9SblyvMOvIvPCa6MqydJhIni1K5SgFS3Q4DMb
         SeE0ChBvuRNnyXQM3ECRNfQK1Z+YwmdziPnrSEZen6A/85e2X0eDsMZONIC9xbnEP36L
         h6T2VQ+9YAUmA9stfsbtEHganGsgKz6FfcEwBJwil88V5sqStqGjy4ngJJz9reRPXNq5
         5iilqEssgfacQV3+vl6heNXv8ImLSNTqRXa8eCOLGCjohKL9AVUQZccQ5k96RZS5Wy+i
         tDsw==
X-Gm-Message-State: APjAAAU++c3WYCndSkzrRwZMEWMrAKUai57cjb8ubCBHszmqrN7SJqTG
        cpzl0i+ijF2EDKQO3fZ0RyHCSIQpXhuT5+tTyifq
X-Google-Smtp-Source: APXvYqxP+NKIMdymuNdywGyr66BSS4v6k55O2ki/LH+gbTj8JqF7IC0etoEueg6k9f62MYcNTIX2tKO2CCs7iiBgekVZ
X-Received: by 2002:a63:642:: with SMTP id 63mr27756465pgg.73.1579028622810;
 Tue, 14 Jan 2020 11:03:42 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:03:39 -0800
In-Reply-To: <d4361b6d34513a3fdefa564d10269f60d4732208.camel@novalis.org>
Message-Id: <20200114190339.120452-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d4361b6d34513a3fdefa564d10269f60d4732208.camel@novalis.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [RFC] Extending git-replace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     novalis@novalis.org
Cc:     kaushik@twitter.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That is, would it be sufficient if every replaced file were replaced
> with the exact text "me caga en la leche" instead of a custom hand-
> crafted replacement?  I guess it's a bit complicated because while
> that's a reasonable blob, it's not a valid commit.  So maybe this
> mechanism would be limited to blobs.  I thought about whether we could
> a different flavor of replacement for commits, but those generally have
> to be custom because they each have different parents.

Since the original email just discussed blobs, I'll confine myself to
discussing blobs. (Commits are trickier, as you said.)

> And if that would be sufficient, could promisors be used for this?  I
> don't know how those interact with fsck and the other commands that
> you're worried about.  Basically, the idea would be to use most of the
> existing promisor code, and then have a mode where instead of visiting
> the promisor, we just always return "me caga en la leche" (and this
> does not have its SHA checked, of course).

Missing promisor objects do not prevent fsck from passing - this is part
of the original design (any packfiles we download from the specifically
designated promisor remote are marked as such, and any objects that the
objects in the packfile refer to are considered OK to be missing).

Currently, when a missing object is read, it is first fetched (there are
some more details that I can go over if you have any specific
questions). What you're suggesting here is to return a fake blob with
wrong hash - I haven't looked at all the callers of read-object
functions in detail, but I don't think all of them are ready for such a
behavioral change. Maybe it would be sufficient to just make this work
in a more limited scope (e.g. checkout only - and if we need different
replacement blobs for different object IDs, maybe we could have
something similar to the clean/smudge filters).

> This could work together with some sort refs/blacklist mechanism to
> enable the server to choose which objects the client replaces.

In the original email, Kaushik mentioned objects larger than a certain
size - we already have support for that (--filter=blob:limit=1000000,
for example). Having said that, Git is already able to tolerate any
exclusion (of tree or blob) from the server - we already need this in
order to support changing of filters, for example.
