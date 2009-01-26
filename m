From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Hosting from Windows XP.
Date: Tue, 27 Jan 2009 01:46:31 +0800
Message-ID: <be6fef0d0901260946jb6ef8deo59dc16a74a371074@mail.gmail.com>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVZU-0003L4-JE
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZAZRqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZAZRqe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:46:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:47502 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbZAZRqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:46:33 -0500
Received: by wf-out-1314.google.com with SMTP id 27so6990861wfd.4
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tbhd0+v3kDwNmGFkhJdJ59EH8U0A2kIot6GCsjOcJeM=;
        b=i3gRVxzUubptTWBLeIDE4GCg7bNFQs+w6DB78h19eVMJ6++1IWZDXOxt0kcTPiTszd
         kyRaN/OXYbgxYSAoQRN2tRIuBzikHKe+tZsuorzS0f/OoABji8JOwBK/1RjabEFHcyie
         Rb+myL9MGrAWD1LxODI7B0GFTeU8BYQJ1H5aY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KB6ErRZ08fqHNfLQxcAg/tUuCs6ZGPYYerGCycFLnbXiZoOc4++nmLVacYP5PDTS/4
         zW+q0MRg2oN70yx5D6GWY4V07+zoMwXAJ0nWHAHUwStVrVGEBJwc0j5xLOy/1o8kSJ8N
         /VBhzslHxHeYrnU5+t210P7ulwR0DwXm37x48=
Received: by 10.114.170.1 with SMTP id s1mr1830688wae.57.1232991991710; Mon, 
	26 Jan 2009 09:46:31 -0800 (PST)
In-Reply-To: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107238>

Hi,

On Tue, Jan 27, 2009 at 12:27 AM, Tim Visher <tim.visher@gmail.com> wrote:
> Hello Everyone,
>
> I'm trying to get git set up for my company.  We're stuck using
> Windows for the foreseeable future so for now I have to host the
> central integration repository out of a Windows box.  I figured the
> easiest way to do this, short of installing cygwin, would be to do a
> simple msysgit install and then run git daemon with the relevant repo
> copied over onto the server.  Then devs could track that repo.
> However, it appears that msysgit does not install git daemon.

you might want to look at using pushing over DAV: say, have all your
employees pulling from a DAV-enabled server.

The DAV protocol itself is platform-agnostic, so your server could be
Windows or Linux or whatever. Since DAV deals with file I/O, you might
want to look at your security options, though I think basic access
authentication would be enough if your server is only accessible
within your company's LAN.

By pushing over DAV, you can avoid running a git daemon. Looking at
how you would do this on Windows, i don't think it's advisable to do
so.

To do this, first, you would need to have cygwin, then you have to run
"cygrunsrv -I", which will install your git daemon as a Windows
service.

AFAIK, cygrunsrv pipes stuff to git-daemon. I don't know how good this
option is, reliablity or performance-wise.

I've tried this out (somewhat limitedly) using git built on cygwin,
with an Apache server, though currently you would have problems if
your Apache was running on a Windows box (my patch to fix this is on
its way).


-- 
Cheers,
Ray Chuan
