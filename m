Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FE520953
	for <e@80x24.org>; Tue, 14 Mar 2017 21:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdCNVdx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:33:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbdCNVdw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:33:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7606A71FE5;
        Tue, 14 Mar 2017 17:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m9tbSSZej2ngopB17VNQjawOr2s=; b=My6iI7
        GGRa83AOoUrhiBFk3AadewGnwTixHf7KkQMfXB1u+EzyPBYK4pmz/18hISIQF6+A
        hRHVz5U2Dx3JXAbaTsztvqnn/HcsW7pSMA5kD+EbKQTYBmZeCK1RU8TszMRHKY9G
        oB0vAkYfn/HdVImfk5t2QUqqN/AfKk/r+53qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nBS0xASEbFCSx4JRpQTj6JGVoeJ6hT9G
        leMrTZJ3Jk6RDFogxbDsrer+NfHmUSADHGWZWabo7/rb8jR2sYXJW1Z3U4LSAYDB
        dHJZ/bKfHJTlnVNgD04IiYqeFO6++XM0Sf1WiicV4JQT6ziTxou+ImQ23akghohN
        Z6czhn67X08=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 662E971FE4;
        Tue, 14 Mar 2017 17:33:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADD6B71FE2;
        Tue, 14 Mar 2017 17:33:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper is-active
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-3-bmwill@google.com>
        <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ6noz7RGbmNwg=NhuWYH=KbNPYUWL7We9YjbHn6uf2Jg@mail.gmail.com>
Date:   Tue, 14 Mar 2017 14:33:43 -0700
In-Reply-To: <CAGZ79kZ6noz7RGbmNwg=NhuWYH=KbNPYUWL7We9YjbHn6uf2Jg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Mar 2017 11:16:29 -0700")
Message-ID: <xmqqpohjh7bc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6A2CC42-08FD-11E7-9314-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So to answer your original question, I think the codebase currently
> thinks by_path is handier, the name is a mere internal field in
> "struct submodule", useful for looking up its git dir.

OK, that makes sense at the conceptual level, too.  When you have a
specific version of the superproject checked out, you would want to
identify which submodule to work on by the path to it inside that
version of the superproject.  The name is used only to keep track
of attributes of the submodule that will not change across versions
of the superproject, no matter where in its tree it binds the
submodule at.

Thanks.
