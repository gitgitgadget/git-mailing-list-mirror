From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problem with git bundle creation
Date: Fri, 15 Oct 2010 11:52:56 -0500
Message-ID: <20101015165256.GB10204@burratino>
References: <AANLkTimsMgsuiS4iT2z_ggD8t0V9xj7ezwxRHk9WgaOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Fri Oct 15 18:56:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6naA-0008QW-Kr
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 18:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481Ab0JOQ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 12:56:30 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57437 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0JOQ43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 12:56:29 -0400
Received: by wwi14 with SMTP id 14so775987wwi.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zFTQi6G3KvnGFc4QUShJWX/RGikuIflVhY6RLZmk3Qw=;
        b=I7U1tvi1CRXQDkUd9lERx/9wpJv0QWepA7ecgx39MCujww98vie/zrtcu4GgBNHiOX
         an1UHN9vzUWgjb57cTdqUibAptgAfGTbfpSKuUwmxzF3tWCo+ly1QMrCUPCsgOjl7XRs
         8sPbD+fmYqHQ8p0AZO8U4xgwsxMnkKF+RIvdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lMml8z3zIsUeSep+T+uWTs1SAKUibkwK6Ad3bseyQd/HLxlrzXD3xdaslGDfOb4WXU
         wvqG/dc8QWvBY5J8d7PhNolAbLPqhfJpLGjqAriUkSpNQV7axrDKCvfCO/eMpEjCXye3
         ejHB1mnwvidPtiZ4J+05ETuDblf82WVjBTjcQ=
Received: by 10.227.145.149 with SMTP id d21mr1205093wbv.149.1287161785514;
        Fri, 15 Oct 2010 09:56:25 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id h29sm10804706wbc.9.2010.10.15.09.56.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 09:56:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimsMgsuiS4iT2z_ggD8t0V9xj7ezwxRHk9WgaOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159125>

Kris Shannon wrote:

> git clone git://github.com/freenet/fred-official.git
> git bundle create bad.gitbundle -1 build01194
> head -2 bad.gitbundle
> 
> Problem manifested by a commit message which happens to have a hyphen
> in just the wrong place such that git rev-list --boundary
> --pretty=oneline has a line which exceeds the 1024 buffer limit that
> git bundle is using for reading and happens to read in the rest of the
> commit messsage as a boundary commit.
> 
> git bundle should probably be checking that the fgets buffer actually
> ends in a newline and if it doesn't then slurp in more until it does
> (probably discarding it in the process)

Sounds like you've tracked down the problem.  Care to write a patch?
(Even a placeholder that die()s would be helpful if you don't have
time for the full proposed fix.)

Thanks for reporting.
Jonathan
