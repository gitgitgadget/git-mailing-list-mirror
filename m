Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15321F404
	for <e@80x24.org>; Fri, 20 Apr 2018 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbeDTPdA (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 11:33:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:41797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755528AbeDTPdA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 11:33:00 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7kwW-1eEZlO3z3w-00vR8O; Fri, 20
 Apr 2018 17:32:55 +0200
Date:   Fri, 20 Apr 2018 17:32:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] replace: "libify" create_graft()
In-Reply-To: <xmqqh8o6d8rg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804201732150.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de> <1f1c64314088383570dd2232e08a88c8df3298f5.1524125760.git.johannes.schindelin@gmx.de>
 <xmqqh8o6d8rg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7/AD/rxvVHoNXmn8mmmsgaNhRkOojqvkPFNYSbroO/v7Xae2PzZ
 R3lfYkZpvX+GkjKP6IJmB3Od3usocDRRrjq2HMCYNcEK9ZBZy2XN7JNEQ2q6g91NPh0E/Q0
 qtT3vZ4u7UY5/ukwjCyEnJBOzaohf5dYOYSjFbZeXA+yz4ZQH8mDrZgjXfWBt/pcLFmE/ct
 FsNtSP6ByqYws3FvD5H0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qew08jtiCro=:01h/F7Cg4ARyNC4IYKbm4J
 Mqy6J3F20WcvDk/c943tijUZ/Ms4PnKRDaeFZjaqPWMpUzOULmuI0hnx37kZspYqcfBrUaXgE
 gVUhRBaGD4jc6esZ6fIor6SNUE+QQbCXrypKowIYR5N5PEeeqzVjUQvn7WW57bVXTTMD+69HI
 3oo5Tkuw9rsw9dS0DWlpw8C56+tSWk+8pOc/AqLp7yFvCfH2fI3oiEgYVJ4Uk+h35nbLRHiuK
 xXr90cNSlUHkIMil8h72ElWOCItrt81fUHiC2LmSOqOX6Sc0w6tDxpE++vGkXPzWmiQw1TWd4
 t9/CKJi1mvpzYP8s6PVE9dzJl8oClHAmC99ZOOkp5yUrKtzoI47Ivf6gVSv3FxMHOKUumqqE1
 pHTZALS1DMwFl2I1OKIvts3y8dqLlJOB/DX8Jzw0ECbWBA+Avm4ux7tNdmSdJFfoyQIv0ru0K
 EZVe40THnFJxSTG3d2dtgMCUOmtX+f7lH+rHqj7ykCVEOVZKxBXwGZ9V+2qqVl+eRxRpV6qZt
 WZ42atlT5fKZjcg42Y6H6WvOY+4yWmM1I0VJOg6ifc479JbxuLkTKXEftbmn3WeJZkzt/FrAd
 CKI0iPOm5xfsrmAa8XeDdpQjGI5ZYcAqT+qC+m8LuuSOKFenSQZnsNDLOxmV8F5OYD3CVNpQ/
 EjvScvrIx6KWFDb4PZ2ROfYE04lBJzeZaO8Qh6/Ku0t61Oh0+R8QsefvHoYYJFwo6/HhksB5Y
 l4jTlju16jcLsI6iJjYnnOqZx/LlSF8ArShHfjd3FEPR0B78+8BKITpKtPVoJe3iNPR/PidDX
 Y/3l9gaPLkIzoe+CR2oiDqq8X7W9PDjRIRLDU9LBQ+48abp2sk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Apr 2018, Junio C Hamano wrote:

> FWIW, I fully agree with the goal of making this (or other pieces
> that would be useful if they were reusable) reusable.

Great! That's something I'll gladly take into my break.

Ciao,
Dscho
