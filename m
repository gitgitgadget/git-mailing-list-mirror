From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH 5/6] Add infrastructure to write revisions in fast-export format
Date: Mon, 7 Jun 2010 23:36:21 +1000
Message-ID: <B78F4B61-E006-47CD-9186-EF81BE5CDAC7@cordelta.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>  <1275658871-1473-6-git-send-email-artagnon@gmail.com> <20100604190222.GB21295@progeny.tock> <AANLkTilqFNqGj8rq3fHZld6ddkHLp_usQSQKgQqeAt0X@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 15:36:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcVF-0005nC-BH
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 15:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab0FGNg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 09:36:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55021 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0FGNg1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 09:36:27 -0400
Received: by pvg16 with SMTP id 16so1432757pvg.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=rEJLLCNGxFczI0FRCjpOzxJuZx+fJxfspUZ+qFoxZ9s=;
        b=IT7+z30y7tj1iQB6Cqzrslx/z1zaGo2js9TfzCwva7VzLWIwtsN4d83yZUBf8GDKom
         MFcW2ElYcbb9XhNpGD8J/u1Fpa/nJ+UOdDYlXtoloSMfiwCuIRmOGtZWPTgjHl6BWy7b
         X3sb9g3vRdDdr0gAOs8sb8lMVkQ92dodDrVfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=CZhCK9se8naCOgPRZcf+euypixWdRTqi7gmHvzKb6X5X3iyp/sAFjhyNuS6AINRGDd
         XwZx6SS2/NdCg7krUXn1IGnzcYAC5dTQMMZxHPLJvd4pRa3dxorHLz/29orvNSdNSkJb
         aBacdM6qtwk8LKFsskZKJcEjBMoH8iHvxF+J4=
Received: by 10.141.14.8 with SMTP id r8mr527210rvi.271.1275917786849;
        Mon, 07 Jun 2010 06:36:26 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id t1sm4697687rvl.9.2010.06.07.06.36.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 06:36:26 -0700 (PDT)
In-Reply-To: <AANLkTilqFNqGj8rq3fHZld6ddkHLp_usQSQKgQqeAt0X@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148594>

Hi Ram,

>> Style: would probably be clearer to write:
>> 
>>        while (~(name = *path++)) {
>>                dirent = repo_dirent_by_name(dir, name);
>>                if (!dirent || !repo_dirent_is_dir(dirent))
>>                        break;
>>                dir = repo_dir_from_dirent(dirent);
>>        }
>> 
>> i.e., fewer unnecessary braces, and dealing with the exceptional cases
>> separately from the normal case.
> 
> This was (probably unintentionally) re-factored by David when merging
> in his `dirents` branch.

Oh no, it was intentional.

>> My 80-column terminal is suffering.  Why not use the common
>> pattern?
> 
> Re-factored (again, probably unintentionally) by David during the merge.

As above, totally intentional.

@Jonathan: Thanks for the review, I took it into account when refactoring dirents.

>> These limits are not checked; is the caller supposed to check them
>> itself?  Does svn obey them?
> 
> I asked David too, and as far as we know, these limits are pretty
> arbitrary. They're no enforced by SVN or any specific filesystem. We
> can discuss about having less arbitrary limits and checking it in
> svndump.c (while parsing the dump).

I am indeed in favour of less arbitrary limits.
The current magic numbers were chosen as common practical bounds.
