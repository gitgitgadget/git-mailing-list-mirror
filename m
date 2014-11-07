From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: git commit --only -- $path when $path already has staged content
Date: Fri, 7 Nov 2014 11:38:16 +0100
Message-ID: <545CA118.6040500@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 11:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmh1q-0002Bg-S4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 11:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbaKGKoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 05:44:24 -0500
Received: from mail96.atlas.de ([194.156.172.86]:33664 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbaKGKoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 05:44:21 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2014 05:44:20 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 2963210165
	for <git@vger.kernel.org>; Fri,  7 Nov 2014 11:38:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtNuRaOY6_Vp for <git@vger.kernel.org>;
	Fri,  7 Nov 2014 11:38:16 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri,  7 Nov 2014 11:38:16 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 81E4B27169
	for <git@vger.kernel.org>; Fri,  7 Nov 2014 11:38:16 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Fri, 7 Nov
 2014 11:38:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

The manpage of git commit reads:

  --only

      Make a commit only from the paths specified on the command line,
      disregarding any contents that have been staged so far. This is
      the default mode of operation of git commit if any paths are given
      on the command line, in which case this option can be omitted. [...]

But that seems to be only true for other content (i.e. other files not
specified in the command line).

If I do:

    # some repo with a file in it
    git init
    echo content >foo && git add foo && git commit -m foo

    # modify and stage a file
    echo other >> foo && git add foo

    # modify the same file even further but don't stage
    echo bar >> foo

    # commit with path specified on command line with explicit '--only'
    git commit --only -m'.' -- foo

    # but everything was commited
    git status -s
    <empty>

I would expect to only get the unstaged changes in the commit.
Could anyone shed some light, please?

Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Useless Invention: Camcorder with braile-encoded buttons.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
