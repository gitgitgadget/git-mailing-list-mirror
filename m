Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEAFC32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 00:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE356206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 00:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMLAuba5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgAGAFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:05:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36622 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgAGAFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 19:05:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so21719810plm.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ygL2oEguUCIjoXs/ndTrPW+ZlhVF8DkdVGHNC7cO4GI=;
        b=GMLAuba534IbWmgbMwLFBZk9f6C1SbEgtCZi8u4VBJGJ2R/DnV8YceMXRNansBQHNb
         bd+Xw5b7dvBENCBeLQmiFMWa+dnDlVgrsoqXHSuNlSx6/sX5QeufP5mNKxvLQaIJdfpb
         10OTpIpuowriVLl0fkrQTOw8WWC6cFhv0VdzJ6ON3zRWs4pzLw71AZ/z4WdHliXpOSHU
         j1ALA+S7QtFxvxkd5T/MHkjxQX9GtDbm/bJXqfrVWCBDnXdhHrRrThtXQqwBRNWuHsJf
         ybWWdP7DwqCEFYjpbU1mxr1mqGeXZt9k/Z22jdGRxmuiFO3ZEw1bEF5uHstBkgK21QSb
         aRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ygL2oEguUCIjoXs/ndTrPW+ZlhVF8DkdVGHNC7cO4GI=;
        b=Z4cOAt4U+IwN4zfsIGyokVBhuv5i3IDI49h7rPmaJTaZ9mHKtsLzVkah+qOu+yHR4X
         kUJZA+wbzbT8IyX0kvWyfMT3jo0ORLqiLJJZnIk4W/dpUQ6iFGO2+Lga1CSNQKat9Nc2
         PZEHgShvkx6Jd8UWUi0rUt2w0OunhqRxb8xRvx5ArlZOkTcdO5qOF1ZPhZUNQlB2iOWw
         RiL3B3Uj/+zBRUPdI0U2umbc5C4wSnwQ86FO2LedsBtQsm/84g22ULZ5VmGHJGOn0vR+
         wA68QFq6V2ZEjEF0PHzbk+z5ABFLWUP/kzGnr3B7Mj0vi3GD6Ic9luHVaa6qaVqGnoiM
         nCww==
X-Gm-Message-State: APjAAAVrXMgGfe05EQe8CqflngC1hYfI1RddBOFVmRzXVE+a+xxepqVu
        jMqJfZ0+a7LAmvlkP9Vy44+UTRyM
X-Google-Smtp-Source: APXvYqx28vVdZCSLjAiwJzZTXMel4Tt/HkRgr8cVXOkh9zYRyQjX/QMyF0e+c8dEd+5CYl+6bzp6LQ==
X-Received: by 2002:a17:902:fe17:: with SMTP id g23mr108861777plj.42.1578355553672;
        Mon, 06 Jan 2020 16:05:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c1sm46049173pfo.44.2020.01.06.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 16:05:53 -0800 (PST)
Date:   Mon, 6 Jan 2020 16:05:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RFC: commit: add a commit.all-ignore-submodules config
 option
Message-ID: <20200107000551.GE92456@google.com>
References: <20200103120613.1063828-1-marcandre.lureau@redhat.com>
 <20200104004516.GB130883@google.com>
 <CAMxuvayT8FtovVnWU4bjQCP26drN37yuPG2+G2jAUsm0Ns_AYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayT8FtovVnWU4bjQCP26drN37yuPG2+G2jAUsm0Ns_AYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc-André Lureau wrote:
> On Sat, Jan 4, 2020 at 4:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Marc-André Lureau wrote:

>>> One of my most frequent mistake is to commit undesired submodules
>>> changes when doing "commit -a", and I have seen a number of people doing
>>> the same mistake in various projects. I wish there would be a config to
>>> change this default behaviour.
>>
>> Can you say more about the overall workflow this is part of?  What
>> causes the submodules to change state in the first place here?
>
> The most common case is, I guess, when you work on different branches
> that have different (compatible) versions of the submodules.

Ah!  This is because "git checkout" defaults to --no-recurse-submodules,
which is a terrible default.

Does "git config submodule.recurse true" help?  If so, we can look
into which it would take to flip that default.

Thanks,
Jonathan
