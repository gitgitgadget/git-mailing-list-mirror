From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 05/12] Windows(msysgit): Per default, display help as HTML in default browser
Date: Fri, 4 Jul 2008 11:06:51 +0200
Message-ID: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <200807022057.47588.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhGb-0003v4-30
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbYGDJGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757929AbYGDJGq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:06:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:61581 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757876AbYGDJGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:06:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6496VfD008114;
	Fri, 4 Jul 2008 11:06:36 +0200 (CEST)
Received: from [192.168.178.22] (p5499FDC0.dip.t-dialin.net [84.153.253.192])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6496QZV007314
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 4 Jul 2008 11:06:27 +0200 (MEST)
In-Reply-To: <200807022057.47588.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87375>


On Jul 2, 2008, at 8:57 PM, Johannes Sixt wrote:

> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
>> The implementation directly calls the Win32 API to launch the  
>> browser.
>> Note that the specific directory layout of msysgit is required.
>
>> +#ifdef __MINGW32__
>> +	const char* exec_path = git_exec_path();
>> +	char *htmlpath = make_native_separator(
>> +			   mkpath("%s/../doc/git/html/%s.html"
>> +				  , exec_path
>> +				  , git_cmd)
>> +			 );
>> +	if (!file_exists(htmlpath)) {
>> +		htmlpath = make_native_separator(
>> +			      mkpath("%s/../doc/git/html/git-%s.html"
>> +				     , exec_path
>> +				     , git_cmd)
>> +			   );
>> +		if (!file_exists(htmlpath)) {
>> +			fprintf(stderr, "Can't find HTML help for '%s'.\n"
>> +				, git_cmd);
>> +			exit(1);
>> +		}
>> +	}
>> +	printf("Launching default browser to display HTML help ...\n");
>> +	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
>> +#else
>
> Can't we move this part into git-web--browse.sh? It should be a  
> matter of
> calling
>
> 	start $htmlpath
>
> (and msys-1.0.dll would convert slashes to backslashes for us).

I try to avoid the shell as much as possible on Windows.

How about the two following patches:

  [PATCH 1/2] help.c: Add support for htmldir relative to  
git_exec_path()
  [PATCH 2/2] help (Windows): Display HTML in default browser using  
Win32 API

I'll send them as replies to this mail.

	Steffen

	
