Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7398C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9191060F46
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 05:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhHKF5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 01:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhHKF5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 01:57:51 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4963C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 22:57:28 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:48646)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDhEy-0002f3-0O; Wed, 11 Aug 2021 01:57:24 -0400
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:55899)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDhEx-00086O-TX; Wed, 11 Aug 2021 01:57:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1DB3727C0054;
        Wed, 11 Aug 2021 01:57:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 11 Aug 2021 01:57:22 -0400
X-ME-Sender: <xms:wWYTYcFbzi0kDjWjRyRUTyXeNvtKsXAyVOu7A8u7A7sXFuw41KPEcQ>
    <xme:wWYTYVWTLiPK8KzJA7PYaH0Gq9TfF400-1JB5xK81-_KepZOPvh74c5ll-2SvaMW6
    kmTWdO9FjFBmA>
X-ME-Received: <xmr:wWYTYWJx71KQKGLJIS3RuxoyTZs-8fDCZ6LcRt5-b362MjVQ46tKomGh9OeJHFR4SgewF74Xl3b8hQ8j4YNqQjzrTSHlp0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvufffjgfkgggtsehttdertd
    dtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhr
    gheqnecuggftrfgrthhtvghrnhephfdtveehffejueekvdffleeiledujeetfefgvdefje
    etveefgeekvdduteehveeinecuffhomhgrihhnpehuthhilhdrmhgrphenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhorhhnodhmvghsmh
    htphgruhhthhhpvghrshhonhgrlhhithihqdekieejfeekjeekgedqieefhedvleekqdht
    shguhheppehgnhhurdhorhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:wWYTYeG-DDfoQQjT1qDO3P-XOIkuiLz82a01VEdn8xP8OAABt4isIA>
    <xmx:wWYTYSUwmzVZ4V9qGRulHSh2_tQS5JHKijqhgqbBiAKvg_dxgho4sg>
    <xmx:wWYTYRNaVzmByYq0VFWeSXUtRiI_UlqQcgDvszle5q_S25U6KESnqQ>
    <xmx:wmYTYVdlDnQtUxpSovqomBeEtkU6L1S7flSkCpoSY0GqZVb53g7XhQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 01:57:21 -0400 (EDT)
References: <20210810190937.305765-1-tsdh@gnu.org>
 <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] userdiff: improve java hunk header regex
Date:   Wed, 11 Aug 2021 07:22:06 +0200
In-reply-to: <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
Message-ID: <87zgtoh6bm.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

Hi Hannes & Junio,

> These new tests are very much appreciated. You do not have to go wild
> with that many return type tests; IMO, the simple one and the most
> complicated one should do it. (And btw, s/cart/card/)

Well, they appeared naturally as a result during development and made it
easier to spot errors when you know up to which level of complexity it
still worked.  Is there a stronger reason to remove tests which might
not be needed, e.g., runtime cost on some CI machines?

>> -	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>> +         "^[ \t]*("
>> +         /* Class, enum, and interface declarations: */
>> +         /*   optional modifiers: public */
>> +         "(([a-z]+[ \t]+)*"
>> +         /*   the kind of declaration */
>> +         "(class|enum|interface)[ \t]+"
>> +         /*   the name */
>> +         "[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
>> +         /* Method & constructor signatures: */
>> +         /*   optional modifiers: public static */
>> +         "|(([a-z]+[ \t]+)*"
>> +         /*   type params and return types for methods but not constructors */
>> +         "("
>> +         /*     optional type parameters: <A, B extends Comparable<B>> */
>> +         "(<[A-Za-z0-9_,.&<> \t]+>[ \t]+)?"
>> +         /*     return type: java.util.Map<A, B[]> or List<?> */
>> +         "([A-Za-z_]([A-Za-z_0-9<>,.?]|\\[[ \t]*\\])*[ \t]+)+"
>> +         /*   end of type params and return type */
>> +         ")?"
>> +         /*   the method name followed by the parameter list: myMethod(...) */
>> +         "[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
>> +         ")$",
>
> I don't see the point in this complicated regex. Please recall that it
> will be applied only to syntactically correct Java text. Therefore,
> you do not have to implement all syntactical corner cases, just be
> sufficiently permissive.

I actually find it easier to understand if it is broken up into more
concrete alternatives and parts which are commented instaed of one
opaque "permissively match everything in one alternative" regex.  It
shows the intent of what you want to match.  But YMMV and since Junio
agrees with you, I'm fine with that approach.

> What is wrong with
>
> 	"^[ \t]*(([A-Za-z_][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[
> \t]*\\([^;]*)$",

That doesn't work for

  <T> List<T> foo()

or

  <T extends Foo & Bar> T foo()

so at least it needs to include &<> in the first group, too.

Also, it doesn't match class/enum/interface declarations anymore, so

  class Foo {
    String x = "ChangeMe";
  }

will have an empty hunk header.

Another thing I've noticed (with my suggested patch) is that I should
not try to match constructor signatures.  I think that's impossible
because they are indistinguishable from method calls, e.g., in

  public class MyClass {
      MyClass(String RIGHT) {
          someMethodCall();
          someOtherMethod(17)
              .doThat();
          // Whatever
          // ChangeMe
      }
  }

there is no regex way to prefer MyClass(String RIGHT) over
someOtherMethod().

So all in all, I'd propose this version in the next patch version:

--8<---------------cut here---------------start------------->8---
PATTERNS("java",
	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
         "^[ \t]*("
         /* Class, enum, and interface declarations */
         "(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
         /* Method definitions; note that constructor signatures are not */
         /* matched because they are indistinguishable from method calls. */
         "|(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
         ")$",
	 /* -- */
	 "[a-zA-Z_][a-zA-Z0-9_]*"
	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
	 "|[-+*/<>%&^|=!]="
	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
--8<---------------cut here---------------end--------------->8---

That works for all my test cases (which I have also altered to include
the method calls from above before the ChangeMe) except for
java-constructor where it shows

  public class MyClass {

instead of

      MyClass(String RIGHT) {

in the hunk header which is expected as explained earlier and in the
comment.

Does that seem like a good middle ground?

Bye,
Tassilo
