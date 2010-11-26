From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 15:43:25 -0600
Message-ID: <20101126214325.GC23462@burratino>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
 <4CEE2060.4020507@drmicha.warpmail.net>
 <AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Cory Fields <FOSS@AtlasTechnologiesInc.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 23:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM6Ku-0004ZA-P4
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 23:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0KZWAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 17:00:00 -0500
Received: from mail-yx0-f194.google.com ([209.85.213.194]:54806 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0KZV77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 16:59:59 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2010 16:59:59 EST
Received: by yxg6 with SMTP id 6so1798898yxg.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WxH5BzXOPm0ijZi8u90a6UYVyrBZQPC6bTubPdNRhp4=;
        b=ATpwkjSmRlO/UinwD6WittC81usgg6eNDZvY6dlX2EqXRXLwrxXbz65msD5XqWHAuW
         vdSc9mNAvT0xSvQOUBsEG4b6A+7waDaNgDfdMJK/hbHzBXJSdSgkokaJj2tJp7NJKQWz
         StJGr/VcZ+AUawowm5mSj88C2sp/LDUxc3Dqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iZ8LcGPi05DyMHGuYBWjs8sgcNjGqXOsgS/VtP08+PiyexTQL2HgdZ6c+B7nbZ0MEB
         nBxeJQDa8kKA4t0TDgu9r3/GGvXpEHzkbbKn+XUbE7sUv/+RqKkeUwQpj0pDZtSXRJRm
         5e7Evhf5q0J9g4vE2agmYwzmigP1ZHEzimcdY=
Received: by 10.151.103.13 with SMTP id f13mr5812710ybm.218.1290807812293;
        Fri, 26 Nov 2010 13:43:32 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.sbcglobal.net [68.255.101.216])
        by mx.google.com with ESMTPS id y29sm1501954yhc.0.2010.11.26.13.43.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 13:43:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162280>

Hi Cory,

Cory Fields wrote:

> I realize that allowing replacements to be pushed "behind users backs", so
> I guess not respecting it makes sense.
>
> But is there no way that I can pull this off without rewriting hashes?

The usual way to accomplish what you are talking about would be like
this:

 Real history
 ------------
 4' --- 5 --- 6

 1 --- 2 --- 3 --- 4

 Fake history
 ------------
 1 --- 2 --- 3 --- 4 --- 5 --- 6

 Replacement ref
 ---------------
 4' --> 4

This way, a person a person can fetch either piece of real history
without trouble, and if they fetch the replacement ref, too, the
history is pasted together.

It is not possible in git to push a commit without its ancestors;
replacement refs do not change that.  However, it is sort of possible
to fetch a commit without its ancestors using the --depth option to
clone and fetch.

Hope that helps,
Jonathan
