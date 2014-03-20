From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git log omits deleting merges
Date: Thu, 20 Mar 2014 22:56:58 -0000
Organization: OPDS
Message-ID: <BC292A8591EF4E8AB1E553FBF6ECC336@PhilipOakley>
References: <5305B045.2060503@gmail.com> <20140320195404.GA19252@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Ephrim Khong" <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQlu7-0006oP-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759741AbaCTW5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:57:19 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:9617 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759160AbaCTW5S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 18:57:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Al4uAAhyK1MCYJl+/2dsb2JhbABZgwZLA4NLhT66BgECAQELgQcXdGkBAYEfAQEUAQQBAQEBAgEIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCBxkMrR+FWZx9F4EpjTw1gkE1gRQEjzqbPYMtPQ
X-IPAS-Result: Al4uAAhyK1MCYJl+/2dsb2JhbABZgwZLA4NLhT66BgECAQELgQcXdGkBAYEfAQEUAQQBAQEBAgEIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCBxkMrR+FWZx9F4EpjTw1gkE1gRQEjzqbPYMtPQ
X-IronPort-AV: E=Sophos;i="4.97,698,1389744000"; 
   d="scan'208";a="453603985"
Received: from host-2-96-153-126.as13285.net (HELO PhilipOakley) ([2.96.153.126])
  by out1.ip03ir2.opaltelecom.net with SMTP; 20 Mar 2014 22:56:52 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244600>

From: "Jeff King" <peff@peff.net>
> On Thu, Feb 20, 2014 at 08:35:33AM +0100, Ephrim Khong wrote:
>
>> Hi, git log seems to omit merge commits that delete a file
>> if --follow or
>> --diff-filter=D is given. Below is a testcase. I'm not sure if it is
>> desired
>> behaviour for --diff-filter=D, but it's probably not correct
>> that --follow
>> _removes_ the merge commit from the log output.
>
> This is by design. Git-log does not calculate or show merge diffs
> unless
> "-c" or "--cc" is specified, and thus no diff-filter can match.

This is hard to discern from the log(1) man page as this conflates
commit inclusion (limiting?) with the diff formatting.

The -c and -cc options are listed in the diff formatting section, but
that's well down the man page. Even then, the note for the options 
doesn't say that it will cause the log output to now include the merge 
commits.

Perhaps the -c and -cc options should also be noted in the options or
the commit limiting section, but exactly where is probably contentious 
(maybe under the --merges).

(or I may have misunderstood)

>
>> echo "log 1 - no output"
>> # note that --diff-filter=A and M work as expected
>> # the merge does not show up for --diff-filter=ACDMRTUXB either
>> git log --pretty=oneline --diff-filter=D -- some_file
>
> Try:
>
>  git log -c --diff-filter=D -- some_file
>
> which does show it.
>
> -Peff
> --
Philip
-- 
