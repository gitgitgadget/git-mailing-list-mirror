Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF1E201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 05:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbdBRF6Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 00:58:24 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34087 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdBRF6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 00:58:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so5541960pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 21:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PtP1gZUTG73JwIQQRFEvw0hwPXn1lEXoPULRX3SO9dk=;
        b=h3VfZvIXRm9ccyYsp9ZJbjaNbydntK8dDQsgQcfa2LbJIqeIkTIkPaSbdqQQ6/+AN/
         rE2TK3/F6vH4zFJeVjKnCdBoTsS8mHZK7fjksVeneGIoBBLPRmBGrEazVdRTXsA51P1H
         FxAPhrKobfmQ9EXQLyuwTsA5x7auyXf+pqCHTSUmgBWFzVeIMzPEtIurKYc7SEcomh9g
         D0QucyZ673zWAMxHXW4lAX7SJ86ZiI6gQddcbyo09/C1xpbx5btLntwlRPe8/ovqB408
         Vx5ktqIWlzujOpG6Il5D3jooux0cIuVy+8SLnXxaux1Gke/vuOFqfvbc27KZ2tu3Spn2
         SL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PtP1gZUTG73JwIQQRFEvw0hwPXn1lEXoPULRX3SO9dk=;
        b=IcY/yZXRpX+VWu77Dz4B99QKamnfBsjzqj+UFt5gRajvS9Evod9JupQSaDAeHalFWz
         WgpgWABh+gIqxk1cTe/YzIRQUfM85geGkKODw+re8bKgnzD4bJNcwoNR8MNJovNr7r74
         kemiwh3LwzbboVrKt8cKok4pDjiU1BHz4VesJvZoO99WslomYtCExKhKVG8rHm46fGIQ
         JQZecAM3ZLLZlmyXAy5F3AzyYbd0Ien3vAR7TsKgzV5o9q0meLcm9Ev69vo2vdbcbb2W
         qo5afIzvSjTOJBUMLItTQrItuPh0CcFJNRnC3xqZ43MnCpIefSEmZlMBbBlvG4Dlqdqm
         Hryw==
X-Gm-Message-State: AMke39kFAdRRot2DEu3b7QmqQVdq4C/cFAOlx4MGrQszPyifPVlelqXkQpZAGp/zMBQVfw==
X-Received: by 10.84.168.131 with SMTP id f3mr16273102plb.163.1487397503270;
        Fri, 17 Feb 2017 21:58:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id h4sm22627919pfk.96.2017.02.17.21.58.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 21:58:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
Date:   Fri, 17 Feb 2017 21:58:21 -0800
In-Reply-To: <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 15 Feb 2017 09:27:53 -0500")
Message-ID: <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'll try to put together a before/after perf-test to better
> demonstrate this.

I didn't pick up the series while watching these exchanges, as I
didn't know how quick your turnaround would be, but now a few days
have passed.  Just to make sure we won't forget this topic, I'll
pick up these 5 patches in the meantime.

Thanks.
