From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Using git with http behind proxy with authentification?
Date: Sat, 23 Jul 2005 12:21:39 +0200
Message-ID: <42E21A33.6010804@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 23 12:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwH96-00046j-2G
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 12:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGWKWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 06:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVGWKWB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 06:22:01 -0400
Received: from smtp-v.fe.bosch.de ([139.15.237.2]:13982 "EHLO
	smtp-v.fe.bosch.de") by vger.kernel.org with ESMTP id S261327AbVGWKV7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 06:21:59 -0400
Received: from mta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta8.fe.bosch.de (Postfix) with ESMTP id C71573C00F
	for <git@vger.kernel.org>; Sat, 23 Jul 2005 12:21:25 +0200 (CEST)
Received: from si-imc02.de.bosch.com (virusscan4.fe.internet.bosch.com [10.4.98.10])
	by mta3.fe.internet.bosch.com (Postfix) with ESMTP id 84CD08C091
	for <git@vger.kernel.org>; Sat, 23 Jul 2005 12:21:55 +0200 (CEST)
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by si-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 23 Jul 2005 12:21:55 +0200
Received: from [10.4.105.54] ([10.4.105.54]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 23 Jul 2005 12:21:54 +0200
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
To: git@vger.kernel.org
X-OriginalArrivalTime: 23 Jul 2005 10:21:54.0666 (UTC) FILETIME=[5943ECA0:01C58F70]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

because I'm sitting behind a firewall I have to use cogito/git using 
http. But http proxy needs special authentification with user & 
password. It seems to me that this isn't supported with recent cogito/git?

In the past, for bk I used

$ export http_proxy=http://user:password@someproxy.some.where:8080/

which worked. But no luck with cogito/git.

Looking into recent cogito/git, the reason for this seems to be that 
cogito/git uses a combination of wget in scripts and curl in compiled 
executables. Having a look to cg-pull script, this script uses wget. 
Then, it calls git-http-pull if it thinks that http should be used. 
Looking at http-pull.c shows that there curl is used for http access. If 
I understand it correctly from man pages, wget understands user:password 
syntax of http_proxy environment, but curl doesn't. As I understand it 
curl understands only 'someproxy.some.where:8080' and wants the user and 
password given as parameter of curl_easy_setopt. The curl_easy_setopt 
man page tells something about CURLOPT_PROXYUSERPWD parameter.

Any ideas?

Many thanks

Dirk
