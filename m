Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BF7202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbdJZPzd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 11:55:33 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:57914 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932527AbdJZPzZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 11:55:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5AAF118079948;
        Thu, 26 Oct 2017 15:55:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: use57_2f139e9ae8523
X-Filterd-Recvd-Size: 1657
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Oct 2017 15:55:23 +0000 (UTC)
Message-ID: <1509033321.11245.3.camel@perches.com>
Subject: Re: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 26 Oct 2017 08:55:21 -0700
In-Reply-To: <CAFQ2z_P9bpw+Pc2DhJTCB8dxj-5JAKLE=nyvToGuiRA8wV66Wg@mail.gmail.com>
References: <1509030170.10651.59.camel@perches.com>
         <CAFQ2z_P9bpw+Pc2DhJTCB8dxj-5JAKLE=nyvToGuiRA8wV66Wg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-26 at 17:11 +0200, Han-Wen Nienhuys wrote:
> On Thu, Oct 26, 2017 at 5:02 PM, Joe Perches <joe@perches.com> wrote:
> > Comparing a cache warm git grep vs command line grep
> > shows significant differences in cpu & wall clock.
> > 
> > Any ideas how to improve this?
> 
> Is git-grep multithreaded?

Yes, at least according to the documentation

$ git grep --help
[]
       grep.threads
           Number of grep worker threads to use. If unset (or set to 0), 8
           threads are used by default (for now).

> IIRC, grep -r uses multiple threads. (Do
> you have a 4-core machine?)

I have a 2 core machine with hyperthreading

$ cat /proc/cpuinfo
[]
model name	: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
stepping	: 3
microcode	: 0xba
cpu MHz		: 2400.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2

