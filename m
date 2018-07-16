Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB9D1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPSuu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:50:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37863 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPSuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:50:50 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so15611913plc.4
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8De+qnEgHREDJNXw0+ByAMyMlNXP5e/62gQKkXQ1dM=;
        b=IGBKMWyc+8IhIy2LkYRUdYeaUu0qbppgLGmtXiNP2P4H34RMjPTrw1Govl/NPbqZTx
         1s8eoSvCSx30jddf5pw3SzsaJkU2hs+VBHCEefRo7OMZgwy4XaHaTk3ePiZ+tEt1ZBwl
         ucUEdSmNj/EG8M/lao3FUbc6NcKNNgRJAdgJnnA22+c6NYYsvu64WyxI9pBrEterngmC
         Cl8rXP86HGSSXpwdXRulqUhwUtaFn0zBoXD5KUtiWhXL77faLvIESPFe2VJnZS4KhKXM
         yp7pA2L4m4h9Aiey442ZwxpWMkY8KSLIQr1HjU2VsQt1oAJVKl7ehgDMB9obc/+K2MF6
         dU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8De+qnEgHREDJNXw0+ByAMyMlNXP5e/62gQKkXQ1dM=;
        b=T9ZldAmjFdJEp6gNO2ZzRqSYTJbQbBJbTlPcUG0BC3dYs8qUxWuPgi1sxhMI/yoWOA
         gLFfJ4ULE5njn6NZjOThaGyaYHLxXKmgWyWkQf8z5rCu5Z+B14giBSDaqCguyvZcqFOB
         0eIF0R+2sdatOiGlP9ItnVldydMLOdm34Psj2kvfhFf+ueFpItcfzGaUwxnnrIIIf6Fd
         co9HQtxuXTlqfgyg40vra7jz+vy8qg6ir58n2k9vHChluVDsyXozpXiwaGq5bxV98rFw
         Apu+Sp/Lju3ffZzYmU+B0kc3lf8X3fcDBf8whO1G3GN7GmtdzfrIiZvv0NXmT8cKyaz/
         f1BA==
X-Gm-Message-State: AOUpUlHtB1PHjmBC6W0MyK55NPhsyFdqttKQ2quKd9kEfj9+VvdOjIPQ
        ebHZ62LyL4dHMCVYYLedmJc=
X-Google-Smtp-Source: AAOMgpe469C4sn0BavO0S1QdmzV88np6lnlw0UAUHAx4SIpiX801zFpW2Y4sZt8jhcTjP7+lHJbGbw==
X-Received: by 2002:a17:902:d716:: with SMTP id w22-v6mr17562414ply.98.1531765333774;
        Mon, 16 Jul 2018 11:22:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k64-v6sm42911797pgd.47.2018.07.16.11.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 11:22:12 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:22:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716182207.GA11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716175103.GB18636@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Jul 16, 2018 at 10:27:17AM -0700, Jonathan Tan wrote:

>> In a087cc9819 ("git-gc --auto: protect ourselves from accumulated
>> cruft", 2007-09-17), the user was warned if there were too many
>> unreachable loose objects. This made sense at the time, because gc
>> couldn't prune them safely. But subsequently, git prune learned the
>> ability to not prune recently created loose objects, making pruning able
>> to be done more safely, and gc was made to automatically prune old
>> unreachable loose objects in 25ee9731c1 ("gc: call "prune --expire
>> 2.weeks.ago" by default", 2008-03-12).
>>
>> This makes the warning unactionable by the user, as any loose objects
>> left are not deleted yet because of safety, and "git prune" is not a
>> command that the user is recommended to run directly anyway.
>
> I'm not sure if this tells the whole story. You may still run into a
> case where auto-gc runs over and over during the grace period, because
> you have a bunch of objects which are not reachable and not yet ready to
> be expired. So a gc cannot make forward progress until the 2-week
> expiration, and the way to break the cycle is to run an immediate
> "prune".
>
> So while I completely agree that it's not a great thing to encourage
> users to blindly run "git prune", I think it _is_ actionable.

To flesh this out a little more: what user action do you suggest?  Could
we carry out that action automatically?

I mentally make a distinction between this warning from "git gc
--auto" and the warning from commands like "git gui".  The former was
saying "Please run 'git prune', because I'm not going to do it", and
as Jonathan noticed, that's not true any more.  The latter says

	This repository currently has approximately %i loose objects.

	To maintain optimal performance it is strongly recommended
	that you compress the database.

	Compress the database now?

which is relevant to the current operation (slowly reading the
repository) and easy to act on (choose "yes").

[...]
> I agree that the "-1" return is a little funny. Perhaps on the reading
> side we should detect that the log contains only a "warning" line and
> adjust our exit code accordingly.

Yes, this is a real problem, and it would affect any other warning
(or even GIT_TRACE=1 output) produced by gc --auto as well.  I think we
should consider it a serious bug, separate from the symptom Jonathan is
fixing.

Unfortunately I don't have a great idea about how to fix it.  Should
we avoid writing warnings to gc.log in daemon mode?  That would
prevent the user from ever seeing the warnings, but because of the
nature of a warning, that might be reasonable.  Should we put warnings
in a separate log file with different semantics?  Should we change the
format of gc.log to allow more structured information (include 'gc'
exit code) and perform a two-stage migration to the new format (first
learn to read the new format, then switch to writing it)?

Thanks,
Jonathan
