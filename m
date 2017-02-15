Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D702013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbdBOXCl (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:02:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35328 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbdBOXCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:02:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so80065pge.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4C2NkqddQsPnNfCWXLX0XGJ/i1I+wCCPv8XRx0wDv44=;
        b=BOJeNzQAez2JF5eD00NevMhUISrzVWu8PQ+5outPqXYzsF7COX1wL6h25iiT3awhyU
         RHJrewJlyS71dlCU0J+mHv1vqnw5zpQLuBH/+Ydg58ZwN+fY8AkGbaJUVzCd05ghadZL
         XrjIDLB+mi4X8usK5rB66EpRvonJhtHBTEmXU29uB3j1hlutcQ8bFfEyXINJcavFsQjW
         IBXva2o4rZoHxjlqgvUwcW6S00Pih35HF0RZEJLvKhVlAdIPtqSjtPdWKLMOVHM7qlOe
         xEIhARTLDxL1f0/pyiJ3HdXPH22FqOijrHi2B3V128AquvPF51pAZ0yN9w7Q18/hKms8
         wgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4C2NkqddQsPnNfCWXLX0XGJ/i1I+wCCPv8XRx0wDv44=;
        b=NsAgmlMlQdyes0zru/GcTcE/dqokfz68vXf3G9KTjlkjJIxh+HyGdJpSaYAHHJVxwr
         EHeGaUYusgM+P9InOpyg9xK7rW4QI+BhFEznzO2YxtJhi3NjmNrePcfaRjmAidqfEP+f
         Z/bC6p017+wSMnlRulr2U9v27ZIrAXQXe2V4vWhiMtOtPQ8qs0iSe/hMtMCYb32gH/sx
         5VcPxLAmai/OnJ6k+KW1PXuSKEy2J97dh+L4yUOITj3fram1eiMvW0+vZtXbnUrOSeua
         yu6WyDb+GwTzu7e+/YH7OhSkguDkW6UikMVk5NxhPFYpjKZbKSyYWlYiyh9FgdBOTcyi
         52TQ==
X-Gm-Message-State: AMke39neMcthV4QfQu8S3WIYtuth2wQ2bHeUekfph4+0X6VR70LSOjwLp/Ix2kasvMCuNg==
X-Received: by 10.99.217.85 with SMTP id e21mr42221901pgj.79.1487199753942;
        Wed, 15 Feb 2017 15:02:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id 129sm9359880pgj.59.2017.02.15.15.02.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:02:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
Date:   Wed, 15 Feb 2017 15:02:32 -0800
In-Reply-To: <f238248f-0df2-19a5-581d-95c8a61b4632@google.com> (Jonathan Tan's
        message of "Wed, 15 Feb 2017 14:54:48 -0800")
Message-ID: <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I had some time to look into this, and yes, command-line parameters
> are too aggressively downcased ("git_config_parse_parameter" calls
> "strbuf_tolower" on the entire key part in config.c).

Ahh, thanks.  So this is not about submodules at all; it is -c var=VAL
where var is downcased too aggressively.

