From: Yichao Yu <yyc1992@gmail.com>
Subject: Re: Remote hung up during `git fetch`
Date: Thu, 22 Nov 2012 15:09:22 -0500
Message-ID: <CAMvDr+RBL2RDeSUjQ=GeRfX-g4WqmdrOWDCYSem=ELMXXuf3mA@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
 <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
 <CAJo=hJveYb09uhZWsKWKYor5Jcuz+wZ40F3wnsR3Hy8bcxeb6g@mail.gmail.com>
 <CAMvDr+Rv6Krmjto6nQL18GnEj-+qCFPYgp7jDQnLs-ybamM0FA@mail.gmail.com> <CAJo=hJs5PwLxwtBoYb+ZLmY=ts9U=UhDPmKXW7KY2BFNpBJfDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbd62-0005Ed-TO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab2KVUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 15:09:46 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:50616 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab2KVUJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 15:09:43 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so6031072iay.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0EismuFb+nwNJi3v3mfMLaIrYjCwAn1HbMqvAdk7xvA=;
        b=QOy5P6hAEI3YUTUBg/IRqh8c/vp5cRw9WxjwkWAFeNejxsCoMxsLWTasG5WABByU2W
         x68CLSPXsLG9tS0IZkywCH80xaWySwvvBkOU6Azfv9JXqpUJb4b+7hVs3aolITxI1MaK
         GcOnTLT6pZJ3NMdIgMG4pnLUevWzLAkiMw3PQbBGjzsnLMfokOxK6l47XFtlRtZFt3b1
         GLrac/DGxSvAzlyXgvxK9S7aH5Er4Q6vP6cTl11Nu/AcXLjq7rSqxVp37qnDRl6BQt1N
         gfnCXcdGmgaSjzK6FNDewWZV4rSf2CJcdjZGBcIzJwR1SRnFwEBZzef9a4PA+igOmAZX
         eYeQ==
Received: by 10.50.152.236 with SMTP id vb12mr1620107igb.15.1353614982663;
 Thu, 22 Nov 2012 12:09:42 -0800 (PST)
Received: by 10.64.15.165 with HTTP; Thu, 22 Nov 2012 12:09:22 -0800 (PST)
In-Reply-To: <CAJo=hJs5PwLxwtBoYb+ZLmY=ts9U=UhDPmKXW7KY2BFNpBJfDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210207>

On Thu, Nov 22, 2012 at 2:52 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Thu, Nov 22, 2012 at 11:44 AM, Yichao Yu <yyc1992@gmail.com> wrote:
>>> US holiday today? The list traffic tends to be down during holidays.
>> This silent?.... 0 email from the kernel mailing list for 10+ hours?..
>> anyway.... nvm...
>
> Check your spam filters? I am having no trouble getting email for the
> Git list. Traffic is down, but there have been several messages within
> the past 4 hours. E.g. this thread among them.

My spam filter is fine (they are not in spam...)... probably gmail
just failed to send to / receive from vger.kernel.org for the last
several hours (or sth similar...)....

>
>> packet:        fetch> want 2d242fb3fc19fc9ba046accdd9210be8b9913f64
>> multi_ack_detailed side-band-64k thin-pack ofs-delta
>> packet:        fetch> shallow 65546ab097b023886a60df4cbc931d4cc362b98e
>> packet:        fetch> shallow b80d60e1c3854460a1f01d4110da5ae98f30f9b2
>> packet:        fetch> 0000
>
> I think this is the problem. Your client told the sever it has the
> Linux kernel shallow cloned, but its talking to a repository that
> hosts git.git. The remote server doesn't know these two SHA-1s
> mentioned on the shallow line, as they are from the Linux kernel
> repository, so the server just hung up on you.
I C. So in my real case it is probably because the different server I
am pulling from are on different branches.... (for a shallow clone, it
may look the same with commits from different projects?...)

>
> Basically this is an unsupported use case. A shallow repository can
> only fetch from the place it cloned from. Anything else working is
> pure luck. It _may_ be able to fetch from a clone of that same
> repository at another server, if the clone has at least all of the
> commits the client already has. If the remote clone is missing commits
> (as in this case where it has none!) then it doesn't work.

So is there a way to ask for a certain commit from a certain server
and update local files that has changed accordingly? For the server,
it shouldn't be much different from another shallow clone (although it
would be better if locally existing objects are not transferred.). But
I am wondering what client side command/script do I need to use.


THX.
