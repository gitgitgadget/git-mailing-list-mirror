From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/5] pretty describe: add name info to struct commit
Date: Sun, 04 Nov 2007 16:06:58 +0100
Message-ID: <472DE012.7040001@lsrfire.ath.cx>
References: <472DB186.9030909@lsrfire.ath.cx> <20071104140700.GB3078@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 16:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioh4j-0002Re-AW
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 16:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695AbXKDPHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 10:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756550AbXKDPHV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 10:07:21 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:51001
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754100AbXKDPHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 10:07:16 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id B32A3873BA;
	Sun,  4 Nov 2007 16:07:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071104140700.GB3078@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63415>

Alex Riesen schrieb:
> Ren=E9 Scharfe, Sun, Nov 04, 2007 12:48:22 +0100:
>> diff --git a/commit.h b/commit.h
>> index b661503..80e94b9 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -18,6 +18,9 @@ struct commit {
>>  	struct commit_list *parents;
>>  	struct tree *tree;
>>  	char *buffer;
>> +	char *name;
>> +	unsigned int name_flags;
>> +	char name_prio;
>>  };
>=20
> It increases size of struct commit by ~12 bytes (assuming 4byte
> allignment), and this is a popular structure. Besides, the three new
> fields used by only git-describe, which nobody has in their top-ten
> used commands (see "best git practices" thread).

True.  When I was looking for a place for the name info I was a bit
worried about this increase, but dismissed it after looking at the
kernel repository: there are ca. 140000 commits, which means my patch
increased memory usage by 2MB for commands that operate on all commits
at the same time.  I haven't taken any measurements to back up this
estimate, though..

I had looked briefly at the decorate stuff that Dscho mentioned in
another reply, but I can't remember why I didn't use it.  Guess I wasn'=
t
motivated enough by those 2MB. ;-)  I'll take another look.

Thanks,
Ren=E9
