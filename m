Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4BB1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 22:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdAZWYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 17:24:25 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:36674 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdAZWYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 17:24:24 -0500
Received: by mail-it0-f53.google.com with SMTP id c7so139255258itd.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9D69o/7DHmqciBkmip1tV1/Kfud0OuJ8LyKjp8AahDk=;
        b=Qmcl1jlk/HFMV8ZQIuMy4PgGdsUgCISwyvVvG8B0NwAziMz6t4W1fumAK/oGQTg5uS
         Nn14oL8sOcYSB9SxfCqeZlmJBkZIiFrs1KIWkmlNev7hiTX6MGQL2YRS92EKZdt2aj/r
         6WjWJ5ikQBdIZNMGDk/jPskm2YrPdPmJwQVUISwTfvEDEjD90Kn4lap+uzHCYojaO/gM
         ZlHwVnI+Gvb/t9nRXHqTKLyTNpYKE5r32XNNUvheA6JBR85h+55q3m3SGiwKxjuCKcZT
         DTOLqrpqSnKYgHUFiRa/sEvA86xQcFrmMqhKJ+AhuuxEgRwM+YMIwjsEMcSKCf1D+mdl
         cirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9D69o/7DHmqciBkmip1tV1/Kfud0OuJ8LyKjp8AahDk=;
        b=P/9SEgtoB0g052azDITlVAJX45F/28kR6k1cIJ6aHjissSqe353mPCkJQ2Y8XYsolv
         uxR3Poy3KlqaoDHSK4L/TvvyX7NSYeRjjzxg+YYFq4gVa7nWO1wiQmnaULlJ9HJh0O+K
         e/tHCxmXsdsozT1dqlAisNn5Nso1ws3bfikbWZwl5Xi8RbyKPUpSG2Mz4/UXmqWD98rY
         VU53M5Z8yb0PYRhMWIRi5fL2/gCUYU9UqQNb/M8ndKOwOZLf9THSQdx5FwpIo8c2vpli
         qs5OPNPrYqnTDwGVRsK47p63g6wEE5I7tKScY2Z+f0CB2+WQU72HusYNwjDeGCXKyLEV
         KEVA==
X-Gm-Message-State: AIkVDXKMcVGYY9fueg4Qs8ZmRk/E4bY1/HlbHMHlGOXDAc/VUSki9s8M8wCzVpwR8O72tm8BL461f377PYFzP6oo
X-Received: by 10.36.4.2 with SMTP id 2mr690278itb.116.1485468926346; Thu, 26
 Jan 2017 14:15:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 26 Jan 2017 14:15:25 -0800 (PST)
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jan 2017 14:15:25 -0800
Message-ID: <CAGZ79kZgx1wQSCQv2xHYK341+nb=EOSTZacoznebNE=_M3JweQ@mail.gmail.com>
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
To:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:02 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Hello everyone - this is a proposal for a protocol change to allow the
> fetch-pack/upload-pack to converse in terms of ref names (globs
> allowed), and also an implementation of the server (upload-pack) and
> fetch-from-HTTP client (fetch-pack invoked through fetch).
>
> Negotiation currently happens by upload-pack initially sending a list of
> refs with names and SHA-1 hashes, and then several request/response
> pairs in which the request from fetch-pack consists of SHA-1 hashes
> (selected from the initial list). Allowing the request to consist of
> names instead of SHA-1 hashes increases tolerance to refs changing
> (due to time, and due to having load-balanced servers without strong
> consistency), and is a step towards eliminating the need for the server
> to send the list of refs first (possibly improving performance).
>
> The protocol is extended by allowing fetch-pack to send
> "want-ref <name>", where <name> is a full name (refs/...) [1], possibly
> including glob characters. Upload-pack will inform the client of the
> refs actually matched by sending "wanted-ref <SHA-1> <name>" before
> sending the last ACK or NAK.

I have reviewed the patches and think they are a good idea,
cc'ing Jeff who you linked to and who had some ideas about the protocol as well.

Stefan
