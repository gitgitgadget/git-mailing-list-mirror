Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D0D20188
	for <e@80x24.org>; Thu, 11 May 2017 02:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbdEKCqD (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 22:46:03 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33625 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdEKCqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 22:46:02 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so6646885pfh.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8dt3yzkFv4uUe/AhPQCYnUX0ShzOggqtTsw5Z5ewdxM=;
        b=PJI+HwgbKSPpYJf5M8mGLYM+cQeDApZjAuh5BnMBQd6PlOOlEEhoicCoaP+wqAHCsj
         WgvPLTjMMK5+qQId/Dw7Filq+piAHwZJDQzJdTckFlOALtbPKwEsKmZzq7dV/1S8H+/1
         JO25Sa6AsGGB6UDcyH6dqhoNXmJsV3YKV07mKmTWD1PGJTNfx3RLPCI32LnwC5mwighO
         CqEjwKveta/eA/i5IlrjBGZvohHjKNf8xqVWPsYYP3UWn3MRCx70eoKuUYuakDtSR6wj
         BKUV4I+S+hbWl4ZLzeKVVTKRSvIiGRYdWxFNmF98vIG5fx/GK9pakqXzz/lYc16oEcjv
         wA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8dt3yzkFv4uUe/AhPQCYnUX0ShzOggqtTsw5Z5ewdxM=;
        b=HnOSraVHFqTvEZ/50tfjJvhOIRPyGJIJ8jOsUM9vgbxi3Z51Dsznt0I8q9Zjfs0wT/
         Q7qvf0uIKl6U59wnMaOGJ1eoQlixCHoJG6HV0UDPDxJCicE6Wv5jiTUDvxU/zp/eZgfw
         gdQmYikVKan+qTvNqu5oCxc4Mq+6qRkRhamAFl9SJtANX7IUcALEmZ/kMlxaUkpL5TlY
         m9w3zKb0rLvLSMgTAuQKRTf5EIk5CmlI/dBg6uGpaY0n33urVAJGaemxkieSusxBNRex
         TAysVtpedoZVLPzBeCb44SCgu/TyZvueAtGCkrGJNcdVv1RzVqkWELnEyFqm9zbJW0hy
         ml8A==
X-Gm-Message-State: AODbwcBiOs3l4Jh9QubkVXitLnlZGjMB9x7U7JnHRWZHCetVAC2qJKE1
        3a9PXEHNCmtxj8dQvms=
X-Received: by 10.98.192.80 with SMTP id x77mr9779287pff.1.1494470761187;
        Wed, 10 May 2017 19:46:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id q28sm416429pgc.0.2017.05.10.19.45.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 19:46:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] status: show in-progress info for short status
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
        <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
        <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqu1oB2J2C9OoqaYAwdNOXT7f0kvHEHHZ4nXaefewBrNQ@mail.gmail.com>
Date:   Wed, 10 May 2017 19:45:59 -0700
In-Reply-To: <CA+P7+xqu1oB2J2C9OoqaYAwdNOXT7f0kvHEHHZ4nXaefewBrNQ@mail.gmail.com>
        (Jacob Keller's message of "Thu, 13 Apr 2017 00:20:19 -0700")
Message-ID: <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Apr 12, 2017 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> Personally, I would want this to become the default and not have a new
>>> option to trigger it. I think we could also extend the porcelain
>>> format to include this information as well, but I'm not too familiar
>>> with how the v2 format extends or not.

I started to do a simple s/inprogress/in-progress/ while waiting,
but Ævar reminded me of this discussion---and I agree with you that
this probably should be on.  Moreover, I think this should not be
optional (which makes s/inprogress/in-progress/ a moot point).  

Michael went the cautious route to make it optional just like the
"-b/--branch" option, but I think "-b/--branch" was a design mistake
and not something we want to mimic.  The long output format gives
the same information without "--branch", and giving "--no-branch"
does not even disable the information in the long format; "--branch"
is only effective in the short format, even though giving it to long
format does not diagnose any error.  

We should have just enhanced the feature unconditionally, I would
think.  But fixing that past mistake is a separate issue.

>> I think the general rule of thumb for --porcelain is that we can
>> freely introduce new record types without version bump, and expect
>> the reading scripts to ignore unrecognised records (we may need to
>> describe this a bit more strongly in our document, though), while
>> changes to the format of existing records must require a command
>> line option that cannot be turned on by default with configuration
>> (or a version bump, if you want to change the output format by
>> default).
>>
>> I am getting the impression that this "we are doing X" is a new and
>> discinct record type that existing readers can safely ignore?  If
>> that is the case, it may be better to add it without making it
>> optional.
>
> Correct. But either way we should be free to change and extend the
> non-porcelain format without worry I thought?

While I think we should update "short" and "porcelain" at the same
time when it is clear that we can (e.g. we are adding a new record
type and we make sure that the current readers of "porcelain" output
would ignore the new record type), an update to "porcelain" can come
later, as long as we don't forget.  Otherwise people will script
around "short", ignoring "porcelain", no?

Thanks.
