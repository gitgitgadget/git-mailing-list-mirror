Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52D22021E
	for <e@80x24.org>; Thu, 10 Nov 2016 00:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbcKJAgY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 19:36:24 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:48236 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbcKJAgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 19:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=0e3525mTONFgGO
        bZFAnoL4kDXS7KI73pbaWa27OtsXs=; b=IpESZY/9nh6eLOByJahQCR1ROns99p
        107gfXkjW+oxJCM0EhU1EX/6e4JrJlcN0zPv5dlOqKiqoKTMRf8KkfaAWLnpIQN1
        kUNHW1aBYI6itWVUaDJZ28MY6rimQdEHAmv4wWAQopW+Wh66UjOikxvCynxGmgWm
        lpIgeaTGxtg3Q=
Received: (qmail 17017 invoked from network); 10 Nov 2016 01:36:20 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 10 Nov 2016 01:36:20 +0100
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not
 to abbreviate
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
 <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
 <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
 <22561.44597.59852.574831@chiark.greenend.org.uk>
 <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
 <22562.32428.287354.214659@chiark.greenend.org.uk>
 <xmqqa8d9b3jh.fsf@gitster.mtv.corp.google.com>
 <22562.65461.845411.29907@chiark.greenend.org.uk>
 <xmqqeg2k8cwz.fsf@gitster.mtv.corp.google.com>
 <22563.45501.383303.374430@chiark.greenend.org.uk>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <ac17a9a7-d951-67f6-8428-d2e142a1f648@jump-ing.de>
Date:   Thu, 10 Nov 2016 01:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <22563.45501.383303.374430@chiark.greenend.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.11.2016 um 00:31 schrieb Ian Jackson:
> I am proposing to set this configuration setting automatically in
> dgit.  Other tools that work with particular git tags would do the
> same.  There would be no need for users to do anything.
> 
> Having this as an option in a menu would be quite wrong, because it
> would end up with the user and the tooling fighting.  This is why I
> don't want to put this in gitk's existing config file mechanism.

Having this conversation watched for a while I get the impression that your point is essentially about introducing another type of references, next to branches and (ordinary) tags. Let's call them "interesting tags", "itags".

The logical path to get this, IMHO, isn't to add some configuration variable, but to store such interesting tags in .git/refs/itags/, just like the other reference types. Then one would create such interesting tags with

  git tag -i <name>
or
  git tag --interesting <name>

To reduce the backwards compatibility problem these itags could be stored in .git/refs/tags as well, itag-aware tools would sort the duplicates out.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
