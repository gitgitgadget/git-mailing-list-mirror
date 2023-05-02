Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008AC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 23:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEBXvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 19:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEBXvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 19:51:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBE3596
        for <git@vger.kernel.org>; Tue,  2 May 2023 16:51:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6a5dd070aa1so1800638a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683071491; x=1685663491;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdvAO1h2N7M80XmJ0xngSP6sWnwmq+FWqp8fdd68yhQ=;
        b=PsKZt/tMJReN54sYUZ59KGcm5i64Jxwoux/D+MRglcDbrUGoCIHMMJivtw6R2n2QuY
         0kU3UdPA9rMFrApw8q5Og4PyUdTaZfsTm0NJnYkpt2K1nJADEuU22FvmUwdnROuEmT/q
         yjwxhGUIUYCM/XnwxvEi3qyOuQA8fPCePPB4cVXHomBNo8ya3nvHZLlgq++t1S5O06Ev
         RZ40sgCPdzZ0XYzZYX8lzs9QAEviwXrKnmyrWvCm5FfDO1UFHfXPXWHXSLVGY25ZwK0B
         w3bFX+XbQ9uGnwk+V2UNtFQqXo+feaUundIdrgrpQR1rf5bIQ/6GhamVI0PztZkx1mjb
         ypeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071491; x=1685663491;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GdvAO1h2N7M80XmJ0xngSP6sWnwmq+FWqp8fdd68yhQ=;
        b=BUGvJpieRDjUhWbD8ML+Owlw2jLEhUINtH+6qPDpffkmOHJAUI4wGDLKuSkBENFJyF
         2SaOtereRuQ+0pxudWJAbYJ8T/xl+Io36itHrJzz4PE+tAJY7lNJbzO8vdAdhdcHNluV
         egqq+EQewaom7DsrN+caQ8F8HpsJ5Vo7Z/Al5AWbGUyjcjYVb08YrqjSkfUpvJS9vygU
         WipPK6PmXmnrsk+g9sJwe56RtL/YAw8bUM0bWyugWfMjDSEnB4z5yIab3XAbIjSkyrFK
         bLLAA/81gYYR1wd+xbRUAEma5fPa39pz/T4K5Z1kQRnjxljpcD2ZUqwqNKWRZzSyx1CL
         aiSQ==
X-Gm-Message-State: AC+VfDwDHn1jia7ScM7B6zDtUZHePX9voEkNk6CKakPvUKJWQ0QTh1yR
        RV8dsAnOfJ8/plC2onoq+0U=
X-Google-Smtp-Source: ACHHUZ7001VABAdC5N1BF+b+7hEmb/YHWRYksRUVZ8IdsBhrbwYnyo0B6jmkmOFRz1Hp3AXcETxCAg==
X-Received: by 2002:a9d:68d7:0:b0:6a7:bf44:904b with SMTP id i23-20020a9d68d7000000b006a7bf44904bmr9999688oto.6.1683071490930;
        Tue, 02 May 2023 16:51:30 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f6-20020a056830204600b006a5f788cfc5sm65206otp.26.2023.05.02.16.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 16:51:29 -0700 (PDT)
Date:   Tue, 02 May 2023 17:51:28 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Message-ID: <6451a200e17d8_200ae294ed@chronos.notmuch>
In-Reply-To: <xmqqildaxt5l.fsf@gitster.g>
References: <20230502211454.1673000-1-calvinwan@google.com>
 <xmqqttwuxtnz.fsf@gitster.g>
 <xmqqildaxt5l.fsf@gitster.g>
Subject: Re: [PATCH 0/6] strbuf cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But if we were moving in that direction, I have to wonder if some of
> > these functions also need to be renamed to lose their strbuf_
> > prefix.
> 
> Just to avoid misunderstanding.  I do not mean to suggest renaming
> these inside this series.  It would make things too noisy and even
> more distracting.  But in the longer term, as we treat strbuf more
> and more as one of our basic data structures, it would make sense to
> lose strbuf_ from functions that are thrown out of strbuf.[ch] with
> this series, and reserve the prefix to functions that are left in
> strbuf.[ch], i.e. those that are about string operations.

I thought precisely the same thing: 1) it's good to move them away, 2)
they should lose the "strbuf_" prefix, 3) that doesn't need to happen in
this series.

-- 
Felipe Contreras
