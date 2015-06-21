From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: broken repo after power cut
Date: Sun, 21 Jun 2015 14:28:20 +0200
Organization: gmx
Message-ID: <330ab8f498e1b435d5b210384200b649@www.dscho.org>
References: <5585C1B6.50407@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Gstir <david@sigma-star.at>
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Sun Jun 21 14:30:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6eNy-0003Gx-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 14:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbbFUM21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 08:28:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:52216 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbbFUM2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 08:28:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Mh9yT-1ZT0ZL1gB7-00MKgb; Sun, 21 Jun 2015 14:28:22
 +0200
In-Reply-To: <5585C1B6.50407@nod.at>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:CiC84Gn0EPCp7DKGxG/dDiHBKPkWRRNoJDUqChYLyPJ57cZHlQs
 kHBMa5/SQY94lF53xonXTRn3zT57fVMmtTP+R72L9bii1AZFXHXP1Oeg4c5ZsjGM2WoJthb
 3RLY9epq7G8CVPgwbwb4Tpsk+A/GdDpEwvGz62O5g5XntAxZXuBunzj8U8nzpnWnXUWidiE
 iswed/AYdzU9w9JSsOiLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fN6liaykgBE=:Cehryms+QnZt6WxfOra4Yq
 Ps3TDnnLUvz4aYUUF+Zmgt2jSl5Rzn5w02S2WqN4oQy3aoxiuBdMcCjyhrSY4zPsOnQ5c/Iwf
 EI+lzRPNWMd/gliV529jRy01yX0YNluIXZywJa0SrpYYdjvbLt+Cr5FEPTcMUdS6r7v9Qtxei
 KjXAjKvP4HXBwfoHljRrXQZInGvN1pmRcxnUye1qgaJyGrBEFPwodWUkZmuLydbUfUgdCO/fk
 9EHsWTyBTqNb3UJjSjrYN21+5jXz7ebrABzqDnuzB51qq3sl+tAvWpkVKgwf62du+hQGMfPDL
 hueupzhirx56uKHxWmkVpUJXtjppNwB5OFLcwF5ZLiGBHSXJIqGorYw5fraBjUhYhGlW2aGqs
 05vo/ex4YmGbboJdS4SdsZuBDE5PdJzvNQ3xcvrRYTHxDXZYD35AE/aWtPMk2JI763AhkdyJJ
 fPwMnDzn/6av4uHuYNX69qOjbkA5ToVbznkqs2ZJwHaC2Jlh6WW72hFBCdS8RNd5/G1HSUP3H
 o/G+FRVgyDeiVFiDiR+f+MMUd98SUHWiLkuwnh9RPbfGAnqkMKzk2EVpiqfRlq/Lwg+wf00bz
 I29NPGYhL+hbQxuv9wbam8VGoYeOclr/rDhAzoWiTbFcRL/efNlewquQ87gaX3pJhD54ejAD7
 IwTm/MHb7vhWYdJFn17rBlDHjWWZxfttEExAnnKiEfVvByWPuZXj257gw1x0iJLDMxdI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272255>

Hi Richard,

On 2015-06-20 21:40, Richard Weinberger wrote:

> Yesterday our git server faced a power cut and a git repository broke.
> The server is running a ext4 filesystem on top of Linux 3.16 (stable
> from openSUSE) and git 2.1.4.
> We had a backup, so no data was lost but I really would like to figure out
> what happened.
> 
> This is the output of git fsck:
> Checking object directories: 100% (256/256), done.
> error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
> error: object file objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d is empty
> fatal: loose object cef7627fc160ad7294b1f728db0c1ddb65a38b1d (stored
> in objects/ce/f7627fc160ad7294b1f728db0c1ddb65a38b1d) is corrupt
> 
> To me it seems like git was creating a new object and got interrupted
> before fsync/fdatasync'ing it.
> As the object was referenced before syncing the data to disk the repo broke.
> Could this have happened?
> Also, is git designed to survive power cuts? Then referencing an
> object before synching it do disk would make no sense.

I had similar issues with ext4 in the past, even with local repositories when using Git without pushing. My then-current laptop would not report battery power correctly, so I ran into out-of-power situations that would result in a loose object file that was simply empty, i.e. its length was zero. As far as my analysis back then went, this was not Git's fault, because its `write_loose_object()` function would write to a temporary file first and only move that file into place once it was written fully.

I was then shocked to learn that ext4 apparently has a default setting that allows it to truncate files upon power failure (something about a full journal vs a fast journal or some such) when I had expected the default to be a true journaled file system with proper atomicity regarding writes and moves. I remember that back then, I angrily fixed that setting to make my file system fully journaled.

Maybe this leads you into the direction of a work-around in your setup?

Ciao,
Johannes
