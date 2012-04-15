From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 10:29:17 +0200
Message-ID: <m2ehrpcs9u.fsf@linux-m68k.org>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
	<CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
	<CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 10:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJKq1-0005F3-Jt
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 10:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab2DOI3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 04:29:30 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44585 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2DOI31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 04:29:27 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VVm9B0tsmz3hhTb;
	Sun, 15 Apr 2012 10:29:18 +0200 (CEST)
Received: from linux.local (ppp-93-104-140-113.dynamic.mnet-online.de [93.104.140.113])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VVm9B1qkrz4KK6y;
	Sun, 15 Apr 2012 10:29:18 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 9B6CB1E52EC; Sun, 15 Apr 2012 10:29:17 +0200 (CEST)
X-Yow: YOW!!  Everybody out of the GENETIC POOL!
In-Reply-To: <CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 15 Apr 2012 07:45:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195548>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> However, I would like to simplify it even more:
>
> __gitcomp_1 ()
> {
> 	local c w s IFS=' '$'\t'$'\n'
> 	for c in $1; do
> 		w="$c$2"
> 		case "$w" in
> 		--*=*|*.) s="" ;;
> 		*)        s=" " ;;
> 		esac
> 		printf "%s$s\n" "$w"
> 	done
> }

Or even:

__gitcomp_1 ()
{
	local c IFS=$' \t\n'
	for c in $1; do
		c=$c$2
		case $c in
		--*=*|*.) ;;
		*)        c="$c " ;;
		esac
		printf '%s\n' "$c"
	done
}

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
