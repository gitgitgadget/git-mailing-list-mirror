Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D011F462
	for <e@80x24.org>; Wed, 22 May 2019 00:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEVARj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:17:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37183 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVARj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:17:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so312699pff.4
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8dwdTD7uuYbDpGX4YoTcBOTNDzm4H9pZYEXkf69YVM=;
        b=HF5Ty4xqF7sszDkEUXks15HE44m9LaUKEdse+HG6MKKJGLtHEUcPGyweoadKogV+eu
         KNQ0NV/Pc9BV2cz+Edx17bYXF+1y0TVpTG+mmOooQOJHVYLjmuDKPVDx5lApVPDgzBTi
         1PLk61bCQ9IfzW4ETn/mi9fw1sO42Do8UhRIx6cd/lDsJjOEREH+xpDcDLuwhMtDo45V
         tKF3fEGwRWdF97R2xTfHJanEV+CyK2NdPxaDwKIsX0+4FvyBgTHCUZUyJjJHhSZcz7sR
         UnoFOASztBwoclTh4XDD4Jo7QG12/87lzToxcd/eNBGRnqz5Zj9OJoAsqmN5AaXnvswN
         inhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8dwdTD7uuYbDpGX4YoTcBOTNDzm4H9pZYEXkf69YVM=;
        b=O/SnrrW/zwNRnSnZniSti11qeMsg7X+RBqj69UtQIMSNA4qWWgrFzVXK02oDrXFkOp
         TtwMdgfTABukN+aT6fnjFmCWXf35E4gf3rf1Ci6EE+nvTZJAntTB5ZMqU+D5bOojIIOR
         0IfbrxLp93uzS3jvmW1CSkKsnnk37nGyA2bzh2TmzO8Xm4NQ4G0eyL1cZH9yj2ema7wI
         4wzA53HRUlksggjDGHcsmk+Xqm/NDRluNVM9kp9Twq5SQmVb2ecrVMZkfEFKRU+Vh6J0
         bz7B3G1gTTi5R3l2c5G60UIdTIGUz0sWwMjdz/f/yUULUFkV5iEYoQLhmTLhuQEtJVVN
         lxJA==
X-Gm-Message-State: APjAAAVA/leP9MDgnOwS4p4hf+32/t5+tkmd7E9JmzL81Y/WNlaX+4KY
        TMTr+qWSv1laiqDyYyl4AcY8ff9m
X-Google-Smtp-Source: APXvYqwx02SbMwVTTT0bTxSN04FwyAqV1koZDVZtUAUz9CVD7Bw7ycx33ZtHoxvsoetwxWddEEIGBw==
X-Received: by 2002:a63:18e:: with SMTP id 136mr57185925pgb.277.1558484258608;
        Tue, 21 May 2019 17:17:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v4sm37727191pff.45.2019.05.21.17.17.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 17:17:38 -0700 (PDT)
Date:   Tue, 21 May 2019 17:17:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] grep: provide sane default to grep_source struct
Message-ID: <20190522001736.GA219159@google.com>
References: <20190516020023.61161-1-emilyshaffer@google.com>
 <20190516214444.191743-1-emilyshaffer@google.com>
 <20190516220254.GG10787@sigill.intra.peff.net>
 <20190521235212.GA46998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521235212.GA46998@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:
> On Thu, May 16, 2019 at 06:02:54PM -0400, Jeff King wrote:
>> On Thu, May 16, 2019 at 02:44:44PM -0700, Emily Shaffer wrote:

>>> +	/* TODO: In the future it may become desirable to pass in the name as
>>> +	 * an argument to grep_buffer(). At that time, "(in core)" should be
>>> +	 * replaced.
>>> +	 */

(micronit, likely moot: Git's multi-line comments start with "/*" on
its own line:

	/*
	 * NEEDSWORK: Passing the name in as an argument would allow
	 * "(in core)" to be replaced.
	 */

.)

>>> +	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in core)"), NULL, NULL);
>>
>> Hmm. I don't see much point in this one, as it would just avoid
>> triggering our BUG(). If somebody is adding new grep_buffer() callers
>> that don't use status_only, wouldn't we want them to see the BUG() to
>> know that they need to refactor grep_buffer() to provide a name?
[...]
> Can we think of a reason anybody would want to be able to use it this
> way with the placeholder string?

I agree with Peff here: using NULL puts this in a better place with
respect to Rusty's API design manifesto[1].

With the "(in core)" default, I may end up triggering the "(in core)"
behavior in production, because there is not a clear enough signal
that my code path is making a mistake.  That's problematic because it
gives the end user a confusing experience: the end user cares where
the line comes from, not that it spent a second or two in core.

With the NULL default, *especially* after this patch, such usage would
instead trigger a BUG: line in output, meaning

- if it gets exercised in tests, the test will fail, prompting the
  patch auther to pass in a more appropriate label

- if it gets missed in tests and gets triggered in production, the error
  message makes it clear that this is a mistake so the user is likely
  to report a bug instead of assuming this is deliberate but confusing
  behavior

In that vein, this patch is very helpful, since the BUG would trip
*consistently*, not only when the grep pattern matches.  Failing
consistently like this is a huge improvement in API usability.

It would be even better if we could catch the problem at compile time,
but one thing at a time.

Thanks,
Jonathan

[1] https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html,
https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html
