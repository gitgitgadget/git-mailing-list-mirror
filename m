From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 02/19] tests: add tests for the bash prompt functions
 in the completion script
Date: Thu, 10 May 2012 08:09:08 +0200
Message-ID: <4FAB5B84.5050201@viscovery.net>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-3-git-send-email-szeder@ira.uka.de> <4FAA25A7.4020300@viscovery.net> <7vzk9hrzwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 08:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMYw-0005LJ-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab2EJGJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:09:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60874 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944Ab2EJGJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:09:13 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SSMYn-0008V2-9U; Thu, 10 May 2012 08:09:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E62D51660F;
	Thu, 10 May 2012 08:09:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vzk9hrzwf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197545>

Am 5/9/2012 20:08, schrieb Junio C Hamano:
> Would it be possible to arrange so that $TRASH_DIRECTORY, $TEST_DIRECTORY
> and $PWD are set to c:/dir style paths in Windows environment?  What would
> we break if we did so?

I don't think that this is possible. The POSIX emulation in MSYS (or bash,
dunno) always converts to POSIX style:

> bash -c "cd c:/temp; PWD=$(pwd -W); echo $PWD; cd $PWD; pwd; echo $PWD"
c:/temp
/c/temp
/c/temp

That is, even if I use Windows style path to chdir around, the result is
POSIX style.

> The other direction of changing the Windows port of git to produce /c/dir
> style paths would probably not work, as it would involve ripping out the
> path mangling feature of bash in MSYS, which is done for some reason, I
> presume.

Doing that is certainly not something that I would be prepared to do just
to make the bash prompt work right ;-) And the added maintainance burden
incurred by the status quo is certainly much cheaper than yet another fork
of MSYS and/or bash.

-- Hannes
