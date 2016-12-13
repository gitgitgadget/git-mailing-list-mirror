Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC7C203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbcLMTys (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:54:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65386 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933519AbcLMTyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:54:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C606957CAB;
        Tue, 13 Dec 2016 14:54:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4p5uge6VnG2RX6Si8haML7DKm9o=; b=E6iYzk
        PpW6srIlHQ4aynx9E+C3q8FxCelCRBO/pk1ialfp6usoQZEZ4yPtw5FSC56aFbhf
        JMzboxAsVVVEWmBgkyvYj4erCM3vejGMdCrC9/XP/sbu1SxuJ2BllCHFnd5pz9ZB
        trZQcN01x19sydG8RhUUPjfzH7gl1v4RvqzUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bAQZ8TWOVkaf6Ows/SL4GL49AeGgj6na
        jmZ1l8MWoaeYvXSP6zxMh10mGfMAVqwt5bRgTpd9V4/SDLSi34xmazatynCmB7mQ
        t8qn6aZ7WiKrk4L/PwPD0/tbr4MqE1w90uvZ2OGm+JDPOhdnU+Bejw0qT4pTcM+5
        vkXwl3jcBNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB51457CAA;
        Tue, 13 Dec 2016 14:54:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22ED757CA8;
        Tue, 13 Dec 2016 14:54:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
References: <20161213014055.14268-1-sbeller@google.com>
        <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
        <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
        <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
        <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
Date:   Tue, 13 Dec 2016 11:54:40 -0800
In-Reply-To: <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Dec 2016 11:38:57 -0800")
Message-ID: <xmqq1sxb38qn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCFF9B96-C16D-11E6-B923-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I guess the latter is the case, so embedding is actually inside
> the working tree and un-embedding is the relocation to the
> superproject.

Another reason why I personally see a .git in each submodule working
tree is "embedded" has nothing to do with Git.  It is an analogy I
feel (perhaps it is just me) with the word "embedded reporters in
warzone".  These people are spread around, assigned to units to
report from places closer to the front line and being closer to the
leaf of the hierarchy, as opposed to be assigned to a more central
place like HQ to do their reporting.
