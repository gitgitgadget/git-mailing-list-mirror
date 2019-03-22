Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAD220248
	for <e@80x24.org>; Fri, 22 Mar 2019 17:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfCVRXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 13:23:01 -0400
Received: from che.mayfirst.org ([162.247.75.118]:47945 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfCVRXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 13:23:01 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553275379; h=from : to : cc : subject : 
 in-reply-to : references : date : message-id : 
 mime-version : content-type : content-transfer-encoding : 
 from; bh=F5TqFGOW87TrF2IaammfOuN8PnBbf16q9JMOgkbb2KI=; 
 b=UyD/zhfDfiZxDan8uf4n7wF/Sg0sUT5vTHO1VFmHEIqtrIZJOO3I1QmJ
 +BsSyov2L4FLHdneBNF54N+gXsDaBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553275379; 
 h=from : to : cc : subject : in-reply-to : references : 
 date : message-id : mime-version : content-type : 
 content-transfer-encoding : from; 
 bh=F5TqFGOW87TrF2IaammfOuN8PnBbf16q9JMOgkbb2KI=; 
 b=gCJw+qF0TzHat7FTbyN0DshK6CP8WRPiOHxWlH5Av2SNo+h+lbTCXLPM
 FfzXcuKzqY0f/wVFfMyKetF6q3e69qZy2eqNwZEnz5EDyEAUb/BoNBniyx
 erBOq14fpMMhjl7YEI0rpkirGKGChGpUJz/qzDVb6PyjvfVhghCNHXlzAb
 tz0LLHbJdbH4u+upSoYz0DNxfMo1etThrU17aixIOpZidFS7H9HImXlXOS
 mALkgAkOA/gw8KJtfWmjT18xpty80kDdJXyhKdkMSKwckEAKQke3TnhrEs
 Kg3C8wIsAY8DuHxqB22k0t6BPKk2Y13xNygOY28cje4ev9tmDeJHmw==
Received: from fifthhorseman.net (ip-78-45-46-183.net.upcbroadband.cz [78.45.46.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 4F564F99D;
        Fri, 22 Mar 2019 13:22:59 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id 90B9820A67; Fri, 22 Mar 2019 01:19:07 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
In-Reply-To: <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
References: <875zsdu41d.fsf@fifthhorseman.net> <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com> <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
Autocrypt: addr=dkg@fifthhorseman.net; prefer-encrypt=mutual; keydata=
 mDMEXEK/AhYJKwYBBAHaRw8BAQdAr/gSROcn+6m8ijTN0DV9AahoHGafy52RRkhCZVwxhEe0K0Rh
 bmllbCBLYWhuIEdpbGxtb3IgPGRrZ0BmaWZ0aGhvcnNlbWFuLm5ldD6ImQQTFggAQQIbAQUJA8Jn
 AAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBMS8Lds4zOlkhevpwvIGkReQOOXGBQJcQsbzAhkB
 AAoJEPIGkReQOOXG4fkBAO1joRxqAZY57PjdzGieXLpluk9RkWa3ufkt3YUVEpH/AP9c+pgIxtyW
 +FwMQRjlqljuj8amdN4zuEqaCy4hhz/1DbgzBFxCv4sWCSsGAQQB2kcPAQEHQERSZxSPmgtdw6nN
 u7uxY7bzb9TnPrGAOp9kClBLRwGfiPUEGBYIACYWIQTEvC3bOMzpZIXr6cLyBpEXkDjlxgUCXEK/
 iwIbAgUJAeEzgACBCRDyBpEXkDjlxnYgBBkWCAAdFiEEyQ5tNiAKG5IqFQnndhgZZSmuX/gFAlxC
 v4sACgkQdhgZZSmuX/iVWgD/fCU4ONzgy8w8UCHGmrmIZfDvdhg512NIBfx+Mz9ls5kA/Rq97vz4
 z48MFuBdCuu0W/fVqVjnY7LN5n+CQJwGC0MIA7QA/RyY7Sz2gFIOcrns0RpoHr+3WI+won3xCD8+
 sVXSHZvCAP98HCjDnw/b0lGuCR7coTXKLIM44/LFWgXAdZjm1wjODbg4BFxCv50SCisGAQQBl1UB
 BQEBB0BG4iXnHX/fs35NWKMWQTQoRI7oiAUt0wJHFFJbomxXbAMBCAeIfgQYFggAJhYhBMS8Lds4
 zOlkhevpwvIGkReQOOXGBQJcQr+dAhsMBQkB4TOAAAoJEPIGkReQOOXGe/cBAPlek5d9xzcXUn/D
 kY6jKmxe26CTws3ZkbK6Aa5Ey/qKAP0VuPQSCRxA7RKfcB/XrEphfUFkraL06Xn/xGwJ+D0hCw==
Date:   Fri, 22 Mar 2019 01:19:07 -0400
Message-ID: <87imwbmqpg.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the thoughtful feedback, Junio!

On Thu 2019-03-21 10:31:59 +0900, Junio C Hamano wrote:
> The other point still stands; there are legitimate reasons people
> would want to have a tag with v1.0.0 tagname in somewhere that is
> not refs/tags/v1.0.0 and an extra validation must need to make sure
> it won't error out, even though warning is probably acceptable.

It would be great if "git tag -v" would present a warning by default in
case of a tag name mismatch!  I would not want to rule out making it
possible to return an error though.

I don't personally have any use case for doing such a tag rename -- you
mention two:

 a) wanting to call tag "foo" that you found on remote "origin" by the
    name of "origin/foo"

 b) wanting to call "v2.20.0" by the name "g2.20.0"

And Ævar mentions a third:

 c) mapping versioned tags (e.g. "v2.20.0") to tags with a date name
    ("2018-03-22")

I'm not sure how realistic or useful any of these patterns are.  While
(a) seems the most plausible of the lot to me, none of them are things
i've ever seen in practice.

So i'd say that anyone in such a scenario is the outlier, and i wouldn't
want the existence of that edge case to make git less useful in the much
more common case.

Here's a revised proposal:

Consider a config setting named tag.verifyNameMatch, which can be true,
false, or some sort of sed expression name mangler.

 - If set to true, it would do the thing that naive users probably
   expect when they do "git tag -v foo" -- show a warning *and* return
   an error if the tag message itself doesn't have "tag foo" in the
   "header section" of the signed tag.

 - If set to false, it wouldn't error out (though maybe it would still
   show the warning).

 - If set to a sed expression, it would feed the name being checked
   through the sed expression and ensure that the resultant value was
   present in the signed tag's "header section".

The mangler would work in a pretty straightforward way for (a)
(e.g. "s_origin/(.*)_\1_") and (b) (e.g. "s_v(.*)_g\1_").

i don't see how it would handle (c), but i think there are probably
better ways to handle (c) (if i'm understanding Ævar's scenario
correctly) than just trying to replay the upstream author's tags with
different names.  For example, the curator of the repository could just
make their own signed tags, based on whatever policy they wanted.  Or,
they could just ignore the warnings :P

As you can probably guess, i'd say that such a tag.verifyNameMatch
should default to true, but i'd also be ok if it started off defaulting
to false, to gather feedback about its impact, and eventually consider
transitioning it to true by default.

      --dkg
