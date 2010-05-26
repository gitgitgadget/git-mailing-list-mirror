From: James Tucker <jftucker@gmail.com>
Subject: bug with 'cl' as alias for 'clone'
Date: Wed, 26 May 2010 09:48:25 -0300
Message-ID: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 14:48:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHG2H-0002nd-SW
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 14:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab0EZMsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 08:48:32 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:43841 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0EZMs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 08:48:29 -0400
Received: by qyk13 with SMTP id 13so9015750qyk.1
        for <git@vger.kernel.org>; Wed, 26 May 2010 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=Cyxw1qaAZl9ucpY+Xe19VxIXsP/iI340ZLdl5/PMHEY=;
        b=hlUQdLayJ4MNGUEuMDE3sSmOCS4sa+SsOBFligtWQnuxXuWG/sdQ1OGoTx8nxDcpkW
         Wf53U3CEVUvAGija4LLAIXrECqq/xQt3FJGIwm0WWRttQK7Iau2FWp/WvIlePUOnRY/a
         bw5zE+UenTM1MYWQSqd7viFcGw3SbClQMiZ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=nGjwDNsuhQoyv4MbXpgZkQPvloyKUBgkYy3WRIx4c6n1Mr7sObUNsuwsB/JU+n4yU4
         T38iRcsm4iLO9s7v88MTBnRGVxZlxndoT1LxPK9fvpcaoYamSXYhUzlFPrQtvCuF9NMN
         +cybj/6Tyh8RcrOBwna7tQqiTLg0GepIw28QM=
Received: by 10.224.29.208 with SMTP id r16mr4065199qac.212.1274878108754;
        Wed, 26 May 2010 05:48:28 -0700 (PDT)
Received: from [192.168.2.111] ([199.172.208.176])
        by mx.google.com with ESMTPS id 6sm222294qwd.13.2010.05.26.05.48.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 05:48:27 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147793>

I've been running the following aliases for a long time now:

alias g='git' # in bash

% cat ~/.gitconfig | grep clone
  cl = clone

This appears to still be calling the right UI command:

% g cl
You must specify a repository to clone.
...

But when I try to actually clone a repository:

% ls rdbi
ls: rdbi: No such file or directory
% g cl http://github.com/erikh/rdbi.git
fatal: cannot set work tree after initialization
* ls -la rdbi/
total 0
drwxr-xr-x    2 raggi  staff    68 26 May 09:46 .
drwxr-xr-x  251 raggi  staff  8534 26 May 09:46 ..

So then, I try it with 'clone' instead of 'cl', and it works (after removing the dead initialized repo in ./rdbi):

* rm -rf rdbi/
% g clone http://github.com/erikh/rdbi.git
Initialized empty Git repository in ...

I could look into this later on when I'm not at $work, but as I have no knowledge of the UI internals, it'd be great if someone in the know could track this down.

Thanks in advance,

James