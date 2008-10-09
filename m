From: "Ed Schofield" <edschofield@gmail.com>
Subject: Re: Git newbie question: permissions
Date: Thu, 9 Oct 2008 23:59:40 +0100
Message-ID: <1b5a37350810091559y151e244t43710d4e4c3dabcf@mail.gmail.com>
References: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
	 <2008-10-09-23-41-14+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 01:01:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko4V4-0006Nx-Hn
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 01:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbYJIW7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbYJIW7n
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 18:59:43 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:63633 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYJIW7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 18:59:43 -0400
Received: by ti-out-0910.google.com with SMTP id b6so88606tic.23
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nJvw6nbQzqBgZiVW5rFXCHuX2MLZ0zBLQgk5AoBM1o4=;
        b=neOULVctnaF38ECLHypBdugBlAg+ocQZyaBAcP/lAd/SvXGFEEiDONRw/v0/93Kkjh
         wPoiZ7EfB7apTSEVb5OWDjSz+uiTxKmRV3QgabmEuY/cuN0L/wRSldppLpJE5ePnb4ZE
         FEirlPRQAw8d85gTQcM5B/VsTjvSZtEAzReGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L7NJlCCvaxav6PSwes94m0nN23AAw694qwXuHHrq5reASTqjqRblFmFb4LrxybczRB
         zlRjOyqvR2k5a12S8V88T9VAcy+ts0TXI2B1WQKuf9GJZ9NT+kYgtvv1AEQIV65QgEdr
         EjBNCQbuWg7Z3cA92/RncgxZvjkQ+jMZwOp20=
Received: by 10.110.49.2 with SMTP id w2mr598605tiw.48.1223593180178;
        Thu, 09 Oct 2008 15:59:40 -0700 (PDT)
Received: by 10.110.31.7 with HTTP; Thu, 9 Oct 2008 15:59:40 -0700 (PDT)
In-Reply-To: <2008-10-09-23-41-14+trackit+sam@rfc1149.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97901>

On Thu, Oct 9, 2008 at 10:41 PM, Samuel Tardieu <sam@rfc1149.net> wrote:
>>>>>> "Ed" == Ed Schofield <edschofield@gmail.com> writes:
>
> Ed> I have now run "git --bare init --shared=group" to reinitialize
> Ed> the repository. This seems to have changed the directories to be
> Ed> g+sx. (Is this all it did?). There are still some objects
> Ed> directories with 755 permissions rather than 770, which I presume
> Ed> I want, and the group ownership of these is wrong. Shall I change
> Ed> these by hand? The sha1 files all have 444 permissions; is this
> Ed> right?
>
> Ed> The last question I have is how to ensure that git creates object
> Ed> files etc. with the right permissions when users push in future.
>
> As Marc said, you should first make sure that "config" contains
> "sharedrepository = 1" in the "[core]" section.
>
> Then you can do the following:
>
>  - remove all permissions for "others":  chmod -R o-rwx .
>  - mirror "user" permissions to "group": chmod -R g=u .
>  - add +s flag to directories:           find . -type d | xargs chmod g+s
>
> This should fix your current situation. The "sharedrepository = 1"
> will tell git to maintain a proper shared state in the future
> on objects it creates (i.e. mirror "user" permission to "group" ones).

This worked beautifully. Thanks Sam, thanks Marc!

-- Ed
