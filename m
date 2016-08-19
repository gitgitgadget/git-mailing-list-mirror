Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381F11F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbcHSW0o (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:26:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65157 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752435AbcHSW0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:26:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24D5837FCC;
        Fri, 19 Aug 2016 18:26:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TVK+hFb92faLUYTOSDrHxTtqIRE=; b=e7OMwy
        W+RNq5xVFdzNfBreUqd8YVjdaRgogtBcjuNydz7n09PRNOFpjkTaTcqxRdQnx1Iq
        9eY9xkIA6Z3n+ZErbk+9Kj55qTN/UCH06MmCuR00xx2N+PtDH7iP0GJrvU6V6Hek
        yoaltBtRcQah87pLvo0zeQvPE+mt5pm7SkunE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m+/LWBQhlRw1E9X4NLO7wTH1NaoQqTET
        OTfzazbIJ04sfKz8EvkN5StcQZKgvPC40WKlE2D4CiKx0yXM5XPZPqZqq0OP+RAf
        BThmgeGc/Y0RtdWSRTyvJemk3aYamCNNujHyERxvEQ2XO7NH67wX5fc1z9gCW7B0
        D9IjACo8WCE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CDB137FCB;
        Fri, 19 Aug 2016 18:26:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93FE937FCA;
        Fri, 19 Aug 2016 18:26:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if path is not checked out
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-5-jacob.e.keller@intel.com>
        <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com>
        <xmqqy43szcom.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xoy+dNY_LVZC4auavHZtPg-tKs_iwaBJF6kgYv_u+ubEA@mail.gmail.com>
Date:   Fri, 19 Aug 2016 15:26:39 -0700
In-Reply-To: <CA+P7+xoy+dNY_LVZC4auavHZtPg-tKs_iwaBJF6kgYv_u+ubEA@mail.gmail.com>
        (Jacob Keller's message of "Fri, 19 Aug 2016 15:00:30 -0700")
Message-ID: <xmqqinuwz97k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00BD4A7A-665C-11E6-9198-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Is there a way to do this lookup? I couldn't find it.

Perhaps submodule_from_path(), that is used to implement "git
submodule--helper name $path"?
