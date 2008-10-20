From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Mon, 20 Oct 2008 20:59:46 +0700
Message-ID: <fcaeb9bf0810200659p91acb1cj58be43d3ef1c3e15@mail.gmail.com>
References: <20081019000227.GA9423@charybdis.dreamhost.com>
	 <20081019131745.GA8643@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Maciej Pasternacki" <maciej@pasternacki.net>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:45:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvJd-0005xM-V6
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYJTN7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYJTN7t
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 09:59:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:1075 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYJTN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 09:59:48 -0400
Received: by ey-out-2122.google.com with SMTP id 6so571461eyi.37
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Rk0vd9iziDFo5Gm5ivJAYzG0GSDkhZP2qroQfygIZuQ=;
        b=LUv5beS+nJrxz1czc2Cx7DMx15g2nzrc13TwGQls7EX1XC6iK7pfirN2nfWZsHWoCs
         ZfWQ+BSs1Faui3E9YpnzWC/7szP1F+kNNO2m50zFuEKDMVw59kVxANsR05qeV8Po5pDh
         9F6ZxBSzEOqWsCkNTISJhWTajR8npKZkaTgFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nRupTqaQwEXTWbrE/oRjMJHj1rRnUELk8JL3Kd7sbJVPbivq8QQUTdI+MLGUXMYQp6
         INTR833Dea7AhSFCj5jTYaN0rIinaCF7P3m7sonTLd+hzUbZe21mbjFlCqN59gSUsWNR
         8UySMh1e66ilx1HWP1/W5qHndIHBbBJAZ2gDM=
Received: by 10.86.74.4 with SMTP id w4mr6837910fga.25.1224511186417;
        Mon, 20 Oct 2008 06:59:46 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Mon, 20 Oct 2008 06:59:46 -0700 (PDT)
In-Reply-To: <20081019131745.GA8643@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98695>

On 10/19/08, Jeff King <peff@peff.net> wrote:
>  I'm not sure if the actual problem is related to the oft-discussed,
>  unresolved work-tree startup woes, or is something much simpler to fix.
>  I'll try to look closer later today.

I think all commands should be able to jump to worktree even if you
are outside work-tree. git-pull and similar commands are easy because
they don't take pathnames. The way pathnames are handled in git does
not make it easy for outside current working directory, because if old
cwd is outside worktree, the parameter "prefix" sent to those commands
become "../../blah/", not a real prefix anymore. If a command expects
an index pathname, then that prefix should be rejected. If they expect
a filesystem pathname, it can be used with care.
-- 
Duy
