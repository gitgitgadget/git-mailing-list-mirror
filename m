From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Sun, 22 Nov 2015 09:20:37 +0100
Message-ID: <56517AD5.6040909@gmail.com>
References: <56501EFA.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 09:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0PtA-0007I0-68
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 09:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbbKVIUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2015 03:20:42 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36793 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbKVIUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 03:20:41 -0500
Received: by wmww144 with SMTP id w144so63085658wmw.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 00:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=JcdPwGHVN1x0f7i5erNSQtlcdml8YvqpnJ+vLyn953U=;
        b=qC0DTAcbWmqoewn9tUvbkQukr5Cmujt2KLrc+Fwi/lYT2kKcJ24mp2UbvaTtha1Rup
         oxowcfl49wa/IW6GjAzxM7f2xCX0LFaVPDjlsPS09is+UTYFpzRNiOw1UVM5NOHDSP4F
         SzQlt8BDM5T68JaxNICPhn9i8oRPyPGIIr7Q4vf4UwP4jEf7yBLTz22E6ZboKzwMf11J
         iSMULTSH08op2R4IIHEniMr5IiKuLgRvyAkdEgiwekw5AesXn7GJe2Jt5ZHm1L5OXyeQ
         jbDz3TxvEIsXb8EMs+WWEakd/WbqI9fmzY5VnRs90oqvHCzgGztKWZNn9dun28YOkPGb
         dD0g==
X-Received: by 10.28.94.194 with SMTP id s185mr10015481wmb.90.1448180440656;
        Sun, 22 Nov 2015 00:20:40 -0800 (PST)
Received: from [192.168.188.20] (p548D6208.dip0.t-ipconnect.de. [84.141.98.8])
        by smtp.googlemail.com with ESMTPSA id he3sm7643352wjc.25.2015.11.22.00.20.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Nov 2015 00:20:39 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <56501EFA.7050105@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281562>

On 21.11.2015 08:36, Torsten B=C3=B6gershausen wrote:

> git ls-files --eol gives an output like this:
>=20
> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty

I'm sorry if this has been discussed before, but hav you considered to =
use a header line and omit the prefixed from the columns instead? Like

index         working tree     attributes    file

binary        binary           -text         t/test-binary-2.png
text-lf       text-lf          eol=3Dlf        t/t5100/rfc2047-info-000=
7
text-lf       text-crlf        eol=3Dcrlf      doit.bat
text-crlf-lf  text-crlf-lf                   locale/XX.po

I believe this would be both easier to read for humans, and easier to p=
arse for scripts that e.g. want to compare line endings in the index an=
d working tree.

> +stats_ascii () {
> +	case "$1" in

[...]

> +		*)
> +		echo huh $1
> +		;;

Personally, I'm not a big fan of supposedly funny output like this. How=
 about printing a proper message rather than "huh", even for cases that=
 should not happen?

--=20
Sebastian Schuberth
