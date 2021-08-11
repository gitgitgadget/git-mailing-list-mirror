Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813EC432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AA660EB5
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhHKIH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbhHKIEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 04:04:37 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6BC0613D3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:03:50 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:50932)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDjDG-00068e-Q5; Wed, 11 Aug 2021 04:03:46 -0400
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:53229)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDjDF-0001cB-2h; Wed, 11 Aug 2021 04:03:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id C37B227C0054;
        Wed, 11 Aug 2021 04:03:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 11 Aug 2021 04:03:43 -0400
X-ME-Sender: <xms:X4QTYa940Whfol2KVZruUr4wiZhwtwTwpW9Itg661EZwSDQ31XtbZg>
    <xme:X4QTYau45x66ZzZmLVJysOBaoyzO6dogaXducumOsLM6VrVdWZ-0bk7ELi6ZTGvxs
    LbWlL-VXirDgQ>
X-ME-Received: <xmr:X4QTYQCbl9dv83VBuMOk2YqwuA4MKgLQW0WJ4-d7QYzf-iLVAWAJpGfjt3G-rujCcTrROmmdI9uza_VeNX6U5p-HURmNrLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvffuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdho
    rhhgqeenucggtffrrghtthgvrhhnpeevveeikeetkeeviefgfeffiedvteeguddvffeuue
    duveegtddthedvhfeuveffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehfrghs
    thhmrghilhdrfhhm
X-ME-Proxy: <xmx:X4QTYSdrsikely4KFyaVOUNVtWgDn4wQC4ChnxF3buWFmTkGX7c47Q>
    <xmx:X4QTYfNtdOPSRVs5igssvZnIN7r_iC2ndyr3S1-1mvGyC5esS70drQ>
    <xmx:X4QTYcm-RQqcShdCyXatXR4xwpqbRWlLpW__fiam8xlPfwIBj-b4SA>
    <xmx:X4QTYV0UhwH_sZ1uqYpPXb4ZQb-AXblPkHNB3kECAc-LUygtGhABtw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 04:03:42 -0400 (EDT)
References: <20210810190937.305765-1-tsdh@gnu.org>
 <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org> <87zgtoh6bm.fsf@gnu.org>
 <95ebb2cf-2e6e-912e-7d80-3947a8e3d9e4@kdbg.org>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] userdiff: improve java hunk header regex
Date:   Wed, 11 Aug 2021 09:39:02 +0200
In-reply-to: <95ebb2cf-2e6e-912e-7d80-3947a8e3d9e4@kdbg.org>
Message-ID: <87wnosh0gz.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

Hi Hannes,

>>> These new tests are very much appreciated. You do not have to go
>>> wild with that many return type tests; IMO, the simple one and the
>>> most complicated one should do it. (And btw, s/cart/card/)
>> 
>> Well, they appeared naturally as a result during development and made
>> it easier to spot errors when you know up to which level of
>> complexity it still worked.  Is there a stronger reason to remove
>> tests which might not be needed, e.g., runtime cost on some CI
>> machines?
>
> I totally understand how the test cases evolved. Having many of them
> is not a big deal. It's just the disproportion of tests of this new
> feature vs. the existing tests that your patch creates, in particular,
> when earlier of the new tests are subsumed by later new tests.

Sure thing, I'll see if I can remove some tests.

>> Another thing I've noticed (with my suggested patch) is that I should
>> not try to match constructor signatures.  I think that's impossible
>> because they are indistinguishable from method calls, e.g., in
>> 
>>   public class MyClass {
>>       MyClass(String RIGHT) {
>>           someMethodCall();
>>           someOtherMethod(17)
>>               .doThat();
>>           // Whatever
>>           // ChangeMe
>>       }
>>   }
>> 
>> there is no regex way to prefer MyClass(String RIGHT) over
>> someOtherMethod().
>
> Good find.

The longer you play with it, the more you find out.

>> So all in all, I'd propose this version in the next patch version:
>> 
>> --8<---------------cut here---------------start------------->8---
>> PATTERNS("java",
>> 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>>          "^[ \t]*("
>>          /* Class, enum, and interface declarations */
>>          "(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
>>          /* Method definitions; note that constructor signatures are not */
>>          /* matched because they are indistinguishable from method calls. */
>>          "|(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
>>          ")$",
>> 	 /* -- */
>> 	 "[a-zA-Z_][a-zA-Z0-9_]*"
>> 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>> 	 "|[-+*/<>%&^|=!]="
>> 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>> --8<---------------cut here---------------end--------------->8---
>
> That looks fine.
>
> One suggestion, though. You do not have to have all positive patterns
> ("class, enum, interface" and "method definitions") in a single
> pattern separated by "|". You can place them on different "lines"
> (note the "\n" at the end of the first pattern):
>
> 	/* Class, enum, and interface declarations */
> 	"^[ \t]*(...(class|enum|interface)...)$\n"
> 	/*
> 	 * Method definitions; note that constructor signatures are not
> 	 * matched because they are indistinguishable from method calls.
> 	 */
> 	"^[ \t]*(...[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*))$",
>
> I don't think there is a technical difference, but I find this form
> easier to understand because fewer open parentheses have to be
> tracked.

Yes, indeed.  Because of that reason I've put the first ( and the last )
on separate lines but your approach is even better.

Patch version v5 will come anytime soon.

Thanks!
Tassilo
