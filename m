From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Thu, 17 Jul 2014 23:48:04 -0700
Message-ID: <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com> <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com> <20140718022208.GQ12427@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X81xl-0003Gm-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 08:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbaGRGsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 02:48:09 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57785 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbaGRGsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 02:48:08 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so4448708pdb.41
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 23:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=ra2ie5UmuWTXMGnnxA+U7EVEGY6DAPYNCw6zttGjAWo=;
        b=pGo45kpujEwVSgFDV9Kw+GpWJRqXsAKDkCw5fOR/w8kVKIZgXWfLdHa3x7FO3GmZns
         eGSkovvGaCaTikvVBSBPz12A3qdSeJZWFDTFHNmNo0+cBDYlqELafwoG5rcUFxtuRkQL
         MdVj4NHEckkC2GG2K3lUslZBCl+0bqTT9IP4Fmd28Dm3v6+E2aaYRu8E+ozRbJFbqM8h
         b2Wws5r2aPuyN1N5DTPvC/+PtOTSpLP9i2cppMNA12GKsDxukdOm6hhDUcLSIn7t1E1b
         dY+fvpElI+QNnCYOVe9vOIxJEte2mGfALTB8Re78D7/tI1768VBNqla5WFrwAHeqPrDG
         A5sw==
X-Received: by 10.70.36.7 with SMTP id m7mr2342723pdj.91.1405666087255;
        Thu, 17 Jul 2014 23:48:07 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mt1sm4527051pbb.31.2014.07.17.23.48.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 23:48:06 -0700 (PDT)
In-Reply-To: <20140718022208.GQ12427@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253796>

On Jul 17, 2014, at 19:22, Jonathan Nieder wrote:

> Thanks for these details.  I'll file a bug and mull it over some more.
>
> RFC 6762 makes it clear that what the package is currently doing is
> wrong.  Given that Debian's libc knows nothing about mdns on its own,
> I think I'll need to parse resolv.conf (that's what libc-ares does).

You might also want to take a look at [1] which suggests that when  
doing SRV lookups for URLs they should be done regardless of whether  
or not a port number is present (which then eliminates the RFC 3986  
issue the current SRV lookup code has).  It's only a draft (and  
expired now and looks like it received a rather chilly reception from  
some), but I haven't noticed anything else that addresses what the  
patch code is trying to do.  The thread at [2] is related to what the  
patch is trying to do.

[1] http://tools.ietf.org/html/draft-ohta-urlsrv
[2] http://www.ietf.org/mail-archive/web/pcp/current/msg01727.html
