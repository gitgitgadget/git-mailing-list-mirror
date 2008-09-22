From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Mon, 22 Sep 2008 14:18:10 +0400
Message-ID: <bb6f213e0809220318k7e505281n53a3948540869894@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <200809221201.35507.angavrilov@gmail.com>
	 <48D7554C.4020601@viscovery.net>
	 <200809221302.52424.angavrilov@gmail.com>
	 <48D762EC.2030009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 22 12:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhiW5-000254-Ob
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 12:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYIVKSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 06:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYIVKSM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 06:18:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:65389 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYIVKSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 06:18:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1316927fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AP4lA7qlvjpxG/9VN8UUejDUajVLVC76zsHbH9sloiY=;
        b=tQ9qjocX7W8lqMI+afnkYus8DaekbUSr0y1Eo9a4/XucB3I+972julHm0GO7HghVm6
         qvPkBu0MMUA2EZDqa4Tc97aH9lJs32Qm01QkzNNpvl/jRgHgRR7SBdOctAnGHkG21aDA
         U1r3Byo/13BDwblpq0/v7ZGrq7E5g76tuLg14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UupWWZDK4/hBLdABoI2MgGGMqwtj1EB4pGK1REQQ1WgGu4xkgI3fgyXVOnMn/8Q2KE
         FpQ4t6EkO6JRbSmtajkzu9mbypWmSu3C3MI2rkuxy3zvZmknAvC9uoZRYCqvAktbt8ws
         xyhuZNtQr1BCf47dQLUSMhlQaIIZarD6w9Uz0=
Received: by 10.103.170.13 with SMTP id x13mr2484613muo.52.1222078690240;
        Mon, 22 Sep 2008 03:18:10 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Mon, 22 Sep 2008 03:18:10 -0700 (PDT)
In-Reply-To: <48D762EC.2030009@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96470>

On Mon, Sep 22, 2008 at 1:18 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Alexander Gavrilov schrieb:
>> You can also try applying this patch (originally made for git-gui). It may save
>> additional 0.3 sec, especially for obscure legacy encodings.
>
> Is this about startup time? Personally, I don't care about 0.3 sec startup
> time. I close my primary gitk and git-gui Windows only once a week. ;-)

As encoding lookups are currently cached, all this discussion is about
the first viewing.

This patch addresses the time necessary to convert an arbitrary
encoding name to a name that is known to Tcl, or determine that it is
not supported. Without the patch it is done using a linear search
through a large table of aliases. In git-gui it caused a noticeable
delay before the Encoding submenu, which lists all available
encodings, was displayed.

Alexander
