Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B3E20966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755016AbdC3VXX (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:23:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754346AbdC3VXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:23:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C816EC4A;
        Thu, 30 Mar 2017 17:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pv4s/VMyAeCzz6pGIZhT8hFJJEs=; b=sDxnCK
        JJD2oC2OZzGLfzZTmMvlUqnzDcUmQeRw09a/HoLyB65fANjxFJU57wgbnICjyCOj
        ZMH5lUJON6y05JDr8UgGiwoRMFiLQ5NF7AWJG6cKoYx4VALqdW4Ct5BB9pqWDlLA
        ksKNCSxFTxEjbRoe7hp1WAAqnemOJJetoC8pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8annOEF0eLOvdtR1FKZhVf5zc8vIlP5
        VKcFSmFZ1itF/tWobcI6P27V28WRRysLI5jNEwYZMAY7ljoPz7nnAPlh58xin+yq
        2VJARQ4RNemLXXaNHpdX3Ha0f+VMBgNNdAGjphiAApEvb3QC8nDSYZOJsm1y7PU2
        cUKtW2IENvI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09C946EC49;
        Thu, 30 Mar 2017 17:23:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 740BD6EC48;
        Thu, 30 Mar 2017 17:23:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git and PCRE2 vs PCRE?
References: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
Date:   Thu, 30 Mar 2017 14:23:19 -0700
In-Reply-To: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 30 Mar 2017 16:59:27 -0400")
Message-ID: <xmqq60iq31dk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 192BB96A-158F-11E7-9D3D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Is it possible to use PCRE2 with Git? If so, how do I tell Git to use PCRE2?

Given that pcre2's symbols are all prefixed with pcre2_ (I only
checked http://www.pcre.org/current/doc/html/pcre2api.html) and we
do not see any hits from "git grep pcre2", I do not think you can
just "configure" Git to use it.  Unless pcre2 library has a drop-in
replacement backward compatibility mode with pcre library, that is.

It probably is possible to use PCRE2 with Git by adding similar
amount of code to grep.[ch] as we have support for pcre and that
would be the way you tell Git to use PCRE2, but I think that is
probably not the questino you are asking.
