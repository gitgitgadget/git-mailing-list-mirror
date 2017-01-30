Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7F71FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 18:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbdA3Sdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 13:33:43 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33735 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdA3SdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 13:33:06 -0500
Received: by mail-lf0-f53.google.com with SMTP id x1so112439944lff.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KQfixAxUNENA0R9jIAf3YLGVdIoVpvo0ygKWjqM3USw=;
        b=RSa7VKfuuxvxKiPFHAhl1uS50gKRXadHz3zRLPXaEk6BTXx7GTlsI4Y0TAMWDA6N0p
         JK36Q4Uyjq2lvMZeGSp/clwGTWMcNnPBlnyDqwdZM9rKDFfLpPMzvNpiwZ3/WIUsTcka
         gdsjYTaHXew7QE1iv+sq1KOUOEPiDkupBxAjcj7EajI65abScTi84J4eAF6d8++Ygvbd
         d2g1fs3fukZ8d2RHXQtSuuTpxKEM+q3ksqdNHo9bxe7MUur5nYG+DwuzLZWzLMhcen0R
         VKugItf8DqU8gt+oJLBC+5F4GtXMALVUnbrM9PkOC6SiBVQV8hu0X+9ix9H5TN28Z+UZ
         ZlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KQfixAxUNENA0R9jIAf3YLGVdIoVpvo0ygKWjqM3USw=;
        b=Qv+VphR/0XQrsuSLtLnXxCI3D/SVxEw2JbiQIFJReD7oIN06+NVLosy5FmKGRLYOWO
         hqa+/Kqb0wivUikPkSy6uqYCXFrmhJH+ESsk4J+4iYB7OSCV7g9A9mwrtjr55DkeT9lJ
         pCKxccKpldCVGil2N6pSqIHM+yeA8kj4itE54RNkNHx01t3F6qlPQx7wKBN4FGv+ZPo0
         KouDbP8BgQnCs3GrYZtvPcWG3q1z7nXiugXZaC2parlUH4dKoy0KV5NKFqxLubelN5Kw
         kRTV95Ens37sR7P+Y4a08Ej5ywSUkGL2BSCZ2DN1UECB5i2l1SAbmLnW8UzDPEfjQKeb
         Vn3Q==
X-Gm-Message-State: AIkVDXK7RojPZPVTDVemoRCgUksR4tOtjralpDXeJOxw0qsOLPYGXry+B+UXiancNmxgHHXbZgLzMrShx8L9Mw==
X-Received: by 10.46.20.14 with SMTP id u14mr3314821ljd.30.1485799002482; Mon,
 30 Jan 2017 09:56:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Mon, 30 Jan 2017 09:56:42 -0800 (PST)
In-Reply-To: <1485713194-11782-1-git-send-email-schumacher@kde.org>
References: <1485713194-11782-1-git-send-email-schumacher@kde.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 30 Jan 2017 18:56:42 +0100
Message-ID: <CAP8UFD3=vaFupEDay-5vrMBwK_YJezysUUvySxnUUZxuW7m_WQ@mail.gmail.com>
Subject: Re: [RFC] Proof of concept: Support multiple authors
To:     Cornelius Schumacher <schumacher@kde.org>
Cc:     git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jan 29, 2017 at 7:06 PM, Cornelius Schumacher
<schumacher@kde.org> wrote:
> This patch is a proof of concept implementation of support for
> multiple authors. It adds an optional `authors` header to commits
> which is set when there are authors configured in the git config.

I am just wondering if you have read and taken into account the
previous threads on this mailing list about the same subject, like for
example this one:

https://public-inbox.org/git/CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com/

> A new command `git-authors` is used to manage the authors settings.
> Authors are identified by initials and their names and emails are
> set in a `.git_authors_map` file.
>
> Signed-off-by: Cornelius Schumacher <schumacher@kde.org>
> ---
>
> When doing pair programming we have to work around the limitation that
> git can only have a single author in each commit. There are some tools
> which help with that such as [git-duet] [1], but there are still some
> limits, because the information about multiple authors is not reflected
> in the native git data model.
>
> Here is a proposal how to change that and implement native support for
> multiple authors in git. It comes with a patch as a proof of concept.
> The patch by no means is finished, it doesn't cover all cases and needs
> more tests and error handling. It's meant as an illustration of the
> concept.
>
> The basic idea is to introduce a new optional `authors` header in
> commits which contains a list of authors. The header is set in each new
> commit when there is an entry `authors.current` in the git config listing
> the current authors. When this config is not there the behavior falls
> back to the current standard behavior.
>
> When the header is there it is treated in the same way as the author
> header. It's preserved on merges and similar operations, is displayed in
> git show, and used to create a list of `From` addresses in `format-patch`.
> Email supports multiple `From` addresses as specified in section 3.6.2 of
> RFC 5322.
>
> When multiple authors are configured, they still write the standard author
> header to keep backwards compatibility. The first author is used as author
> and committer. In the future it might be good to implement something like
> automatic rotation of the order of authors to give credit in a fair way.
>
> To make it easier to work with the authors there is a new command
> `git-authors`. It sets the list of authors using initials as shortcut for
> the full configuration with name and email. The mapping of initials to
> names and email addresses is taken from a file `.git_authors_map` in the
> home directory of the users. This way it's possible to quickly set a list
> of authors by running a command such as `git authors ab cd`. This is
> useful when doing pair programming because the people working together
> usually switch quite frequently and using the command with the intials is
> quicker and less error-prone than editing the configuration with full
> names and emails.
>
> The command also supports setting a single author, setting more than two
> authors or clearing the configuration for multiple authors to go back to
> the standard behavior without the new authors header.
>
> The concept of the command and the mappings file is similar to what
> git-duet does, so that it should be familiar to many people doing pair
> programming. The behavior of git doesn't change when the new feature is
> not used and when it's used it should be backwards compatible so that it
> doesn't break existing functionality. This should make a smooth transition
> for users who choose to make use of it.
>
> Adding support for multiple authors would make the life of developers doing
> pair programming easier. It would be useful in itself, but it would also
> need support by other tools around git to use its full potential.

From what I recall from previous discussions, the most important
question is: are you sure that it doesn't break any other tool?

> This
> might take a while, but I think it's worth the effort.
>
> I'm willing to continue to work on this and create a patch which is suitable
> for inclusion in git.
