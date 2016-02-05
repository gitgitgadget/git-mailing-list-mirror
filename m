From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 2/3] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Fri, 5 Feb 2016 14:30:46 -0500
Message-ID: <CAPig+cRuRiL1_44tVFSP8k64aMhf6Tu0PeXfN8HUV7wX8=vLzA@mail.gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
	<1454658148-3031-3-git-send-email-alonid@gmail.com>
	<20160205191805.GA7245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Aloni <alonid@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:30:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRm5k-0007g9-Hp
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbcBETas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:30:48 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36514 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbcBETar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:30:47 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so2780753vkg.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JKovq1ld/F/WhIs7+8rHeZ4VvRkMJoKzOPs8CLvddAA=;
        b=V1vSblROoIBaejQX2PKEwXt15SO3qthKpsHfDNBJ7EjVRhOr9b5EfEHMM7S+rAzjpY
         EfwBTPYdFKXcsS+rj0+PjRdvXwFacxPOZkIGXr29DEEJsWV9nCkTbJUuL7lOErnw7b1a
         RLJpYpvISAMTglPnAwNZ+HLibs6fcRLLRxodzz2BmbA614TncJQskr+hOHENceWvffgI
         oqykBeFrOoIR85X5Iw9I0imziWd/dyk/7Q686M91s0DOfsoTsbEZmug42Clpldi1qxbk
         XREbwqPbdvpOwkNaysxKym4MnGB8eqLEqaOBmtuwusavdO7vnW7r2VVHDj1uoir5oVep
         QZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JKovq1ld/F/WhIs7+8rHeZ4VvRkMJoKzOPs8CLvddAA=;
        b=JqC4DUwQiWD2cu/3EELJcnoevg5ueaf4u2rqUodvQNokW4ATRE4JQDXOdPwOIDtviL
         0ywNnCCBCO9LkTXKEg+Q/ywJyQUHdw9akqAGHcV7UejO6PsC6fLvcx1LCrHZsexszPVS
         cm0u3o65oo+0L1eLKgY6KGWEbHAcCvQ800yoxH3sGbvqzQTTmWuSTAePDefOCR1P485d
         nAwyIoeLdpMzQhBMfBE9sEwtY72MskMKQwap2McLjiNFNTr8QpufTnTD7AhhplfzscvT
         Z8S3VeHggs2LjoGuNDb3uKxDCHZsMeoxtZAw5W+IHY9iKviEE2opaoizWxy7OjnkWxMU
         paVg==
X-Gm-Message-State: AG10YORRRM7PEWM72KmZvBKBbLdutzWpqa6zic5TyjZ7rUkzxPcwl0Bju3nd0t8G71hPJQ7gHhifBBy4nPFtdg==
X-Received: by 10.31.146.71 with SMTP id u68mr9530992vkd.19.1454700646792;
 Fri, 05 Feb 2016 11:30:46 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 5 Feb 2016 11:30:46 -0800 (PST)
In-Reply-To: <20160205191805.GA7245@sigill.intra.peff.net>
X-Google-Sender-Auth: 0w-DOpjqJprIMUhAjmfZG7HPJ0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285599>

On Fri, Feb 5, 2016 at 2:18 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 05, 2016 at 09:42:27AM +0200, Dan Aloni wrote:
>> +prepare () {
>> +     # Have a non-empty repository
>> +     rm -fr .git
>> +     git init
>> +     echo "Initial" >foo &&
>> +     git add foo &&
>> +     git commit -m foo &&
>> +
>> +     # Setup a likely user.useConfigOnly use case
>> +     sane_unset GIT_AUTHOR_NAME &&
>> +     sane_unset GIT_AUTHOR_EMAIL &&
>> +     test_unconfig --global user.name &&
>> +     test_unconfig --global user.email &&
>> +     test_config user.name "test" &&
>> +     test_unconfig user.email &&
>> +     test_config_global user.useConfigOnly true
>> +}
>
> The flow of this test script is a bit different than what we usually
> write. Typically we have some early test_expect_success blocks do setup
> for the whole script, and then progress through a sequence (and we rely
> on the test harness to do things like "git init").
>
> IOW, most of your "prepare" would go in the first block, and then the
> rest of the tests rely on it.
>
> The only thing I really see that needs to be repeated for each test is
> setting up the "about to commit" scenario. But you can simply use
> "commit --allow-empty" so that the tests work no matter what state the
> previous test left us in. We care about the ident, not what gets
> committed.

I was going to make all the same suggestions, so thanks. One thing to
add is that the &&-chain is broken in the prepare() function.
