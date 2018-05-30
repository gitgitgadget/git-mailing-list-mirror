Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DB21F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965133AbeE3Ipn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:45:43 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40865 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964851AbeE3IpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:45:25 -0400
Received: by mail-qk0-f196.google.com with SMTP id r66-v6so13738430qkr.7
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8iYAQJiGbhcoQE8prBhyqga66a1il5fOPBfpQfOdjus=;
        b=fGQDr+SsJ9jJ6O8VDWbVahJgSMstETWqbEUZtHUqHgygzhAKqbslcL4V3+RRgwwNdj
         hQibua2xb8I8eKqL6kQYOTvQQFruIdJX33QBbFMghu/uD9ymTdl04gEm+X0N3tbSavQ5
         mAGRlrW9NxkuV5csffugFH85k37wXcfgsTLmp+TFjpAflhqKEo+lFtTAqHd9PClKPN6i
         aWBF5WFch00fSQoYpEPJL69bZr25Zslcbzke+M86piChx4iUQXmtDlCaGCVRZPJwTbDq
         wiqpNafR1YYFdkzk8D2B73SH07m+6uSZCC4AA7kuDi3H1vfRdlmZYXK4XLWcDXbl9keU
         CX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8iYAQJiGbhcoQE8prBhyqga66a1il5fOPBfpQfOdjus=;
        b=eb+5AwYf0d8SGvbHpLPaL8thzhPukmAGmoiikHx5iVEZWRlDb1irhoUsmWPxOSzPI7
         gMdK/PqfMV+yp8FRa2RXwpaiLf/F7oDUTnOhM2nmXUdacHHuNL6sY708Rm9VTefzYMBC
         pahoBVRxuOK6Nj3X7sU5rWspRyb0A2ed+/dTRwNFrqQWMRdgwrHValmHtgW04SfPrtxI
         +Uo8d+Lg6/WUJv86O9vkIOBbm3iYXVgM86YEq3L37ecXoCRq/plpZ5LnawOUGtyAwsBg
         tXwdPs5dp735u9PReGe1JwDmNmWVf1uVBODv7WVm6+4X7pRgRoUrvs69x853bIn1FjhZ
         S9fw==
X-Gm-Message-State: APt69E13DrjG2h4RO5O+w865yQGNxvstIWyOkgND83pxQ5kEt3O4DJKE
        +gIi94rJvy4xaLGOi8FbvO6sKTjgwpTg6903GC8=
X-Google-Smtp-Source: ADUXVKIvtaEhF1A7aC07HOgYYCIOHb2csmKrZU6Tni05d5p4y5f9mFlbFFNBxIkT29Mp/FgktJZEuQJJxZvv2hVnjKQ=
X-Received: by 2002:a37:270b:: with SMTP id n11-v6mr1462295qkn.91.1527669924527;
 Wed, 30 May 2018 01:45:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 30 May 2018 01:45:24
 -0700 (PDT)
In-Reply-To: <20180529053037.38015-2-istephens@atlassian.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com> <20180529053037.38015-1-istephens@atlassian.com>
 <20180529053037.38015-2-istephens@atlassian.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 04:45:24 -0400
X-Google-Sender-Auth: 3U-tkMAYEtiiK6fLIJFVD_xD7zE
Message-ID: <CAPig+cTCDP0zJonDFXyv6Kue5y4PMPaveyjfvfTVNoifzYg-Og@mail.gmail.com>
Subject: Re: [PATCH] blame: prevent error if range ends past end of file
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 1:30 AM,  <istephens@atlassian.com> wrote:
> If the -L option is used to specify a line range in git blame, and the
> end of the range is past the end of the file, git will fail with a fatal
> error. This commit prevents such behavior - instead we display the blame
> for existing lines within the specified range.

Makes sense; the new behavior is intuitive and more friendly.

> Tests and documentation are ammended accordingly.

s/ammended/amended/

> This commit also fixes two corner cases. Blaming -L n,-(n+1) now blames
> the first n lines of a file rather than from n to the end of the file.
> Blaming -L ,-n will be treated as -L 1,-n and blame the first line of
> the file, rather than blaming the whole file.
>
> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> @@ -152,6 +152,16 @@ Also you can use a regular expression to specify the line range:
>  which limits the annotation to the body of the `hello` subroutine.
>
> +A range that begins or ends outside the bounds of the file will
> +blame the relevant lines. For example:
> +
> +       git blame -L 10,-20 foo
> +       git blame -L 10,+20 foo
> +
> +will respectively blame the first 10 and last 11 lines of a
> +20 line file. However, blaming a line range that is entirely
> +outside the bounds of the file will fail.

This documentation seems misplaced. Rather than inserting it after the
discussion of -L/regex/, a more natural place would be just above
-L/regex/ where -L<begin>,<end> is discussed.

However, I am not at all convinced that this behavior should be
documented to this level of detail. Doing so assigns too much emphasis
to what should be intuitive, thus wastes readers' time wondering why
it is so heavily emphasized. At _most_, I would think you could say
merely:

    A range that begins or ends outside the bounds of the file
    will be clipped to the file's extent.

and drop the example and discussion of the example results altogether.

In fact, because this new behavior is what most users will intuitively
expect, it might be perfectly reasonable to not say anything about it
at all (that is, don't modify git-blame.txt).

Thanks.
