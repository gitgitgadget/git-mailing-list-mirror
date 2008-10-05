From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Sun, 5 Oct 2008 23:51:30 +0400
Message-ID: <20081005195129.GP21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <81b0412b0810050214w15a25e3axfb8bf3ca05ffc215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZes-0008Bx-4p
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbYJETvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbYJETvj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:51:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:26769 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbYJETvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:51:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1690364fgg.17
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kqZPX/oKiG4cnjrj2ldzTSBSGJMl5z5dK5fb1nR9ziE=;
        b=G9av+iIci/1kc/U5vJZVi0V67tJE0Ae443spU3mzPI81XJIXUztU32O8yJA7GEcfY0
         Az2X1S8hTHs0pQVFbNG3K4Iemuk9OXuTmqxw7m9YuOW/JrmnomzZMwW4NJHzOkRYcOsM
         PQJnBr2BmT68mPmzjAMqndXsqHYSryb+GudT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dl/A4ZRYu3reeiOcgNVq2G1q+kK9j6v5YsT16Fkv7v78JrRydgIeOdzp0ldhZEs8R9
         spAFvro+JtxtNUc9asi/1l8d+6k4OB7sF9iBYtDAhlySQL+dTEFU0T4HWQp7M0Z0/j1F
         pLsO5JbzPEJM7VZqntf14DZ34NRDpm+BNnFIM=
Received: by 10.86.74.4 with SMTP id w4mr3705249fga.58.1223236295578;
        Sun, 05 Oct 2008 12:51:35 -0700 (PDT)
Received: from localhost (ppp85-140-168-27.pppoe.mtu-net.ru [85.140.168.27])
        by mx.google.com with ESMTPS id l12sm11250883fgb.6.2008.10.05.12.51.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 12:51:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0810050214w15a25e3axfb8bf3ca05ffc215@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97532>

On Sun, Oct 05, 2008 at 11:14:00AM +0200, Alex Riesen wrote:
> 2008/10/5 Dmitry Potapov <dpotapov@gmail.com>:
> > So, here is a patch. It basically disallow backslashes and colons in
> > file names on Windows (whether it is MinGW or Cygwin).
> 
> With this and sparse checkout patch combined it maybe possible
> to make Git work on these backward filesystems in a saner way:
> just never checkout the names which the filesystems cannot support
> on disk and mark them correspondingly in the index.

Perhaps, using sparse checkout is a good idea for dealing with prohibit
characters, but the goal of my patch was a bit different -- to close a
security hole in checkout when files outside of the working directory
can be overwritten. In fact, the whole point of having verify_path() is
to prevent this from happening, and if it does not work properly on
Windows then this function should be corrected.

Dmitry
