From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log --graph --oneline - false parent-child visualization
Date: Mon, 05 Nov 2012 15:17:33 +0100
Message-ID: <5097CA7D.50301@drmicha.warpmail.net>
References: <CAMn6BBaeWfwa_mAyTBFOmFYs0GwUauzqZZP+NWM=8f0_hKDz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: martyone <martyone@ubedi.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 15:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVNUq-0002Xk-7a
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 15:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab2KEORf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 09:17:35 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33705 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754341Ab2KEORf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 09:17:35 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7B9F320856;
	Mon,  5 Nov 2012 09:17:34 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 05 Nov 2012 09:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=pf39dn8EegWnqI6euYz7bP
	OiWOM=; b=u72/m6SQZ8SW7kYtkiNOpin688xYYhFVi5lYV92wuGZG7R1rY8IHUv
	kwlkxOW5Pt9Y0KfdBaCL+Vmypc8uIDAai/ZND7JY1uu7ST9ZWWN0Gp89FYtgslXw
	ssUmQWT/md7S0UZXWNErVWPb8cYwWX2dtSjzz3nmkQdGj1gL9sSR4=
X-Sasl-enc: 7VoOg+1/p5z5bpXwY0tLkJVHV7/SscoeL4aNqe70D80B 1352125054
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 06FA88E00DE;
	Mon,  5 Nov 2012 09:17:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMn6BBaeWfwa_mAyTBFOmFYs0GwUauzqZZP+NWM=8f0_hKDz3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209061>

martyone venit, vidit, dixit 05.11.2012 13:57:
> Hello,
> 
> the combination of --graph and --oneline sometimes produces output
> which is -- at least for me -- not clear about parent-child relation
> between commits. I noticed it when using with --simplify-by-decoration
> switch but it should not be specific to the use of this switch.
> 
> See this example output (git version 1.7.11.3)
> 
> | | | * eead15f (origin/branchA) Lorem ipsum dolor sit amet
> | |_|/
> |/| |
> | | | * 8da3b9f (origin/branchB) Consectetur adipisicing elit
> | | |/
> | | | * c4d6b9a (origin/branchC) Sed do eiusmod tempor incididunt ut labore
> | | | * d623246 (origin/branchD) Ut enim ad minim veniam
> | | |/
> | | | * 458d305 (origin/btanchE) Quis nostrud exercitation ullamco laboris
> | | |/
> 
> Here it seems commit c4d6b9a is based on d623246. But when the format
> is more-than-oneline (or when checked with gitk), it is clear there is
> no relation between commits c4d6b9a and d623246.
> 
> | | | * commit eead15f (origin/branchA)
> | |_|/  Author: John Doe <john.doe@example.net>
> |/| |
> | | |       Lorem ipsum dolor sit amet
> | | |
> | | | * commit 8da3b9f (origin/branchB)
> | | |/  Author: John Doe <john.doe@example.net>
> | | |
> | | |       Consectetur adipisicing elit
> | | |
> | | | * commit c4d6b9a (origin/branchC)
> | | |   Author: John Doe <john.doe@example.net>
> | | |
> | | |       Sed do eiusmod tempor incididunt ut labore
> | | |
> | | | * commit d623246 (origin/branchD)
> | | |/  Author: John Doe <john.doe@example.net>
> | | |
> | | |       Ut enim ad minim veniam
> | | |
> | | | * commit 458d305 (origin/branchE)
> | | |/  Author: John Doe <john.doe@example.net>
> | | |
> | | |       Quis nostrud exercitation ullamco laboris
> | | |
> 
> Correct output produced with --oneline switch should output an extra
> newline when commit has no parent listed:
> 
> | | | * eead15f (origin/branchA) Lorem ipsum dolor sit amet
> | |_|/
> |/| |
> | | | * 8da3b9f (origin/branchB) Consectetur adipisicing elit
> | | |/
> | | | * c4d6b9a (origin/branchC) Sed do eiusmod tempor incididunt ut labore
> | | |
> | | | * d623246 (origin/branchD) Ut enim ad minim veniam
> | | |/
> | | | * 458d305 (origin/btanchE) Quis nostrud exercitation ullamco laboris
> | | |/
> 
> Best Regards,
> Martin
> 

Yes, you have the same problem when you simply have two disjoint
branches: They're listed "concatenated". The problem is that log --graph
uses the single symbol "*" for many different cases, independent of the
number of ingoing or outgoing lines. There are two solutions:

- use more spacing
- use more symbols (like tig does) and stay compact

Feel free to experiment ;)

Michael
