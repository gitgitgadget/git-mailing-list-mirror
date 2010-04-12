From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] remote-helpers: add tests for testgit helper
Date: Mon, 12 Apr 2010 09:24:28 -0500
Message-ID: <20100412142428.GA3839@progeny.tock>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
 <1269881309-19690-8-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KZ3-0000F1-1g
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab0DLOYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 10:24:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64725 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0DLOY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:24:29 -0400
Received: by pwj9 with SMTP id 9so4357889pwj.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NN7NFVDrhJTn9gF/f23Fi/7MMojjF/j4677coZTd1JU=;
        b=Z2/AdADXL5t/uE/vdsw1PRsMzKZk1gwFROJyIlHfZM1bF3XC2asbV24e9pxLCQfXh7
         cDDuqcdsQX7coeO1r4n7AtjV1Jioji4PeMA1Qd8IOOxrgQLIiYeteQVJPtWY7JIJjIbs
         nxKWykjuzN07cbFd7imR/iC4Uz7T+I/KmMQWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gbvcg47yygKqlbzsh6pI5PzkPOpfgiJlA9D5RDUvDr7du+P2Zmx5yY3A75MAAFEMtM
         bi88wf5HNdcd+OoQXHutg75V1dpcYCh1BsDBqFam3P20+gIKayu2JmEmvAtwIRlF6vBx
         MHf2lKa8l2QVMVwIGw1j5P9733ErB/BeaoxQE=
Received: by 10.141.108.19 with SMTP id k19mr3367131rvm.110.1271082267182;
        Mon, 12 Apr 2010 07:24:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 12sm618013pwi.11.2010.04.12.07.24.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 07:24:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269881309-19690-8-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144732>

Hi Sverre,

Sverre Rabbelier wrote:

>  t/t5800-remote-helpers.sh |   70 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 70 insertions(+), 0 deletions(-)
>  create mode 100755 t/t5800-remote-helpers.sh

Sorry I missed this before.  Maybe it would make sense to squash
something like this in.

-- 8< --
Subject: t5800: testgit helper requires Python support

git remote-testgit is written in Python.  In a NO_PYTHON build, tests
using it would fail, so skip them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5800-remote-helpers.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index eb31709..75a0163 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -7,6 +7,12 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PYTHON
+then
+	say 'skipping git remote-testgit tests: requires Python support'
+	test_done
+fi
+
 test_expect_success 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
-- 
1.7.0.4
