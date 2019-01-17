Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2661F453
	for <e@80x24.org>; Thu, 17 Jan 2019 18:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfAQSo1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 13:44:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46555 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfAQSo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 13:44:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so12121477wrt.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AFwGdeiBS+kqaOf8VF+xo19opzgZ/0lgylnuEi13lQ4=;
        b=Qp3QNk72XGHN6yQOW0HP2hYhh4vbc3t3sN8aiG5jRCHNwNqmUYFy9nsGv8OdgnvQa0
         Ueb0kpkTyEGlU7SHYvXIgFmfEEsAcHBXf6d4XaAc3eEhRQoVpArQyga0HO5EURpwaR8v
         wz5WcxfnHAt/mN1hoJ23WLP4lkONCgKSnjyJDMsaG3g9Y/csn/c8Y0oeRtBoVDw0N8C0
         yRRvj87MwkL++ASL+cJUGZmXUiRS9Zagxe73BrX52ngFNwsrnzzILq+oBMtdgLWqt2rX
         oUIi6578kVMsxv8b7YUATsVW/XtOtSdEVAk6GwxWJLOq6dQXUAIq9cFW3L3T40CuvPhq
         kIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AFwGdeiBS+kqaOf8VF+xo19opzgZ/0lgylnuEi13lQ4=;
        b=g9vtbK4+jdpqwgecNItGeffPc2s/br+BnAS0QevTR5rXB6kQOQ8LIb0bGAtoIhcjKN
         TsBEdLVk6ZZsnOEJzgDFjouwgHVVEPgzsVkmIYtE4NwMaBTMLF9JPRQLcxU0gfkkTChn
         s+RwkCm2UXfIvWxmPknquE60nuMQTTLlCbQHPfC8dghWXoFhFawpkcMmRP4s/27h7aaU
         Tq0hLx2aOliL+uDN4FyzbhiSajgdBSqIym0l58uCBX+/Y9siIEMzPxvYF9JPfNMmtY29
         wfm7ZxM4CNE+aWEkVcjpbxznUBxdKYgg/nbr58b7iV458aKck7wcIBMFCPnb+uVRBNI2
         rtKg==
X-Gm-Message-State: AJcUukcB11guqmdCkb8VEgqvBvUn07DC1vrSvjQkF24RwSyyqWD76d1Z
        hLw9pBUJrexY60X+IcrcSa8=
X-Google-Smtp-Source: ALg8bN6Jci5QrhO5bHIEhKgOGGDp2GnPLex9RqdAFw40pCrbJbM5byxmb9OvqXltvHhCFkS8ejcszw==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr13251564wrd.294.1547750664742;
        Thu, 17 Jan 2019 10:44:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v4sm33854039wme.6.2019.01.17.10.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:44:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] support for filtering trees and blobs based on depth
References: <20190109025914.247473-1-matvore@google.com>
        <20190109180633.10273-1-jonathantanmy@google.com>
        <xmqqftttpk8w.fsf@gitster-ct.c.googlers.com>
        <xmqqbm4hpjyg.fsf@gitster-ct.c.googlers.com>
        <04d6b46f-da87-bde2-1511-a9f2071bf034@comcast.net>
Date:   Thu, 17 Jan 2019 10:44:23 -0800
In-Reply-To: <04d6b46f-da87-bde2-1511-a9f2071bf034@comcast.net> (Matthew
        DeVore's message of "Wed, 16 Jan 2019 16:14:56 -0800")
Message-ID: <xmqqef9bnmyg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> This seems like a easier problem to understand, but I'm not sure how
> to avoid this issue in the future.

Sorry---I was mostly venting and it was not productive.

There isn't much individual contributors can do by themselves, other
than choosing the right place to base their topics on and
communicate it accurately when sending the patches to the list.

I think I made sure that all the topics in master..pu that have
tricky dependencies are at least buildable (which involved a few
topics to be rebased on the right commit, sometimes rebuilding the
base that is a merge of a few topics in flight), so hopefully we are
in good shape now.

Thanks.
