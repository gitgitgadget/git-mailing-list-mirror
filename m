From: david@lang.hm
Subject: Re: Better big file support & GSoC
Date: Sat, 2 Apr 2011 21:00:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104022056530.29543@asgard.lang.hm>
References: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jonathan Michalon <johndescs@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 06:01:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6EUq-0006Sy-J8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 06:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758Ab1DCEA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 00:00:58 -0400
Received: from mail.lang.hm ([64.81.33.126]:36747 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701Ab1DCEA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 00:00:57 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p3340rY0019164;
	Sat, 2 Apr 2011 20:00:54 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170673>

On Sat, 2 Apr 2011, Jonathan Michalon wrote:

> Hi Git people,
>
> I'm an applicant to the GSoC within git.
> I would like to help building a better big file support mechanism.
>
> I have read the latest threads on this topic:
> http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=165389
> http://thread.gmane.org/gmane.comp.version-control.git/168403/focus=168852

there was also an offshoot of a similar discussion that pointed out that 
this could be done pretty cleanly with the clean/smudge hooks.

David Lang

> Here's a compilation of what I read and what I think.
>
> What come the most are OOM issues. But I think that the problem is, git tries
> to work exactly the same on binaries and text. If we managed one way or another
> to skip tasks (what "intelligent" operations are possible on binaries ?
> Almost none...) we should be able to avoid them, like most of the time.
> This means that a first step will be to introduce an autodetection mechanism.
>
> Jeff King argues that, on binaries, we got uninteresting diffs, and compression
> is often useless. I agree. We would better not compress any of them (okay, tons
> of zeros would compress well but who's going to track zeroes?).
>
> Eric Montellese says: "Don't track binaries in git. Track their hashes." I agree
> here too. We should not treat computer data like source code (or whatever text).
> He claims that he needs to handle repos containing source code + zipped tarballs
> + large and/or many binaries. Users seem to really need binary tracking and
> therefore git should do it. I personally needed to a couple of times.
>
> He also says that we could want to do download-as-needed and remove-unnecessary
> operations, and I think that it may be clean enough to add a git command like
> 'git blob' to handle special operations for binaries. Perhaps in a second step.
>
> Another idea was to create "sparse" repos, considered leafs as they may not be
> cloned from because they lack full data. But it may or may not be in the
> spirit of Git...
>
>
> What I personally would like as a feature is the ability to store the main
> repo with sources etc. into a conventional repo but put the data elsewhere
> on a storage location. This would allow to develop programs which need data
> to run (like textures in games etc.) without making the repo slow, big or
> just messy.
> I faced the situation on TuxFamily where the website, Git/SVN etc. are on one
> quick server and the download area on another one. The first was limited to
> something like 100MB and the second to 1GB, extensible to more if needed.
> On the same idea, on my home server with multiple OpenVZ containers I host repos
> for my projects on one free-to-access container which may be attacked, or even
> compromised which has a small disk partition. On the other side my data is on a
> ssh-only, secured, firewalled big partition. It may be useful to have code on
> the first but ssh'd data on the other.
> I suspect many other situations where a separation between code and data may
> help administrators and/or users.
> To handle this I thought of a mechanism allowing a sort of branch (to make use
> of multiple 'remote') to be checked out at the same time as the code...
> In addition we should use an extensible protocol layer to manage data.
> git-annex or git-media which already address some of the problems here
> are using various things like ssh, http, s3. And I just saw that Debian's git
> package already recommend rsync.
>
>
> What do you think about that whole? Would it fit on a GSoC background? Great
> interesting task indeed. May sound too long. But of course if the summer went
> too short I would not drop the project on the floor as soon as the time limit
> will be reached.
>
>
> Best regards,
>
> --
> Jonathan Michalon
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
