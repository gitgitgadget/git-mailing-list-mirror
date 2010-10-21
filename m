From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 15:39:26 -0500
Message-ID: <20101021203926.GB12685@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <AANLkTikJXaqDH6vJzPna7txssMO67SxmVy_Nvu2SW46W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>, matled@gmx.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91yp-0007PO-MC
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab0JUUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:43:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52527 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab0JUUnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:43:14 -0400
Received: by ewy7 with SMTP id 7so137470ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WBgJKFmSvOsYp/MKKDsW2Lf5UAT4EmDsw/MKiXC7a6E=;
        b=u5NEd2mv0KNOx6NOuhuZg9TmLD2NyNMAx6rpPlwxKSn9OXY4q2bwYybvHIHO2Lz+r+
         Z9dPYGPsj5d8xgh2xlKSWy9m0u/MeOHy8zGifTvGeAdEu7w398fx2yPzhaJdJMUWi/E9
         77A57BYYM7qc3M80tRPGACvXVzRHJfGxyYkQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JhpExuw11eBOmi6OpVb81WUb7Z8WU3qTo+N6SJUC4eDpfL1KnN4qvyHXFxmi9tYtOu
         gFX+dH2mxKU1KWRUkv+pp0AWs543sEJAG4bjEqrQ/pgxCArlxnHnVrUXZHLy3ave43lD
         5H/4/ImnsUjZobLTwiusmCDCNHgYWCtAH4+30=
Received: by 10.14.119.197 with SMTP id n45mr1296736eeh.38.1287693792834;
        Thu, 21 Oct 2010 13:43:12 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q58sm2252168eeh.9.2010.10.21.13.43.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikJXaqDH6vJzPna7txssMO67SxmVy_Nvu2SW46W@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159564>

Erik Faye-Lund wrote:

> I understand that it might be beneficial in the --detach code-path,
> but how can stdint, stdout or stderr be closed in this code-path?

Maybe "git daemon >&- 2>&-"?

In some situations involving setuid programs, this kind of thing
can be a security problem (since fd 1 is not taken, the first open()
uses that fd, so output intended for stdout goes to that file).
