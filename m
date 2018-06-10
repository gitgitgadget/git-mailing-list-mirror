Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EA11F403
	for <e@80x24.org>; Sun, 10 Jun 2018 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbeFJPOw (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:14:52 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:46778
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932092AbeFJPOt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:14:49 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1wEfgzM8S8poS1wHfm5uL; Sun, 10 Jun 2018 08:07:31 -0700
Date:   Sun, 10 Jun 2018 18:07:27 +0300
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180610150727.GE27650@jessie.local>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604044408.GD14451@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMQebGgUucjXlqNNpqJaOemTG4QauJpY2umcPbDI/IIKvSIiaylxrOrw7y0Zg72fygOkQEkT/SEJ+S207QUjF/CVHU0EYLn4sYk0XI42u0jg7bC3e1g1
 4PI+TWG/RKTvLk/9/9LxQ7JG6JZe9dZfYOJ4zT4h6NdG41c56SoTBWkt85gpsElKsci7TMBB9o5VPrnaQE1vMNJVhn5jnZ5+1TmGXuAw7XkBU1k0HECE5xNz
 3RDYLGwD5wB1Li/XolhhPEkpPiLmDYCag2/MbHChQJmCuvBPls5Wtmxbv+2sECT+PQqte+DycChsFTzDPG2uv7gAl/4guOQPhsQcTQ6Tn3NQNcU1CqlwuvH1
 1p5D1zgzKgDgQJtO/tJ9vQxeDEDqgNgAmRWvO+7Q4i5Mw+iArEI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 12:44:09AM -0400, Jeff King wrote:
> On Sun, Jun 03, 2018 at 12:27:49AM +0300, Max Kirillov wrote:
>> +	env \
>> +		CONTENT_TYPE=application/x-git-upload-pack-request \
>> +		QUERY_STRING=/repo.git/git-upload-pack \
>> +		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>> +		GIT_HTTP_EXPORT_ALL=TRUE \
>> +		REQUEST_METHOD=POST \
>> +		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
>> +		git http-backend </dev/zero >/dev/null 2>err &&
>> +	grep -q "fatal:.*CONTENT_LENGTH" err
> 
> I'm not sure if these messages should be marked for translation. If so,
> you'd want test_i18ngrep here.

Message localization does not seem to be used in
http-backend at all. It makes sense - server-side software
probably does not know who is the user on the other side, if
the message gets to the user at all. So, I think the
message should not be translated.
