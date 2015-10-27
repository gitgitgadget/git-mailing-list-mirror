From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v3] Add git-grep threads param
Date: Mon, 26 Oct 2015 22:25:41 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FC@mail.accesssoftek.com>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>,<20151026193241.GO19802@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>,
	Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 06:30:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqwqJ-0003eY-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 06:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbbJ0Fae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 01:30:34 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:49587 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbbJ0Fac convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 01:30:32 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 26 Oct 2015 22:30:31 -0700
Thread-Topic: [PATCH v3] Add git-grep threads param
Thread-Index: AdEQJSnMPL9eDF3JQx28MuhhQ3L7tAAUsHLm
In-Reply-To: <20151026193241.GO19802@serenity.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280245>

Hello John,

see comments inline.

>> @@ -22,6 +22,7 @@ SYNOPSIS
>>          [--color[=<when>] | --no-color]
>>          [--break] [--heading] [-p | --show-function]
>>          [-A <post-context>] [-B <pre-context>] [-C <context>]
>> +        [--threads <num>]

> Is this the best place for this option?  I know the current list isn't
> sorted in any particular way, but here you're splitting up the set of
> context options (`-A`, `-B`, `-C` and `-W`).

Agree, I'll move the option both here and in documentation.

>> -static int wait_all(void)
>> +static int wait_all(struct grep_opt *opt)

> I'm not sure passing a grep_opt in here is the cleanest way to do this.
> Options are a UI concept and all we care about here is the number of
> threads.

> Since `threads` is a global, shouldn't the number of threads be a global
> as well?  Could we reuse `use_threads` here (possibly renaming it
> `num_threads`)?

This thought also crossed my mind, however we already pass grep_opt to start_threads() function,
so I think passing it to wait_all() is not that ugly, and kind of symmetric. And I do not like the idea
of duplicating same information in different places. What do you think?

--
Best Regards,
Victor
