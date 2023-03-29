Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA93C77B61
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 16:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjC2QVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjC2QVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 12:21:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9D1FE0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 09:21:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7so14526749pjg.5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680106901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VP+jPtFwTS97Gxw9Ban3wA1RSPnSHOAeNkUATnx1lHQ=;
        b=K+CwIzL7828l4pVIQTK6ayl9Vh9CefYNg8Ah9cW6UZWutfuZQzUMKyKP9Q21PriqX7
         t4JJCObRMBRrpUmygWXI7JZWT50asEFonz33NGdapvDHelG2/Nl2PrvBiazDbhRIY6T8
         zUJJTWjwyg8ycuw29oJNjyTB1cJZLgIoycmWFBKDlYQdo5zr8hV+10dT1EcpLObhB3AC
         J97PuXMSSJPgMp98lxdZUS8sdA4jm+YZsn837DDd7kfoIhcq93Fh75v79yhNMxN9u93i
         Xtlp1RjCaP7y8AYbmOmnIM8bU9V0E3OISbftY9PJ0LXDwv4g+lyBi9csHrcSXEdkBHfw
         iOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VP+jPtFwTS97Gxw9Ban3wA1RSPnSHOAeNkUATnx1lHQ=;
        b=wftz0jq1o61g9qvViQPRaYUqVutTb8hM9wlQLze8vMEsDiLppbGyWT8PPqtOHFpNlB
         +eCskYg7WAT9QnrP8JiI7dPCJVtsCdV2EeAGyEcWBq3bSojkXf/6Z4tqsBWUZIIZJvz/
         QmmJ0VUTi7SaUdeK52MN4ybMjgvHRaCMW72Kzx1YjUojxFHLMQMQT5bfOQKcgLWDFOdr
         ypbTzGSr97YR+vB1knK2LFy+SJhZo5lO4E113Q8XLy6OexuPm4tJQNoiX5itwpZx9pGv
         lwRx7JOi6zlfWFtTmgsRnGGZRSjwbtcEyLq5Krz1UunSbZpPfXuTTLBvrczLvj85caTm
         koTg==
X-Gm-Message-State: AO0yUKVdUlVxkRKNPEbw9l9UxMhcJGxtRdzCk/MYrAnkqCdtmOJTYVCn
        6Z3dQM+NlBD7GUHU3a6YEPs=
X-Google-Smtp-Source: AK7set+iBQFc9SKUeFr9mwV6aO2tpfLOfwLUI6CCUAOH8xKTrL/V8bHeVwZCN1Z7b7CkAMq2Hjbsyg==
X-Received: by 2002:a05:6a20:1a92:b0:d7:8ad3:bc66 with SMTP id ci18-20020a056a201a9200b000d78ad3bc66mr16279138pzb.11.1680106901109;
        Wed, 29 Mar 2023 09:21:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r13-20020a63e50d000000b004fb26a80875sm21822510pgh.22.2023.03.29.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:21:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 4/4] notes.c: don't do stripespace when parse file arg
References: <xmqqsfdog9d1.fsf@gitster.g>
        <20230329120613.11415-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 29 Mar 2023 09:21:40 -0700
In-Reply-To: <20230329120613.11415-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 29 Mar 2023 20:06:13 +0800")
Message-ID: <xmqqo7obbka3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Actually, -m/-F/-c/-C in 'git notes add' is quite like the
> options in 'git commit', rather than "--binary-file=", I think
> maybe '--[no-]stripspace' is a bit better.  Defaults to
> '--stripspace' which keeps old logic (stripspace the string fed by
> -m/-F). If specifying '--no-stripspace', we do not stripespace.

It is a fairly easy way to both implement and explain.  The approach
is certainly attractive from the "expectation management" point of
view.

With "git notes add --no-stripspace -F file0 -F file1 ...", we may
still be making the resulting note unusable as a binary file due to
splicing the inter-paragraph separator, but the option name does not
hint that we are giving this option to users to help them use binary
contents at all, to prevent them from complaining.  If it is truly
useful is a separate matter, but I somehow suspect that there will
be a lot more users who want "no stripspace on text contents" than
those who want "binary contents in note", so it probably is a good
way to go after all.  I like that.

Before proceeding further on this front, we'd probably need a bit
more tests that are specifically designed to catch behaviour change
before and after this series with respect to stripspace behaviour.
The current code without these patches calls stripspace() on the
whole thing every time it receives and appends an additional piece
of contents.  The parse_msg_arg() function, for example, handles "-m
<possibly multiline message>" by first appending a blank line (if we
already have some contents) and then appending the new message, and
runs stripspace on the whole thing.  "-F <file>" is handled by
parse_file_arg() the same way, i.e. append the file data and then
stripspace the result.  This can of course be optimized somewhat
(e.g. an early part of the buffer may have already been cleansed by
stripspace before appending new data, so as long as we do not
introduce double-blanks and other things that are to be corrected at
the boundary of appending new data, we shouldn't have to run
stripspace on the earlier part in order to behave "as if we did a
stripspace the whole thing over and over again"), but we should make
sure we do not change the behaviour to cause regression.  After
doing something silly like this:

    cat >file1 <<-\EOF &&

    With a leading blank line, this is the second line of the file.
    And with a trailing blank line, this is the second from the last.

    EOF
    git notes add -m '
    Message from the command line.


    Two blank lines above.' -F file1    

we should see the leading blank line before "Message from the
command line." removed, two blank lines from the "-m" option
squeezed into one, only one blank line to appear before the contents
taken from file1, and the trailing blank line removed.

Thanks.
