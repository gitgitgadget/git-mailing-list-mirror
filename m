Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5C91F461
	for <e@80x24.org>; Mon,  9 Sep 2019 18:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfIISdA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:33:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63857 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfIISc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:32:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8E002B523;
        Mon,  9 Sep 2019 14:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XgygtoR+1NTknD9lpH2Hhn7Lb5g=; b=lzel9a
        4GMXl+rsoKb1PJ1Ul6lOkQbzYbS3huStF6XOEzKTHMJyEUNXi8DrHVK+/EUwhDgA
        GkCHkxxT/Epu1XusS9j5wy+YhrW37vKrjY6ZZ8/IunSHF0Hlv2p0hEGWH5fPMrsR
        nmkGfUrZssxqyExKMjB7uV84ITzHevr1t2Lzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=awWH1d3Wjq5RkOJt8quNM7iiUtndiWig
        ExJGC1DUEIXFHDvyLSBkh8Aoq+QfQsvoYjQLiSgmvfrRsg8WlazfCCtWW0rCnuY/
        382XOACF7c7NySm/UXkQ0a+v9av9kuWQfdS8y/M/2T40ivirDEZDyFUWLTBxsiF5
        rk3uCjsWzk4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D16DB2B522;
        Mon,  9 Sep 2019 14:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 197952B51F;
        Mon,  9 Sep 2019 14:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Date test code clean-up
References: <20190909014711.3894-1-ischis2@cox.net>
Date:   Mon, 09 Sep 2019 11:32:55 -0700
In-Reply-To: <20190909014711.3894-1-ischis2@cox.net> (Stephen P. Smith's
        message of "Sun, 8 Sep 2019 18:47:09 -0700")
Message-ID: <xmqqh85ljp60.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E74AF36-D330-11E9-8DBE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> As part of a previous patch submission[1], a cleanup patch was
> suggested to remove a now unnecessary passing of a date environment
> variable to the production code.

It looks like that the idea to realize that get_time() that is aware
of GIT_TEST_DATE_NOW is always called before functions like
show_date_relative(), approxidate_str() and approxidate_careful(),
and arrange it to be called in the lower level of the callchain,
which makes sense to me.


Thanks for tying the loose end.
