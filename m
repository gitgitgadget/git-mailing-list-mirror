Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACB1201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 18:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbdBSS7y (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 13:59:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36324 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbdBSS7x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 13:59:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so7254485pgc.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T0G1uEuSLmoMc9DiFo6zse3GimWAXFLi1iQfNzVDPvw=;
        b=EqUKiXJD1Ql1Quf+AN8UCfUnq8EW1jP0hsGPYcUxkc0MdJJeIvHmErHFs9i3+3h2YW
         pb1EtcDsN8rnRJzi8AcG1HKA1CXVxn0x3vv6U8Hu1wL1Ud5ul1O5ehaukHWuSRSOGWdK
         nBSLO3XYHa0orI7nSwdF0K4KaTIyOqSK6wRQCjC8/3FcM86o1XPp1lHUt4u8heTyT37A
         WMQIuwawNb6b5bMYcBIeXlIZ8HbqyiFSbDb5uPHrviJ2koHBJtCWZ46BJs4FvkTr9/9z
         3Vz5sADyw3UZDF6eLZUfFZldMYC0HpLkGbsJMhBr88ft3J2MCb/yHUOqk+lVs7+T7OjP
         yJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T0G1uEuSLmoMc9DiFo6zse3GimWAXFLi1iQfNzVDPvw=;
        b=mcGlpNEcRQd1oLey7fjKlyCNuhnFcgA1eOAijio/vsmiPm5kZqATjGhbQfzakqTMdT
         AiscI0RYRAurK/WXFJjDOEQLQWEx6cqdYh1O8DHag+PQoCOXrAPU+DdtmOFxNIm0STjP
         4/hWSQ+npone4lSPw4nSYANElQuQaRHaTJ5uhxtou8Efhar1lN9V0nw4Jp44ela+Jydz
         p6DW8PlHRvgt6l3eMzn4LRM/BgkjE0R36v3rPXv/VRfrOJUEjG7V3ceIL6skay+YlyGC
         2atonJVb1FFQuh/ufzq3x10C02s1dDuLptnKSqNzlVI0E01etySwJ+B0Qrk6D21nGjlw
         Pumw==
X-Gm-Message-State: AMke39nUKJXDtqSkXglCCVUHzG+ldSB5CZupzZ0LI6JKGr2kH8w8bi4RzynJcasqCUCxTg==
X-Received: by 10.98.13.203 with SMTP id 72mr21315995pfn.64.1487530792466;
        Sun, 19 Feb 2017 10:59:52 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id e25sm30716072pfk.3.2017.02.19.10.59.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Feb 2017 10:59:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Vanderhoof\, Tzadik" <tzadik.vanderhoof@optum360.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: new git-diff switch to eliminate leading "+" and "-" characters
References: <2C8817BDA27E034F8E9A669458E375EF11886C5A@APSWP0428.ms.ds.uhc.com>
        <CACsJy8CTL1GUreqNVBYyu2EqqdiUxj-dOOE9=Rr0ivK6-7yKjw@mail.gmail.com>
        <2C8817BDA27E034F8E9A669458E375EF11888CC1@APSWP0428.ms.ds.uhc.com>
Date:   Sun, 19 Feb 2017 10:59:49 -0800
In-Reply-To: <2C8817BDA27E034F8E9A669458E375EF11888CC1@APSWP0428.ms.ds.uhc.com>
        (Tzadik Vanderhoof's message of "Fri, 17 Feb 2017 16:06:19 +0000")
Message-ID: <xmqq60k6m2fu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com> writes:

>> From: Duy Nguyen [mailto:pclouds@gmail.com]
>> 
>> I face this "problem" every day, but most editors nowadays have block-
>> based editing that would allow you to remove a column of "+/-"
>> easily. At least it has not bothered me to think of improving it.
>
> Would a patch be welcome?

I am not enthused for at least two reasons.  

The weaker one is "it would likely to introduce a lot of noise in
the code for a feature of dubious merit".  

The other is a bit more serious.  Cutting and pasting has been a
source of lost or mangled whitespaces.  Tabs get expanded, a wrapped
long single line turns into two lines, an originally indented line
auto-indented when inserted to the receiving editor, etc., etc.,
depending on the pager that the output was passed through for the
terminal, the terminal program itself and the editor.  The "feature"
will encourage cut-and-paste, and I personally would be reluctant to
add things that encourage bad practice to the users.

As Duy said, saving the "diff" output to another file, opening in an
editor that output file and the file the patch targets to modify,
and transferring the lines while dropping unnecessray parts (i.e.
unwanted context lines and preimage lines, and possibly undesired
postimage lines, and also the leading SP/+/- designators) has no
such downside.  It obviously has an added benefit that it makes it
less likely for people to cut and paste a line and then become
unsure if they really cut from the green line or they by mistake
also pasted an adjacent red line.

So, I'd say the answer is "probably not".
