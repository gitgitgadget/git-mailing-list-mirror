From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Thu, 05 Jun 2014 23:42:19 +0200
Message-ID: <5390E43B.3070501@web.de>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>		 <1401853091-15535-2-git-send-email-dturner@twitter.com>		 <538ED2F1.9030003@web.de>		 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>		 <538F2C6B.2030004@web.de> <1401916560.18134.167.camel@stross>	 <539062D9.60000@web.de> <1401996362.18134.179.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXI=?= =?UTF-8?B?c2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsfQa-0003nN-0A
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 23:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaFEVmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 17:42:24 -0400
Received: from mout.web.de ([212.227.17.12]:62339 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbaFEVmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 17:42:23 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M09z2-1WeAPQ1xSW-00uGpm; Thu, 05 Jun 2014 23:42:20
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401996362.18134.179.camel@stross>
X-Provags-ID: V03:K0:NvA1ciX5fy2z3PsnRQhsc0VS5rVs6Kg+JM0p8+srz4TqYgxG6cB
 b8EbM/9LXen393FZD3evyA4J688bmQ7BbLzRhrohhsaHzy63HumNuFpGUVhW68LknDzWpsW
 ZcvHiX91eE23QXIW9C9Qjf1HlbEmN7mQQIGaAK+mFt61J/zAz6eH4inYAKJpE4tDeuq3rIO
 OHPb0WXAeYhGzHY1TpVWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250865>

On 2014-06-05 21.26, David Turner wrote:
> On Thu, 2014-06-05 at 14:30 +0200, Torsten B=C3=B6gershausen wrote:
>> On 2014-06-04 23.16, David Turner wrote:
>>>
>>> Sure!  I actually went with > 120k to make measurement easier:
>>> https://github.com/dturner-tw/many-refs
>> Hm, I didn't get so man
>>
>> git remote -v
>> origin  https://github.com/dturner-tw/many-refs=20
>>
>>  wc .git/packed-refs=20
>>      750    1130   38868 .git/packed-refs
>>
>=20
> Oops.  It looks like I forgot to push all of the refs.  And when I tr=
y,
> it fails with "fatal: cannot exec 'send-pack': Argument list too long=
"

I just noticed that I may be able to re-use code from t5551 to create a=
 repo
with 50000 tags.


And how about renaming check_refname_component_1() into
check_refname_component_slow() ;-)
