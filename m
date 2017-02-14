Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AFB2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdBNJlE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:41:04 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35794 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbdBNJlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:41:02 -0500
Received: by mail-oi0-f67.google.com with SMTP id x84so1420994oix.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HCV6VOCZMITq4D2WdfzccN2nL9p4jfHGbI4z/L/zagA=;
        b=PdzWhKVbfRuvUxBwYSNNY42imDiUZrNzN9Wjo1bPCP7BPMJo58clGlY4P0WF8YP14K
         K5eCf9ahXM3nPzYHja+jUkooqdy+9i3dnRv9ZMrQhwNucmbUD4ZA1PQ35S3yEMAbGLs4
         RmHLuNcT9xUS6XKObVmTAJFYfB/BiG1on5L9TDeruFMlCkoiBZaNHaLkXqa+BE0rHX04
         2tu5o8FDVaeNwsNuosR2D/QHxuUagxGmUWUva1N5wOw7gL+dBYs+UvEMXzQtytje3MsR
         V+eCkEKKctmPQSrO2LFcTeMrR3lzi0vTEi4jN5Mvt7emVl5xdt2jP3X/OoADOTmBgs7L
         5I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HCV6VOCZMITq4D2WdfzccN2nL9p4jfHGbI4z/L/zagA=;
        b=A64oFPrJoDuJ77dWqbT7iJmE0TNd5BQLbnOXvXr5TjOZJiFJovF5cGfNzwT5Xh1g/2
         Zoh/ujA3TZCH9BzVg9pbgdd61Sm7xAQlRm+u1YykP6MgdHh9E7WrRLU43vYKfeK8bwWn
         EPPPK5SCLOg70rx1FvAVwojvKU/vKl/1o3m3D1AzDPJ1ikP4GJr/FxffKGxdSYEe4IK6
         znb+/ry+jvVJdkZLpd9DfP3GKSRwbNfkhLdngl1zmMNM5pInZ8DJ/iHuFT9UXlhakei6
         VuaQUQj0OWrgGFYBnmTd8kf9xvl6EgtV6ffyjxNdy+Eobee/oyU627oYJTURQjDxLafA
         uD3g==
X-Gm-Message-State: AMke39kNHkbB94f12ZASJ+66xdwfQ0dGmOoGsRms7lFeTdEOHYw+7YhsdZbK81WhtBQWrwsy68bsLoE2imxC4w==
X-Received: by 10.202.182.7 with SMTP id g7mr15305560oif.175.1487065261453;
 Tue, 14 Feb 2017 01:41:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 01:40:30 -0800 (PST)
In-Reply-To: <CAGZ79kYkc-_=RiK1uJ+ndhQu=B8u=UDVusXZu-dYe7KnGNye3Q@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-7-pclouds@gmail.com>
 <CAGZ79kYkc-_=RiK1uJ+ndhQu=B8u=UDVusXZu-dYe7KnGNye3Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 16:40:30 +0700
Message-ID: <CACsJy8D=qFQ2_62e4oO1pSBz4JfZV4Zcoai=Ghjw5DTaNxrwog@mail.gmail.com>
Subject: Re: [PATCH 06/11] refs-internal.h: correct is_per_worktree_ref()
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 5:37 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> All refs outside refs/ directory is per-worktree, not just HEAD.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs/refs-internal.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index f4aed49f5..69d02b6ba 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_store=
 *refs,
>>
>>  static inline int is_per_worktree_ref(const char *refname)
>>  {
>> -       return !strcmp(refname, "HEAD") ||
>> +       return !starts_with(refname, "refs/") ||
>>                 starts_with(refname, "refs/bisect/");
>
> you're loosing HEAD here? (assuming we get HEAD in
> short form here, as well as long form refs/HEAD)

I don't understand. if refname is HEAD then both !strcmp(...) and
!starts_with(refname, "refs/") return 1. If it's refs/HEAD, both
return 0. In other words, there's no functional changes?
--=20
Duy
