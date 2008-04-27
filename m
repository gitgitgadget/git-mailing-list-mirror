From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 13:51:07 +0800
Message-ID: <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
	 <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
	 <48141379.9030306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 07:52:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpzns-0006Gy-P8
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 07:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYD0FvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 01:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYD0FvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 01:51:16 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:35487 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYD0FvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 01:51:14 -0400
Received: by an-out-0708.google.com with SMTP id d31so1097624and.103
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=a3zwY/vGY+JJ6J5Sk+C6xavN/SLl4fuFRQ5AZouh14Y=;
        b=e6q8mpbj9mNlymay+hal9DWt+/5G+S/PDRbHymAS9+HzKXFY/WDBg+POauehXV0lrMeSpFKOg8LpPaea0bWuahhQOM0aVVm42CKdNH7c8ZbPQxvSrwrKNLJ/8V5XMzo2S1OS/Cs+xxlk0xWccf/QQEr+LtA/b9SNHY/t5arpyEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qOHkZR5JjXwEZ46CvPdZrQwTkvwSYo0+3/62ShJpZ59/9Erj4sHiHQ8MAj3aEylgbH8w7ML2ccOwUaGgyAmoE2PLw3c5IaA/4CbU9kbtT8acA5tQG4hW0PxCPa7NIEPsQ9PCkO9DfUXWwZ9x7CxS/LL2FMHB0vZxtcNfGgSZxPg=
Received: by 10.100.110.16 with SMTP id i16mr10073297anc.40.1209275468120;
        Sat, 26 Apr 2008 22:51:08 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 26 Apr 2008 22:51:07 -0700 (PDT)
In-Reply-To: <48141379.9030306@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80412>

On Sun, Apr 27, 2008 at 1:47 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Ping Yin wrote:
>  > These days i tried to convert the cvs repository into git. I really
>  > want the conversion to be as accurate as possible. However, the cvs
>  > repository has been tagged in a very bad style which makes
>  > git-cvsimport or cvsps not work well.
>  >
>  > cvs2git sounds to be the right tool i should try. Unfortualely, i
>  > can't touch the cvs repository directly. So is it possible to use
>  > cvs2git in the remote host instead of the host of the cvs repository
>  > just as git-cvsimport does? Yes, i know it can't now. I just wonder
>  > whether it is possible to implement.
>
>  cvs2svn/cvs2git itself can't work with remote repositories.  It would be
>  enough if you could just get a copy of the repository; obviously you
>  don't need to use the original.
>
>  If you can't get a copy of the CVS repository directly, you might be
>  able to recreate it indirectly via information read over the CVS
>  protocol using a tool like CVSsuck [1,2].  I have no experience with
>  CVSsuck, so if you try it out, please let us know whether you were
>  successful.
>

THX. If i try out cvssuck, i will let you know.


-- 
Ping Yin
