From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 08:06:33 +0700
Message-ID: <CACsJy8CZvDfCPPbsRkKJJXiQNpuQOXD-Hm-A7ePbu9tFaG_v5A@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net> <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 02:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKIMR-0001eq-8l
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 02:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab3CZBHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 21:07:06 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55971 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab3CZBHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 21:07:04 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so7179332oag.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KLK9uFh8opKLL99DI43UJ7atnZVFlH+05NR/OeauITs=;
        b=sYTKHge7IAsoM+SKUVCm81cqTHjs8KM5hMgo6dIawX/5F/RVimGQ09sHuixRLh3diR
         jSDaCExa6T3JUDQ9Bt7eRtqXxirPBBmu+FrdFdutj2ojwAvIgXR0vu26JyXz8WmoMzHX
         GKrgzdYeRTVPMolraQ6qMf1+USuQhf/a6Ujkl0ZnqpVQ6j8RNY8oWC3Ram4H4CH1Uff2
         m+CGpZhdHdqeZB+SILVi/Xj8oP/05aLPWp7Eu6uxjq1njuc7XTFY1q/WQt/edxaRHZtr
         N+B3wIshaNZRhzdul59/rkBBxktYHdxELDXtpuJ1NcR+BxwDATm5H4Y4GESrvsyd+ZG7
         1n/A==
X-Received: by 10.182.123.76 with SMTP id ly12mr1361148obb.53.1364260024414;
 Mon, 25 Mar 2013 18:07:04 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 25 Mar 2013 18:06:33 -0700 (PDT)
In-Reply-To: <20130325155600.GA18216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219126>

On Mon, Mar 25, 2013 at 10:56 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 25, 2013 at 10:31:04PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, Mar 25, 2013 at 9:56 PM, Jeff King <peff@peff.net> wrote:
>> > There are basically three levels of transport that can be used on a
>> > local machine:
>> >
>> >   1. Hard-linking (very fast, no redundancy).
>> >
>> >   2. Byte-for-byte copy (medium speed, makes a separate copy of the
>> >      data, but does not check the integrity of the original).
>> >
>> >   3. Regular git transport, creating a pack (slowest, but should include
>> >      redundancy checks).
>> >
>> > Using --no-hardlinks turns off (1), but leaves (2) as an option.  I
>> > think the documentation in "git clone" could use some improvement in
>> > that area.
>>
>> Not only git-clone. How git-fetch and git-push verify the new pack
>> should also be documented. I don't think many people outside the
>> contributor circle know what is done (and maybe how) when data is
>> received from outside.
>
> I think it's less of a documentation issue there, though, because they
> _only_ do (3). There is no option to do anything else, so there is
> nothing to warn the user about in terms of tradeoffs.
>
> I agree that in general git's handling of corruption could be documented
> somewhere, but I'm not sure where.

I think either a section in git-fsck.txt or git.txt. Probably the
former as people who read it are probably more concerned about
corruption.
-- 
Duy
