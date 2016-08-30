Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917271F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbcH3R0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:26:43 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:54055 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932463AbcH3R0m (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 13:26:42 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 31E7F268E11;
        Tue, 30 Aug 2016 17:26:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rice20_1132ddba54a
X-Filterd-Recvd-Size: 2760
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 17:26:40 +0000 (UTC)
Message-ID: <1472577999.5512.107.camel@perches.com>
Subject: Re: git am and duplicate signatures
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 30 Aug 2016 10:26:39 -0700
In-Reply-To: <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
References: <1472573556.5512.93.camel@perches.com>
         <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-08-30 at 09:54 -0700, Junio C Hamano wrote:
> Support for more generic footers was supposed to come when the
> "interpret-trailers" topic started, but the author of the topic
> seems to have lost interest before the mechanism has become ready to
> be integrated in the workflow commands like "am", "commit", "rebase"
> etc., which is unfortunate.

I think adding at least an option to git send-email
allowing auto-cc's for all
	"<foo>-by: [name] <address>"
lines in the commit log would be useful.

Today, only "Signed-off-by" and "CC" lines are
added to cc's.

I've always called these lines "<foo>-by:" lines
"signatures", but perhaps there's a better name.

Any preference?

from git send-email --help
       --suppress-cc=<category>
           Specify an additional category of recipients to suppress the
           auto-cc of:

           ·   author will avoid including the patch author

           ·   self will avoid including the sender

           ·   cc will avoid including anyone mentioned in Cc lines in the
               patch header except for self (use self for that).

           ·   bodycc will avoid including anyone mentioned in Cc lines in the
               patch body (commit message) except for self (use self for
               that).

           ·   sob will avoid including anyone mentioned in Signed-off-by
               lines except for self (use self for that).

           ·   cccmd will avoid running the --cc-cmd.

           ·   body is equivalent to sob + bodycc

           ·   all will suppress all auto cc values.
> > 
> > sequencer.c:append_signoff() has a flag for APPEND_SIGNOFF_DEDUP
> Yes, I think this is one of the warts we talked about getting rid of
> but haven't got around to it.  It is there because "format-patch -s"
> was incorrectly written to dedup Signed-off-by: from anywhere in its
> early implementation and to keep the same behaviour.  We should drop
> that flag from append_signoff() function.
