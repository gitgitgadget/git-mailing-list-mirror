From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix,
 argv) pair
Date: Fri, 11 Jan 2013 18:10:06 +0700
Message-ID: <CACsJy8C4_Cvy+Q52gaHeWgdo_yZDcCW=tpaNOWuthURfPN8NrA@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-4-git-send-email-martinvonz@gmail.com> <7vy5g25f9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8Apu1BJ2t+vpbzpQ4Wni==Azzmp99a+TmBzR3h8qpx=8g@mail.gmail.com> <7vfw28eiu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcVm-0005lA-ER
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3AKLKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 06:10:38 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64680 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3AKLKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:10:37 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so1571398obb.8
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UZmUi/KUvqroCWVFBE+raQF/XrETtg4K7WO9v3ACaro=;
        b=FYZM6ngfRcflbkHsxxXs7g5BwI5fj+ldNST0DYLYRTCkxfcWVa4h4B8yBvc8vwy08H
         v5JuIfMK5vRaEMaa4bNBqkgbFx75NoB5BpMIqWbNJsf+/p6dDWb23jb6y0Kke18BTDtc
         O+MjRiOnDjxbbt/CQ53GrXkXFW7AhQaAnUccMNcv1s9y/GQ2CRqT+XcmSLW82srL8DOJ
         Z/OFvPsRaYXjY8+MgVvljNokHd9mSof2P4ksG8c6pLx80EkK2ZIus4hj5PkGOT8wzdtP
         tyZZx2jDhsGBqWASCO+pyMPAYi5/kFan6WlCATQLyyMwL1c6bxjPf8rHmjkbZPfIPOY9
         LbgQ==
Received: by 10.182.164.103 with SMTP id yp7mr53749531obb.74.1357902636871;
 Fri, 11 Jan 2013 03:10:36 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 11 Jan 2013 03:10:06 -0800 (PST)
In-Reply-To: <7vfw28eiu3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213191>

On Fri, Jan 11, 2013 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Or I could hold off nd/parse-pathspec if this series has a better
>> chance of graduation first. Decision?
>
> I am greedy and want to have both ;-)

Apparently I have no problems with your being greedy.

> There is no textual conflict between the two topics at the moment,
> but because the ultimate goal of your series is to remove all uses
> of the pathspec.raw[] field outside the implementation of pathspec
> matching, it might help to rename the field to _private_raw (or
> remove it), and either make get_pathspec() private or disappear, to
> ensure that the compiler will help us catching semantic conflicts
> with new users of it at a late stage of your series.

There are still some uses for get_pathspec() and new call sites won't
cause big problems because they would need init_pathspec() to convert
get_pathspec() results to struct pathspec. I will rename raw[] though.
-- 
Duy
