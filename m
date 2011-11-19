From: Scott Parrish <wsparrish@gmail.com>
Subject: Re: t/t1304: avoid -d option to setfacl (db82657)
Date: Sat, 19 Nov 2011 15:28:49 -0500
Message-ID: <D95BFEA0-BAC1-4CBD-8B56-27DB4BDF147C@gmail.com>
References: <gitster/git/commit/db826571e4099066fe44233d95642591016c831b@github.com> <gitster/git/commit/db826571e4099066fe44233d95642591016c831b/729354@github.com> <CA+sFfMc6BCPvk1FCjZwyY_pWqXBut3D--OfrFEcfK5p97D-KHQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: wsp 
	<reply+c-729354-3460aca0fa61e627f9d1a271cf70a99d5c1e7e4e-921167@reply.github.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrgO-0003Ks-6g
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab1KSU2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:28:53 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61180 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab1KSU2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:28:52 -0500
Received: by vcbfk1 with SMTP id fk1so4372641vcb.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        bh=Elrh52GUA4yxwgEYKKS38+JYX/zct6S/xM+EhdKnStc=;
        b=Jg6Hrkt6uI2aFdxY+p0dP3+MKp+ue4xRxFL2tef93JkaL045uOFBEh/QTNo6KxtSCZ
         b7MyyRn511xTpMiC66YFCTxECIs2c7fXHgvDzgjbbxH3WH3d8d5A+ZOsKpH0nGAOES2o
         w11jLch7z5PzjUmIMm7z4gsztvgtOdI8fT3dk=
Received: by 10.52.100.106 with SMTP id ex10mr8345684vdb.28.1321734532000;
        Sat, 19 Nov 2011 12:28:52 -0800 (PST)
Received: from [192.168.1.7] (cpe-065-190-200-190.nc.res.rr.com. [65.190.200.190])
        by mx.google.com with ESMTPS id r5sm6782352vdj.11.2011.11.19.12.28.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 12:28:51 -0800 (PST)
In-Reply-To: <CA+sFfMc6BCPvk1FCjZwyY_pWqXBut3D--OfrFEcfK5p97D-KHQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185707>

Hi Brandon,

Thanks for posting my question. I realized shortly after my post to github that I should have posted to the mailing list instead.


On Nov 18, 2011, at 12:37 AM, Brandon Casey wrote:

> [cc git@vger.kernel.org since that is the appropriate place for this discusion]
> 
> On Thu, Nov 17, 2011 at 8:59 PM, wsp
> <reply+c-729354-3460aca0fa61e627f9d1a271cf70a99d5c1e7e4e-921167@reply.github.com>
> wrote:
>> Could this test case be reviewed again? It fails on FreeBSD where the appropriate way to specify default ACL's is with the "-d" option. The "d[efault]:" syntax is invalid on FreeBSD.
> 
> Well, I'm not sure there is a right answer here.
> 
>   Linux accepts -d or "d[efault]"
>   Solaris only accepts "d[efault]"
>   FreeBSD only accepts -d
>   a quick search shows z/OS only accepts "d[efault]"
>   other?
> 
> I think most everything else rolls their own implementation into chmod
> or chacl or something like that.

OS X does indeed roll ACL management into chmod. The test passes there because the prereq isn't met (i.e. the setfacl command does not exist) and thus the tests are skipped.
> 
> The abandoned POSIX draft does actually specify the FreeBSD behavior.
> 
> So I think it's kind of a toss-up.  Which option we choose should
> probably depend on whether we get more test coverage by using the
> "d[efault]" notation or by using the -d option.  That depends on
> whether there are more Solaris users compiling git or whether there
> are more FreeBSD users.  I don't know the answer to that either.  I
> tend to think there are very few of either.

Is there a reason conditional logic can't be used (perhaps keying off of `uname -s` or the like) so that we have coverage in all cases?

-S

> 
> -Brandon
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
