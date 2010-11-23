From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 12:02:50 -0600
Message-ID: <20101123180250.GF12113@burratino>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-2-git-send-email-kusmabite@gmail.com>
 <20101123174050.GB12113@burratino>
 <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 19:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKxD2-00050g-6s
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 19:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab0KWSC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 13:02:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62547 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab0KWSC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 13:02:57 -0500
Received: by fxm13 with SMTP id 13so4121782fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+BRQD8PTzRLaQpD79/QhCPu9eaVe2Y8l3pSHPB4nMXk=;
        b=LCRdX97xC4mSyTXPeelhJI17ySMyAWx0Z4/BthylCWZV1rMYXmxFPvdjze85Wq01Zk
         XcJRhKBKLIbNFLiBCcLLzvOe0xuxNRp484KKQ/DLzoLmxheXLQ37VFaW9DC7JKDkuL1y
         ayDGjPkQ9zWv/accPhudMHa6Ofu7ejctw4FQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hu9iGQLWYwgXbc/mHsX080mnSoudHAMv6ooR0vCe/OvPpRhzKhCGjc6OmL1rYp27W7
         NEZqXJZEbxMg52bGrLkWaVToElCAwBlzwbxRreTb0bv+9g7C7/Tl74Udzjrr4dE/kwOD
         VsYwpoEMeq3sakM3ZXksfAgoJW7ffE7vDS6KA=
Received: by 10.223.79.7 with SMTP id n7mr7024542fak.33.1290535375894;
        Tue, 23 Nov 2010 10:02:55 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j14sm1901066faa.47.2010.11.23.10.02.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:02:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162000>

Erik Faye-Lund wrote:

> The motivation is just to avoid having to deal with the error, like we
> do other places. It's not a big deal though. I could also set errno to
> ENOMEM and return NULL if that's preferable. I just don't see how it
> is.

I don't disagree; just fishing for a commit message. :)

> I also slightly dislike setting an error not listed in POSIX'
> documentation of opendir, even though it's probably allowed.

For future reference, here's what POSIX has to say.

	Implementations shall not generate a different error
	number from one required by this volume of
	POSIX.1-2008 for an error condition described in this
	volume of POSIX.1-2008, but may generate additional
	errors unless explicitly disallowed for a particular
	function.

So ENOMEM would have been allowed from that front.
