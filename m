From: "Sky Patrick" <patricksky852@gmail.com>
Subject: Re: How can i write a new protocol for git
Date: Mon, 8 Sep 2008 10:32:16 +0800
Message-ID: <976e6d070809071932r60ca6c50na813166feec7e153@mail.gmail.com>
References: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
	 <20080905094746.GA26820@glandium.org>
	 <20080905145246.GA20537@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 04:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcWZL-0003Fy-0V
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 04:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYIHCcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 22:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYIHCcT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 22:32:19 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:4798 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYIHCcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 22:32:18 -0400
Received: by yx-out-2324.google.com with SMTP id 8so697839yxm.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=I1TYPFPgQEMiV7DbHiHxdrNxcf/CvpgDI3PqBP6LoKk=;
        b=XiDxFg+far4dsB1g3OQiX6rBtvxN6EP1fpPnRY0wLARwpgASY3l9MHBh+Xr8ZgOmkn
         5Viwd5suIS5WeZajKYns305iYHB7x5VEgOtdcVWkoJTWqv7rk+M44aysjHpZQreiQzKp
         KwH7XvWcQhgTpSWNftG3ts0q67paAzT9BwKXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JcKJnC0FHcjS7424opn5LuymdcfOtC4HCsAk7mJdmYvh2BjQuNxKi0ZognV+mfjbgA
         D1P2VWXrNaKV4+EfPvBWhrf7YpKysygbi/qyxF3b/RqF7lP22OUlSuQtX/MBSXDBhTOH
         V4S+X0s4ih6Pd7UEiKQfMgNDLNSyPfv8pVn5o=
Received: by 10.142.242.8 with SMTP id p8mr5030724wfh.176.1220841136585;
        Sun, 07 Sep 2008 19:32:16 -0700 (PDT)
Received: by 10.142.225.6 with HTTP; Sun, 7 Sep 2008 19:32:16 -0700 (PDT)
In-Reply-To: <20080905145246.GA20537@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95206>

Hi,

The new protocol i mean is the network transfer protocol, like rsync.
Is the word "dumb protocol" you mean is the network transfer protocol
? But seem if i just implement a new protocol using jgit but not in C
(integrate with git core code), it may not worth because more of the
client using git core command line tool as git client.

Thank you ~

Regards,
Patrick

On Fri, Sep 5, 2008 at 10:52 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Mike Hommey <mh@glandium.org> wrote:
>> On Fri, Sep 05, 2008 at 05:22:57PM +0800, Sky Patrick wrote:
>> >
>> > If i want to write a new protocol for file transfer and would like to
>> > to integrate it with git. Is it possible and easy to integrate it ?
>> > Currently, i know that jgit may achieve it, but it is a Java
>> > implementation and may not work with git command line program that
>> > written in C.
>
> Writing a dumb protocol support isn't difficult in JGit due to the
> abstractions in place.  Its a little harder in C Git, unless Mike
> (or someone else) can abstract out the cURL library usage and make
> it more flexible.  Though these days cURL supports just about any
> file transfer protocol known.
>
>> First, it would depend if you need this new protocol to be a dumb
>> protocol (like rsync and http) or "native" (git or ssh).
>
> Writing a smart protocol is a PITA.  Look at the smart HTTP effort
> I am trying to do.  OK, I'm not spending a whole lot of time on
> it, but its a damn difficult thing to do well, and to keep simple
> enough that it can be described and reimplemented.  Otherwise we
> have another that-thing-before-Git on our hands.
>
>> I've been meaning to refactor the dumb protocol "stack" for a while, but
>> haven't gone much further than ideas in my mind (i.e. no code). I also
>> have some start of http code recfactoring, that is waiting for this dumb
>> protocol rework to be completed.
>
> Yea.  One reason why I'm doing the smart HTTP effort prototype in
> JGit is because the C code structure makes this harder to implement
> without first going through a number of refactorings.  Though for the
> smart HTTP stuff I really need to refactor fetch-pack/send-pack and
> upload-pack/receive-pack, not the dumb walkers.
>
> --
> Shawn.
>
