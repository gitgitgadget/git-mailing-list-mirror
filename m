From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Sat, 26 May 2012 11:09:07 +0700
Message-ID: <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
References: <20120523122135.GA58204@tgummerer.unibz.it> <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 06:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY8Kg-0002X9-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 06:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834Ab2EZEJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 00:09:39 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37276 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778Ab2EZEJj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 00:09:39 -0400
Received: by lahd3 with SMTP id d3so1056742lah.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M20IeuGzzlxptMLpsjnG55Bi93CV3rCOhMGQJv19A+8=;
        b=kI8Pt4mLs/yFMGmkCZs+m2sRACh0zBBYLwL2P0ATgw17M65l3J5OCLY3amBHUGOjGa
         ijRUll1BtGIAGyOmnlqayGT5fKnEeQWsQSeUpXCodeRHUfvknJZBs+Rr8L7S2jnNyR3K
         qcFh0JmGotOWaIr/glINznyhG7VhJdsH4nTN3ya9u8NsQKlvAPaJsyiMrSD2NWZxPlyZ
         OB7RFTOS8gbVW6kbHnC255XyLQL1NOR0KkVptEOB4c0cjr9NgJ/d1SiUiJdlMBImOIk0
         sK/qA5nOdckxNV0Tub/Tba4lNPDNrV7EUL3YZb5LunBO/W+HXPcckT18JkQXBS+KlCUc
         zpuw==
Received: by 10.152.105.235 with SMTP id gp11mr1102806lab.44.1338005377412;
 Fri, 25 May 2012 21:09:37 -0700 (PDT)
Received: by 10.112.150.100 with HTTP; Fri, 25 May 2012 21:09:07 -0700 (PDT)
In-Reply-To: <20120525201547.GB86874@tgummerer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198539>

On Sat, May 26, 2012 at 3:15 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 05/25, Nguyen Thai Ngoc Duy wrote:
>> On Wed, May 23, 2012 at 7:21 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > == Outlook for the next week ==
>> >
>> > - Start working on actual git code
>> > - Read the header of the new format
>>
>> I know it's out of scope, but it would be great if you could make
>> ls-files read the new index format directly. Having something that
>> actual works will ensure we don't overlook anything in the new format.
>> We can then learn from ls-files lesson (especially how to handle both
>> new/old format) and come up with api/in-core structures for the rest
>> of git later.
>
> Thanks for your suggestion. How did you think this should be done?
> Writing a extra function in ls-files, just for outputting? I don't
> think it is necessary to write a extra function, since the result
> from the read_index_from function in read-cache is used for that
> anyway. Or did you have something different in mind, that I'm missing
> here?

No, read_index_from would go through the normal tree->list conversion.
What I'd like to see is what it looks like when a command accesses
index v5 directly in tree form, taking all advantages that tree-form
provides, and how we should deal with old index versions while still
supporting index v5 (without losing tree advantages)
-- 
Duy
