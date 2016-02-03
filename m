From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per repo
Date: Wed, 3 Feb 2016 12:47:56 -0500
Message-ID: <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
	<20160203035648.GA20732@sigill.intra.peff.net>
	<20160203082112.GA27454@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 18:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR1X7-00043w-QT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 18:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258AbcBCRr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 12:47:58 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34852 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbcBCRr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 12:47:57 -0500
Received: by mail-vk0-f53.google.com with SMTP id e6so19632430vkh.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8AVZ18VTORQy1cWfYRzLGqwmxqa6ApzNg/PDh/4vF3g=;
        b=xY2Bu96CbULZk0uE4+j4zduW5cPhagTf9txREk8IFu7SPBcQR2A6If0r3JvGTncp5m
         L6xv3/BxK8zp6N+Yf5O2bTpORiLZx6Vt22gqOMZH0oEIc9c/kSFPRPj1aq078r9LQw/q
         +jvUlHshMp05+GKlIIZiJfp/QCy57CbuM/ng4U5IzUcBA0aqanyW5hy/qUatDbV9icLy
         hA70PGGDxWaJFsmvlx3xCAxvoDoJO+An5pb42jv4esX29gAk75/x8K8EylFYH2NJDigl
         8dYWtp29ca06sCvWS1mp/vX7u3hCs9pxsUsXvvTZjfawgg/+cCuAFbrPozF4RjItaN5S
         jbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8AVZ18VTORQy1cWfYRzLGqwmxqa6ApzNg/PDh/4vF3g=;
        b=XmxH9345Vnoar/Cb9ggtPZynuyRTgXKOG1SMYvrynxSAbxFyHUT7AVDoz3osDyBKrm
         E28ajudUbNV7qA4rGRkRAjxeHMoS6qZaV4SyCX1jdpSyUUcu+0fyw4PMEViuolfPc6lC
         1UrB9+XD+5PIjy/BHnRGKgV5YK1dU5iIDcrYvBw1dMEOLJrQcpbVCFJlFVky7BMgTwNv
         Md5ddQKs7J8BI/IO/IYbjduhaXOPPWM6C2lKy/h0b9JKRXAQGJ2rDl276kL34PYr0/oc
         lld3dRK3Wy6isc0SgGFW8n/uDUNs3v+PPI4Ll8LAhqWoXpduLvX2mNX22fJMDUSUDE8o
         LqLA==
X-Gm-Message-State: AG10YORTxMwPe4QieOnTrT1WiLGOOHnfSRV6+cjPJNbIRvavsi7gW5Z6qTfP/WWsEGNo5pR1IQ619ZZ3PDC0FA==
X-Received: by 10.31.146.71 with SMTP id u68mr1857673vkd.19.1454521676377;
 Wed, 03 Feb 2016 09:47:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 3 Feb 2016 09:47:56 -0800 (PST)
In-Reply-To: <20160203082112.GA27454@gmail.com>
X-Google-Sender-Auth: jlv-ijx3Cm16AwPnwSvopv4Qh3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285371>

On Wed, Feb 3, 2016 at 3:21 AM, Dan Aloni <alonid@gmail.com> wrote:
> On Tue, Feb 02, 2016 at 10:56:48PM -0500, Jeff King wrote:
>> On Tue, Feb 02, 2016 at 09:54:21PM +0200, Dan Aloni wrote:
>> > +   if (strict && email && !strcmp(email, "(per-repo)")) {
>> > +           die("email is '(per-repo)', suggesting to set specific email "
>> > +               "for the current repo");
>> > +   }
>>
>> I find it disappointing that we go back to looking for magic sequences
>> in the string. Could we perhaps do this more cleanly with a new config
>> option? Like a "user.guessIdent" which defaults to true, but people can
>> set to false. And without that, we do not do any automagic at all; we
>> get the values from the GIT_COMMITTER_* environment or the
>> user.{name,email} config variables, or we die().
>
> Agreed. New patch attached, feel free to amend.

Please re-send with the patch inline since reviewers will want to
comment on on specific bits of code inline as well. When the patch is
an attachment, this process becomes too onerous for reviewers, and
most will simply ignore the patch. Thanks.

Before sending v3 (inline), perhaps take note of the few issues below
which I noticed while quickly scanning the attachment:

* The final paragraph of the commit message appears to be outdated
since it still seems to be describing the approach taken by v1.

* Elsewhere, in the project, the spelling "email" is preferred over
"E-Mail"; that's true even in the files your patch is touching.

* In the documentation:s/mutiply/multiple/.

* The documentation doesn't seem to mention the default value of the
new config variable.

* The new config variable "user.explicit" has a more nebulous name
than Peff's suggestion of "user.guessIdent", which may make its intent
harder to determine without consulting documentation.

* Don't initialize static variables to 0 (let the .bss section do that
automatically).

* One space before && operator; not two.

* Drop unnecessary braces.

* Perhaps use test_config(), test_unconfig(), test_config_global() in
the test script rather than the manual git-config invocations in
subshells.

* test_expect_failure() is for indicating that a test will fail
because some feature is known to be broken, not for when you expect a
git command to fail in a controlled fashion. Instead, use
test_expect_success, and then use test_must_fail() within the body of
the test.

    test_expect_success '...' '
        ... &&
        test_must_fail git commit -m msg
    '

* Do these new tests really deserve a new test script, or would they
fit into an existing script? (Genuine question.)

It's also reviewer-friendly to indicate the patch revision in the
subject "[PATCH v3]", and to describe what changed since the previous
version of the patch. Providing a gmane link to the previous version
is also very helpful.
