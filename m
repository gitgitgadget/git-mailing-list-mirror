From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4] Test fsck a bit harder
Date: Sat, 21 Feb 2009 20:21:37 +0100
Message-ID: <200902212021.37807.j6t@kdbg.org>
References: <499F12BF.4080405@kdbg.org> <5d214c5180b20fa90d76cf0c2f064a14be1fb195.1235213803.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaxRm-0004Jm-Pw
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbZBUTVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbZBUTVo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:21:44 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:42693 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758AbZBUTVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:21:43 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E363CDF8B;
	Sat, 21 Feb 2009 20:21:39 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AE2D51D163;
	Sat, 21 Feb 2009 20:21:38 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <5d214c5180b20fa90d76cf0c2f064a14be1fb195.1235213803.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110973>

On Samstag, 21. Februar 2009, Thomas Rast wrote:
> I changed the tests
> to use
>
> 	test_must_fail git fsck 2>&1 | tee out
>
> instead, which both checks the exit status and makes the tests more
> verbose with -v.

This is wrong: It does not test the exist status. In a pipeline, the shell 
looks only at the exit status of the last command. You really want this as

 	test_must_fail git fsck >out 2>&1 &&

If you want to have it more verbose, add 'cat out &&'. But IMHO that is 
overengineered. If the test detects a regression in the future, it is easy to 
inspect the file out if necessary.

-- Hannes
