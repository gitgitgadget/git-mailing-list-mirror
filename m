Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947FE2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 19:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbdHDTqy (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 15:46:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59795 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdHDTqx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 15:46:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xPHVz3RvPz1qrMd;
        Fri,  4 Aug 2017 21:46:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xPHVz1xybz3jR9c;
        Fri,  4 Aug 2017 21:46:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4l0hQx-4B039; Fri,  4 Aug 2017 21:46:50 +0200 (CEST)
X-Auth-Info: mj32V2G31IruzX9Cje/D1ia8tTTOfKvmgx3vG5i96l9aP5JupSCzXEMg9d3j7czw
Received: from igel.home (ppp-88-217-1-226.dynamic.mnet-online.de [88.217.1.226])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  4 Aug 2017 21:46:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C30AD2C397B; Fri,  4 Aug 2017 21:46:49 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        <git@vger.kernel.org>
Subject: Re: [RFC] imap-send: escape backslash in password
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
        <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
X-Yow:  Go on, EMOTE!  I was RAISED on thought balloons!!
Date:   Fri, 04 Aug 2017 21:46:49 +0200
In-Reply-To: <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 04 Aug 2017 12:09:52 -0700")
Message-ID: <87bmnvktee.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 04 2017, Junio C Hamano <gitster@pobox.com> wrote:

> Is the quoting rules documented somewhere?  If so, please also give
> a reference to it here.  RFC3501 "6.2.3 LOGIN Command" does not say
> much (other parts of the RFC may specify the rules that apply to
> arguments in general, but I didn't look for them).  Without such
> reference, it is hard to judge if this change is sufficient or even
> correct (in an extreme case, the IMAP server you are talking with
> that prompted you to make this change might be in violation).
>
> For example, FRC3501 "9. Formal Syntax" says that both "password"
> and "userid" are "astring"; it looks strange that the code with this
> patch only touches cred.password while sending cred.username as-is.

astring         = ... / string
string          = quoted / ...
quoted          = DQUOTE *QUOTED-CHAR DQUOTE
QUOTED-CHAR     = <any TEXT-CHAR except quoted-specials> /
                  "\" quoted-specials
quoted-specials = DQUOTE / "\"

Thus the quoting applies to any element that is a string (and a double
quote needs to be quoted as well).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
