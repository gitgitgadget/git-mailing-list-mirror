Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C40F1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbcIIKeR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:34:17 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33601 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbcIIKeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:34:16 -0400
Received: by mail-oi0-f43.google.com with SMTP id y2so132444271oie.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9qPqRZw/kIjHL5thBhMNH7SM7GDvAAiiEai4OytHQ44=;
        b=U/N+JGLEtmB+Zkg7t90KxX6SXWHs9neeY2K+krBLec6Ss3ZDHzDAYnYXFa0i7okYW5
         /hZ0lyz7l9762HvnXE/Fo9lsKOzf1xvKeYVY8e8JM9i8dxLIzFI/qBIgwXEQHXbYXG8L
         D3ANJc6dUGOXxgKclOUqEz1tIn1N5JOQK+BVSttGc1gM4D0kAZD5L5xlZaUShyc4NHlM
         woEeJJlmRMNEf6cGs/yosryf7iAl4825KO6RIQy+GRJf7eL3XnunfGaaVaJBlaTEK7VQ
         zLJuD+myhEB/mB3mN3wzIbO+MuBF9uCJxGlIY7V01qx/Dy+hw/sbhorfsROdPPcydO5k
         7xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9qPqRZw/kIjHL5thBhMNH7SM7GDvAAiiEai4OytHQ44=;
        b=Ndxw2aHHwzvkApEFGouloNEU7QF9O7eVWttUQ7w4Hqf1EXYhnz6Kq3iP7+Z5Tnq4di
         Vsfox+76ottWhgNuqEM6PImra2bVpZSjWitm+bMRxkDQaYA9zK9xN/NJR1dEuNO1PG69
         K6R8QObTzzprrvOkqbWDVSwAHDLDYgN1OstkdKAnweX+Y2LwbwYpF12JMuKYe9pwBUA+
         CIibMy19UIMP/so1K7sJ9VoEU2KoQHlSNqvqgzRY5HtesKhbCwLgL1pNjTJYSQ+f090f
         KXQYYw1P+e3jQOq8ZxqwZPSKySAuE9FxFYwfBWPElbOcnlrxdIabFgaWOYOROqFhimyv
         q14g==
X-Gm-Message-State: AE9vXwMlL0YbgU8xm9ze8BBnENVz8WOVULq5OLE1MqfTf16Oh26zxqgllUjFJBwZl9bfUCgDat88aqNOi/b0DQ==
X-Received: by 10.157.47.36 with SMTP id h33mr3949177otb.140.1473417255799;
 Fri, 09 Sep 2016 03:34:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 9 Sep 2016 03:33:45 -0700 (PDT)
In-Reply-To: <xmqqbmzygoat.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com> <20160908134719.27955-4-pclouds@gmail.com>
 <xmqqbmzygoat.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Sep 2016 17:33:45 +0700
Message-ID: <CACsJy8D3ek5KRN_L2Kc-s=eQkeu8L2Nsd6F9+R9jY1BFRLQr3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] init: do not set core.worktree more often than necessary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +/*
>> + * Return the first ".git" that we have encountered.
>> + * FIXME this function for not entirely correct because
>> + * setup_git_directory() and enter_repo() do not update first_git_dir
>> + * when they follow .git files. The function in its current state is
>> + * only suitable for "git init".
>> + */
>
> Would it be possible to move this to "init-db.c" then?
>
> The very first thing cmd_init_db() does to what is in the
> environment.c is to call set_git_dir() via set_git_dir_init() to
> tell it where the ".git" thing is, no?  Can't that code remember the
> location itself, instead of adding code that is known not to be
> usable by other callers?  That would help avoiding the future
> confusion.

Good idea. I was fixated on read_gitfile()m it didn't occur to me.
--=20
Duy
