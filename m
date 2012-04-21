From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit
 more
Date: Sat, 21 Apr 2012 05:51:40 +0200
Message-ID: <4F922ECC.4040103@alum.mit.edu>
References: <vpqfwbye9re.fsf@bauges.imag.fr> <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr> <20120420201357.GA13103@sigill.intra.peff.net> <xmqq62cum6tf.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 05:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLRMq-0005G5-L0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 05:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab2DUDwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 23:52:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50606 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab2DUDwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 23:52:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.140] (p4FC0D9A1.dip.t-dialin.net [79.192.217.161])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3L3peKB023225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Apr 2012 05:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <xmqq62cum6tf.fsf@junio.mtv.corp.google.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196036>

On 04/20/2012 11:28 PM, Junio C Hamano wrote:
> [...]
> Perhaps make this part a separate paragraph so that it stands out a bit
> more, like this,
>
>      * `current` - push the current branch to a branch of the same name.
>      +
>      The `current` and `upstream` modes are for those who want to
>      push out a single branch after finishing work, even when the other
>      branches are not yet ready to be pushed out.
>
> and update the description for `matching` to explain why it is suited
> for what we claim that it is suited for, like so:
>
>      * `matching` - push all branches having the same name in both ends.
>        This is for those who prepare all the branches into a publishable
>        shape and push them out atomically, and suitable when pushing to a
>        non-shared repository. It is not appropriate to use when pushing into
>        a repository shared by multiple users, since locally stalled branches
>        will attempt a non-fast forward push if other users updated the branch
>        remotely.
>      +
>      This is the default.

"Atomic" implies that either the whole push succeeds or the whole push 
fails, and that readers will never see part of the push.  Is full 
atomicity really guaranteed?  Does the guarantee depend on the 
repository being non-shared?  What if the repo has one writer but 
multiple readers?

I have trouble answering questions like these because I haven't figured 
out the big picture of git's locking model.  In the code, all I have 
seen so far is fine-grained locks that only block writers (though the 
fast-index GSoC proposal includes a plan to introduce a lock on the 
index that blocks readers).  Is git's locking model documented somewhere?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
