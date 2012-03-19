From: Kevin Ballard <kevin@sb.org>
Subject: Re: Please discuss: what "git push" should do when you do not say what
 to push?
Date: Mon, 19 Mar 2012 11:57:16 -0700
Message-ID: <87BE88BA-2827-4EDC-99BF-94026E604AB0@sb.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 19 21:01:22 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S9ile-0002eB-37
	for glk-linux-kernel-3@plane.gmane.org; Mon, 19 Mar 2012 21:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162292Ab2CSUBM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 19 Mar 2012 16:01:12 -0400
Received: from mail-out.apple.com ([17.151.62.49]:60172 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162173Ab2CSUBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Mar 2012 16:01:07 -0400
X-Greylist: delayed 3830 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2012 16:01:07 EDT
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0M15001SFAI4C7K0@mail-out.apple.com>; Mon,
 19 Mar 2012 11:57:13 -0700 (PDT)
X-AuditID: 11807136-b7bd3ae000002dbb-e2-4f678188fffb
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id 5F.72.11707.881876F4; Mon, 19 Mar 2012 11:57:13 -0700 (PDT)
Received: from il0103b-dhcp193.apple.com
 (il0103b-dhcp193.apple.com [17.201.38.243])
 by kencur.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPSA id <0M1500LGLBBCEK30@kencur.apple.com>; Mon,
 19 Mar 2012 11:57:12 -0700 (PDT)
In-reply-to: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsUiON1OTbezMd3f4PM5ZouuK91MFpd3zWFz
	YPL4vEkugDGKyyYlNSezLLVI3y6BK2PH209sBdMlKo40pTUwbhPuYuTkkBAwkdh36ggThC0m
	ceHeerYuRi4OIYF2Jokdfb+ZIZzlTBKLPp0HqxIWiJKYcnAlC4jNK2Aose/3f7A4s4CWxPqd
	x8FsNgEliXsTloDZnAJmEquWTGQDsVkEVCV2NX1jh6g3lWie+B2qV1viybsLrBAzLSW+bjrB
	DGILAdXsvX8BzBYRUJOY2HaIBeJSWYnbB/czTWAUmIXkjFlIzpiFZOwCRuZVjIJFqTmJlYam
	eokFBTmpesn5uZsYQSHYUGi2g3HHX7lDjAIcjEo8vBtj0v2FWBPLiitzDzFKcDArifA6XU/z
	F+JNSaysSi3Kjy8qzUktPsQozcGiJM57Lg+oWiA9sSQ1OzW1ILUIJsvEwSnVwOibdyYw+uDv
	w/+PfYjPVF3mfav0ZAXXW9bD2/qdr8SV9EwoVk6etfbDk555ena+KvcnZNyymtrQWdPwkdvC
	rz4pUS1hwubyR+cP6pZ8ncSdsXr1T6d3p1+t/eLQeGC56sUnfTbT1fZv23plm9iTg1rXlzxa
	YsejlfiK+/Ce29X66hlzU7lESlmUWIozEg21mIuKEwH3Pg27PQIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193453>

I would love to see the default changed to 'upstream'. I've wanted this ever
since the push.default=tracking value was introduced. When introducing new
users to git, one of the first things I always tell them is to run

    git config --global push.default tracking

because it's far easier to explain how that behavior works than it is to
explain how the 'matching' behavior works, and it more closely aligns with
the way people (in my experience) typically use git.

-Kevin

On Mar 16, 2012, at 10:10 PM, Junio C Hamano wrote:

> There is a proposal to change the default behaviour of 'git push' on the
> Git mailing list. The goal of this message is to encourage you to discuss
> it before it happens (or the change is aborted, depending on the outcome
> of the discussion).
> 
> In the current setting (i.e. push.default=matching), 'git push' without
> argument will push all branches that exist locally and remotely with the
> same name. This is usually appropriate when a developer pushes to his own
> public repository, but may be confusing if not dangerous when using a
> shared repository. The proposal is to change the default to 'upstream',
> i.e. push only the current branch, and push it to the branch 'git pull'
> would pull from. Another candidate is 'current'; this pushes only the
> current branch to the remote branch of the same name.
> 
> For more details on the behavior of Git with these values, read the
> documentation about 'push.default' in 'man git-config'
> (http://schacon.github.com/git/git-config.html).
> 
> You may be negatively affected when such a change happens if you do not
> see anything in the output from 'git config push.default' and if you rely
> on the default that pushes all your matching branches. On the other hand,
> you may want to see the default behaviour to change, especially if you are
> using shared repositories. In either case, please join the discussion to
> give us more data point and help us decide the future of Git. Also, if
> you think your friends and colleagues will be affected by this change,
> either positively or negatively, please tell them about this discussion.
> 
> What has been discussed so far can be seen in this thread:
> 
>    http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694
> 
> Previous relevant discussions include:
> 
>    http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541
>    http://thread.gmane.org/gmane.comp.version-control.git/166743
> 
> To join the discussion, send your messages to:
> 
>    git@vger.kernel.org
> 
> The list accepts messages from non-subscribers, and you do not have to ask
> "please Cc me, I am not subscribed", as it's customary to Cc: posters when
> replying on this list.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
