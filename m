From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 07/32] hold_lock_file_for_append(): release lock on
 errors
Date: Fri, 12 Sep 2014 13:04:12 +0200
Message-ID: <5412D32C.2060003@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>	<1409989846-22401-8-git-send-email-mhagger@alum.mit.edu> <xmqqiokwifi9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSOl7-0007A0-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 13:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbaILLLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 07:11:17 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45226 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752905AbaILLLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 07:11:16 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 07:11:16 EDT
X-AuditID: 1207440c-f79036d000005e77-16-5412d32e218f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 64.8D.24183.E23D2145; Fri, 12 Sep 2014 07:04:14 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CB4Cvn028671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 07:04:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqiokwifi9.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqKt3WSjEoGstp0XXlW4mi4beK8wW
	T+beZbb40dLDbNHZ8ZXRgdXj4asudo9nvXsYPS5eUvb4vEnO4/azbSwBrFHcNkmJJWXBmel5
	+nYJ3BlrpvcyFkxnrpi+4RZzA+MBpi5GTg4JAROJKzeXMkLYYhIX7q1n62Lk4hASuMwosfPB
	OyjnPJPE7I4LLCBVvALaEk93XgXrZhFQlXgw8TBYN5uArsSinmawuKhAgMSHzgeMEPWCEidn
	PgHrFRFQk5jYdogFZCizwGZGid8rt4AVCQsES/xZ08wCsW0No8SV1euYQRKcAtYSV6d+ZwOx
	mQX0JHZc/8UKYctLbH87h3kCo8AsJEtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy8
	1CJdQ73czBK91JTSTYyQQOfZwfhtncwhRgEORiUe3koWwRAh1sSy4srcQ4ySHExKorw+R4VC
	hPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwmoPkeFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1Kz
	U1MLUotgsjIcHEoSvAsuAjUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg+I1vhgY
	sSApHqC9zSDtvMUFiblAUYjWU4zGHC1Nb3uZONZ1futnEmLJy89LlRLnnQ1SKgBSmlGaB7cI
	luJeMYoD/S3MewakigeYHuHmvQJaxQS06t0csFUliQgpqQZGE91/4s/eehg1T9/m6+t7Xdt0
	adaE1Oi589VzFnIG/gis0DGzMI4SfP3mh8LOnb0fay+efvAoi0/xkuP9+b47Zns+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256915>

On 09/10/2014 12:41 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If there is an error copying the old contents to the lockfile, roll
>> back the lockfile before exiting so that the lockfile is not held
>> until process cleanup.
> 
> Same comment as 06/32 applies here.

Same reply applies here, too.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
