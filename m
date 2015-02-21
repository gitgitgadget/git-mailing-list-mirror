From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git blame swallows up lines in case of mixed line endings
Date: Sat, 21 Feb 2015 14:45:30 +0100
Message-ID: <54E88BFA.9050900@web.de>
References: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 14:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPANc-000225-K7
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 14:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbbBUNpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 08:45:35 -0500
Received: from mout.web.de ([212.227.15.4]:56792 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbbBUNpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 08:45:34 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LphiA-1XvtpF2d0A-00fVCB; Sat, 21 Feb 2015 14:45:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
X-Provags-ID: V03:K0:TThjPgrs4Eboj4koukho7kU/WKDrMGia1bbc5qpdun5jVJ+kJok
 azxIUt3dN8qBQFKYIFm2yZIsuFlAjOL+54EBfaR5bTG0b6dV3g4KB5rsnXbdkWakU6bvLMr
 0Af+8QPAlYXvh7xijK+vIXlJRuzxHnk6QtX/1jFLYUiWpv3z7fMQVDKdVChcO3aMDM0uPP/
 h/TRx1sICc2azYRTZGF2A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264215>

On 2015-02-19 14.48, Sokolov, Konstantin (ext) wrote:
> Hi Folks,
> 
> I encounter unexpected behavior in the following case:
> 
> file content:
> 
> line1<CR><LF>
> line2<CR>
> line3<CR><LF>
> line4
> 
> This is what I get as console output (on Windows):
> 
>> git blame -s file.txt
> 7db36436 1) line1
> line3436 2) line2
> 7db36436 3) line4
> 
> This is the real content:
> 
>> git blame -s file.txt > blame.txt
> 
> blame.txt opened in Notepad++:
> 
> 7db36436 1) line1 <CR><LF>
> 7db36436 2) line2 <CR>
> line3 <CR><LF>
> 7db36436 3) line4 <LF>
> 
> Admittedly, very stupid editors, such as Windows Notepad, cannot handle mixed line endings as well. But is this also the way git blame should behave?
> 
> Kind regards
> Konstantin
>
Git (and other tools) do not handle a single CR as a line ending.
A line ending in Git is either CRLF or LF.

A "mixed line ending" in Git sense is a mixture between CRLF and LF, 
but not a lone CR.
(And in this sense it is the expected behavior)

Are you sure you want to use it, or is it a typo ?
