Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96E4203C1
	for <e@80x24.org>; Tue, 13 Dec 2016 01:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbcLMBPd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 20:15:33 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34182 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbcLMBPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 20:15:32 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so41325698pgx.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 17:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QuRQcH85wyk4B0kYOZoiZd5i4fHQ2/ol1rQTbrK1W0c=;
        b=SAeR7E6xkusZc15iZyi+j7hC8XKhXRfwNQ9r0jpwZBjt44mnWlbLbhyqfVsMBEl6X/
         Z9jv2+l4HZ0bYEOa1Q3XKP87TenBpV+99eBUWL2V8vkCrHkwUMrkqClJ8EuiCGCQ+DhB
         /hRjwA3IXAhABSeAxNObynKuWdi2HFcwH97cET9CEbqGnPCqqoKyqtb1ueIQJV8JL7ok
         C6/f7LOfIu3nKAwTODT4TxZ6i/ibQFQU3i+4o/3G+sgPDpT6/QIwc8bz3JvrIoHf82yU
         vFW0mCPHeILbGdggQEJvmRHpGpXaAZ4FCY+963Q9h4S1n9k9noUpRMZp29/k3w9NG9yr
         8JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QuRQcH85wyk4B0kYOZoiZd5i4fHQ2/ol1rQTbrK1W0c=;
        b=clZBTogixgtXUMjJAMxh85VkjXV1sJaHF5cf1oZbCtep8wb+yPgDQLqvotdWGJ4aEW
         ig8V8TjEhRF4xIy2BfE/86szPGg8nUw8J+0lfCM9RFFlqKQNHOyrtOzkG8yhpc0xj98r
         Unsi0wpT6jTED9nwQYXV3RiMM7o895pkCtBdygZypk2YWmn30g1+rgGuhGWf/TStD4FF
         BNeKTYcfD6PACoaKe9IYvyCnEewSwRbEXvgXc8hLmaW+Tz90p5PpWmypeEiT7U1rnmpC
         LU1JGCmfEE8naVNG0beCIXmGAeXHbCdY1lVsn3kvLKZsTZ1npMrqbOeSTbvk76YIblCh
         Tzbg==
X-Gm-Message-State: AKaTC02aJ+6+5XjvQTUsNl3Y6fLQW8dO5oiNMTt7oZ/rtD7DDf9pUE932X1rv0qphidHZPDh
X-Received: by 10.99.114.2 with SMTP id n2mr172124603pgc.130.1481591731420;
        Mon, 12 Dec 2016 17:15:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b51d:6a5e:36ae:c0a])
        by smtp.gmail.com with ESMTPSA id k67sm78074164pfk.69.2016.12.12.17.15.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 17:15:30 -0800 (PST)
Date:   Mon, 12 Dec 2016 17:15:29 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/4] real_path: have callers use real_pathdup and
 strbuf_realpath
Message-ID: <20161213011529.GC193413@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <1481566615-75299-5-git-send-email-bmwill@google.com>
 <xmqqzik07pin.fsf@gitster.mtv.corp.google.com>
 <xmqqfuls7lri.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbYAyGwTb7AkymoaMo+TPGVRiv8kn00fXGS=S_ZVFG0Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbYAyGwTb7AkymoaMo+TPGVRiv8kn00fXGS=S_ZVFG0Jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12, Stefan Beller wrote:
> On Mon, Dec 12, 2016 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Brandon Williams <bmwill@google.com> writes:
> >>
> >>> Migrate callers of real_path() who duplicate the retern value to use
> >>> real_pathdup or strbuf_realpath.
> >>
> >> Looks good.
> >
> > This has small non-textual conflicts with Stefan's embed^Wabsorption
> > topic; please holler if you spot my mismerge.  Thanks.
> >
> 
> 5f6a003727 (Merge branch 'bw/realpath-wo-chdir' into jch)
> looks good to me.

Looks good to me as well.

-- 
Brandon Williams
