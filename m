From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 1/1] clone: replace relative paths in the alternates
Date: Fri, 19 Aug 2011 14:39:23 +0800
Message-ID: <4E4E051B.5020803@gmail.com>
References: <1313731396-10458-1-git-send-email-jason77.wang@gmail.com> <1313731396-10458-2-git-send-email-jason77.wang@gmail.com> <7vy5yp53aj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Hui Wang <jason77.wang@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 08:39:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuIjx-0003Xn-Uq
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 08:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab1HSGjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 02:39:33 -0400
Received: from mail.windriver.com ([147.11.1.11]:48354 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1HSGjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 02:39:33 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7J6dSbH014031
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 18 Aug 2011 23:39:28 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Thu, 18 Aug
 2011 23:39:28 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vy5yp53aj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179682>

Junio C Hamano wrote:
> Hui Wang <jason77.wang@gmail.com> writes:
>
>   
>> +	mapsz = xsize_t(st.st_size);
>> +	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
>> +	close(fd);
>> +
>> +	tmpbuf = mapsz > 4096 ? xmalloc(mapsz * 2) : xmalloc(mapsz + 4096);
>>     
>
> Where do these magic numbers come from, and what guarantee do we have that
> these magic numbers give safe upper bound for pathnames that are expanded
> to be absolute?
>
>   
If an alternates file has dozens of relative path lines, this code has 
great risk.
> Wouldn't it be a lot cleaner and much less error prone if you open the
> original, read from it with strbuf_readline(), convert the path using
> strbuf manipulation functions and write the resulting line out to the
> lockfile you obtained to update it, line by line?
>   
This is a good suggestion, i will try to use the above way to prepare a 
V2 patch.

Thanks,
Jason.
