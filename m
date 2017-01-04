Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91DA920754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935151AbdADSX3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:23:29 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34910 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbdADSWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:22:11 -0500
Received: by mail-pg0-f52.google.com with SMTP id i5so165131147pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WX3l0tmhHJB9v9upSG2JwRS0u+B7tplpbtwVpw5s8bQ=;
        b=KCYree/G1tCgKaqnegeb6+bM3vwxuW1UxRqrGdnBcXpD/eFoVdWcFh5UcOqwTwL4gM
         R3rboUnlHZW/BaO7MHU/IIGfr9wKjQYEWMSRg70uwsXlHBIIHS5WtDd6TKnbJv1Q35Nr
         aYrd3q+czqI6h8ck5DPhu5v0/Og4255V3IoS2iL4H9GbLogLg25F3WUpa66Xe3XQppPS
         n7hawrwtQyY9jJszR2OLnGkPGzXqyHGWgq0FW9QmFBa0GZcxNquyUmVKbwnrTUywWhC7
         hv0b4sUOgZQEBYsYLXj5DdivlcXoCLX0kGf6r86+HscQfPNipeULDZfgkI7KNttKLoGl
         7lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WX3l0tmhHJB9v9upSG2JwRS0u+B7tplpbtwVpw5s8bQ=;
        b=t98NPH56Cx2P4JfWvoPs1AOVV6/4eE2qWjs6ptYnEBTkRpUndSZsaZcFb9khjRUR9A
         psNpjcBwxO6lzUV+Oks2Slkatf2RtamoQsQKF8OCoWriShrugs+IFJkW2mV5WQvS5lY1
         2Wc6rx4L/vKfhQblu07xOLegBzZ6Fge3s8QJRAOYTE5Gx+204QWuuQFx6YKRv3bTbSz2
         fVr5dOtYbj/ZG/uvQ7r35Wx4Anqv90tCEP08vNFA3y12tUAJBxFz/w27mcL1PVF/Ooee
         DwqPRFBXOZlMJrSdgo6LkM5VLD16edKcDoVuJRdn4vvsk6GApItEu0tTnWNZopXF5ZIh
         VtEA==
X-Gm-Message-State: AIkVDXJzxhun8AIm+dG54iqyqDH/IrHwv4MeWI4AA0kEJGCK3I1griQ3Wm55VFsZw7sgf2tC
X-Received: by 10.99.178.6 with SMTP id x6mr126212956pge.63.1483553691609;
        Wed, 04 Jan 2017 10:14:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id y189sm148366962pfy.32.2017.01.04.10.14.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:14:50 -0800 (PST)
Date:   Wed, 4 Jan 2017 10:14:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/5] real_path: have callers use real_pathdup and
 strbuf_realpath
Message-ID: <20170104181449.GD69227@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
 <20170103190923.11882-5-bmwill@google.com>
 <CA+P7+xrgt+aTF4ibJ139=WihwHwG_m01bjAaF5-VW=Rk8u1ykA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xrgt+aTF4ibJ139=WihwHwG_m01bjAaF5-VW=Rk8u1ykA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Jacob Keller wrote:
> On Tue, Jan 3, 2017 at 11:09 AM, Brandon Williams <bmwill@google.com> wrote:
> > Migrate callers of real_path() who duplicate the retern value to use
> > real_pathdup or strbuf_realpath.
> 
> Nit: s/retern/return

Thanks for catching that, I'll fix that in the next reroll.

-- 
Brandon Williams
