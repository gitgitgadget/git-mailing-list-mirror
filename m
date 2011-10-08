From: Andrew McNabb <amcnabb@mcnabbs.org>
Subject: Re: unexpected behavior with `git log --skip filename`
Date: Fri, 7 Oct 2011 20:36:37 -0600
Message-ID: <20111008023637.GA18136@mcnabbs.org>
References: <20111007171503.GB16607@mcnabbs.org>
 <CAG+J_DwnUOeDTiUW-UUJGLLg8jJ4EhXN21B7o_hOMnyowM9a8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 04:36:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCMmK-0002NG-0R
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 04:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab1JHCgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 22:36:39 -0400
Received: from komodo.mcnabbs.org ([67.207.145.27]:33294 "EHLO
	mail.mcnabbs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab1JHCgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 22:36:39 -0400
Received: from maggie.mcnabbs.org (unknown [76.8.220.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mcnabbs.org (Postfix) with ESMTP id 73DB6BD825;
	Fri,  7 Oct 2011 21:36:38 -0500 (CDT)
Received: by maggie.mcnabbs.org (Postfix, from userid 1000)
	id A702C28D16; Fri,  7 Oct 2011 20:36:37 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <CAG+J_DwnUOeDTiUW-UUJGLLg8jJ4EhXN21B7o_hOMnyowM9a8g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183133>

On Fri, Oct 07, 2011 at 05:54:36PM -0400, Jay Soffian wrote:
> 
> Hmm:
> 
> $ git log --oneline GIT-VERSION-GEN | head -2
> 7f41b6bbe3 Post 1.7.7 first wave
> 703f05ad58 Git 1.7.7
> 
> $ git log --oneline --skip=1 -n 1 GIT-VERSION-GEN
> 703f05ad58 Git 1.7.7

I went back to reproduce this, and I think I may have been using the
--follow option earlier.  In my private repository, git log gives
identical output for the last two commits when I don't specify --skip:

$ git log -n 2 --oneline httpd.conf.orig
f0026e9 updated many of the *.orig files to the latest version
e57e840 moved the .orig files into place, too
$ git log --follow -n 2 --oneline httpd.conf.orig
f0026e9 updated many of the *.orig files to the latest version
e57e840 moved the .orig files into place, too
$

But when I specify --skip=1, the output is different:

$ git log -n 1 --skip=1 --oneline httpd.conf.orig
e57e840 moved the .orig files into place, too
$ git log --follow -n 1 --skip=1 --oneline httpd.conf.orig
f0026e9 updated many of the *.orig files to the latest version
$


GIT-VERSION-GEN example that you shared, I don't notice this difference.
It's not immediately obvious to me what's different between the two
examples.

--
Andrew McNabb
http://www.mcnabbs.org/andrew/
PGP Fingerprint: 8A17 B57C 6879 1863 DE55  8012 AB4D 6098 8826 6868
