Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FEE1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 11:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbcLHLGQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:06:16 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35089 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcLHLGP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:06:15 -0500
Received: by mail-io0-f193.google.com with SMTP id g8so195548ioi.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bns7oqLrVD/OMU+A+qmGPL/AZzx5S4A2FiOKF7DtSW0=;
        b=mNGIOJm8hngjK6tg+itBgVCkyQUFKh1YPiJ0AZHvXlb17+IkT/rMgoTX21KF1Kmxrp
         +Pb2P8cs35ArXumXKdGn8M8cWPQxbOrddNAxgvcqcXa4MV7QC5ivkdggYp3AhsF3Z31T
         7bc0rWgbvtVLlFcRt2H9SCi7X8QNiQwSH1XtpPpfl0fAWHzIv1WjCRRgQzc7nSPW4Drk
         n2/33y14l/gBOTvy8JgnqQQnPeF8QS8tyMD/W2urUneeUdhxSh32KQipOrrvAfHwPBSX
         8qdB8+I2oJrTQy/sU71afs+9ucs+YaVPt9aikRBD0IgZmcBIb7YvDs8aB4da06kcY2o9
         yYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bns7oqLrVD/OMU+A+qmGPL/AZzx5S4A2FiOKF7DtSW0=;
        b=PPQSBf0Z3UdTS5L2N8fHWsIpX5/depFy8dgF/mfDyi5NLT1qq9sN0K3AvhVKEe4YAS
         8OKKzSy3vOnCMFMBnZc9qoSof3KRKTf8DnegAIiM6mKsDl5mO9FjgKGBxfwb68Q3eExD
         hYY8krBTknsff10PZnrbrvqEkk2KQVnjZIAJ92pqzHSS1Lw90iI7oUsUUWIjJOOpx1AW
         SnXWuHrNkBi6iRutgZ/AGbMRdMZcOT3KX9udt9YM4K8H31Vfx8AUCWww5FgaJnAUxv2F
         /nS8KJllU49BCOui0Qs7t//EQpQTZcz6I+vc6KKFFDK+BnNqMcqX3xZoKMaLrvNvwJli
         2U2w==
X-Gm-Message-State: AKaTC03No7fDKniR+tBvjXiR2QmqkTZUFnRuPFMdInuIKx2SQh54xLHHhIoqh9PotQgL5j4sZ6s0qoxnRV7bkQ==
X-Received: by 10.36.26.148 with SMTP id 142mr1117225iti.74.1481195174862;
 Thu, 08 Dec 2016 03:06:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 03:05:44 -0800 (PST)
In-Reply-To: <20161208000357.GJ116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com> <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
 <20161208000357.GJ116201@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 18:05:44 +0700
Message-ID: <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 7:03 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/07, Duy Nguyen wrote:
>> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
>> > Convert 'create_simplify()' to use the pathspec struct interface from
>> > using the '_raw' entry in the pathspec.
>>
>> It would be even better to kill this create_simplify() and let
>> simplify_away() handle struct pathspec directly.
>>
>> There is a bug in this code, that might have been found if we
>> simpify_away() handled pathspec directly: the memcmp() in
>> simplify_away() will not play well with :(icase) magic. My bad. If
>> :(icase) is used, the easiest/safe way is simplify nothing. Later on
>> maybe we can teach simplify_away() to do strncasecmp instead. We could
>> ignore exclude patterns there too (although not excluding is not a
>> bug).
>
> So are you implying that the simplify struct needs to be killed?  That
> way the pathspec struct itself is being passed around instead?

Yes. simplify struct was a thing when pathspec was an array of char *.
At this point I think it can retire (when we have time to retire it)
-- 
Duy
