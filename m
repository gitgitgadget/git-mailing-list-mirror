From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 4 Feb 2014 18:11:01 -0800
Message-ID: <62DB6DEF-8B39-4481-BA06-245BF45233E5@gmail.com>
References: <20140117041430.GB19551@sigill.intra.peff.net> <20140117042153.GB23443@sigill.intra.peff.net> <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com> <20140121054927.GD5878@sigill.intra.peff.net> <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com> <20140204221220.GA5457@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 03:11:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WArxh-00062K-L8
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 03:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbaBECLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 21:11:07 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62720 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaBECLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 21:11:06 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so9371497pad.28
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=VS1TAj2WspMr0316ifopyJxKHWmGoIZxxUssxxtOgU0=;
        b=XunB6TU5eVJTC83Kc048WmM9lN3EHXlkywE4peOZ57mm/zZhLz9S/mYPT55nhzdiu5
         Yf1fAQavtzaTEz4hEK0KsF/xfncH095pAtv4IPaZYFsxLHMfDPJmOtUrcIuTGxnzmAj/
         W0r7lKSzpJtTCNt477AGYX08ag/bfLFkUOW/r7ds7kxAfII8RbmmZo/iEYarCbGTeEuP
         LrBKO8qYlx/anbANNV5YVTMhPqQt43f+flbDPJ/tKRyC7HzTCsXzX+gzljeOigTWiuEx
         YVq3DW/+d6l5xaDvcar/WVMtc1VGrXkydFhV2B78SUUbHLEp6zyxUDjoNUA412BfCAIi
         dm7g==
X-Received: by 10.68.14.130 with SMTP id p2mr48134467pbc.17.1391566265237;
        Tue, 04 Feb 2014 18:11:05 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id oa3sm70716163pbb.15.2014.02.04.18.11.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Feb 2014 18:11:04 -0800 (PST)
In-Reply-To: <20140204221220.GA5457@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241592>

On Feb 4, 2014, at 14:12, Jeff King wrote:
> On Tue, Jan 21, 2014 at 11:23:30AM -0800, Junio C Hamano wrote:
>
>>> does complicate the point of my series, which was to add more  
>>> intimate
>>> logic about how we handle LESS.
>>> ...
>>>                return !x || strchr(x, 'R');
>> [...]
>>
>> I am not sure if it is even a good idea for us to have so intimate
>> logic for various pagers in the first place.  I'd seriously wonder
>> if it is better to take this position:
>>
>> 	A platform packager who sets the default pager and/or the
>> 	default environment for the pager at the build time, or an
>> 	individual user who tells your Git what pager you want to
>> 	use and/or with what setting that pager should be run under
>> 	with environment variables. These people ought to know far
>> 	better than Git what their specific choices do. Do not try
>> 	to second-guess them.
>
> Sorry for letting this topic lapse; I wanted to look at some possible
> Makefile improvements, which I'll be posting in a moment. I did want  
> to
> address this point, though.
>
> If we are just talking about packagers and defaults (e.g., setting
> MORE=R on FreeBSD), then I agree that the right tool for the job is
> empowering the packagers, and the Makefile knob we've discussed does
> that.
>
[snip]
>
> It seems a shame to me that we cannot do better for such users.
> However, the level of intimacy with the pager is getting to be a bit  
> too
> much for my taste, and the saving grace is that not that many people  
> set
> LESS themselves (and git is widely enough known that "R" is a common
> recommendation when people do). So it's probably the lesser of two  
> evils
> to ignore the situation, and let people who run into it find the  
> answers
> on the web.
>
> So I think there is nothing to be done.  But I did want to mention  
> it in
> case somebody else can come up with some clever solution. :)

I think we can do better without adding intimate pager knowledge.  And  
at the same time make it a simple matter of tweaking the Makefile to  
deal with new pagers on specific systems.

There are two parts to the proposal.

Part 1

Add a new configuration item which I will call "pager.env" for now  
that can have multiple values of the form ENV=value (whether multiple  
lines or whitespace separated on a single line to be decided later).

On a system where more can support color by setting MORE=-R it might  
look like this:

[pager]
         env = LESS=-FRSX LV=-c MORE=-R

On a system where more does not it might look like this:

[pager]
         env = LESS=-FRSX LV=-c

The default value of pager.env is to be configured in a system- 
specific way (i.e. Makefile knob) at build time.

Then, if Git is going to output color AND start a pager (that logic  
remains unchanged by this proposal), then it processes the pager.env  
value by examining each ENV=value setting and if the environment  
variable ENV is NOT already set, then sets it to value before starting  
the pager.

This is mostly a clean up and shouldn't really be controversial since  
before commit e54c1f2d2 the system basically behaved like this where  
pager.env was always set to "LESS=FRSX" and after it behaves as though  
pager.env is always set to "LESS=FRSX LV=-c".

Part 2

Alongside the current false/never, always, true/auto settings for  
"color.ui" a new "carefully" setting is introduced and the color.ui  
default if not set is changed from auto (commit 4c7f1819) to the new  
"carefully" setting.

Why a new setting?  So that people who have explicitly set color.ui to  
auto (or one of the other values) will not be affected by the proposed  
new logic.

Another new configuration item which I will call "pager.carefully" for  
now is introduced that again can have multiple values of the form  
name=ENV.  It might look like this:

[pager]
         carefully = less=LESS LV=lv more=MORE

Again the default value of pager.carefully can be configured in a  
system-specific way (i.e. Makefile knob) at build time.

If color.ui is set to "carefully", then the logic is as follows:

a) Decide whether to output color the same way as for color.ui=auto
b) Select the pager the same way as for color.ui=auto
c) If (a) and (b) have selected a pager AND enabled color output then  
check to see if the selected pager appears in pager.carefully as one  
of the name values (perhaps a suffix match on the first whitespace- 
separated word of the selected pager value).
d) If the selected pager does not appear in pager.carefully, disable  
color output.
e) If the selected pager appears in pager.carefully, but the ENV  
associated with it does NOT appear in pager.env, disable color output.
f) If the pager appears in pager.carefully, but the ENV associated  
with it is already set, disable color output.
g) Otherwise, go ahead with color output as the change in Part 1 above  
will properly set the pager's options to enable it.

This has the following advantages:

1. No intimate pager knowledge.
2. Color output will be selected on supported systems by default  
assuming the user has not set any pager-specific environment variables.
3. This should prevent the user from ever seeing the ugly ESC[33 and  
ESC[m sequences with the default settings.
4. A user who has color.ui=auto set is not affected by this change.
5. Support for additional color pagers is easily added by tweaking the  
Makefile.

It has the following disadvantage:

1. A user who has a pager-specific environment variable set for the  
default pager will not get color by default even if color would be  
supported without first setting color.ui=auto or using an equivalent.   
Essentially they will get the pre-1.8.4 behavior.

--Kyle
