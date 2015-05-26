From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 17:04:41 -0400
Message-ID: <CAJ80sau7aO9mSvBCp9TyXqeO4gS=gwsou0eX9CxmzTXcajx6rg@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<CAPig+cTaiZ_PVaGk6n_bsEqqTJEYEMSCWcnC0=MiN2Bf7L4sWw@mail.gmail.com>
	<CAJ80sasp6kNgbJJw-2TzZnPPDVgYdAwwsdh=hNH4xxu1TBtiyA@mail.gmail.com>
	<CAPig+cQoUrAhpvyrBTFyDDjaZt8brkhhw3aehC-hNeS7gND6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 26 23:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxM1o-0000b6-2U
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbbEZVEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:04:43 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33442 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbEZVEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 17:04:43 -0400
Received: by wgez8 with SMTP id z8so108221724wge.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a8rbBGLVeH35M/qq5NqI9RXGHOLt7ixW+3vK+g8L1oc=;
        b=xsK40k7mXaYo8ct1k+8AakjHHg+7QpSEellrMWnvlJAGlU1N2A38Vg6rGpzmaNJ6p5
         ze7KoSG+lEfnrvyVeuuidHQOdlU7CqH/mXcreCsuV9nmIFTME3QwRdQc7+D+CohQyS56
         XE3u6HV6QFdsgWeqsjT2Rpzxv8Zli2LEsq8rpkHAyVZawE4mURYn4+APKc93UipMbB/d
         Vsnjnbl/GDBMQxqqAd9JsxYYpedTvKFmnxfup47Lx1FCzbe3Ec55SU07Jg/FWISWifzr
         czBp7KhHG3ZuvY7a0/mU+k3SvQDtH3DlgBF2PfB8KHDVhFtQ6S+TjUKQMuqhShocSQAf
         5ckw==
X-Received: by 10.194.205.225 with SMTP id lj1mr52857633wjc.138.1432674281875;
 Tue, 26 May 2015 14:04:41 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Tue, 26 May 2015 14:04:41 -0700 (PDT)
In-Reply-To: <CAPig+cQoUrAhpvyrBTFyDDjaZt8brkhhw3aehC-hNeS7gND6jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269976>

On Tue, May 26, 2015 at 4:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 26, 2015 at 3:41 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>> On Tue, May 26, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Saturday, May 23, 2015, Allen Hubbe <allenbh@gmail.com> wrote:
>>>> +               # recognize lines that look like an alias
>>>> +               elsif (/^(\S+)\s*:\s*(.+?)$/) {
>>>
>>> Observation: Given "foo:bar:baz", this regex will take "foo:bar" as
>>> the key, and "baz" as the value, which is probably not what was
>>> intended, however, it likely doesn't matter much in this case since
>>> colon isn't legal in an email address[1].
>>
>> That's a keen observation.  I think it would work simply to use a
>> non-greedy +? in the first capture group.
>
> Yes, that would work. Alternately: /^([^\s:]+)\s*:\s*(.+?)$/

I will use the non-greedy +? because the resulting expression is easier to read.

I will remove the non-greedy +? from the second capture group.  It
serves no purpose there any more.  It had been there to allow matching
a trailing backslash after the group, but now lines with trailing
backslash are ignored entirely before reaching here.
