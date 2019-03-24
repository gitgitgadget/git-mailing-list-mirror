Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFE020248
	for <e@80x24.org>; Sun, 24 Mar 2019 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCXPp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 11:45:26 -0400
Received: from che.mayfirst.org ([162.247.75.118]:55495 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXPp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 11:45:26 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553442325; h=from : to : cc : subject : 
 in-reply-to : references : date : message-id : 
 mime-version : content-type : from; 
 bh=zAJVHhaChnTmGuFUcAWr0yZeBANNsHAHLt0ceH5NT5Y=; 
 b=1v+iWBvWk/IY5rvvBeQSBJXXVzIlJaN4KHmkTgvrPMgsl5oaEmeezWEg
 llyXA3Ifh6xFBfNq2nHk55Bz4hhyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553442325; 
 h=from : to : cc : subject : in-reply-to : references : 
 date : message-id : mime-version : content-type : from; 
 bh=zAJVHhaChnTmGuFUcAWr0yZeBANNsHAHLt0ceH5NT5Y=; 
 b=g8Z0cI53oi4alx+rQzlC80abbJ2z7C1duetX1L6Ay035pN2iA7pfoboP
 QqS/iFmmo/2We9xrv34lFZ9Q1LF+lSCQ8WcXacdrQg5/izatyZ6zXbqUV2
 e/ex8UBfeiPDzz41xe0uDdrGAHZ30YaD/8KFX0bQjpmOoVrYFRZp0gfR0s
 3kkeGQ3UWUYtpqK6RSmkuo29qLocX8lvSg4wxQln+ePJvKiHlG1SZMduVq
 oxeadVFOBtycZSBb1awshmy7Pe+9JwVeIOmtsluas88qQzVGWT9qR5Sn73
 JKJsRmehiZMw7hjRhKYEjelA+Cysi1S7RKTsgkgUrgLL1phqiHs/yA==
Received: from fifthhorseman.net (dhcp-8363.meeting.ietf.org [31.133.131.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 0B027F99E;
        Sun, 24 Mar 2019 11:45:24 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id 30A032045B; Sun, 24 Mar 2019 11:07:21 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
In-Reply-To: <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com>
References: <875zsdu41d.fsf@fifthhorseman.net> <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com> <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com> <87imwbmqpg.fsf@fifthhorseman.net> <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com>
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
Date:   Sun, 24 Mar 2019 16:07:21 +0100
Message-ID: <87k1goia52.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun 2019-03-24 21:26:13 +0900, Junio C Hamano wrote:
> Daniel Kahn Gillmor <dkg@fifthhorseman.net> writes:
>
>> I don't personally have any use case for doing such a tag rename -- you
>> mention two:
>>
>>  a) wanting to call tag "foo" that you found on remote "origin" by the
>>     name of "origin/foo"
>>
>>  b) wanting to call "v2.20.0" by the name "g2.20.0"
>
> For the record, in the latter there is no "wanting to call".  It was
> merely a set-up used to illustrate what support there already exists
> in the current system that helps making users aware of tags that are
> not stored in there "natural" place.
>
> The former however is a natural consequence of noises people make
> around here from time to time, wanting to have tags you grab from
> elsewhere and tags you create locally in separate places.

Gotcha, thanks.  I like the warnings that are already showing up from
(b) So I won't worry about (b) as a justification then, but rather keep
my focus on (a).  (and i still think that (c) has better solutions than
tag renaming)

What do you think of my updated proposal for tag.verifyNameMatch ?

     --dkg
