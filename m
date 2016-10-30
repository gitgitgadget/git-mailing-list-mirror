Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66092021E
	for <e@80x24.org>; Sun, 30 Oct 2016 08:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbcJ3IDX (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 04:03:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751080AbcJ3IDU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 04:03:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E17940AAB;
        Sun, 30 Oct 2016 04:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=24RRwSaEflNo4tnwZR5yFjnOuk0=; b=hRCq8l
        43YE4+s9Tnne0V7QJI2MxrIHCA1f3hQOt3noSPIdX93YZBSdj+QeoLuTVDuTP5lm
        RX+UeUnEOo2llCp6HHIBfb8e25E7hBnct1ZQKAXNMnx6DgTF06OLUTuB7VMRkI1y
        4AQlC77mbZ0LicAzEk9nkoT/WvlYTECZA8NhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TrZXwMy6ZbzvOsdiovrSxu9Y9uCvGTB6
        RFq3sFflGCKffFY6dqGN03DWUMFPddn4DuXKFN8iKpUJFyGVN5Z37cKKd+kkJmMk
        Cgalx9kRWAwZBBdKuhwneECn4IurbCEWzwStiNOEWNz08h/all2ke3bmGmNnBTgk
        basBIJ7x/Ek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 851E840AA9;
        Sun, 30 Oct 2016 04:03:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0970B40AA8;
        Sun, 30 Oct 2016 04:03:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
References: <1477690790.2904.22.camel@mattmccutchen.net>
        <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
        <1477692961.2904.36.camel@mattmccutchen.net>
        <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
        <1477712029.2904.64.camel@mattmccutchen.net>
        <CAPc5daVOxmowdiTU3ScFv6c_BRVEJ+G92gx_AmmKnR-WxUKv-Q@mail.gmail.com>
        <1477757268.1524.20.camel@mattmccutchen.net>
Date:   Sun, 30 Oct 2016 01:03:17 -0700
In-Reply-To: <1477757268.1524.20.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sat, 29 Oct 2016 12:07:48 -0400")
Message-ID: <xmqqtwbuuuuy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51B5A4A6-9E77-11E6-B6F7-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> On Fri, 2016-10-28 at 22:31 -0700, Junio C Hamano wrote:
>> Not sending to the list, where mails from Gmail/phone is known to get
>> rejected.
>
> [I guess I can go ahead and quote this to the list.]
>
>> No. I'm saying that the scenario you gave is bad and people should be
>> taught not to connect to untrustworthy sites.
>
> To clarify, are you saying:
>
> (1) don't connect to an untrusted server ever (e.g., we don't promise
> that the server can't execute arbitrary code on the client), or
>
> (2) don't connect to an untrusted server if the client repository has
> data that needs to be kept secret from the server?

You sneaked "arbitrary code execution" into the discussion but I do
not know where it came from.  In any case, "don't pull from or push
to untrustworthy place" would be a common sense advice that would
make sense in any scenario ;-)

Just for future reference, when you have ideas/issues that might
have possible security ramifications, I'd prefer to see it first
discussed on a private list we created for that exact purpose, until
we can assess the impact (if any).  Right now MaintNotes says this:

    If you think you found a security-sensitive issue and want to disclose
    it to us without announcing it to wider public, please contact us at
    our security mailing list <git-security@googlegroups.com>.  This is
    a closed list that is limited to people who need to know early about
    vulnerabilities, including:

      - people triaging and fixing reported vulnerabilities
      - people operating major git hosting sites with many users
      - people packaging and distributing git to large numbers of people

    where these issues are discussed without risk of the information
    leaking out before we're ready to make public announcements.

We may want to tweak the description from "disclose it to us" to
"have a discussion on it with us" (the former makes it sound as if
the topic has to be a definite problem, the latter can include an
idle speculation that may not be realistic attack vector).

