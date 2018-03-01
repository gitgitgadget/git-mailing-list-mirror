Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B961F404
	for <e@80x24.org>; Thu,  1 Mar 2018 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162813AbeCAXLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 18:11:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54560 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162999AbeCAXLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 18:11:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id z81so15111150wmb.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8uitJOfDFWxtNIJ7I99ZKYycEbAOJYN4WL/ALMXVnf4=;
        b=QcDOtVEQigsHw5PLbEKKj5qzeSSbm49qDCtv62rd2ZTN4gN6mU8ZrdS32clnY6ypDl
         AF8bzVTPhqg0bmgWylRfdZrl5gqks/gX8YRBiWDUAIgkN8LfTLJwqKBitTxo4K8+VSNs
         6aqZyi9trsnx8wOIelbVEJeB4vpHOwAHYexMp5OoFEyXVkon8lwtkSQUOHRDl8vEVjdY
         wMqlDdTNUYHX/VY6/oLz2aLH3q0ubl1zAZz5pcVyIQTyHFpabMrdB5GHcSKyLcSs0pD5
         LgmSvqIt1WruvCKJMZvp69naoBUisqKBYsrT/HW7oRl2BbHbOsi7xnlRmPmLfeXDRp9b
         Ejdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8uitJOfDFWxtNIJ7I99ZKYycEbAOJYN4WL/ALMXVnf4=;
        b=FnKSh87FtUz/cjYDq04CuQBaEXsQYz92BwjWhsqMnxD9M7xoaMiG2uovdHS/fKpHqz
         7durfW8Br1FGjjxBj3CeD3Yu5nXdoDGcndgnpu9yKTDdjAmzgBQGHiaN06WeRrvxgxDu
         kyGy4ARMCXkfJ8b86eE68/otbXjprQd/mPlWF0YRjpRC/v2LSfPG3kuURfwhizglgato
         H0q2wQDB/DE11VznrfmyxPRK+l3ITTQzt2vLlLlEJTn3UWN9X06pPkh12/IM+KlD79rl
         ME6v9lmhTR2VRZdJ0DUF1pucYUd/Vbgho0QUMJ2ZXgJeVQHS+xVLqHWJWpHyRma/YYES
         NNHA==
X-Gm-Message-State: APf1xPAyofDDCYaGXDgL4Ol61VstCET3diPcW4ZoGFw3dQT2bx3hTt1N
        okcQxBJekFdwQJ9jG6Iyqv0=
X-Google-Smtp-Source: AG47ELuizxp9cWlcQOWXmcaHRImkuIt91j+0bjd06IIOZukGOODPQuutPPbd5ik5QReWxeGjPqfL3g==
X-Received: by 10.28.196.200 with SMTP id u191mr3155977wmf.17.1519945865204;
        Thu, 01 Mar 2018 15:11:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l22sm284wmi.39.2018.03.01.15.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 15:11:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-13-bmwill@google.com>
Date:   Thu, 01 Mar 2018 15:11:02 -0800
In-Reply-To: <20180228232252.102167-13-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:29 -0800")
Message-ID: <xmqqinafe6ih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  Documentation/technical/protocol-v2.txt | 171 ++++++++++++++++

Unlike other things in Documentation/technical/, this is not listed
on TECH_DOCS list in Documentation/Makefile.  Shouldn't it be?
