Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93BD2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbdBOSeb (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:34:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33910 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdBOSea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:34:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so11781000pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pTFhyr5Swlpf8nDZq8P0kWdNol19cB+9XGmDWWXQ7UA=;
        b=dmmplV363/GVO3GSmvusJBjku44Ccb5cgv6jN5X54zqLrToBJKRkgoyAPRi3VhIm1u
         exYy/H2uJDUfThmWLjv5ktwYkt4kgE+E9MGy6LrktZ+d13a8c3g+cmfpedjQRrT/im8N
         cwI/BKMEGpPehEX5mlX0XEzYG439lv4Uq95M2MzpNSagF40OTzC/tnfKulRW4zekUtqM
         DlkLEdufKbmT35UZUugrILzHaM6d/Ne3dlarRO3SAG4R8nukAC5Z0FhnDoHjjEe+1DWv
         EhUPS9iNwuQoB0W2QMGDjjkfTmnty8gxneFH749yBT63SySOxA/fFNhWigF/gd1rvRtK
         5+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pTFhyr5Swlpf8nDZq8P0kWdNol19cB+9XGmDWWXQ7UA=;
        b=n1EpcQ9TDwzKv5rYfxslFczoCoh+6XlXmmtCew5yehFf3XZZKypUzK0//H1yyVXYy8
         5+tnow3D/vmFYiO+EumdxenkV6EQp1+VZh+KKhpduIf+SgrUD+5JTdcHWflH5ZuuOXiV
         jJqdGssnenYFSJlNjqrdrOAcCewoOUDghp3YnyzTDiSRkmLwqo8lmJA2N72YWQt4kf+9
         6QGY8Fi3805/loKp6Xfw4hfUPlDSytxcq61kw+tuqxrOh/+iOq9lCHcwBPYHMN5j43Xp
         kWK8u/UpHD6rRL8JoyTSqhkfyYKghNEcZplRnV2uVU2F6bHwDbzJAl6+r9S5Kx3CSI0b
         AX+Q==
X-Gm-Message-State: AMke39kEug6I3rLWqluMiI12qtSyEjH8BLXuuERBmnUtS/n8owcZSaVMpVW/etTKBEhY9w==
X-Received: by 10.98.80.29 with SMTP id e29mr38885028pfb.118.1487183670278;
        Wed, 15 Feb 2017 10:34:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id y21sm8876787pgh.52.2017.02.15.10.34.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:34:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFCv3 PATCH 00/14] Checkout aware of Submodules!
References: <20170215003423.20245-1-sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:34:28 -0800
In-Reply-To: <20170215003423.20245-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Feb 2017 16:34:09 -0800")
Message-ID: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Integrate updating the submodules into git checkout, with the same
> safety promises that git-checkout has, i.e. not throw away data unless
> asked to. This is done by first checking if the submodule is at the same
> sha1 as it is recorded in the superproject.

I've so far read only the first half of this series (i.e. the
preparatory part) and haven't reached the place where it starts to
become really interesting, but what I've seen so far looked very
sensible.  I also find that comments given by others so far all
raise good points.

