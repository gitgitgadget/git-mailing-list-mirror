Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D11C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731FA61077
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhHKRwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKRwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:52:37 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CDC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 10:52:13 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:40186)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDsOi-0006jC-8s; Wed, 11 Aug 2021 13:52:12 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:58715)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDsOi-0003Bu-5m; Wed, 11 Aug 2021 13:52:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id ED1FB27C005A;
        Wed, 11 Aug 2021 13:52:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 11 Aug 2021 13:52:11 -0400
X-ME-Sender: <xms:Sw4UYSPxQLWFyV9jR9pfWXMYKgTkARFVVmfUjdQOwh0KQs9cLZZ7ig>
    <xme:Sw4UYQ86hnM_8rfWZV-Ghg_gw8lKHV5REQTnHGU7gPRQb5vUdy3wdC-0IJcy8K_2n
    YCjZ7UlADp_kA>
X-ME-Received: <xmr:Sw4UYZSKhEeo0k9OyyBJVsqt4mZdfxlLw4a3GYwZahw_YHR5mrGtQ2escL60g30WaKDFth6ppfYiFw4hJrBdpCQu9xjLwLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvffuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdho
    rhhgqeenucggtffrrghtthgvrhhnpeevveeikeetkeeviefgfeffiedvteeguddvffeuue
    duveegtddthedvhfeuveffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehfrghs
    thhmrghilhdrfhhm
X-ME-Proxy: <xmx:Sw4UYStlQ-WVFtgqECtxZUypwPGWizjuvXdtyKPwQPcyt43ZlF3MYg>
    <xmx:Sw4UYad5fvQC2JkEKih-pQe4HGhMA5FLrrBqUbphXxJTBdRamJDwTw>
    <xmx:Sw4UYW1yADQ3h6sAncJFEWwasv3gfKTVlEy8FE-rMwpEeWPc08kThg>
    <xmx:Sw4UYSnm2KWD4uZn6NykhsXqfuG3mlR6n2Nm0Aynbs8AHU19KEfDVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 13:52:10 -0400 (EDT)
References: <20210811145341.43429-1-tsdh@gnu.org> <xmqqa6lnaola.fsf@gitster.g>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: improve java hunk header regex
Date:   Wed, 11 Aug 2021 19:42:59 +0200
In-reply-to: <xmqqa6lnaola.fsf@gitster.g>
Message-ID: <87im0b6f92.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Just a few whitespace nits that "git am" noticed for me.

Ah, indeed.  Should all be fixed in v6.

>> diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
>> index 298bc7a71b..a8d7850412 100644
>> --- a/t/t4018/java-class-member-function
>> +++ b/t/t4018/java-class-member-function
>> @@ -3,6 +3,10 @@ public class Beer
>>  	int special;
>>  	public static void main(String RIGHT[])
>>  	{
>> -		System.out.print("ChangeMe");
>> +            someMethodCall();
>> +            someOtherMethod("17")
>> +                .doThat();
>> +            // Whatever
>> +            System.out.print("ChangeMe");
>
> I notice that the original used HT (horizontal tab) to indent, but
> the new one uses runs of SP (space).  This project has no written
> preference for coding style for Java, which means it would have been
> more appreciated if the original style were kept.

Fixed in v6.

>> diff --git a/t/t4018/java-enum-constant b/t/t4018/java-enum-constant
>> new file mode 100644
>> index 0000000000..a1931c8379
>> --- /dev/null
>> +++ b/t/t4018/java-enum-constant
>> @@ -0,0 +1,6 @@
>> +private enum RIGHT {
>> +    ONE,
>> +    TWO,
>> +    THREE,
>> +    ChangeMe
>> +}
>
> For these new tests, you'd be the one setting what styles to use ;-)
> After all, we serve users from projects with different style, and
> having variety in our test patterns is not bad.

I completely agree.

>> diff --git a/userdiff.c b/userdiff.c
>> index 3c3bbe38b0..6644931ce1 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -142,7 +142,11 @@ PATTERNS("html",
>>  	 "[^<>= \t]+"),
>>  PATTERNS("java",
>>  	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>> -	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>> +         /* Class, enum, and interface declarations */
>> +         "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
>> +         /* Method definitions; note that constructor signatures are not */
>> +         /* matched because they are indistinguishable from method calls. */
>> +         "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>>  	 /* -- */
>>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>
> This hunk does violate project convention that our codebase uses
> leading HT to indent (and align with extra SPs if needed).

Also fixed in v6.

That leads to the question if you'd welcome a patch adding a
.dir-locals.el to the repository with the right settings so that it'll
just work for contributors using the One True Editor.  Would you?

Bye,
Tassilo
