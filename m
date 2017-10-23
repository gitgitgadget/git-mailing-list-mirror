Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586B6202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdJWV2f (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:28:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:46919 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdJWV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:28:34 -0400
Received: by mail-it0-f65.google.com with SMTP id f187so7648255itb.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FF6S6Cgza3X3kzMzTlw9p4OvTfp2bPNUKnQgoIrBhc=;
        b=KrQv19PZrvEZn5UzY02jFxFbHXjkPXOXPb4QY9/6YJ35u05wq0IYKxrQ3Ho4/gpjui
         bCw2V/8DuDF47h0lRETfs9lhprqYs9Wmb6xEQSb+mX9XxPhRoKJMy7szOjyXy1YNbq4B
         uxf9EbNWaMe+MPwFXcBvhJz6n8pE124EcTozpiM+wyCmmRQi8E5szRhbMQyPodX+497y
         7Zucl+kWO/+KFnpdVd/STo9BS+XzOmsxPXTeD8hnGuK9z/qHlc6mAm5s6ouJCahq+hQ1
         E1BWdyzxYGYqBo+zJUoeDQAPLcZKM9ZgiqbFJCSPv811mpwzVvtRByEhv4EQS2L2aNHz
         6Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FF6S6Cgza3X3kzMzTlw9p4OvTfp2bPNUKnQgoIrBhc=;
        b=bziICmkCjgFyxJ3M+PkC7IOhZDOIqScjJwkUTagIhLWMK4q7dY+jRe/GtakSUmr6cd
         kXtOmUGE6xYKdQgSBitoV8CYVW72QJvyYzwrzhovJdkjj/yIpuuReOrkFEAS8ILhU9Re
         eBxw3X5OSJop1ZKIIOYb6e/l6D2QL31D42gFcrfx3JB6tkr/0WisA0T2NsNSVuguS9Ay
         8LcD8XIgU7xmeRuRGR6N20WcImKRbbi5Xq1LY0zYcrJ+GS1AEQizyjYDVQNA5Xcbqtej
         5HpEBBOZBA1XNrXc8GaHvyMbZ/Oik/uA0odkXFFwssKZRDthMyjnKEIab/u1AHW2Hn46
         ABxg==
X-Gm-Message-State: AMCzsaXmu82wWsRM+ZS5lLykCJUIyuR5hh9MrF4dmdvtV+5EQEwb4OsO
        s32tGN5oZ6MWlLRgziUChVc=
X-Google-Smtp-Source: ABhQp+TUwQ1em8Mazd1pgObQXn9kPdsXR6zFGrpBnNU7pH8qugj+yGMJUQXxn4xNT0pPUM9I1NbuBQ==
X-Received: by 10.36.123.149 with SMTP id q143mr10445592itc.122.1508794113426;
        Mon, 23 Oct 2017 14:28:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s17sm3612734ioi.28.2017.10.23.14.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:28:32 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:28:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 0/5] Coping with unrecognized ssh wrapper scripts in GIT_SSH
Message-ID: <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016171812.GA4487@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:
> On 10/03, Jonathan Nieder wrote:

>> What happens if I specify a ssh://host:port/path URL and the SSH
>> implementation is of 'simple' type?
>
> The port would only be sent if your ssh command supported it.

Thanks again for this patch.  William Yan (cc-ed) ran into this case,
and based on his experience here are some patches to handle it.

See patches 3 and 5 for more details.

Longer term, I hope that wrapper script authors start setting
GIT_SSH_VARIANT based on the behavior they want (e.g. like (*))
instead of making us autodetect, but this should be useful as a
stopgap in the meantime.

These patches are against bw/protocol-v1, which is in "next".

Thoughts of all kinds welcome, as always.

Sincerely,
Jonathan Nieder (5):
  connect: split git:// setup into a separate function
  connect: split ssh command line options into separate function
  ssh: 'auto' variant to select between 'ssh' and 'simple'
  ssh: 'simple' variant does not support -4/-6
  ssh: 'simple' variant does not support --port

 Documentation/config.txt |  17 +--
 connect.c                | 275 ++++++++++++++++++++++++++++++-----------------
 t/t5601-clone.sh         |  34 ++++--
 t/t5603-clone-dirname.sh |   2 +
 4 files changed, 214 insertions(+), 114 deletions(-)
