From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v2] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 08:15:02 -0400
Message-ID: <CAJ80sav9QEBnqbib5mG9O+XkWvgcH+C4aK+p4AdnE53_goNtCw@mail.gmail.com>
References: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
	<CAPig+cQ8Gw3Q1QcJ=k4647LW1gBZ3fuJBYpOCE=AxA0ZWtktmQ@mail.gmail.com>
	<CAJ80savXAOMAbdDC_F77esD1Fdi=BP6GK4biFOLJTtqqehjEOw@mail.gmail.com>
	<CAPig+cSDAagVNhdobtTDGrdzLNSxKpOtUhEEDq+NLQZBOoWJxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 22 14:15:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvlr4-0008Eo-3A
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764AbbEVMPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 08:15:05 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34994 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbbEVMPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 08:15:03 -0400
Received: by wgfl8 with SMTP id l8so15998730wgf.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DtamLIQceESnql/tgEAy80rkXOJcubG5Ytl9Mt42EY8=;
        b=hYNJdNkpTn3GcTAmJgzi+5lZJWXSToTpI37yRiV7H8JnaWgJrtY4ix8nOFgwr31o0V
         7OUzsPwXzCt1gXN/7N/8hT2BP7khfSKjFkzRNWsq+VbX6+aXLQWxAex56dDUMi2EwhyI
         48x323f/tjLtXCjf6kObVWDXe5R6bxf9DRb95Fv61pztRkJrOohpK6aXJC9OLm5G5PW6
         Dqego1RF+e1sncYIxLzuGIN1t4t2fdxkvEJgC1dFPagWjf1PfbKl5jrOgguBd9S5jMpS
         9E1MfpoC6BlFJ7ndb68J7XYEIOS1YvnI2BXw7ZavxbfRQWMpjMuuTY8WKXQ9Qhs8B7FI
         6LxA==
X-Received: by 10.194.193.71 with SMTP id hm7mr8043149wjc.40.1432296902305;
 Fri, 22 May 2015 05:15:02 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Fri, 22 May 2015 05:15:02 -0700 (PDT)
In-Reply-To: <CAPig+cSDAagVNhdobtTDGrdzLNSxKpOtUhEEDq+NLQZBOoWJxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269706>

On Thu, May 21, 2015 at 11:59 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 21, 2015 at 11:19 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>> On May 21, 2015 9:05 PM, "Eric Sunshine" <sunshine@sunshineco.com> wrote:
>>> On Thu, May 21, 2015 at 8:16 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>>> > +test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
>>> > +       clean_fake_sendmail && rm -fr outdir &&
>>> > +       git format-patch -1 -o outdir &&
>>> > +       {
>>> > +               echo "alice: Alice W Land <awol@example.com>"
>>> > +               echo "bob: Robert Bobbyton <bob@example.com>"
>>> > +               echo "chloe: chloe@example.com"
>>> > +               echo "abgroup: alice, bob"
>>> > +               echo "bcgrp: bob, chloe, Other <o@example.com>"
>>> > +       } >~/.tmp-email-aliases &&
>>>
>>> A here-doc would be easier to maintain and read:
>> A here-doc does not flow nicely in an indented block.  Each line in
> That's true if you use <<EOF here-doc, but not for <<-EOF, as I did in
> the example. With <<-EOF, all leading tabs are stripped from the input
> lines, including from the EOF line, which is why it can be indented to
> the same level as the other code in the test. The added '\' in <<-\EOF
> from my example indicates that you don't want/expect any interpolation
> inside the here-doc. The <<-\EOF form is used extensively throughout
> the Git test suite.

Alright.
