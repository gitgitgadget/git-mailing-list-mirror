Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CAFC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35626124F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhIWWGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 18:06:15 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23179 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbhIWWGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 18:06:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18NM4Qrq084294
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Sep 2021 18:04:27 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'The Grey Wolf'" <greywolf@starwolf.com>, <git@vger.kernel.org>
References: <20210923052122.2F655CE@eddie.starwolf.com>        <YUzvhLUmvsdF5w+r@coredump.intra.peff.net> <xmqqmto3x8ik.fsf@gitster.g>
In-Reply-To: <xmqqmto3x8ik.fsf@gitster.g>
Subject: RE: ANSI sequences produced on non-ANSI terminal
Date:   Thu, 23 Sep 2021 18:04:20 -0400
Message-ID: <038801d7b0c6$f9345a90$eb9d0fb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHzKS1X8+OhPx5wRnftnkcRu86GpwHNlhe/AW7r6eWrYVaywA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 23, 2021 5:55 PM, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>> On Wed, Sep 22, 2021 at 10:21:22PM -0700, The Grey Wolf wrote:
>>
>>> Anything else you want to add:
>>> 	I searched google and the documentation as best I was able for
>>> 	this, but I am unable to find anywhere that will let me disable
>>> 	(or enable) colour for a particular term type.  Sometimes I'm on
>>> 	an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
>>> 	for which this is sub-optimal.  My workaround is to disable colour
>>> 	completely, which is reluctantly acceptable, but it would be nice
>>> 	to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
>>> 	colour or cursor-positioning, otherwise shut it off."  If this
>>> 	seems too much of a one-off to handle, fine, but most things that
>>> 	talk fancy to screens are kind enough to allow an opt-out based on
>>> 	terminal type. :)
>>
>> Git doesn't have any kind of list of terminals, beyond knowing that
>> "dumb" should disable auto-color. It's possible we could expand that
>> if there are known terminals that don't understand ANSI colors. I'm a
>> bit wary of having a laundry list of obscure terminals, though.
>>
>> If we built against ncurses or some other terminfo-aware library we
>> could outsource that, but that would be a new dependency. I'm hesitant
>> to do that even as an optional dependency given the bang-for-the-buck
>> (and certainly making it require would be right out).
>
>I was wondering if Gray Wolf can run screen on the Wyse, and then wouldn't git see TERM=screen which is pretty much ANSI if I am
not
>mistaken ;-)?

Would something like switch in .gitconfig make a difference? Like core.colourize=false. There are situations where SSH sessions come
in from automation, like Jenkins and Travis, which sets term to something other than dumb by default. Coloring makes a mess of the
output. The ability to turn off colouring off by user might be helpful.

-Randall

