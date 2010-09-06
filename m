From: Artur Skawina <art.08.09@gmail.com>
Subject: remote-helpers: The lost verbosity level
Date: Mon, 06 Sep 2010 17:24:19 +0200
Message-ID: <4C8507A3.5050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 17:24:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsdYk-0002PD-G4
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 17:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab0IFPYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 11:24:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51439 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0IFPYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 11:24:32 -0400
Received: by bwz11 with SMTP id 11so3375219bwz.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=H3SF0yI1WazUKkvNeFun5FBj+DHhXfWL+Q2yuFL/EZU=;
        b=iJVmdSzWNIxHQFNylGy1xdf6n5hklSerM3MMt4Dpbs2t+VsT0slpf6ERUKcY4YNsOz
         vgF3Cbi3YhObbD0ZQeHu2KSOrCrsHDBZzJcrjvMbt4mJDftiD44nONpOB0a8XlnQjpKa
         fnEmvwS7daFRm+m9zZlE8G2tvA5wvjjbr6PQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=IljANd8vT5Cmp9+OGVU4BCt/Vn5rSvtamjzM9hvMfzvFFkIPMBgmf/96nq35GeTU5v
         KzUiMozafy1qIlbgu+vV8wi6Jtyx4ruDrwhz7HvHV4DNdSbj2+i3U8Xj/nce8lvP7OSf
         O1cHvq8IvZwqHU3FrmaDqnhw4DjMOfZTVDqQY=
Received: by 10.204.27.20 with SMTP id g20mr3278261bkc.114.1283786671454;
        Mon, 06 Sep 2010 08:24:31 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-25-146.multimo.pl [94.42.25.146])
        by mx.google.com with ESMTPS id f18sm4401787bkf.15.2010.09.06.08.24.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 08:24:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155576>

Tried turning on more debugging in my new remote-helper and was surprised by this:

$ git fetch -q swarm://address blah
I= "option verbosity 0"
$ git fetch swarm://address blah
I= "option verbosity 1"
$ git fetch -v swarm://address blah
I= "option verbosity 1"
$ git fetch -vv swarm://address blah
I= "option verbosity 3"
$ git fetch -vvv swarm://address blah
I= "option verbosity 4"
# etc 

$ git --version
git version 1.7.2.1

IOW the '-v' case is undetectable. Presumably an off-by-one check somewhere,
and not part of ABI cause some existing helper depends on this behavior? ;)

artur
