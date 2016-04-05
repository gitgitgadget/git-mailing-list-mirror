From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Tue, 5 Apr 2016 14:36:09 +0800
Message-ID: <20160405063609.GB10110@yexl-desktop>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
 <1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
 <xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
 <20160401135207.GB2915@yexl-desktop>
 <xmqqlh4xjoub.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anKc7-0000Zg-5f
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 08:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbcDEGhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 02:37:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:10805 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbcDEGhC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 02:37:02 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP; 04 Apr 2016 23:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,443,1455004800"; 
   d="scan'208";a="938418075"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2016 23:36:54 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqlh4xjoub.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290764>

On Fri, Apr 01, 2016 at 09:06:20AM -0700, Junio C Hamano wrote:
>Ye Xiaolong <xiaolong.ye@intel.com> writes:
>
>> On Thu, Mar 31, 2016 at 10:43:48AM -0700, Junio C Hamano wrote:
>>>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>>>
>>>> Introduce --base=auto to record the base commit info automatically, the base_commit
>>>> will be the merge base of tip commit of the upstream branch and revision-range
>>>> specified in cmdline.
>>>
>>>This line is probably a bit too long.
>>
>> How about simplifying it to "the base_commit is the merge base of upstream and
>> specified revision-range."?
>
>What I meant was not that profound.  I just wanted you to wrap your
>lines a bit shorter so that quoting in the discussion thread like
>this would not make the result overlong to fit on a 80-column
>terminal ;-)

Emm, get your point now, I'll shorten the lines to fit in 80-column.

>
>>>> +			base = base_list->item;
>>>> +			free_commit_list(base_list);
>>>
>>>What should happen when there are multiple merge bases?  The code
>>>picks one at random and ignores the remainder, if I am reading this
>>>correctly.
>>
>> If there is more than one merge base, commits in base_list should
>> be sorted by date, if I am understanding it correctly, so
>> base_list->item should be the lastest merge base commit, it should
>> be enough for us to used as base commit.
>
>By definition, when there are multiple merge bases, there is no
>latest one among them.
>
>When the history involves criss-cross merges, there can be more than
>one 'best' common ancestor for two commits.  For example, with this
>topology (note that X is not a commit; it merely denotes crossing of
>two lines):
>
>       ---1---o---A
>      /    \ /
>  ---O      X
>      \    / \
>       ---2---o---o---B
>
>both '1' and '2' are merge-bases of 'A' and 'B'.  And the timestamps
>on one (be it committer or author timestamp) being later than those
>of the other do not make it any more suitable than the other one.
>

For this criss-cross merges, as neither merge base(like 1) is better
than the other(both 1 and 2 are 'best' merge bases), I think it should
be fine to pick a random one as base commit(Or you prefer to show all of
them?) and I'll add this part of discusstion into documentation.

Thanks,
Xiaolong.
