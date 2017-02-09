Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE151FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 16:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbdBIQ61 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 11:58:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34294 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbdBIQ6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 11:58:23 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so745706pgv.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 08:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3l3xSoAQ9uiRvJxQDYG4txIZnNnPScTMQF3gC9T/oyY=;
        b=bHbRp5he7SpbG6v6e4NsYwq85w/8wspJtPZg/MARFjDsWWo3aapXpx2OPTFQyk4LVY
         Y0nBOEbhTjkrzatipltmZUnirnfHnDx7p+ovqbLtbV1NQ81n+nj0yPTIb74KgzFzdVP7
         9+GuJFv+j+F8d0LkJdDDoVKO7RHKz/JNwdaIaanEXlMiUOF9L1CeFpQZF81d6ggj1u6p
         cC0k9gEvt4JBiMJpbBephTG9ziI+Mw6lvTl7JyPcQ+GBx7PWWIdD30i6xODDgCoGwh0f
         AzCRQodW0870XNKrZs5MQnU4oXvpjnOYti1WfayYYhcKjA+Kj8Qk3cO1siXMui9A/dvh
         hh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3l3xSoAQ9uiRvJxQDYG4txIZnNnPScTMQF3gC9T/oyY=;
        b=EkyQOs43ZPo6qadbFR5gmASfZvZQf6ru8cktTj/K9V/Lqvy1CK8NmJN0s8CQDFYZfZ
         NAMzkVd7ZGsV8OFjSB8qeJhHlAgQ6hj7CWIULCgvI5v5+TRDmVSBrxspKBCOu4hbR7xv
         V8gq+2ly6EF8NdbSX7Ia+tA7Ws8A6X04DIe9GjYEKRE6WNY4FAOKxY+BrR8XlbAyYnoU
         JYnhuGsChzULBOhi14JxCjeSRorHUlx1tLIFHhVEkKEg2OjXJftb5N2lVbZkoxXJOoFD
         WNzCnl6qzAMTOeJNZG/Vx6kcuHnoPkQHGj/bVUALy1KtGMWpKWdEYKCj1rl/0cosWcyb
         QPtg==
X-Gm-Message-State: AMke39mTHS+waqnyPoCgcABOXjojOxUEL5lBe9m4uzQ26NhEvmf9Jvbh7FryoPHlQmhqoA==
X-Received: by 10.99.50.132 with SMTP id y126mr5201549pgy.8.1486659452066;
        Thu, 09 Feb 2017 08:57:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id h14sm30547516pgn.41.2017.02.09.08.57.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 08:57:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [RFD] should all merge bases be equal?
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
        <8a9b3f20-eed2-c59b-f7ea-3c68b3c30bf5@alum.mit.edu>
Date:   Thu, 09 Feb 2017 08:57:30 -0800
In-Reply-To: <8a9b3f20-eed2-c59b-f7ea-3c68b3c30bf5@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 9 Feb 2017 15:44:09 +0100")
Message-ID: <xmqqlgtfs3np.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Anyway, I mostly wanted to remind you of the earlier discussion of this
> topic. There's a lot more information there.
>
> Michael
>
> [1] http://public-inbox.org/git/539A25BF.4060501@alum.mit.edu/

Your http://public-inbox.org/git/53A3F67A.80501@alum.mit.edu/ in the
thread appears to me the best place to continue exploring.

Thanks for the link.  
