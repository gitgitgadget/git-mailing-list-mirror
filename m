From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 2/2] convert: ce_compare_data() checks for a sha1 of a
 path
Date: Wed, 18 May 2016 17:10:06 +0200
Message-ID: <04175530-b0b8-572d-1fea-06a2bd029029@web.de>
References: <573A993F.8020205@web.de>
 <1463503301-3634-1-git-send-email-tboegi@web.de>
 <xmqq60ucwlz8.fsf@gitster.mtv.corp.google.com> <573BEEEF.8040305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 17:10:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b337M-0005Lh-78
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcERPK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 11:10:27 -0400
Received: from mout.web.de ([212.227.15.14]:57094 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcERPK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:10:26 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LhNaa-1bOxfQ1c0W-00mZea; Wed, 18 May 2016 17:10:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <573BEEEF.8040305@web.de>
X-Provags-ID: V03:K0:+0j/U/jGw/CLoXqcLLbZ0jQChqfCGlkSgyn59T+CH2dMBZ1CVer
 AuK0lApnY8hC7s1Rydk7RjlFUyTQ7bT/ewNPi305IUXT7ooNpYoQdV7jWK/2ybq/w0+j3FC
 aoob56DTHxl9XjY+f0aCkgk+minO5eTakNXJKEiEqj7omJWKp9msA2Xl9snpIQhzJf3wBUB
 YxdOv1DLdhw9elDZHDP3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:heCW+p94us4=:eYz/vgZkAoFssnT9gv3Tdr
 yTY9tNOc3DzwgJQH8fRa6NLsPv+TkF8aXBmaWql4wU6U3KmjvucuxCH+6MVjebUN75eqYTKmL
 Ju4a3o5VOqLm3lh3wZjbZc93dxUa2opRZeXHnnh/+KExR3tw4rUxhf0G/bb/qyUzfUiI9b0+f
 tsqsTFX7YuTI89RJE59jN4W12RzWVhGyEYBgHP5yBoNeFnGnZH13tHe3qe6VhgQpWm8SbEGxx
 z7S0zqoVzvc7FFmVWAmdd+eJL2XV3o08DmgHn8fr2m6WBDedSKOskQgOUhUnwXBWybOsw2Ji3
 am2eg9OkHzHDX9+RANZIK4hXE8D2h8bT2DUiHfLf2W1u6caohJ7tR0Vc02FTEOdpRZVHWT8bL
 eJGqtWBdCqkKhqzgojtuKgSIrEbQXSUicR52dvYbKGGhxrtM5V53posrKJF65Hf6OBAoJTqGR
 n82LZsYAdKVR7lVk1lVruUzAHunzU0WrdNb/wEIHhkgfxbiTqK3Uw2ykTPi+K/hTJqE4hngE5
 /7j0MmxGqSMmItMVWRfgzdHhfvC7Bm2w4VgfgohTfwXpLot8RA/8t81lB8zBjFE6vXfiVt2V+
 N30/O33oXR9rODKTB/RlYRDcojogoniyOWWZfkEUKm2Wb4BsTCHak9060Mo/oqpStnaYbr0G3
 b23TLTvd7i9Qhc7+CyYLIxyPVArsaXKwnyunTve0Kv27Mrz22Ys/ySI+1Lq6bhh+/4IHbxuDa
 MLe3pEYdrS3NhoxcNHLHfptL8WBA6TAWxg3I9cZZM6LxkIUMdx68moNu67r193hBjFyJSDSr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294942>

On 18.05.16 06:26, Torsten B=F6gershausen wrote:
> On 05/17/2016 08:58 PM, Junio C Hamano wrote:
>> tboegi@web.de writes:
>>
>>>   #define HASH_WRITE_OBJECT 1
>>>   #define HASH_FORMAT_CHECK 2
>>> +#define HASH_CE_HAS_SHA1  4
>>
>> How does one pronounce the words in this constant?  Does it make a
>> listener understand what this constant means?
> How about
> HASH_USE_SHA1_FROM_CE
> or
> HASH_CE_HAS_VALID_SHA1
or, before I send a new patch,
HASH_USE_SHA_NOT_PATH=20
