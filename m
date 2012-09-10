From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] notes get-ref: --expand expands the output notes ref.
Date: Mon, 10 Sep 2012 22:21:09 +0200
Message-ID: <CALKQrgen5r-VPp2mX7Yyiudx2+n1b_oK6iF57SWQ0o394Lm+Fg@mail.gmail.com>
References: <cover.1346848834.git.wking@tremily.us>
	<4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
	<CALKQrgem2KM07vA0LeVgD6HkM1yMDBSfThKUZ7aBaxpbcC49hA@mail.gmail.com>
	<7v4nnb67x1.fsf@alter.siamese.dyndns.org>
	<20120906061147.GA11770@odin.tremily.us>
	<7vr4qf2atd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAU1-0002au-Is
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab2IJUVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:21:17 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:53681 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab2IJUVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:21:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TBATp-000Czn-Cf
	for git@vger.kernel.org; Mon, 10 Sep 2012 22:21:13 +0200
Received: by obbuo13 with SMTP id uo13so3657700obb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 13:21:09 -0700 (PDT)
Received: by 10.60.28.202 with SMTP id d10mr15377995oeh.36.1347308469914; Mon,
 10 Sep 2012 13:21:09 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Mon, 10 Sep 2012 13:21:09 -0700 (PDT)
In-Reply-To: <7vr4qf2atd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205174>

On Thu, Sep 6, 2012 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>> On Wed, Sep 05, 2012 at 10:23:54PM -0700, Junio C Hamano wrote:
>>> Really?  Would "git log --expand master" be useful?
>>
>> I'm clearly not an expert on this, but isn't that what
>>
>>   git show-ref master
>>
>> is for?
>
> But then can't you say the same against "git notes get-ref --expand"
> with "git show-ref refs/remotes/origin/notes/foobla"?
>
> My primary point is that I think it is a UI mistake if the DWIM
> ignores the user input that directly names that can be interpreted
> without DWIMming.  When the user wants to avoid ambiguity, it should
> always be possible to spell it out without having to worry about the
> DWIM code to get in the way.
>
> The problem with the current notes.c:expand_notes_ref() is that it
> does not allow you to do that, and if you fixed that problem, the
> user never has to ask "what does this expand to", no?
>
> Perhaps something like this.  Note that this only deals with an
> existing ref, and that is semi-deliberate (because I am not yet
> convinced that it is a good idea to let any ref outside refs/notes/
> to be created to hold a notes tree).

(sorry for the late reply; I was away this weekend)

This patch looks like an acceptable solution to me. Especially since
it prevents the notes code from "accidentally" creating new notes
trees outside refs/notes/*.

That said, we should check for more cases of hardcoded "refs/notes/"
that potentially needs changing as well.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
