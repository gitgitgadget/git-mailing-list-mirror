From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [msysGit] Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 18:26:25 +0200
Message-ID: <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
	 <4A8EA53B.9080809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeWwl-0004yX-RR
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 18:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbZHUQ00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 12:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbZHUQ00
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 12:26:26 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54342 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZHUQ0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 12:26:25 -0400
Received: by ewy3 with SMTP id 3so774376ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MSBNKdm+V4CJag4lkm3yMbJDO1m8TShZONhRnJW1Du0=;
        b=Ja1Te71dMmNCOjN/RwSoWpVDDj7GzTZCeQMiA/R/unWoDYzHF0ku/tYDTRSIHOW7aZ
         Ch9AiPsgSlKHA6Sxj7+kqi5xLXz8x1UYbOukibyEqRexioaPEsjY9+SJk85DRkEHCWtR
         AA/+oIaFhDlVm3fum9xATZJ35WGlWpths9Ao4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aQ4p3//GOjPeA0praYmhUwanuyh8wmCGY5Huwaa1Z+Fo0/c0OF3Ztv8PDhmEiEQKPc
         MJLmA+HbVhPAzf0hD3AKbuSb6uX7R0JDbardjR3Z5qvjA4SgDAt6jf44NViffEsTXGX+
         9RJFYSTlPUCPR1uaTuN1dZ9xwa8ZngUtv9Zg8=
Received: by 10.216.91.82 with SMTP id g60mr239168wef.74.1250871986014; Fri, 
	21 Aug 2009 09:26:26 -0700 (PDT)
In-Reply-To: <4A8EA53B.9080809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126735>

> MSVC compiles regex.c, so it must handle it. I'm fine with that.

msvc supports alloca, but regex.c doesn't make use of it per default
(you must define HAVE_ALLOCA_H in order to use it). basically _alloca
is fine for that task, but be aware that error handling on windows is
a bit compilicated. when _alloca fails it throws a structured
exception, you must reset the stack and use traditional memory
allocation as fallback. see
http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx. :-)

janos
