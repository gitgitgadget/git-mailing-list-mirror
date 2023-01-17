Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC8C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAQQAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 11:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQQAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 11:00:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CF2B291
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 08:00:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso6658995pjg.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xazxDWOLLFIfBv/voPUf2OIeA+gHvLjDQ2SszsG+n7g=;
        b=iR2PH7i8hwq3n1tlaJyqhSOv6QJhlU21axC7/BCevNdEA7L7j6kRiCPN6SDHbKWzIb
         v8Pri+bHc464IY+l+Lg+JbNF8ahSatIIZlYsTpvNuSVbCy9u3WYI6jJw6xU3n/BIFv2d
         ZHDcaSCkbxMffPslZf4lzeNkFdPa0C3JFVCo6jNQpSTSei8/PRSNvDMXdtCTZaz4LoWA
         U5LyO807ksuKzzwrcG6BaJWKo/JS65eW5H9+aCizGc2Ee25+EAa3a2CJjUt7UhbYo9Os
         1PMyLFjwCSc2s/YFoZKVdVJPpxngu0dZ3/2TuTcjtFOZkvDViflZ3Dk+amZ6XBZgNzh8
         2sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xazxDWOLLFIfBv/voPUf2OIeA+gHvLjDQ2SszsG+n7g=;
        b=DU8hSlJfGqqTENyJYzDDnXzFbF6C4UczfedFA6FyXElxekDx+eY0heWbj1NdrK3E3x
         6xPGGwpCFZK0JFf796S4erT9Bx5c3FdluGU46nCJ+XnJ3DxoMeChuUEpzXO/+kRMZ2Gp
         sJjwTk6kwjOUG1MdiugfdEuI8/tTRA9IGp0QSdgsHJHVn5/ddA4KlOtRBapYVSnwIX1n
         +vBs9JYTaRA/2zycId673Or8MNExnBlsWl53seWc6LQRIzfyuM/2ZaZhsrrWnx9mjKNh
         cJhO+Kf2dz8TrQmd+A+3b/R/7tIExGWQPHa4xob1a59Uao+47fywsZL/8Ivh4HKmHSVM
         tauQ==
X-Gm-Message-State: AFqh2kr0ZJDpprgubdG1wf/ghuXS1KDEW4hgfKmBbbjpK1qmlvZ76Dz9
        yjsIE6exx+qa7kmwlz/V9jU=
X-Google-Smtp-Source: AMrXdXtzz2yqCYSI5fF/bFDC1NfpjgQhof5ioRtKVdt7ul02bi2OC5XO11vC65meFW9rZ8G16xFHcg==
X-Received: by 2002:a17:902:6b06:b0:194:a602:13c8 with SMTP id o6-20020a1709026b0600b00194a60213c8mr3217553plk.52.1673971242813;
        Tue, 17 Jan 2023 08:00:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001911e0af95dsm21309918plh.240.2023.01.17.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:00:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v7 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230117142706.230404-1-michael.strawbridge@amd.com>
        <20230117142706.230404-3-michael.strawbridge@amd.com>
Date:   Tue, 17 Jan 2023 08:00:42 -0800
In-Reply-To: <20230117142706.230404-3-michael.strawbridge@amd.com> (Michael
        Strawbridge's message of "Tue, 17 Jan 2023 14:27:20 +0000")
Message-ID: <xmqqedrt9mmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:

> +This hook is invoked by linkgit:git-send-email[1].
> +
> +It takes these command line arguments. They are,
> +1. the name of the file which holds the contents of the email to be sent.
> +2. The name of the file which holds the SMTP envelope and headers of the email.

The previous iteration said SMTP headers, but now this talks about
envelope.  I however did not think we have direct access to any
envelope information [*] (i.e. such a feature is necessary if we
want to send to one set of recipients by specifying their addresses
in the envelope, while recording different set of recipients to the
e-mail headers' To: and Cc: list)?

	Side note.  We can specify different sender and it gets
	passed as a command line argument "-f $sender" to the
	sendmail program, which is used in "MAIL FROM" SMTP
	envelope.  But I do not think we muck with the list of
	recipients that appear in the header when we formulate "RCPT
	TO".  And I do not see where you give "MAIL FROM" value in
	the input to the hook in the patch.

If we say "we will give your hook information in the envelope and
headers" to those who know the distinction between the two, they
will inevitably say "that is great. Now how do I tell which in file
$2 are in the envelope and which are in the header, when some of
them are different?"

We just hand the message plus the header, and let $sendmail_cmd come
up with the envelope info using what is in the header, no?  I am not
sure we want to mention envelope as that would give readers a false
impression that we may treat it separately from the headers.

Thanks.
