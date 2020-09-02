Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8AEC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FE320773
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBTxA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 2 Sep 2020 15:53:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:47968 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBTw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:52:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 082JqsfE055925
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Sep 2020 15:52:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'git'" <git@vger.kernel.org>
References: <077a01d680af$2ad65510$8082ff30$@nexbridge.com> <xmqqft80arpy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft80arpy.fsf@gitster.c.googlers.com>
Subject: RE: [Suggestion] Documentation: quick-install-man not propagating DESTDIR
Date:   Wed, 2 Sep 2020 15:52:47 -0400
Message-ID: <00c101d68162$a598c900$f0ca5b00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHs3eCWNRlAIHgl0UK0IMMhnQe/xAFjnWbRqR3sX/A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 2, 2020 3:45 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > The make quick-install-man rule is not propagating DESTDIR when GNU
> > Make
> > 4.2.1 is used.
> 
> I wonder, instead of having to change all "$(MAKE) -C elsewhere", we can
> add DESTDIR to the list of variables that are exported.
> 
> ... goes and looks ...
> 
> Hmph, DESTDIR is exported together with DIFF, TAR, INSTALL and
> SHELL_PATH.  We do rely on SHELL_PATH to be exported correctly to
> t/Makefile for "make test" to work, so it is puzzling.
> 
> It is doubly puzzling that we use $(INSTALL) in Documentation/Makefile on
> the same line as $(DESTDIR) is used, and apparently you are not reporting
> problem on that one.
> 
> > It seems like a bit of a nit to report this, but I discovered that the
> > installation is not putting the manuals in the same place as git. It’s
> > a pretty simple fix. I can put a patch together if desired.
> 
> I do not think we want that patch.  Instead I think we'd want a patch that
> uses the same trick as what makes INSTALL work.

I'll look into that approach. Thanks for the direction.

Regards,
Randall

