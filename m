Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D5C2098B
	for <e@80x24.org>; Wed, 19 Oct 2016 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756662AbcJSQfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 12:35:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:54634 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbcJSOKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:10:39 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MIhDo-1byyXr1P2m-002GAw; Wed, 19 Oct 2016 09:49:15
 +0200
Date:   Wed, 19 Oct 2016 09:49:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1_name: remove ONELINE_SEEN bit
In-Reply-To: <xmqqd1ixphog.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610190949040.197091@virtualbox>
References: <xmqqd1ixphog.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6F2HfecLPr2EE7ACSeSLX0zufydr6fIu7uyfMdBbyWPTK8Dpbnj
 TydVa2JPHhbUH8yul97mFOTdX/PxXOrleC9ZO1x0yKYG436zqEHOC1Etgp6ZFMroi0LnrNT
 QeYP52IyZ2B45a0TFSpjLMcMX8y8V3F2IDwqueyvjGVQCiWCGIAvS4QEMkPV2/fkWu8IiN9
 Zj+/I+OeqwojU+ZV0iIWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fSarIqIxOcU=:a3hWJQSKsd2y8DKeBOx6wh
 HdE2ZhmxzYr5dYOxkUjmqBn3XePpON6u6T5iGJ7QIpsbtfwN5WbsYVMT06m4o07KNsJvOEm6/
 2MYzgvDtaJsUlIH2gk6mjXNNPfBYJIsb6HS/vU3kSSjCGeZOh958reHIXhJ6+Lh28QkkGAwNi
 M+a7tFqFC1hmJX23w/qPmKmhUzFoUALN5slv77Gh1VwkIWT8XJ+xYvzLX+YqS7TrlGcLBqa/V
 UXk/zdvERoZZEaR4K5MIKUuAnSh5ZejyCHke52W3ZPs46EN4ChvUSIlYFc+MA6HyVbXybA2QC
 tSMY2zmOYd2euVsKcCTUuVRJdcN5kv46vGAAvZdCSk9ly2BTrtceLeXfzDsuwoy3/s77SxA7n
 /NOpQbpJ902PMOLhcvLIWRtW4uzuLtgdAoB68wxNyF9HDPZL+kWQ5xQ4cBcXHkDaZ+Pnjwqsz
 3MCtXbWrD2/lky4cHyN/72qvAr9Bn5DraykhCQcZUR2S4Pp9Qgv4ZpXiUky64M6y6UkjjAkWw
 +8qwMeL85ytdtrVk9ZEjdZeLgZrt4s+s9JkSRd+UU9/knDlJ0DLm63KLetd1lldcsrIdfZCi2
 Sl+q1+r/XucbVzQgGXEAak5MQ/eUMTzhyYFm+J/j7dkeyj1b6Kxkf0/j9Ya6NyPzQW3mAg49V
 gtCJlkgeSBnrJ4f9xgVBc/h07t4toEUClshaOw2Rf4+HMVysNvUYjiF0poKFjjjIhvLUgoL9S
 eH7FHk2QbCdRj1tTwmEYzSedNZOvCdfWYbTu9yqlf2maSqJqkPHbtvVNtGp4tci4MuN1p7LG1
 w5o+vIm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 18 Oct 2016, Junio C Hamano wrote:

> 28a4d94044 ("object name: introduce ':/<oneline prefix>' notation",
> 2007-02-24) started using its own bit from object->flags to mark
> commits used while parsing the ":/token" extended SHA-1 syntax to
> name a commit temporarily, and this was kept even when f7bff00314
> ("sha1_name.c: fix parsing of ":/token" syntax", 2010-08-02) found
> and fixed a bug in its implementation.
> 
> The use of that flag bit, however, is limited to a single function,
> get_sha1_oneline(), which first sets it for the commits sitting at
> the tips of refs, uses the bit to avoid duplicate traversal while
> walking the history, and then cleans the bit from all commits it
> walked.
> 
> Which is exactly what the general-purpose TMP_MARK bit meant to be
> used for isolated case was invented for.  Replace ONELINE_SEEN with
> TMP_MARK and retire the former.

ACK,
Dscho
