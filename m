From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 19:17:31 +0100
Message-ID: <AANLkTim9a89WZdMBYWjTH0p_SR+cy80ndogGJeguKxyE@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie> <201103101815.23477.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:18:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxkQw-0007hU-2h
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 19:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab1CJSRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 13:17:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33663 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1CJSRw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 13:17:52 -0500
Received: by qwd7 with SMTP id 7so1458851qwd.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 10:17:51 -0800 (PST)
Received: by 10.229.12.130 with SMTP id x2mr6604289qcx.207.1299781071136; Thu,
 10 Mar 2011 10:17:51 -0800 (PST)
Received: by 10.229.78.209 with HTTP; Thu, 10 Mar 2011 10:17:31 -0800 (PST)
In-Reply-To: <201103101815.23477.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168840>

On Thu, Mar 10, 2011 at 6:15 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Jonathan Nieder wrote:
>> Thanks for a pointer. =A0Some ideas still at the "throw them against=
 the
>> wall and see if they stick" stage: please feel free to add to the pa=
ge
>> if you think you can find subsets with the right scope.
>
> Some stuff off the top of my head, please apply a similar filter:
>
> * Word-based merge helper
>
> =A0The existing merge algorithms are all tailored to line-based forma=
ts
> =A0such as code. =A0Writing, e.g., LaTeX or even asciidoc requires
> =A0sticking to a strict word-wrapped format. =A0Worse even, re-wrappi=
ng
> =A0leads to headaches if people work on the same areas a lot, much li=
ke
> =A0the effects of code reindents.

Not a complete/right solution (and not even extensively tested), but I
did a "trivial" merge program for LaTeX files that:

1.- Rewraps all files as the first one, using dwdiff
2.- Perform a normal line based merge

[wlmerge]
#!/bin/bash
tmp1=3D$(mktemp -t wlmerge.XXXXXXX)
tmp2=3D$(mktemp -t wlmerge.XXXXXXX)
trap "rm -f $tmp1 $tmp2" 0 1 2 3 15
[ ! -e "$1" ] && exit 1
file1=3D$1 && shift
[ ! -e "$1" ] && exit 1
orig=3D$1 && shift
[ ! -e "$1" ] && exit 1
file2=3D$1 && shift
dwdiff -2 -w "" -x "" "$orig" "$file1" > $tmp1
dwdiff -2 -w "" -x "" "$file2" "$file1" > $tmp2
merge "$file1" $tmp1 $tmp2

I even have a "wldiff", but nowadays I use --color-words exclusively!

HTH,
Santi
