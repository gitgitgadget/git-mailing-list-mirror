From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Tue, 6 Jan 2009 23:36:39 +0100
Message-ID: <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
	 <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKZ4-0004Ex-Uj
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbZAFWgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 17:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761310AbZAFWgn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:36:43 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:49106 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbZAFWgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 17:36:41 -0500
Received: by fk-out-0910.google.com with SMTP id 18so4037060fkq.5
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=rLCMQ3KKPaCykDI1zSDFl+FmoT5IlV4Al3rDcNP4ZYM=;
        b=jbTFlvpa7hpV+D2jOfexZL7OT11bVi0EE+SRswNS4P6HZZL/EO7rNkFdCDnTeQstLL
         Nwg+JAiqM9a3Xj4lVWJSE+W/qtV2kVJGi39Q1n8hCOCj5zyXi4/fFrqqEdOs5mFiPu4O
         7mZWeUS4JqC9Y+SPkYGaF3kRC5oDcPnos4q30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mq9WVGcQ0WAoy51ssbt4OcQef6VeKN4ZRWrY1mnWWMAZdM3o3Ge/gep6KEMjmc9bDb
         /A+XwC/gZdwzUm5UaJBhqPb59+/VOoauw6Ywv4ewlTu5nsAX86genk9V38ZVOwP7Ozsv
         q5d+2TsE4vWGks2bgSJaXUZ9pN/YmLciP5kj8=
Received: by 10.223.111.211 with SMTP id t19mr15891088fap.64.1231281399223;
        Tue, 06 Jan 2009 14:36:39 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Tue, 6 Jan 2009 14:36:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 3aef3a28c2b5b400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104733>

On Tue, Jan 6, 2009 at 11:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 6 Jan 2009, =D8yvind Harboe wrote:
>
>> Q1: How can I figure out what it is in .git that takes so much space=
?
>
> If it is a pack that is taking so much space:

it is.

>
> $ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4

I have never used the git verify-pack command, but I'm pretty sure the
"Terminated" string isn't the normal output :-)

$ git verify-pack -v
=2Egit/objects/pack/pack-1e039b82d8ae53ef5ec3614a3021466663cc70a4
Terminated

This is running git version 1.6.1. on CentOS on a virtual machine. I'm =
not quite
sure how to debug this. I'm sure I've done something wrong when I insta=
lled git.
I'm just a humble user of git trying to convert from cvs/svn.


> and then for the last few lines do a
>
> $ git rev-list --all --objects | grep $SHA1

I was able to run this procedure on a different machine than the
server and I can
then tell which objects take up all the space.

However, I'm unnerved by git verify-pack "Terminated"'ing on me above
and I'll have
to sort that out before I can think about using git in production.


Thanks for the pointers though! They definitely answered my questions!

>
> Hth,
> Dscho
>



--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
