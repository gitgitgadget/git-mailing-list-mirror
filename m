From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 4/6] Teach "git remote" about remote.default.
Date: Fri, 06 Jul 2012 10:43:34 -0400
Message-ID: <4FF6F996.8080205@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-5-git-send-email-marcnarc@xiplink.com> <CABURp0oYfzKrkKOZJrH2hrYMTPbFe_i5mMKQ3HnWQdGZa=oujw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	peff@peff.net
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn9kq-0004U3-B7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 16:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093Ab2GFOn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 10:43:27 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:60796 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab2GFOn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 10:43:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id F2D4E1C80EC;
	Fri,  6 Jul 2012 10:43:25 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7AD421C806D;
	Fri,  6 Jul 2012 10:43:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <CABURp0oYfzKrkKOZJrH2hrYMTPbFe_i5mMKQ3HnWQdGZa=oujw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201114>

On 12-07-06 08:51 AM, Phil Hord wrote:
> On Thu, Jul 5, 2012 at 6:11 PM,  <marcnarc@xiplink.com> wrote:
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> The "rename" and "rm" commands now handle the case where the remote being
>> changed is the default remote.
> 
> I think this is the right thing to do.  But I noticed a subtle
> behavior change that we may wish to consider.
> 
> Today I might do this (contrived example):
> 
> git checkout somelocalbranch
> git push # pushes to "origin" by default
> git remote rename origin origin1
> git add origin ssh://new-server/foo
> git push  # pushes to "origin" by default
> 
> But after this change, the last command is different.  Now it pushes
> to "origin1" because the rename set the remote.default to "origin1",
> even though it was previously not set at all.  It did this because the
> "oldname" is compared to the "remote_get_default_name()", which
> returns "origin" by default.  So the old setting, which did not exist,
> is now "renamed" to have an actual value, and the actual value is not
> "origin".
> 
> One can easily contrive an alternative example showing that this is a
> good thing.  As I said, I think it is the right thing to do.
> 
> But it is different, I think.

Yes, I agree it is different.

> I doubt many script writers are counting on default settings to carry
> the day, so they are probably more explicit about how they push.  But
> I didn't see this mentioned in the patch.

I think this sort of thing is better suited to the documentation of
remote.default.  I'm planning to re-roll this series with documentation
updates, and I'll include your example.

		M.
