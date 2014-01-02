From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 22:19:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401022212150.1191@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com> <52C5D0AB.7050309@gmail.com> <xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypgC-00047F-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbaABVTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:19:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:50656 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbaABVTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:19:42 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Le5bY-1VdojB1BN6-00psTC
 for <git@vger.kernel.org>; Thu, 02 Jan 2014 22:19:41 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:KIjKbWKjkgGOs3ftbGWF37ZDlB7r1gEvzeUhByEii7fKs5+FXl4
 E7cD6hLMu4u0lPaatH3frfon3Q4ga8srrxTM7cX3iQT6uo+DOEBlR3K7/gW4sezKdEujR9H
 9jvRU/0Ij216nWSVawxvv8I9GOPoA5GKeopmxn0o4OINl4GHb9XXBx7sb1dqk35MtDzwOrw
 pHHdXSwDgqSe0bxK8bVIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239885>

Hi Junio,

On Thu, 2 Jan 2014, Junio C Hamano wrote:

> If we are going to change the meaning of the function so that it can
> now take any random path in platform-specific convention

Note that nothing in the function name or documentation suggests
otherwise.

> that may be incompatible with the internal notion of paths Git has (i.e.
> what is passed to safe_create_leading_directories() may have to be
> massaged into a slash-separated form before it can be used in the index

The safe_create_leading_directories() function never interacts with the
index, so you find me quite puzzled as to your objection.

> and parsed to be stuffed into trees), it is fine to do so as long as all
> the codepaths understands the new world order, but my earlier "git grep"
> hits did not tell me that such a change is warranted.

You call safe_create_leading_directories() with an argument that is
supposed to be the final path, correct? So what exactly is wrong with
safe_create_leading_directories() creating all the directories necessary
so that we can write to the path afterwards, *even* if that path is
interpreted in a platform-dependent manner (as one would actually expect
it to)?

Last time I checked we did not make a fuss about
safe_create_leading_directories() interpreting the argument in a
case-insensitive fashion on certain setups, either. So it is not exactly a
new thing that the paths are interpreted in a platform-dependent manner.

Ciao,
Johannes
