Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF6120D09
	for <e@80x24.org>; Sat, 27 May 2017 23:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbdE0XzG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 19:55:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35853 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdE0XzF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 19:55:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so2586397pge.3
        for <git@vger.kernel.org>; Sat, 27 May 2017 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iT0p1N1I9UN+YDDSDPGzDxe7Blwv4MYak6RXXZamqeo=;
        b=B9FLUMq/uMBKq+/TzlF0xikLry0eEcBz+2lIzIs9oV6lb1oBUGay/coKR7XeL24lfM
         ppeXmnDoWyLU3041VevmvxSWO5RPO+BhVBwWHtGda3DxpRcw2Y6hr4PfiIQbKqftm4Sk
         zfT8qSFK/bRnCtL8yi6KclfdjLZGrdkTcJ/PhZlLmWpWpbI+J1QYPqHOfnJaaAyvMGeM
         SW4OWrmJloeioN59nzBU/Gb9R+ctv2mnkbcQjI0HmBvmjQtF0+LItsZ7lV62gc7S7Sx5
         yLpDyUhItesEJAf+SMCw+/5nc1TQEnsbzKpfTGf+kFUxPDJXC2emfBzs+vZEmUzU7TB3
         SA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iT0p1N1I9UN+YDDSDPGzDxe7Blwv4MYak6RXXZamqeo=;
        b=NDcO6vy++AIRyAf6hNr2fHch/aGcMJhRezIJ2xcJcUUi1nitvjH3DGjX7EtAic78OT
         h1zBKytUxW61aAM2D1OW4gQqjCv4mp3fxYt1Cs5JowPzE2gZz5523qUz2CXk8v4uicI2
         ffV7K7/OnxhIhcfI6RnH36EajJs+/upPZRU6znSH7+R2nV+xqgn7BW4b9EFV17FnaoOe
         zzTvhVbFPmj00QbnppbUy5eSg9DgagLYQgdjXKVg4Bp4loUB1+d7mEY0POZRpkN0cez9
         8wgNOObiSWaV9ued4rNS/Fy0n2kuxdHGLX5MNOjinO7EcxlCNykn6vKnnfcP3Hmk8je5
         qzRQ==
X-Gm-Message-State: AODbwcAiUrcJCe0SgHld0QskYc+MF75SPhr1QSN9hurR293xSXDlDopR
        fdI3BIjxdJVdEA==
X-Received: by 10.99.116.7 with SMTP id p7mr10451628pgc.162.1495929304914;
        Sat, 27 May 2017 16:55:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bd10:cbc8:82cc:8993])
        by smtp.gmail.com with ESMTPSA id t3sm7400014pfl.60.2017.05.27.16.55.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 27 May 2017 16:55:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Jeff King" <peff@peff.net>,
        =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>,
        <git@vger.kernel.org>
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
        <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
        <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
        <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
        <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>
        <CEF93B59EA3F49608B41892952454B1D@PhilipOakley>
Date:   Sun, 28 May 2017 08:55:01 +0900
In-Reply-To: <CEF93B59EA3F49608B41892952454B1D@PhilipOakley> (Philip Oakley's
        message of "Fri, 26 May 2017 21:00:57 +0100")
Message-ID: <xmqqh905c0tm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> However given the discussion about an unborn HEAD, the option here
> would be to also pass the NULL sha for the symref and then add the
> annotation 'HEAD' after an extra \0, in the same way that an active
> symref could be annotated with the '\0HEAD'. This would kill two birds
> with one stone!

Are you aware of the symref capability that is already advertised in
the initial upload-pack response?  Right now, we do so only when
HEAD actually points at something, and the earlier suggestion by
Peff is to do so unconditionally, even when HEAD is dangling.

Existing clients that are symref aware do not do anything (good or
bad) when a HEAD that is dangling [*1*] is advertised, so such a
change will not hurt (but it would not help by itself either).
Ancient clients that are not even aware of the symref are not
affected.

Then new clients _could_ start paying attention to the advertised
HEAD that is dangling.

The bundle transport is a different beast.  I do not think it
advertises where HEAD is pointing at, whether it is dangling or
not.


[Footnote]

*1* A HEAD symref that is advertised in the upload-pack response is
    dangling when its pointee does not appear in the set of refs
    that are advertised.  Félix's case would have shown HEAD
    pointing at refs/heads/master in the symref capability extension,
    but the list of refs and their values would not have included
    that ref (there was only refs/heads/MASTER "for joke reasons").
