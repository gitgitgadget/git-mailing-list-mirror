From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] connect: improve check for plink to reduce false
 positives
Date: Thu, 23 Apr 2015 08:50:17 +0200
Organization: gmx
Message-ID: <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
 <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_D?= =?UTF-8?Q?uy?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 08:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlAyO-00052n-L5
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 08:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbDWGul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 02:50:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:49514 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbbDWGuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 02:50:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhAVV-1Yyhe12DwX-00MMWJ; Thu, 23 Apr 2015 08:50:20
 +0200
In-Reply-To: <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:J8f9iC8CnuF/ecW8A6UzBVbE9RgvySkfAvGLNUjMts3IfdCLqiS
 Jh0ufS1rjFry+LQoJ8bNTSQtyAArnuqcVp6uAzQFGaQQyPUDzfoi4KxHQKNLogTHBxgXrUz
 sxXm0OJjr3CaHpiGhwCyaAfqibATaGGsm9ZjAl+cYAQ7yBn1zoJjvwA80ZHMoiYpXCB0o7c
 glvu+0WwEEYxC680yFrlQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267677>

Hi Brian,

On 2015-04-23 02:06, brian m. carlson wrote:

> +				tortoiseplink = tplink == ssh ||
> +					(tplink && is_dir_sep(tplink[-1]));

Maybe have a helper function here? Something like `basename_matches(const char *path, const char *basename, int ignore_case)`? That would be easier to read (I have to admit that I had to wrap my head around the logic to ensure that tplink[-1] is valid; It is, but it requires more brain cycles to verify than I would like).

Also, I am really hesitant to just test the start of the basename; I would rather have an entire basename match so that something  like "PLinKoeln" would not match. (And of course, for Windows I would want that hypothetical `basename_matches()` function to allow basenames to end in `.exe` automatically).

In contrast to Torsten, I am not so concerned about `myplink` scripts: that only affects power users who can easily add the `-batch` into the script, where it actually belongs.

Ciao,
Dscho
