From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] make git installation footprint smaller
Date: Fri, 23 Jul 2010 21:31:45 -0500
Message-ID: <20100724023145.GH13670@burratino>
References: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jul 24 04:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcUXk-0001Uq-5P
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 04:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab0GXCcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 22:32:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35396 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0GXCcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 22:32:45 -0400
Received: by iwn7 with SMTP id 7so801308iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=taIz/XJ+1nAKFqRStUHvoUn1zoH4WKnbl16lm5fss0w=;
        b=Y4fq9eX+Sd2uc11KrmSqTc/njG6lqKaUlc+ZeSwuwkND14Y8cddd2Z8fEHGkNpvplp
         WtJl6oVidgeVjm2yXiQVrfOqSGI4lzms7eATNR/NOl/QB1TbS/3iP6Tcr3BgVLXC9hxi
         l4LeBc80P7OTNH29c4VORla2nx/bUokVS9jc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O4MHpi2fFnkj9lpDcge1zJspOEban3JfhjeKJU/e0gFilbZOO3H3KSDnt7WYuFrxKF
         IhaXpHx2tQO7vIEOFtghGViwSCwkXZCgMoTEoNq+k3J/pMuSiDBORIGdeOjUUfWGeFxk
         2sL5cdyzLtMOmigBU/jDWxwXBV/gz4YA8Gdy4=
Received: by 10.231.32.200 with SMTP id e8mr4574922ibd.66.1279938764896;
        Fri, 23 Jul 2010 19:32:44 -0700 (PDT)
Received: from burratino ([64.134.164.56])
        by mx.google.com with ESMTPS id r3sm832312ibk.19.2010.07.23.19.32.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 19:32:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151599>

Brandon Casey wrote:

> Brandon Casey (2):
>   Makefile: link builtins residing in bin directory to main git binary
>     too
>   Makefile: make hard/symbolic links for non-builtins too

So in the end, the hardlink-forming step has four steps:

1. (if bindir != libexecdir and NO_CROSS_DIRECTORY_HARDLINKS is unset)
   Files in libexecdir with cousins in bindir are replaced by
   hardlinks to their cousins. (patch 2)

2. Any builtins in bindir are replaced by
   hardlinks, symlinks, or copies of git.

3. Any builtins in libexecdir are replaced by
   hardlinks, symlinks, or copies of git.

4. git-remote-{ftp,http, etc} are replaced by
   hardlinks, symlinks, or of git-remote-http.

Looks good to me.

Thanks for the pleasant read,
Jonathan
