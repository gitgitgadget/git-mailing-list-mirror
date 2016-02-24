From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 11:36:24 +0800
Message-ID: <20160224033624.GB17763@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
 <87d1rnjil4.fsf@x220.int.ebiederm.org>
 <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 04:36:44 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYQFn-0000QZ-Ag
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 04:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbcBXDgd (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 22:36:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:45015 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcBXDgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 22:36:31 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 23 Feb 2016 19:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,492,1449561600"; 
   d="scan'208";a="658268751"
Received: from wfg-t540p.sh.intel.com ([10.239.197.212])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 19:36:25 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYQFU-0004ku-O9; Wed, 24 Feb 2016 11:36:24 +0800
Content-Disposition: inline
In-Reply-To: <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287170>

On Tue, Feb 23, 2016 at 12:35:12PM -0800, Junio C Hamano wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> It is valuable for a testing organization to say "We tested this
> >> series on top of version X.  We know it works, we have tested on a
> >> lot more hardware than the original developer had, we know this is
> >> good to go."  It is a valuable service.
> >>
> >> But that is valuable only if version X is still relevant, isn't it?
> >>
> >> Is the relevance of a version something that is decided by a
> >> developer who submits a patch series, or is it more of an attribute
> >> of the project and where the current integration is happening?
> >> Judging from the responses from Dan to this thread, I think the
> >> answer is the latter, and for the purpose of identifying the
> >> relevant version(s), the project does not even care about the exact
> >> commit, but it wants to know more about which branch the series is
> >> targetted to.
> >>
> >> With that understanding, I find it hard to believe that it buys the
> >> project much for the "base" commit to be recorded in a patch series
> >> and automated testing is done by applying the patches to that exact
> >> commit, which possibly is no-longer-relevant, even though it may
> >> help shielding the testing machinery from "you tested with a wrong
> >> version" complaints.
> >>
> >> Isn't it more valuable for the test robot to say "this may or may
> >> not have worked well with whatever old version the patch series was
> >> based on, but it no longer is useful to the current tip of the
> >> 'master'"?  If you consider what benefit the project would gain by
> >> having such a robot, that is the conclusion I have to draw.
> >>
> >> So I still am not convinced that this "record base commit" is a
> >> useful thing to do.
> >
> > So I don't know what value this has to the git project.
> 
> Oh, don't worry, I wasn't talking about value this may have to the
> Git project at all.  "The value to the project" I mentioned in my
> response was all about the value to the kernel project.
> 
> > The value of Fengguag's automated testing to the kernel project is to
> > smoke out really stupid things.
> 
> I'll snip your bullet points, but as I wrote, I do understand the
> value of prescreening test.
> 
> What I was questioning was what value it gives to that testing to
> use "the developer based this patch on this exact commit" added to
> each incoming patch, and have Fengguag's testing machinery test a
> patch with a base version that may no longer be relevant in the
> context of the project.  Compared to that, wouldn't "this no longer
> applies to the branch the series targets" or "this still applies
> cleanly, but no longer compiles because the surrounding API has
> changed" be much more valuable?
> 
> In your other message, you mentioned the "index $old..$new" lines,
> and it is possible to use them to find a tree that the patch cleanly
> applies to, but it will not uniquely identify _the_ version the
> patch submitter used.  IMHO, finding such _a_ tree from the recent
> history of the branch that the patch targets and testing the patch

Problem is, it's typically not clear what the patch "targets". Linux
is such a big project, there are dozens of maintainer trees and an
order more branches in their trees. The robot does a hard work trying
to guess what are the patches' targets, based on various hints like the
files being modified, the TO/CC list, the subject, etc. However it's
error prone -- even big maintainers cannot make a certain judgement
at times: "shall me or you take the patch?". Not to mention the
semi-private rules of co-maintainers, sub-maintainers and topic
branches. Sometimes people are backporting patches, hence "don't
test my patch on new RC kernels"; Or people may be working on cool
futurism patches that depend on more changes than the latest RC
kernel. To a robot, it's really hard to avoid stupid actions in such
a versatile bazaar. The "base commit/tree-id" under discussion would
be a perfect compass to guide the bot.

Thanks,
Fengguang

> on top of that tree (as opposed to testing the patch in the exact
> context the developer worked on) would give the project a better
> value.
