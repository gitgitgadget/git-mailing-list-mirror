From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Sat, 25 Apr 2009 16:13:07 +0400
Message-ID: <20090425121307.GA20459@dpotapov.dyndns.org>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 14:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxgmj-0001mu-9K
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 14:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbZDYMNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbZDYMNf
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 08:13:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7214 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZDYMNe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 08:13:34 -0400
Received: by fg-out-1718.google.com with SMTP id 16so316782fgg.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NNel6FU+g16CLz/B2tDt2gq3F0uSNql0HVQovoWQZ18=;
        b=gkQemGRXcSLd8PfW2Xbp1JxIhMPaH4fdzsmwhmhaYm4+Zn10QpVrxTxUAR6mWOLH+i
         D8VGS4hCPQDKVklai6y0pESt9rIy3FgUVZM4zDH/ptJvd5IchCfzJVdCThxAABMIL7x/
         9EDPnFHuVtsH49Ovq15HK5esItZyPce1JLZqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jAbs8cR3LFXrpjKyJihqApZ3JHSVewypGp3TJWSjgap1Ycj99nuSPxSIo6jwOyrnep
         obhhAhSQ6f037K1ByrlQyr9LEI14I8DWrAvjLBvXXBjH+LYjz/S+eyCl9qc8HN/fSXzo
         /UeMvJJ2jiud0rIniWoLB/BzkKDgL2hAjiBEY=
Received: by 10.86.82.6 with SMTP id f6mr1595062fgb.79.1240661613351;
        Sat, 25 Apr 2009 05:13:33 -0700 (PDT)
Received: from localhost (ppp91-77-224-226.pppoe.mtu-net.ru [91.77.224.226])
        by mx.google.com with ESMTPS id d6sm2617691fga.17.2009.04.25.05.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Apr 2009 05:13:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117553>

On Fri, Apr 24, 2009 at 04:49:34PM +0200, Michael J Gruber wrote:
> Replace sha1 by SHA-1 with the following exceptions:

I seriously doubt that mentioning any particular hash algorithm (which
is implementation detail) in so many places make much sense.  IMHO, it
would be much better to use some general name as hash-id or something.

Besides, mentioning SHA-1 may lead to confusion. Take a look at the
following text:

> @@ -164,10 +164,10 @@ Using --cacheinfo or --info-only
>  current working directory.  This is useful for minimum-checkout
>  merging.
>  
> -To pretend you have a file with mode and sha1 at path, say:
> +To pretend you have a file with mode and SHA-1 at path, say:
>  
>  ----------------
> -$ git update-index --cacheinfo mode sha1 path
> +$ git update-index --cacheinfo mode SHA-1 path
>  ----------------

This is incorrect, and here is why:

$ touch empty
$ git hash-object empty
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
$ sha1sum empty
da39a3ee5e6b4b0d3255bfef95601890afd80709  empty

What should be given to git update-index is the hash produced by git
hash-object and NOT SHA-1 of the file. (Yes, git hash-object does use
SHA-1, but I seriously doubt that any Git user needs to know how git
hash-object calculates the hash.)

So, I hardly see how a mechanical replacement of sha1 with SHA-1 can be
any improvement. While, at least, sha1 can be interpreted as SHA-1 based
hash value returned by git-hash-object, your patch only enforces the
misconception that we are dealing with SHA-1 of the file here.


Dmitry
