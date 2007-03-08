From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Advice on strategy for "temporary" commits
Date: Thu, 8 Mar 2007 17:11:58 +0100
Message-ID: <81b0412b0703080811m27ff892eg5bf1cdf93f89051a@mail.gmail.com>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPLDs-0001nF-31
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 17:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbXCHQMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 11:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbXCHQMC
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 11:12:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:15127 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbXCHQMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 11:12:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so993096uga
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 08:11:59 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SXx3VGSUNjzqho8MOrPjXb8TOcEJO2ULHc4zbnM4dihaTqponh1RxmF6/g3/BvamfFrH07kMQXEdCcvoxq3X6TVhz8/lVxbo74fKNLFMwkqJd/NI7OV5TYpLyQXGHYzyQmrQJVAlBGIhovdBu5msgSgsmknVHaLiXT5PLjP/bv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nkn3YOHIxDEO/Vki/AKV0KdDRBkdmet83c9GXNz5F8IfetKKpaeKEcSxVKqaJYq102JwviStrK/cWOhIN5ejg8SeDQfqB0jaBYcOp2O6gdnSJLDqhjtmghV9YRGoT3bW4IHAocYvk9KaT8dc1d6s4OzQR8o+0B7ymaPwdTnZ070=
Received: by 10.78.178.5 with SMTP id a5mr72011huf.1173370319131;
        Thu, 08 Mar 2007 08:11:59 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Thu, 8 Mar 2007 08:11:58 -0800 (PST)
In-Reply-To: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41753>

On 3/8/07, David Tweed <david.tweed@gmail.com> wrote:
> I've been working with my system taking automatic
> hourly git snapshots of (filtered portions of) my home
> directory for a couple of months. Being able to look
> back to what files looked like mid-afternoon yesterday,
> or on 18 Nov, is proving modestly useful. However,
> I'm thinking about adding "temporary" commits every
> ten minutes which then get discarded after 5 hours-ish
> (in addition to the long-term archival hourly commits).
> This is motivated by the desire to have finer granularity
> for testing/bisecting short-term regressions but not having
> ridiculously fine-grained changes clogging up the
> archive long-term. (I'm aware that with the commits
> being primarily taken on a timed basis I'll have more
> non-compiling changes than is usual in a repository, so
> that this may not turn out to be useful in practice.)

Try using temporary and primary branch. Commit
10-minutes to the temporary branch, reset it to the
head of primary branch after you did a commit to
it and repack. Commits from temporary branch will
be removed.
You even can setup/modify your editor, to do a
temporary commit every time you save a file, for
extra ganularity.
