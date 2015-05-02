From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] git help: group common commands by theme
Date: Sat, 02 May 2015 13:43:19 +0200
Message-ID: <87wq0rb3xk.fsf@igel.home>
References: <554405D5.9080702@gmail.com> <554406FC.8010309@gmail.com>
	<CAE5ih78xxHj-YZVnNB=kNw5ZOkT1t2dcc5yjiUWemEQpwFQfDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat May 02 13:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoVpT-0004wT-NF
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 13:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbbEBLnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 07:43:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48181 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbEBLnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 07:43:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3lf7qr67Vbz3hk39;
	Sat,  2 May 2015 13:43:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3lf7qr4RQDzvh1m;
	Sat,  2 May 2015 13:43:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id B6xQMMUz03ks; Sat,  2 May 2015 13:43:19 +0200 (CEST)
X-Auth-Info: qxVP20jNavuhdnc3yEFhxN/zpmxVGz9XAjFlveV49hua6UNMDfhgawQL6xG6aSsV
Received: from igel.home (ppp-93-104-92-93.dynamic.mnet-online.de [93.104.92.93])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  2 May 2015 13:43:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 81F3A2C4050; Sat,  2 May 2015 13:43:19 +0200 (CEST)
X-Yow: LOU GRANT froze my ASSETS!!
In-Reply-To: <CAE5ih78xxHj-YZVnNB=kNw5ZOkT1t2dcc5yjiUWemEQpwFQfDw@mail.gmail.com>
	(Luke Diamand's message of "Sat, 2 May 2015 07:32:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268227>

Luke Diamand <luke@diamand.org> writes:

>>  };
>>
>>  static struct cmdname_help common_cmds[] = {"
>>
>> -sed -n -e 's/^git-\([^     ]*\)[     ].* common.*/\1/p' command-list.txt |
>> +sed -n -e 's/^git-\([^     ]*\)[     ].* common-\(.*\)/\1:\2/p'
>> command-list.txt |
>>  sort |
>> -while read cmd
>> +while read line
>>  do
>> +     cmd=`echo $line | cut -d ':' -f 1`
>> +     grp=`echo $line | cut -d ':' -f 2`
>
> Should this use $(...) rather than `...` ?
> i.e.
> cmd=$(echo $(line | cut -d : -f 1)

There are various ways to do that without a command substitution, eg:

   cmd=${line%%:*}
   grp=${line#:*}

or:

   IFS=:
   set $line
   cmd=$1 grp=$2

or:

  sort |
  while IFS=: read cmd grp
  do

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
