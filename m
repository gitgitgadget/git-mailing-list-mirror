From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 23:38:09 +0530
Message-ID: <CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
	<20160319175705.GA6989@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahLIg-0001nK-Dh
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 19:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304AbcCSSIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 14:08:12 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35060 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcCSSIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 14:08:10 -0400
Received: by mail-ig0-f173.google.com with SMTP id cl4so6247177igb.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XcfNXYVnWR6gIDovavDtrQTOYBfuGT8Lw0+GRtsx0LA=;
        b=yojjolaQMBvpKnspYtWGC4KGB3sgErh/JyYKf7JLRHTrrpEn9iIxivzuCYaiJMxCih
         OagJP1jy3YBy9y8IhxU9J3pRLSftSpQyVXOg70KBzMdpVUMhlrNHqpMgxZeUBygBtZO6
         0CkEVItOCsOicaEpDEWwdyObsusV/2AYnZhYGLe21BHjFjVGSBwh1d1kGa5kSfy8rpq3
         9qiz7VAJUX4F9Ruxu2vyKKcWB/LohsZw/WFC5sWA5iZRWDa062o/U0mmizX6xExILHJQ
         Ni0Ifk709qRHZfgPOqew4lJASMTRbO7mWTPL8fDEpHCz+I2affGXAMQsaGsI99BrKYwl
         1YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XcfNXYVnWR6gIDovavDtrQTOYBfuGT8Lw0+GRtsx0LA=;
        b=QnYHqPF6g3EvFIVWDOZt2XODHDrilJECeh9alfQ2UuixOMTsJB0mQDq2vW5sGCUcus
         rheKDvN2WWZhjXqKiYFF7lWV4ivmGl2OJnNLn7mIwit8p51muu+eM8pSandpHxFt0r81
         f1jV6a/FxbqO9qpDVSKOBoV8tIzjXSvf96+HuFrmX3LGxkdgFaSMY30metNKuWL2+RQX
         HbjVkFf1PffzUqCNo4OLQj2fP1LRSzUkmkRRy0oB/X/0LBi5SJP2P7ycZKEDo8wWP2jv
         EqBFdHemql9eXbRfHrNveC/UZ+9/rltv55eaIWt58/y4zf2Y9ih6Tko2b7QcLOhcdwuj
         KTMg==
X-Gm-Message-State: AD7BkJJUhWWGmJpNLs3gwGwDJieTxbFF4BNLcNqAtZnmAf8uRixBFdXnZiJjXsguBdTj4WDD2VhN8CQvAsQCcw==
X-Received: by 10.50.147.34 with SMTP id th2mr4925780igb.27.1458410889452;
 Sat, 19 Mar 2016 11:08:09 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 11:08:09 -0700 (PDT)
In-Reply-To: <20160319175705.GA6989@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289319>

On Sat, Mar 19, 2016 at 11:27 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 19, 2016 at 10:19:02PM +0530, Chirayu Desai wrote:
>
>> > Yeah, I agree that showing the "-h" help is a bit much.
>> > This is a side effect of looking up in the commit in the parse-options
>> > callback. It has to signal an error to the option parser, and then the
>> > option parser always shows the help on an error.
>> > I think we'd need to do one of:
>> > 1. call die() in the option-parsing callback (this is probably a bad
>> > precedent, as the callbacks might be reused from a place that wants
>> > to behave differently)
>> I assume you mean parse-options-cb.c:parse_opt_commits() by the callback.
>> I see that it is currently used only by commands which have a "--with"
>> or "--contains" option,
>> and all of them behave the same way, printing the full usage, so a one
>> line change in that function would fix it for all of those.
>
> Yes, that is the right callback.
>
>> > 2. have the callback just store the argument string, and then resolve
>> > the commit later (and die or whatever if it doesn't exist). This
>> > pushes more work onto the caller, but in this case it's all done by
>> > the ref-filter code, so it could presumably happen during another
>> > part of the ref-filter setup.
>> I'm not quire sure how exactly to do that.
>
> You'd teach parse_opt_commits() to store the string _name_ of the
> argument (e.g., using a string_list rather than a commit_list), and then
> later resolve those names into commits.
Gotcha, will need to figure out where exactly would those names be
resolved, can do after following the code path a bit more, can do.
>
>> > 3. teach parse-options to accept some specific non-zero return code
>> > that means "return an error, but don't show the usage"
>> This sounds good, but also the most intrusive of 3.
>
> Yeah. Reading the options again, I kind of like this one. The only trick
> is that you would need to make sure no other callbacks are returning the
> value you choose for the "don't show the usage" flag. That is probably
> not too bad, though. There aren't that many callbacks, and they are not
> likely to be using values besides "-1" and "0".
I'll try to go through that as well.
>
> -Peff

-Chirayu
