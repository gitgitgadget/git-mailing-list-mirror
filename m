From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Mon, 05 May 2014 01:44:46 -0400
Message-ID: <5367254E.5030402@bbn.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <5364A143.1060404@bbn.com> <5364b62d5fb7b_ac68dd30816@nysa.notmuch> <5365691C.1010208@bbn.com> <5365af33825c3_520db2b308bf@nysa.notmuch> <5365F10C.6020604@bbn.com> <536613bd14e24_1c89b0930cac@nysa.notmuch> <53669051.6090204@bbn.com> <5366ad66b9a6c_18f9e4b308b8@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whht7-0005Yp-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbaEEFov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:44:51 -0400
Received: from smtp.bbn.com ([128.33.1.81]:20510 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbaEEFou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:44:50 -0400
Received: from socket.bbn.com ([192.1.120.102]:43100)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WhBhy-000JFl-6z; Mon, 05 May 2014 01:44:58 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 79E2040086
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5366ad66b9a6c_18f9e4b308b8@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248117>

On 2014-05-04 17:13, Felipe Contreras wrote:
> Richard Hansen wrote:
>> On 2014-05-04 06:17, Felipe Contreras wrote:
>>> Richard Hansen wrote:
>>>> On 2014-05-03 23:08, Felipe Contreras wrote:
>>>>> It is the only solution that has been proposed.
>>>>
>>>> It's not the only proposal -- I proposed a few alternatives in my
>>>> earlier email (though not in the form of code), and others have too.  In
>>>> particular:
>>>>
>>>>   * create a new 'git integrate' command/alias that behaves like 'git
>>>>     pull --no-ff'
>>>
>>> Yeah but that's for a different issue altogheter. I doesn't solve the
>>> problems in 1. nor 2. nor 3.
>>
>> 'git integrate' would handle usage cases #2 (update a published branch
>> to its "parent" branch) and #3 (integrate a completed task into the main
>> line of development),
> 
> But these cases are completely different. One should reverse the
> parents, the other one not.

No -- for both #2 and #3 I want the remote branch to be merged into the
local branch.

In the example I gave for use case #2, foo is a local branch with
origin/foo as the configured upstream and origin/foo was forked off of
origin/master.  Someone pushed new stuff to origin/master, and the user
wants the new stuff to also be in origin/foo.  So the user does this:

  git checkout foo
  git pull --ff-only  # this is use case #1
  git pull origin master  # this is use case #2
  git push

The merge commit created by 'git pull origin master' should have
origin/master as the second parent, not the first.

-Richard
