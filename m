Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4468F20A10
	for <e@80x24.org>; Mon,  6 Nov 2017 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbdKFSIK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 13:08:10 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:43675 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbdKFSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 13:08:09 -0500
Received: by mail-io0-f173.google.com with SMTP id 134so16681248ioo.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVQn5dirJXI3a56Hmj/HdeOYrsqjpZmklKadXKCD6Uo=;
        b=SRRPw0GAhtHaGnljdiWvbaDSkbvJ/xqZ+sIyJmTLc8DCAV9xHaU987zqByZt3lXOkq
         7jtV0GGPNv/JO519lkaa+ZQ0m277fVuNpbVYw+utQikbAGa6rOYkCZ3psxb+C6MZvgCg
         D7Bx4QXv3SBUeyXFu5INi4FIzE6Bl8ebOte3vGFLf24OhM/aBk4Im/sjVW/UdXTVoFS5
         w2OYw8ot5TXhdDUo0cSs9N4Uk7RkSA1aECIA/JEeYvrSkoGpd3FR81tcxy2jrfrfbJJL
         F6RrxDBt2j0XS4IG4rWjqcKU2Ute0WzUvxhCJAoJm5bDnsXG3kRevbuKwnFvG+bYEOQv
         4/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVQn5dirJXI3a56Hmj/HdeOYrsqjpZmklKadXKCD6Uo=;
        b=ZDQ7p8a7G0dBhz5ZIukgUAf3drYGXPciYufEpWSmoXsPbJAhvGXHosDN4AI4UvY8ko
         mZ4SNlRcej/St9t6gq45bp/Cxlv/w9NtnmTHbl8X2GujJYpXnic9Is1zCE4IDx39M+Mw
         OOSeX/XvShlSmLaxfBPZ3MjU1zThW/LfP+Uk/+0PvMpl/s6YLKxwJNxLfb44kZKi2VdZ
         zno1bDPbCg9ZHYSj12HHcHhV335Z5QsyccLCpMJhB28RXdO3JpJqFuzc0HD0sbHnb3Mv
         WWg2V+cOJggESycDHip6IKb+nnpiz6qivyeiS4Z5sab3SAdmXHJ10qMaa5TQE08CvYO9
         CP0A==
X-Gm-Message-State: AJaThX5JDBotXhZQYfCi8wV5QZ0cgXoJHCnUHJqowcIwHSBPm4pVKDJ6
        H4vc4+rUvXml24F9ETFAvRmRkw==
X-Google-Smtp-Source: ABhQp+QcUG3nq0/l49nJiqVMg4UoiFHi2waJkjeA8/F1wnp27b24Egh1Cf/1y9YUHRg7PuwaTTjDVw==
X-Received: by 10.107.81.21 with SMTP id f21mr20011702iob.63.1509991688869;
        Mon, 06 Nov 2017 10:08:08 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b9ff:79e6:288e:1217])
        by smtp.gmail.com with ESMTPSA id y136sm5959180iof.56.2017.11.06.10.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 10:08:08 -0800 (PST)
Date:   Mon, 6 Nov 2017 10:08:07 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20171106100807.f459c0181637d20a7e556158@google.com>
In-Reply-To: <68f3c18f-8bee-dbb7-26f3-c1070d9177ac@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
        <20171102175013.3371-5-git@jeffhostetler.com>
        <68f3c18f-8bee-dbb7-26f3-c1070d9177ac@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Nov 2017 12:51:52 -0500
Jeff Hostetler <git@jeffhostetler.com> wrote:

> Jonathan and I were talking off-list about the performance
> effects of inspecting the pathnames to identify the ".git*"
> special files. I added it in my first draft back in the spring,
> thinking that even if you set the blob-limit to a small
> number (or zero), you'd probably still always want the
> .gitattribute and .gitignore files.  But now with the addition
> of the sparse filter and functional dynamic object fetching,
> I'm not sure I see the need for this.
> 
> Also, if the primary use of the blob-limit is to filter out
> giant binary assets, it is unlikely anyone is going to have
> a 1MB+ .git* file, so it is unlikely that the is_special_file
> would include anything that wouldn't already be included by
> the size criteria.
> 
> So, if there's no objections, I think I'll remove this and
> simplify the blob-limit filter function.  (That would let me
> get rid of the provisional omit code here.)

This sounds like a good idea to me. (For the record, one of the
performance impacts of checking the filename is that bitmaps can't be
used to obtain a whitelist of what is to be packed - instead, a regular
object walk must be used.)
