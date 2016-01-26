From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Tue, 26 Jan 2016 16:43:44 +0000
Message-ID: <56A7A240.7000102@ramsayjones.plus.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <cover.1453632296.git.johannes.schindelin@gmx.de>
 <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de>
 <56A4FB64.4010609@web.de> <alpine.DEB.2.20.1601250749580.2964@virtualbox>
 <56A67B6F.60300@ramsayjones.plus.com>
 <alpine.DEB.2.20.1601260951030.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO6io-0008CE-7E
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 17:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966800AbcAZQn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 11:43:56 -0500
Received: from avasout07.plus.net ([84.93.230.235]:36905 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966688AbcAZQnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 11:43:55 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id Agjr1s0024mu3xa01gjsfY; Tue, 26 Jan 2016 16:43:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=Q9fys5e9bTEA:10
 a=gdTuQe83DAwf91Fj7hoA:9 a=PUjeQqilurYA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <alpine.DEB.2.20.1601260951030.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284841>



On 26/01/16 08:54, Johannes Schindelin wrote:
> Hi Ramsay,
[snip]

>>
>> But you are only testing 3/4 conflict markers end in CR/LF. :-D
> 
> The fact that ||| markers are present is the fault of previous test cases.
> I tried to make a point of *not* relying on such a side effect (so as to
> debug failures quicker by commenting out all previous test cases).
> 
> So the fact that I am testing only 3 of the 4 conflict markers is very
> much by design.

I'm sorry, but I don't understand what you are trying to say here. :(

> 
>>> Read: I am uncertain that I want to spend the additional lines on
>>> testing more than actually necessary.
>>
>> If the here doc is too verbose for you, how about something like this
>> (totally untested):
>>
>>     test $(tr "\015" Q <crlf.txt | grep "^[<=>|].*Q$" | wc -l) -eq 4
>>
>> instead?
> 
> Hmm. I do not see the benefit over grepping for `txtQ$` it's essentially
> the same.

Well, as I said 'totally untested', but it _should_ be different. ;-)

The output from the 'tr "\015" Q <crlf.txt' subcommand should look
something like:

    1Q
    2Q
    <<<<<<< crlf-diff1.txtQ
    4Q
    ||||||| crlf-orig.txtQ
    3Q
    =======Q
    5Q
    >>>>>>> crlf-diff2.txtQ

so that your 'grep "\\.txtQ$"' should select these lines:

    <<<<<<< crlf-diff1.txtQ
    ||||||| crlf-orig.txtQ
    >>>>>>> crlf-diff2.txtQ

whereas my 'grep "^[<=>|].*Q$"' should select these lines:

    <<<<<<< crlf-diff1.txtQ
    ||||||| crlf-orig.txtQ
    =======Q
    >>>>>>> crlf-diff2.txtQ

(ie. select all 4 conflict markers).

> 
>> HTH
> 
> How the hell?

:-D Hope That Helps.

> 
>> ATB,
>> Ramsay Jones
> 
> Authorization to Buy?

All The Best.

ATB,
Ramsay Jones
