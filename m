From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: XML parsing error from gitweb at freedesktop.org
Date: Thu, 6 Dec 2007 23:11:32 +0100
Message-ID: <8c5c35580712061411k7a40a08el35f31c43add25cb3@mail.gmail.com>
References: <799406d60712061334q33d2dba5r5496ba21069a4547@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Mercer" <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 23:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Owo-0006mg-7T
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 23:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbXLFWLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 17:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXLFWLg
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 17:11:36 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:6843 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbXLFWLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 17:11:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so906308wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rZF5Nvoht3CGjg+AYMtliT7VfyB3KeoFdQ4tkOTjP3A=;
        b=Qs2T9raMHmRV1u452Hx9kJ3I+h8TbSI9CA3Ers9GmeFEiVpEJlQ1i0uoslbCY51NJEFNx00VseUrdLDCJOMtm77z5ob5DXd5PUa9DY8cYcoXoQ57NazoM/FVPmFwFBE41KbljmFYWNfWfnTmsaY8eUizpXPp4IDy8JuoQ+uzAwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JyaFAwrUvz1n6I+YZcZnEO49N77NVGDb3qcFAbqqdE5yv47DmvfihdtZmrZPo69apmk6/TpMQcNAu7ZGySGvhHz5w9RcicIoIfulUSBBomdmKjK7Jk8lAVEcd6lCcCW1AVe5eCWPAOlmP/ZzQxDm6YsgLvFrwwcgb0PkM3vUZd4=
Received: by 10.115.79.1 with SMTP id g1mr2244315wal.1196979092821;
        Thu, 06 Dec 2007 14:11:32 -0800 (PST)
Received: by 10.114.234.1 with HTTP; Thu, 6 Dec 2007 14:11:32 -0800 (PST)
In-Reply-To: <799406d60712061334q33d2dba5r5496ba21069a4547@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67345>

On Dec 6, 2007 10:34 PM, Adam Mercer <ramercer@gmail.com> wrote:
> as cgit displays the commit OK
>
> <http://cgit.freedesktop.org/xorg/xserver/commit/?h=xorg-server-1.2-apple&id=48e6a75fbdd0fee86e364f02ace83f20b312a2b2>
>
> leads me to think that the problem lies in gitweb.  Could this be a
> problem with gitweb?
>

Actually, it's a problem in both cgit and gitweb, but you need to look
a bit harder to find the error in cgit. It seems that gitweb on
freedesktop.org doesn't detect a file rename (due to diff.renamelimit
maybe?), so it shows the full source of the offending files, while in
cgit you'll need to go from the diff to either the old or the new
sourcefile to get the same error:

http://cgit.freedesktop.org/xorg/xserver/tree/hw/darwin/quartz/applewmExt.h?h=xorg-server-1.2-apple&id=141f69dc3d8d6e7d8ff65607f43700ac11243041
http://cgit.freedesktop.org/xorg/xserver/diff/hw/xquartz/applewm.c?h=xorg-server-1.2-apple&id=48e6a75fbdd0fee86e364f02ace83f20b312a2b2

The problem is a number of unencoded ascii char 12.

--
larsh
