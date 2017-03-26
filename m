Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EFC20966
	for <e@80x24.org>; Sun, 26 Mar 2017 03:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdCZDnO (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 23:43:14 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35844 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdCZDnN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 23:43:13 -0400
Received: by mail-it0-f41.google.com with SMTP id w124so42821626itb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 20:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R6n3mv5SSzL4epy8u8RdYEkblcRc1aPJ0eYd4fE5GPM=;
        b=Fb2gX28gB/UlrFOefTryeTtMKM1W6tX05c6YMti+Rv+C9Uf2XgOYAqozVrjeLIFByf
         7jLkG3MX35039p4EpRFjwbxFgpwVHodvkkspkBadOM6d/SrUdKVfsQFxTeRYxMJc/9Cx
         GLNwmQNAmegSQghlhnK20Yh8I3meOgpnyMdFP5dIVVUFUs19Tu8tc86OQSiG7wP4v1Us
         pNLgcS60UN1OEwCptTGmHga7+uFbnTqkmK46UHaGMejiU6eQeOQzVuqMMz+buSqv5XIA
         shkDbFbGddCp6POLgkzfX9oGsj0oGJfUOmmEcTJ30OON+9Uf5+78QImL0tX8E9pbNb+O
         tJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R6n3mv5SSzL4epy8u8RdYEkblcRc1aPJ0eYd4fE5GPM=;
        b=BZD1AxEc6EARvCXu5F/AYAwG8u3oa/6nGk9vmFJh7nsq7WKq17rO99y43Z14LEc0wS
         p3PYa5+2k3m407+tmNB8Bb1W+M+8+XCsf1qZH1GVTj9RFhKQSEBG7VnOpEa3+N5uOry8
         389rCoYfEy/5m83aDHEdBsR39JOOlYLIoiYKFc68EWOcy9AVJCYCXccAg7+p54ksz3vH
         CACPh4C2IQbv44NlP6eWS2nMpF0H0wqA1sMeMGPSJciSMl2AgNjEu60yN40wPomIbVdb
         kcXR0P30U8ydc2dLq7WZnrN64XjhkhtZK4NXHiS0jQVqsil8OARH+cd8iANdv1FeioBb
         fK8A==
X-Gm-Message-State: AFeK/H0ID4S4EIod8l+2u384daDe31mC1D+m8Orf1sJTmn8F1mMctc5PcZ+9WzMUo2PVLj3Ud83HEZOpXBS+fA==
X-Received: by 10.36.135.6 with SMTP id f6mr221895ite.110.1490499791896; Sat,
 25 Mar 2017 20:43:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.19.75 with HTTP; Sat, 25 Mar 2017 20:42:51 -0700 (PDT)
In-Reply-To: <1490477422.29662.3.camel@kaarsemaker.net>
References: <20170324213110.4331-1-dennis@kaarsemaker.net> <20170324213110.4331-2-dennis@kaarsemaker.net>
 <xmqqziga5lnn.fsf@gitster.mtv.corp.google.com> <1490477422.29662.3.camel@kaarsemaker.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 25 Mar 2017 20:42:51 -0700
X-Google-Sender-Auth: i-M4-k8L35KSSdXWhl46-CmkN8E
Message-ID: <CAPc5daV-12U2mNcvfXmy4UmYnEm2UQWGWPUX7EO3Uc15e1D-VQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] diff --no-index: optionally follow symlinks
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 2:30 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
>
>>  - does this code do a reasonable thing when the path is a symbolic
>>    link that points at a directory?  what does it mean to grab
>>    st.st_size for such a thing (and then go on to open() and xmmap()
>>    it)?
>
> No, it does something entirely unreasonable. I hadn't even thought of
> testing with symlinks to directories, as my ulterior motive was the
> next commit that makes it work with pipes. This will be fixed.

To be quite honest, I do not mind it if the "toplevel pipe that came from the
command line is treated as if it were a regular file" was the only change in
this series, without doing anything for symbolic links. I do not use the
process substitution myself, but I can see why sometimes it is handy to
pass two process invocations on the command line of "diff" (if it were only
one, then "-" with the usual redirection already works, but you cannot do
two command using that syntax).

Perhaps we can have only that part and perfect it first and have it ready for
the next release, postponing the symlink dereferencing, which is a different
issue?
