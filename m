Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CB0202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbdGLSYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:24:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32898 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGLSYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:24:51 -0400
Received: by mail-pg0-f51.google.com with SMTP id k14so17022622pgr.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQX8Vx/VnmAvwnWZS3SEUhv8Rz2i+tu1khMmAy3tsRw=;
        b=X/i/6yvYoU4JI0obMLFH+G16WYYSuAgz2rCsaWZ7EpKfh93Ewx80ZmLZWsM3R2cF78
         xrPKLhEQUiR4HqfhNBSo3tsPFqTwuRp12IRnNra3uWQcFHfjOdP0PtWrYhccH7AgJprV
         KgI3DMb/xVEHJZ9d7+cj7IWFeW/xUh9YWsWk3+LwXBFUP2zsXATbOzYi2pA2X+6Vr42v
         d7WWuVCzV3wqoLYnQh0VYCvA7sbcLgPT3E1bcmhJj9XYr+caEnvEccIRdk83w1ZDzKx1
         8ptLlPX/JNixvKt00AjjTogEXTc/eNfE/IpK1FWsUxn+z6rVACRbKH5MoZUBG6Vyod4R
         bFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQX8Vx/VnmAvwnWZS3SEUhv8Rz2i+tu1khMmAy3tsRw=;
        b=X1QVXAsw71SHZwZdInW3GUn+gP5E+MumJnhIfXofS4iiDHYWrO5+yBsboa6+cldl0T
         k3mJohWHKPIdjjceeDU94FeX/qoXGRs1SAV1lN+mmogzTh05L/Fffb4zsll7zKaQDYUm
         Vv43h3/Y/G/6uxrUaEh5Avkxs6enLtaIVyxfIr+pvGe3aTjMMXordfP8InS2ZKXjTFtR
         iGcAk2Fj4x/eJq32bhiej5GI2mnhHZSCgPhijrOKb8BW4Vt7JwwfTpfy9+tdCrF9q1GA
         7c4EuPHDVFtQ2KRyNS/fg38L/DzPg0+tdnirUwVlTK/IcOBdSxxl+ZTdYxbKLsPTeEWc
         OVhQ==
X-Gm-Message-State: AIVw110pc0Xv2ZpUVMH0+r2G/6W4TrYRnpsMqpMJ+C5NJmchsMHmgui4
        MWOZEDDe4Sv4DRAJvNM=
X-Received: by 10.84.232.15 with SMTP id h15mr5488760plk.168.1499883890921;
        Wed, 12 Jul 2017 11:24:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id h90sm9062315pfh.133.2017.07.12.11.24.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:24:49 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:24:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712182447.GF93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
 <20170712180603.GE65927@google.com>
 <20170712181717.uj7paoz5btfv7ocz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712181717.uj7paoz5btfv7ocz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Jul 12, 2017 at 11:06:03AM -0700, Brandon Williams wrote:

>> Each 'struct repository' does have its own config so we could
>> potentially want a config in a submodule to override some config in the
>> superproject.  Though for right now it may be simpler to not worry about
>> doing this overriding, mostly because you would only want to allow
>> overriding of some configuration and not all configuration.  One example
>> would be the number of threads allowed in grep,
[...]
> I think that's probably one of the more complicated cases, and I don't
> think it really needs to be done on day one.

That's fair.  Could you give an example of a simpler case?

Thanks,
Jonathan
