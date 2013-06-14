From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 14 Jun 2013 12:55:40 +0200
Message-ID: <51BAF6AC.2080504@ira.uka.de>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com> <20130607063353.GB19771@paksenarrion.iveqy.com> <CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com> <20130607175717.GA25127@paksenarrion.iveqy.com> <CAPKkNb4myh9MPNSgLqs5Mku-z1EOsHyWrgK2Qy_3_UOivXvcnw@mail.gmail.com> <51B23F01.5020608@brokenzipper.com> <CAPKkNb460fNJcwt6084xkuDa2sWMRnF+FBu+i_G01aJMMiRevA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Charles McGarvey <chazmcgarvey@brokenzipper.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRfB-0007LL-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3FNKzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:55:21 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39642 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625Ab3FNKzU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 06:55:20 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UnRen-0002dC-A6; Fri, 14 Jun 2013 12:55:16 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UnRen-0007ux-1G; Fri, 14 Jun 2013 12:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAPKkNb460fNJcwt6084xkuDa2sWMRnF+FBu+i_G01aJMMiRevA@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1371207316.283135000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227811>

Am 07.06.2013 22:21, schrieb Constantine A. Murenin:
> I'm totally fine with daily updates; but I think there still has to be
> some better way of doing this than wasting 0.5s of CPU time and 5s of
> HDD time (if completely cold) for each blame / log, at the price of
> more storage and some pre-caching, and (daily (in my use-case))
> fine-grained incremental updates.

To get a feel for the numbers: I would guess 'git blame' is mostly run 
against the newest version and the release version of a file, right? I 
couldn't find the number of files in bsd, so lets take linux instead: 
That is 25k files for version 2.6.27. Lets say 35k files altogether for 
both release and newer versions of the files.

A typical page of git blame output on github seems to be in the vicinity 
of 500 kbytes, but that seems to include lots of overhead for comfort 
functions. At least that means it is a good upper bound value.

35k files times 500k gives 17.5 Gbytes, a trivial value for a static 
*disk* based cache. It is also a manageable value for affordable SSDs
