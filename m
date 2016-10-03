Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC96207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbcJCV4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:56:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57621 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753022AbcJCV4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:56:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3332B41F7F;
        Mon,  3 Oct 2016 17:56:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HE76Vrf3nnh3+UDWA6z3zum2ZTk=; b=phnFlj
        W3ZiM6C/XBEpb6pf2TqnLFX80ZQ/IfoA7V7rQYXrpj1whn9POPhP9VTwG9S9X2ER
        4gGusLDTKjn1Vwgaj/wDPfHL6mIny9WPgifmBADWXaJ8j8oG0tiTbap1Q0RoR2IU
        Ux+jEl2emOdQ4ySnWbxE02C9SZbya/wVF5tus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ndAPpKNRT7Tda2wQWwXXMTRCRJ2DuMRH
        WMK/JXkTNMgImUAMvwJ9Xjytkmy2WTclzYgLj9z00pn153kSVNFRhHE6coAKnC8g
        klFXP2W1DpvaCkSe6A8XPs5Hew1+UguYtJl/LqrzOOiOha2uWnIGpZqKAna2pqW5
        0Gp1X0cdjLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C6EB41F7E;
        Mon,  3 Oct 2016 17:56:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9900341F7D;
        Mon,  3 Oct 2016 17:56:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
        <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
        <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
Date:   Mon, 03 Oct 2016 14:56:46 -0700
In-Reply-To: <CAGZ79kYt+Z=ff1b2G+wWRAGGS=je+dpksfmMXj0fWwYVvHk8Cg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 3 Oct 2016 14:49:51 -0700")
Message-ID: <xmqqh98t5c69.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4897D60A-89B4-11E6-8B3E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>     // Note: git_attr_check_elem seems to be useless now, as the
>     // results are not stored in there, we only make use of the `attr` key.

I do not think git_attr_check_elem would be visible to the callers,
once we split the "inquiry" and "result" like the code illustrated
above.  I actually doubt that the type would even internally need to
survive such a rewrite.

The point of "future-proofing" the callers is to hide such
implementation details from them.  We know that the current API will
need to be updated at least once to prepare the implementation of
the API so that it has some chance of becoming thread-safe, and I
think we know enough how the updated API should look like to the
callers.  I was hoping the minimum future-proofing would allow us to
update the current "attr" API users only once, without having to
update them again when we make it ready to be used in threaded
environment.
