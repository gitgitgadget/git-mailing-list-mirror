From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [BUG] 'stg add FILE' when FILE is a symlink to dir adds dir contents
Date: Sat, 14 Apr 2007 00:02:22 +0100
Message-ID: <b0943d9e0704131602o694a46c8xb4101a05cf8ec2d3@mail.gmail.com>
References: <20070411155452.GL5329@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcUmr-0000u7-HL
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 01:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965679AbXDMXC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965673AbXDMXC1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 19:02:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6624 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030881AbXDMXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 19:02:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so638051uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 16:02:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLQT2KPU+A1S6fpB0/6ZKgjW6fuN/yQw9XH8GltIvUHXC31CHqvBj/QtfSwqPAokru3/Sd7O96jt+PFNt+W5s7/7AlPN060TDInN/ZZCZi/shQVQuy+/4oSXiyb5gYI4lctJdPYkbCufCtuTs80WTJZHiM2VLKkahEf3qUQm/gI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m63FVtMvaqZ9ibbYYOfTtEVy7qWyye7OupDx9W++tsiNYdeMHhxW88D47t1XJxeTFjuL5px67mYCAQ+o51jPasslam4crXPzkR+Yc1uH5XR0h6Qm0rB5MERIRA2ub1hOLyDRENmZNIWOW9pjHsGL9XjXBtQaWYG14Nb1ys8oT/U=
Received: by 10.67.115.14 with SMTP id s14mr2320183ugm.1176505342460;
        Fri, 13 Apr 2007 16:02:22 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Fri, 13 Apr 2007 16:02:22 -0700 (PDT)
In-Reply-To: <20070411155452.GL5329@moonlight.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44439>

On 11/04/07, Tomash Brechko <tomash.brechko@gmail.com> wrote:
> I have noticed that 'stg add FILE' works differently from 'git add
> FILE' when file is a symlink to the directory: StGIT adds the contents
> of dir, while GIT adds the symlink itself.

Thanks for this.

> But curious, why does the code traverse the tree itself?  Why not to
> give the file list directly to git-update-index, and let it decide
> what files to add, and how?

Because this code was implemented almost 2 years ago when I don't
think git-update-index was able to scan directories. Never looked at
re-implementing it.

> I also guess the code doesn't honor .gitignore.

It doesn't, unless git-update-index ignores the files passed on the
command line according to the .gitignore content.

> Could 'names' list be passed to git-update-index directly?

Probably, I'll give it a try and see whether it breaks anything.

-- 
Catalin
