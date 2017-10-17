Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF82202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbdJQHeq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:34:46 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:45283 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933111AbdJQHeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:34:44 -0400
Received: by mail-io0-f181.google.com with SMTP id i38so1221081iod.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3CQmxd4qC8WfY+g/cfwH/lGc0VDOggmhmgV/7+sjnU=;
        b=tOGifmJ3VYK7+D/OacwI1UQb4Es+OgawtjGsvzGQiW8BLIBFsRvZYkmFOsAVTCUixq
         /JauF4/SvXZzD0g2+m2inOvpcZo5o4BcSOfwGlPeSEz09Ju4E6vpPOgC3wtbH7bNKrbQ
         o68u477ASDLNKH9BfQ8fjcWWw0r2Tpx5P8ppZVukIypzYkyzyDi98unGQ6vIPTjIeGea
         rgkxZiDxJb0r95vSqXRCSCvJXkwgXIgNFP1M6Me3bgc/Hp9qZW0/MBUpIWxEjegP6Vfj
         sa+otfIf/TJPapyOunSDiTKlLrjFM7ANWRAuqOc99yflzmTVQMBTkwurJJFw+/To+bbL
         xlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3CQmxd4qC8WfY+g/cfwH/lGc0VDOggmhmgV/7+sjnU=;
        b=S1Fm6QMG9bOH3hwOJZtSvnFaZ3TINcer52pRkI0hGbXValkv2/xBPqwBVcV8yYOByA
         PB4ACf1J/PrbzbQF7UtDS7n/goGjWGX6xE6obO7NMDZU/7QzxLE9Q1CZA0PTXdjRsKES
         L+p8qEDv0bZVqghpWC9tPI0kE2GxMty26a5z7hSiBV2UrzKz2fp5rfdAqhLAlzBttiNh
         sMiGvSZzPL3tu8ON10teObVDSzC9GAwadhnoy/E6V5ZxN0ZbzCa6cfJlOu8D7XJ4asOK
         XcgJ8C8iUAOtHHpLo89mvmqOJvtBISYYnWysywDi2P0UI2cGQRjidTxow1ja4/xEYZUy
         DKgw==
X-Gm-Message-State: AMCzsaVJURLtZL77Rv4r2TbgigFPzKjRUuGVVpdXjysZxff4pkA+FEVR
        kcFvmazD4XfZ7/I80J/v2OI=
X-Google-Smtp-Source: AOwi7QA55ra+M5nu4iusNqKgkGf1JJUYoc7GJ0dbaMs2lQSXM5+l3T5HrnTJvhldEG7nGkb/qsT04g==
X-Received: by 10.107.46.99 with SMTP id i96mr11953426ioo.8.1508225683876;
        Tue, 17 Oct 2017 00:34:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j190sm1557589itb.35.2017.10.17.00.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:34:43 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:34:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171017073441.ovfhfnh5dsrbpxse@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <20171017044111.ahe4eiepvokecnkr@aiede.mtv.corp.google.com>
 <xmqqinfentiw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinfentiw.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> And in that spirit, I think the patch you replied with aims to go in
>> the right direction, by providing the core functionality when in a
>> repository while avoiding breaking such a script outside of one
>> (though I do not understand it fully yet).
>
> Given that, is it safe for me to ignore this earlier one
>
>> For what it's worth, I don't agree with this repurposing of
>> "check-ref-format --branch" at all.
>
> as reacting to the patch without reading what it does?

On second reading, yes, I was reacting to the discussion leading up to
the patch instead of the patch.  The patch looks good.

Sorry for the noise,
Jonathan
