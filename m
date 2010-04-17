From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: GIT Performance question
Date: Sat, 17 Apr 2010 14:40:37 +0400
Message-ID: <20100417104037.GA20631@dpotapov.dyndns.org>
References: <1271498149921-4917066.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 12:40:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O35SA-0001iO-My
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 12:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0DQKkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 06:40:42 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:36110 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab0DQKkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 06:40:41 -0400
Received: by bwz25 with SMTP id 25so3926425bwz.28
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GabhwEKglgamm4VJePQbHLSGGQ3EqNhCYsQRu26J+oQ=;
        b=voXStQqU+NywTw/69YdTZdBQF1/nEBWRmpa5KGNVZaPZM/4zU7pR8W5LIEUKE+XJEs
         9/3P5CoE46I4fJ8IKicj2imS0qlimrkViYlKZMbDrp+ukrbPlKlw0I8ggDSYPeFICq8Q
         nv1l7DD5dD+p+uabfnJlhd2gfNHWeQ40r+Adg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xYEm43mT0BrC4BCfpNzuq8KcNJoKmgRWIsElpDuMf9tGuUYEZbk+u1ECf1XJidofTY
         vNk4NAD4mkpvDxKnv78Qwv8a0iPo1q/D67uUvvCBp/WIayYw1qOJgcmEDCy77EdyOGeL
         efZD/yK3d2aJh8oJrDvBRQt/MfLXso4WgyHkQ=
Received: by 10.204.73.149 with SMTP id q21mr2677844bkj.57.1271500839651;
        Sat, 17 Apr 2010 03:40:39 -0700 (PDT)
Received: from localhost (ppp85-141-233-62.pppoe.mtu-net.ru [85.141.233.62])
        by mx.google.com with ESMTPS id 16sm2275913bwz.13.2010.04.17.03.40.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 03:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271498149921-4917066.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145131>

On Sat, Apr 17, 2010 at 01:55:49AM -0800, santos2010 wrote:
> 
> I read that GIT doesn't use deltas, it uses snapshots. My question is: how
> could GIT have high performance (most of the users say that) if for
> synchronization (pull/push command) with e.g. a shared repository GIT
> transfers all modified files (and references) instead of the respective
> deltas? 

Well, Git _does_ use deltas for storage and synchronization, but this
deltas are unrelated to history of changes stored in the repository. So,
conceptually, Git just stores snapshots, but files in those snapshots
are deltified against some old files based on some heuristic of finding
similar files, which allows Git to create deltas not only to previous
version of the same file (which most VCSes do), but potentially to any
file stored in the repository if it similar enough. So, typically, Git
has the most compact storage comparing to other VCSes, in particular, in
case of complex history with a lot of branches and merges.


Dmitry
