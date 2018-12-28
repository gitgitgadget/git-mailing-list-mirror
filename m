Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1209C1F770
	for <e@80x24.org>; Fri, 28 Dec 2018 20:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbeL1UDu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 28 Dec 2018 15:03:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35936 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL1UDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:03:49 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBSK3gtd015578
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Dec 2018 15:03:43 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <20181227223856.18768-1-randall.s.becker@rogers.com> <CAPig+cTjn4je8dOANs-xHhU_NYRw-Twm22HSnSLNXTkDB-qRYw@mail.gmail.com>
In-Reply-To: <CAPig+cTjn4je8dOANs-xHhU_NYRw-Twm22HSnSLNXTkDB-qRYw@mail.gmail.com>
Subject: RE: [PATCH v3 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Fri, 28 Dec 2018 15:03:36 -0500
Message-ID: <000c01d49ee8$6ea2a0a0$4be7e1e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWZAyZ9vkzTphgb4gU3ZQu12NNQQGrlG+/pYOr5nA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 28, 2018 14:43, Eric Sunshine wrote:
> On Thu, Dec 27, 2018 at 5:39 PM <randall.s.becker@rogers.com> wrote:
> > A number of configuration options are not automatically detected by
> > configure mechanisms, including the location of Perl and Python.
> >
> > There was a problem at a specific set of operating system versions
> > that caused getopt to have compile errors. Account for this by
> > providing emulation defines for those versions.
> 
> This version of the patch looks much better and addresses my comments on
> previous attempts. One note below...
> 
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/config.mak.uname b/config.mak.uname @@ -441,26 +441,45
> @@
> > ifeq ($(uname_S),NONSTOP_KERNEL)
> > +       # The current /usr/coreutils/rm at lowest support level does not work
> > +       # with the git test structure. Long paths cause nftw as in
> > +       # 'trash directory...' cause rm to terminate prematurely without fully
> > +       # removing the directory at OS releases J06.21 and L17.02.
> > +       # Default to the older rm until those two releases are deprecated.
> > +       RM = /bin/rm -f
> 
> Thanks, this comment does a much better job of explaining the actual
> problem and selling the solution.
> 
> There is a slight grammatical problem:
> 
>     Long paths _cause_ ... _cause_ rm to terminate...
> 
> which might deserve fixing.

Rerolled. Thanks.

