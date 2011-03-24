From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [RFD] git update-index --remove frotz --add frotz expected behaviour?
Date: Thu, 24 Mar 2011 18:07:57 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D8B7A6D.5050801@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 18:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2o1A-0001Xo-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933931Ab1CXRIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:08:06 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:43421 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab1CXRIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:08:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 258A71B4BA2;
	Thu, 24 Mar 2011 18:08:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fy4Tay33PMR; Thu, 24 Mar 2011 18:07:57 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id B4B641B4A90;
	Thu, 24 Mar 2011 18:07:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169927>

I'm a bit stumped by update-index' behaviour when calling --remove and 
--add on the same file in that order:

$ touch frotz
$ git update-index --add frotz
$ rm frotz
$ git status -s
AD frotz
$ git update-index --remove frotz --add frotz
$ echo $?
0
$ git status -s
$

Notice that update-index doesn't complain that I'm trying to add a file 
that doesn't exist, and it's returning with 0.

Is this expected behaviour? Shouldn't I get some sort of error message 
telling me that I'm trying to add a file I've just removed? Compare:

$ touch xyzzy
$ git update-index --add xyzzy
$ rm xyzzy
$ git update-index --remove xyzzy
$ git update-index --add xyzzy
error: xyzzy: does not exist and --remove not passed
fatal: Unable to process path xyzzy

Can anyone explain this to me?
