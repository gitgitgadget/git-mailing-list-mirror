From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 12:23:04 +0200
Message-ID: <482ABD88.30103@viscovery.net>
References: <482A7CA0.9060908@facebook.com> <alpine.DEB.1.00.0805140903560.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Wed May 14 12:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwE9U-0005K4-76
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 12:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYENKXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 06:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYENKXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 06:23:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62887 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYENKXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 06:23:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JwE8W-0003xX-Qj; Wed, 14 May 2008 12:23:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95EDBAFCC; Wed, 14 May 2008 12:23:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0805140903560.30431@racer>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82093>

Johannes Schindelin schrieb:
> On Tue, 13 May 2008, David Reiss wrote:
>> diff --git a/setup.c b/setup.c
>> index c54f2b6..d7d986c 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -359,10 +359,11 @@ const char *read_gitfile_gently(const char *path)
>>  const char *setup_git_directory_gently(int *nongit_ok)
>>  {
>>  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
>> +	const char *env_ceiling_dirs = getenv(CEILING_DIRS_ENVIRONMENT);
>>  	static char cwd[PATH_MAX+1];
>>  	const char *gitdirenv;
>>  	const char *gitfile_dir;
>> -	int len, offset;
>> +	int len, offset, min_offset = -1;
> 
> AFAIR we have min_offset in the mingw branch, too, but I think it is 
> initialized to 0.

Yes, indeed, and even for much the same purpose (i.e. to stop before the
beginning of the path is reached - on Windows we don't want to look at
"C:" prefixes). Please look at this commit:

http://repo.or.cz/w/git/mingw/j6t.git?a=commitdiff;h=4ab30965f520bd444f3eefe1dee4622181933f90

-- Hannes
