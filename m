From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: disallow fast-forwarding tags without --force
Date: Fri, 27 Aug 2010 20:21:01 -0500
Message-ID: <20100828012101.GB2004@burratino>
References: <1282893284-17829-1-git-send-email-cxreg@pobox.com>
 <7vfwy0hsn1.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1008271046080.20874@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 03:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpA8V-0003vX-7V
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 03:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab0H1BXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 21:23:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40726 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0H1BXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 21:23:03 -0400
Received: by gwj17 with SMTP id 17so1356158gwj.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xfEDqez3f+ht1XmqJrmSf7FZP111oPG3Gdrl9aUlAzg=;
        b=iwLZTUGC1bnSjHr+rKucz74XYpBlT2/KVEGN344rZeSUc2GoK7KgOY3ZHWBM6bauuN
         eH6s3Wk49t8C2RVsImA9pn/1TxRSrZbiqiNGgh0Q0elwyDJ96pMJIEmHJsa5tj+OUHKb
         Uq4bi5hEiNpORkB71Qw2wUGSCgqO03uqCNr0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XbP7k8on4ihl8b4rfyzRpBMuf9ls9+qE4BM2ogOXZePAlf0nTjSgZQQak0gNeBaWQF
         GDCZu30Ex38OdusQhNnw3hWZZnSrZ4W8XVpklqVRhUP1tD3AMy96168FYySzseGaRmv8
         YBoFvgHj9pAlTLiVoL0pj6wGuEe6wiC/IRyzk=
Received: by 10.100.33.14 with SMTP id g14mr1736284ang.180.1282958582008;
        Fri, 27 Aug 2010 18:23:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm7243395ann.20.2010.08.27.18.22.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 18:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008271046080.20874@narbuckle.genericorp.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154625>

Hi,

Dave Olszewski wrote:

> It's trivial for someone to update build software from "git push remote
> tag" to "git push remote +tag" or "git push -f remote tag", but I can
> understand your objection.

Right.  The thing to prevent is unhappy surprises: it is best if
users upgrading get a chance to update their scripts before it matters.

> It seems unlikely that many people are ever going to "flip on" this
> feature; either they won't know about it (and for them, it should be
> on), or they'll have a reason to move a tag, and want it off.

This is why a switch of some kind is useful: after reading the release
notes, a user can flip the switch for a glimpse of the future, forsee
the upcoming disaster, and fix everything up before it really matters.
After the default changes, the switch has the opposite purpose: users
who were not prepared can use it to turn back time and avoid having
to change their code.

So the deprecation process for unwanted features tends to look like
this:

 1. complain about use of the feature, with an option to suppress
    the warnings.  or: loudly proclaim that the feature is going
    away in release notes

 2. add an option to disable the feature, to help people transition

 3. change the default to true

 4. remove the option

Step 1 is the most important one imho.  See
Documentation/RelNotes-1.6.6.txt for an example.

I don't think we've ever reached step 4, but we should try it some
time.

Hope that helps,
Jonathan
