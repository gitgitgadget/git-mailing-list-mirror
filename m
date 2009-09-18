From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 14/15] Add scripts to generate projects for other buildsystems
 (MSVC vcproj, QMake)
Date: Fri, 18 Sep 2009 08:59:46 +0200
Message-ID: <4AB32FE2.1060604@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <260603a54845df34659d605fadaf663d0094c8cb.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <200909172228.28174.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, lznuaa@gmail.com, raa.lkml@gmail.com,
	snaury@gmail.com
To: Johannes Sixt <j6t@kdbg.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 09:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoXSC-00068k-DA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 09:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbZIRHAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 03:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZIRHAO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 03:00:14 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:35737 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbZIRHAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 03:00:13 -0400
Received: by ewy2 with SMTP id 2so1059578ewy.17
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+lJzmhEwi3AxDQm55yt8obEgxi02QcjyMmp5JqjZdQE=;
        b=lH74V7IO8nX1b+YeY6EupRkUMjYk3kH68pzhX3eH4Va9rOnL2kmOzT2VFSuXfpaxvb
         OpYLEfTSbQJUzf/dRYCljitd9KLkp8awRgnfUMzsFiApelsW7hmy37uBLh8iB0sWKPGZ
         u39vRYGrRwuLTof/o1XETTCxErn3l746Ma0S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fXidsrsHwBP9AsOpRg2DMWgSM5F19tuQlp4DCDZpVmSByW5vnOE0zFMXlQ3wXF2owF
         fL+awaM0B/dnqUpyr2gZOC2Z2sVjv5w9w5onfhKE1kuZoySOEp+qlhXEZXwYMM2cd/rT
         6K23OY8fiA26BWa6J2HzAzGt7G0XaFDX8FuN8=
Received: by 10.210.3.7 with SMTP id 7mr1656892ebc.47.1253257215771;
        Fri, 18 Sep 2009 00:00:15 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 24sm3897394eyx.7.2009.09.18.00.00.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 00:00:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <200909172228.28174.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128788>

Johannes Sixt said the following on 17.09.2009 22:28:
> On Mittwoch, 16. September 2009, Marius Storm-Olsen wrote:
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -179,3 +179,14 @@ configure
>>  tags
>>  TAGS
>>  cscope*
>> +*.obj
>> +*.lib
>> +*.sln
>> +*.suo
>> +*.ncb
>> +*.vcproj
>> +*.user
>> +*.idb
>> +*.pdb
>> +Debug/
>> +Release/
> 
> If I understand correctly, then 'make MSVC=1' still produce *.o files, not 
> *.obj. But if the VC++ project is used, I expect that the *.obj, *.idb, and 
> *.pdb end up in Debug/ or Release/ directories. Then why do you need entries 
> for *.obj, *.idb, and *.pdb?

When using only the vcproj generator, you are correct. However, if you 
use the qmake generator, and create vcprojs from those, the *.idb and 
*.pdb files are located in the project directory itself, and not under 
Debug/. I'm not too worried about this case though, so for me, the 
three entries *.obj, *.idb and *.pdb can go.

Junio, you want me to push a new patch?

--
.marius
