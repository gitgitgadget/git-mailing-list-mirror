From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git SVN Rebranching Issue
Date: Thu, 6 Nov 2008 15:48:17 -0500
Message-ID: <32541b130811061248n151c7512w4f6ba140ebb283af@mail.gmail.com>
References: <20081103140746.GA5969@mars.cyantechnology.local>
	 <20081104084111.GB14405@untitled>
	 <20081104094224.GC24100@dpotapov.dyndns.org>
	 <20081105003318.GA5666@hand.yhbt.net>
	 <32541b130811041640x18e3bbfewa639df356ff7561e@mail.gmail.com>
	 <20081106093917.GA15686@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Matt Kern" <matt.kern@undue.org>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 21:49:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyBnS-0005hY-GK
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 21:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbYKFUsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYKFUsU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 15:48:20 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:53605 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYKFUsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 15:48:19 -0500
Received: by yx-out-2324.google.com with SMTP id 8so332029yxm.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LsgllHjTpDcvJLMTOeLEjgY73/RMwgmH9KlXBUU5PLU=;
        b=Ix8+LDQ4q0DAsbxb+ZKxH9STKDcqhEPokD9o8zs9Yg0vqdzLIVJI3UglbfVcUdl2ov
         1OJZyCD3Z6osHcd5UjEyBvm3NDckPqUCAzwsigLCVuuHXI+HuWO5la+nTa/W27wry+OY
         wZaVcOJQjIYgxVwGPoy7uCd3kwzCDF9k/of+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZfrXXtC1ZUZvQoyEeQYtKR9B/sg3MA+Xz/Sgm8iErEuWx8fv/n4d+c2jMoxToKlciN
         XbOFdGsdL7DCb9P9qaDWjz8YLCRFnLHOQ3sbpsMazXdqcE7DuX9dXurUgBKqt0b3PCcF
         n6MmAuyAd3XZuGcMylHnPtr2th8K0s+poEG2c=
Received: by 10.150.201.13 with SMTP id y13mr2056777ybf.2.1226004498170;
        Thu, 06 Nov 2008 12:48:18 -0800 (PST)
Received: by 10.150.96.5 with HTTP; Thu, 6 Nov 2008 12:48:17 -0800 (PST)
In-Reply-To: <20081106093917.GA15686@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100265>

On Thu, Nov 6, 2008 at 4:39 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>> Well, you wouldn't have to rename the existing branch.  You would
>> simply create the new @SVN-NUMBER branch when it became clear that
>> that commit is no longer reachable from the undecorated branch ref.
>> Isn't that why the @SVN-NUMBER branches are needed in the first place?
>
> Making @SVN-NUMBER branches for new/latest branches is even more
> confusing.  That would mean the user would have to remember the
> @SVN-NUMBER every time they wanted to do operations with the
> recycled branch.

Hmm, I wasn't suggesting using @SVN-NUMBER for the *latest* branches;
you create one for the older branches at the time the old one is
replaced by the new one.

Note that this is exactly how it works in svn, so in fact it's a very
clean mapping from svn onto git.  If I ask about
/branches/whatever/myfile.c@SVN-NUMBER, it's different from asking
about "-r SVN-NUMBER /branches/whatever/myfile.c".  The difference is
precisely what we're talking about representing here.

What's important is that they really are two totally unrelated
branches of history, which happen to have been referred to by the same
name at the time when they were current.

> The current use of @SVN-NUMBER in branches are only used when following
> parents (when repositories are rearranged).  In retrospect, it's
> probably possible to for git-svn to not make them user-visible (I seem
> to recall they made development/debugging/testing easier in the past,
> though).

I wouldn't want to lose those names as they are now; they're
inconvenient, but important, because they accurately represent the
important points in svn history as it has been imported.

Have fun,

Avery
