Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF06D1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 21:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeFYVtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 17:49:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39782 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFYVts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 17:49:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so9688018wro.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MGl3bldZQr2vkUIa0MYpW6FSd2R01wcbaHXtz6BjwgE=;
        b=ljbB/S2LO+9+vmsH5PfOM5LH3LBaPxcV4sNqieS69u3KzVC6Bf1l+i6ljue7kOHrku
         H9UidQFVmua5aWlrar0Vm/xYH1I7YT83YLKTeeYeO2Lk103USNxJLg65ef4YqTmmW0Fn
         Po8817HvXwM5YtTOc3uvZH3bIRen3X3AuNZQNXMwDpNTlijQtiBs6h9Avk29owvVT/Yb
         FYMINK0MgnIayo/dkcQ4jETUWf1Kjhmi4N4vyyKRdhbykGpD029Nnd45ok9lM1f11M7m
         ar2DZMFkCPCKHFbi01addbaFpLdYRTlxo1bZ/OJ55ZNuAewtcMZC4UydtU/cMMYmskln
         5ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MGl3bldZQr2vkUIa0MYpW6FSd2R01wcbaHXtz6BjwgE=;
        b=j9n/+l8TeXJ6nMRCUU8S6w0Q/ywt1VRLqbrC74hOOJFGoRdYXuur1Fp+uMyIM7QFMp
         flINb/0vIPpf/hpbN3PdKJqOpX46/2K/dw2zwIzTx+W47VjN86nP5a3AieF+CuweTOR8
         hygL2Rz4OnkJKkVEadwzx7EAJV3dUX8Q4fw69PONsqMIbJU9ZXFFmJJLEHdgRin2eHxN
         I/BJqdf4OU5tSHjGJuDV9O40DerqPZidD7hyuOb+HlZ/JoTsLDj2xmpEN+S/PlLLlkSt
         z1UFjA946F+Uo6WcAJ4apZA84e/ikQKKRguThEsKkPUlewtNCGmX1sETr1jzG7csRQhg
         +hsQ==
X-Gm-Message-State: APt69E0ej9fyXcDIJ0B81D0vKlh4pMDswdWdoGFNJh2y1mZ/pURiTLTS
        k6+FlAZZUFyVM0BzWSTETqreYBg2
X-Google-Smtp-Source: AAOMgpdlnn3oYSr74Pf3R4/rs6X4B7Sq9zLseu5Pr9upnBx+VEdPecWv6TQCoAEYEY16zSd8exWdEQ==
X-Received: by 2002:adf:f6cb:: with SMTP id y11-v6mr2656240wrp.4.1529963386859;
        Mon, 25 Jun 2018 14:49:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t1-v6sm207327wmt.40.2018.06.25.14.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:49:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 0/9] Introducing remote ODBs
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Date:   Mon, 25 Jun 2018 14:49:44 -0700
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sat, 23 Jun 2018 14:18:37 +0200")
Message-ID: <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This is a follow up from the patch series called "odb remote" that I
> ...

Just an early warning, as I haven't even complained on patch titles
of these patches in the series ;-)

5702.20 and 5702.21 seems to fail in standalone test, when these are
directly queued on top of Git v2.18.0; I haven't looked into the
failure myself (yet).



    
