From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Wed, 25 Mar 2015 22:14:18 +0100
Message-ID: <5513252A.7050601@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>	<20150319052620.GA30645@peff.net> <xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com> <55118B74.1030201@alum.mit.edu> <551195B6.9040402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:14:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yasd9-0005Aw-I1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 22:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbCYVOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2015 17:14:23 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47492 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbbCYVOV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2015 17:14:21 -0400
X-AuditID: 1207440f-f792a6d000001284-b1-5513252da00e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 87.99.04740.D2523155; Wed, 25 Mar 2015 17:14:21 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1AEE.dip0.t-ipconnect.de [93.219.26.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2PLEI1k026311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 25 Mar 2015 17:14:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <551195B6.9040402@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqKurKhxqMGc3t0XXlW4mi4beK8wW
	Z7b2M1v8aOlhtnh8awKTA6vHs949jB5z71t6XLyk7PF5k5zH7WfbWAJYo7htkhJLyoIz0/P0
	7RK4M7ZeustecIqrYt2RySwNjEc4uhg5OSQETCSmXN/GCGGLSVy4t56ti5GLQ0jgMqPEzRmb
	oJzzTBIt514zgVTxCmhLTNj3gxnEZhFQlXg96z+YzSagK7GopxmsRlQgSOLlrb+MEPWCEidn
	PmEBsUUEaiSmXnrGDmIzCxhJzLpxhhXEFhYIl1h6bzYTxLJzjBIPdrWxgSQ4BdQkpl77yAzR
	oCex4/ovVghbXqJ562zmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKL
	dE30cjNL9FJTSjcxQoKcfwdj13qZQ4wCHIxKPLweIkKhQqyJZcWVuYcYJTmYlER5+YSFQ4X4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8PY8AirnTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1O
	TS1ILYLJynBwKEnwSqoADRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWt8MTBe
	QVI8QHsNQNp5iwsSc4GiEK2nGBWlxHndQBICIImM0jy4sbDU9YpRHOhLYV4TkCoeYNqD634F
	NJgJaPC5fD6QwSWJCCmpBkaNm/MDL1Yfqot1/fVTapvp94jUlU0rX/e4fM+8p7e4dKmp3PdH
	wlszv8s1ZVqZzWuxflhwn7t9dUOYQOb1mFu3TK32XnWc1VM19xVTEs+PqqkHZVpj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266303>

On 03/24/2015 05:49 PM, Ren=E9 Scharfe wrote:
> Am 24.03.2015 um 17:06 schrieb Michael Haggerty:
>> Parsing numbers is not rocket science, but there are a lot of pitfal=
ls,
>> especially around overflow. It's even harder to write such code via
>> macros and the result is less readable.
>>
>> This patch series is mostly about finding a reasonable API and whipp=
ing
>> the callers into shape. That seems ambitious enough for me. I'd rath=
er
>> stick with boring wrappers for now and lean on strtol()/strtoul() to=
 do
>> the dirty work. It will be easy for a motivated person to change the
>> implementation later.
>=20
> The OpenBSD developers invented strtonum for that.  Are you aware of =
it?
>  Would it fit?  This discussion may be useful:
>=20
>     http://www.tedunangst.com/flak/post/the-design-of-strtonum

I wasn't aware of strtonum; thanks for the reference. It has an
untraditional interface. Their willingness to sacrifice half of the
unsigned range and requirement that the user specify minval and maxval
have the nice effect of permitting one function to be used for all
integer types.

I think git will need more flexibility, for example to support other
radixes and to allow trailing characters. So personally I don't think w=
e
should use (or imitate) strtonum().

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
