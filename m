From: Brian Bourn <ba.bourn@gmail.com>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 14:03:41 -0400
Message-ID: <CAM+=D-D=PW=ZJFvc0y+Zhs8tPcbXnP-q4w-MeeLwT+t-QD_55w@mail.gmail.com>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
	<20140321054208.GA31737@sigill.intra.peff.net>
	<CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
	<xmqq8us3v42o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:03:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3nH-0005Dm-80
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbaCUSDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:03:44 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:43220 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaCUSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:03:42 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so8046601qgz.6
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e87z8I1sZCvMOIUjgC/aYXY6x5TjzDXVHc4O4faHm04=;
        b=msUu9MbwR6v2xhbe+mq/c/FCLGl7/xrf8vxoh8WXQPSTTDeDkD+7Bi1gW633fJ8aUi
         hoyASuRUB1EBnDnZOzLboJLmdcn74BqziHvwgLiHoHsAsm9F8wMOAqJCwohhmDzSL170
         6ryu4F/9wvXRSsChhYQ0D885IOWjy4wULN+eEZ/rZES2e7g9gT/Mbpu59u3dH7Feh9/Q
         leOwI9fJmxWYbg1LpDjMxAv0Bf+K+4yj/GrYIbD7zDsBJIrl4KmoQxjifINDhR8hmbBu
         nYzVj97AduOqjDchDszYBHMCNW7KYsLoURpypKfWDsNFXCBgdVGdBR14Yx1a4T0O0FX8
         Q6pQ==
X-Received: by 10.140.87.67 with SMTP id q61mr7470172qgd.94.1395425021809;
 Fri, 21 Mar 2014 11:03:41 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Fri, 21 Mar 2014 11:03:41 -0700 (PDT)
In-Reply-To: <xmqq8us3v42o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244713>

On Fri, Mar 21, 2014 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Bourn <ba.bourn@gmail.com> writes:
>
>> Something like this?
>>
>> Sample api calls
>> Add_Opt_Group()
>> Parse_with_contains()
>> Parse_with_merged()
>> Parse_with_no_merged()
>> Parse_with_formatting()
>> (each of the 4 calls above may have internal calls within the library
>> in order to parse the option for each of the different function which
>> may call these functions)
>
> This list is a bit too sketchy to be called "sample api calls", at
> least to me.  Can you elaborate a bit more?
>
> What do they do, what does the caller expect to see (do they get
> something as return values?  do they expect some side effects?)?

so something like this would be better I'm assuming?

Some basic sample API calls are found below, each of these would hold
code to complete parsing and/or formatting the flags.
Add_Opt_Group() - returns an OPT_CALLBACK with contains, merged,
no-merged, or formatting which can be used in a commands options list.

Execute_list()-the main call into the library and would pass into the
library all of the necessary flags and arguments for parsing the
request and executing it. This would accept the flags like
-contain, with arguments such as the commit or pattern that is being
searched for.

The next four commands would be called by execute_list() to execute
the original command with respect to the flags that are passed into
this library.
Parse_with_contains()
Parse_with_merged()
Parse_with_no_merged()
Parse_with_formatting()
