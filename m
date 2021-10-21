Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A2C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66D060F25
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhJUXjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:39:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31455 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJUXjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:39:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb3mb2CSlz5Y;
        Fri, 22 Oct 2021 01:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634859439; bh=DhtSgPgXDBvU1gykUVSkv5UkKFlgUpUGRw20sQpZqio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGE36gxrVYwjG1ta5iLCxgzVo1RQ7faTSiyQMRpKm93vooPIxc3TXi8PwxWKIgjD3
         cYd0I6xdZGubX/5jtl6ijCHtSep6s4KKqXMRAMeYE3CCENlxFlCcaLOS3Zss6E1eZf
         sqr/NSVNPAboqqKeprokBEckhX5IfIl7rO2t3PtYkawqDaTyIHU4LxWgWv7JldYsht
         zt8vgNTfVaKDZhib0Qdm4PWG3t6Krf5dJPnGbYwqoHQA5SHL2v/w45PbfSchtl4qGV
         Ei8A8pS5gq3oK/b/+c6aLi9P67uzABHEpOcoWV8wmEQAJVvct3/OU1i4d3nDM+Rjwx
         Pis1DuJsWXbUA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Fri, 22 Oct 2021 01:37:16 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git format-patch --signoff
Message-ID: <YXH5rKsjPIeWSGTE@qmqm.qmqm.pl>
References: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
 <xmqqo87ihurk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo87ihurk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 03:34:39PM -0700, Junio C Hamano wrote:
> Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> writes:
> 
> > I just noticed that `git format-patch --signoff` adds the 'Signed-off-by'
> > line even if the exact same line is already present in the commit message.
> > Could this be avoided in the tool?
> >
> > git version 2.30.2
> >
> > Best Regards
> > Micha³ Miros³aw
> 
> The rule should be "avoid adding the same sign-off as the one at the
> end".  In other words, as a record of the flow of patch custody,
[...]
> This test hasn't changed since it was written in Feb 2013, and I
> think 2.30.2 is recent enough to conform to the rule to pass this
> test.

The test indeed works correctly, and I couldn't reproduce the effect
on a fresh git repo. I finally took a look with hexdump on the output:
the culprit was a UTF-8 non-breaking space -- indistinguishable on
a terminal from a normal space. I'm not sure what to think about this...
Sorry for the noise.

Best Regards
Micha³ Miros³aw
