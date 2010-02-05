From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Remove .git auto detection from setup_git_env()
Date: Fri, 05 Feb 2010 21:29:34 +0100
Message-ID: <4B6C7FAE.5070104@lsrfire.ath.cx>
References: <1265370468-6147-1-git-send-email-pclouds@gmail.com> <20100205151239.GC14116@coredump.intra.peff.net> <7vy6j7a98f.fsf@alter.siamese.dyndns.org> <7vljf7a901.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:30:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUoZ-0006oB-Ev
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab0BEU3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 15:29:52 -0500
Received: from india601.server4you.de ([85.25.151.105]:49742 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab0BEU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:29:51 -0500
Received: from [10.0.1.100] (p57B7DAFB.dip.t-dialin.net [87.183.218.251])
	by india601.server4you.de (Postfix) with ESMTPSA id A2D332F803C;
	Fri,  5 Feb 2010 21:29:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7vljf7a901.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139079>

Am 05.02.2010 18:27, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> This topic started from "We broke 'git grep' in .git directory" and =
I
>> think it is the sanest to revert 3081623 (grep --no-index: allow use=
 of
>> "git grep" outside a git repository, 2010-01-15) which nobody has us=
ed so
>> far in any released version of git, until we sort this out at least.
>=20
> Sorry; spoke too fast.  We'd also need to revert the one to git.c (7e=
62265
> (grep: prepare to run outside of a work tree, 2010-01-15) as well.

>  		{ "fsck-objects", cmd_fsck, RUN_SETUP },
>  		{ "gc", cmd_gc, RUN_SETUP },
>  		{ "get-tar-commit-id", cmd_get_tar_commit_id },
> -		{ "grep", cmd_grep, USE_PAGER },
> +		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
>  		{ "hash-object", cmd_hash_object },
>  		{ "help", cmd_help },
>  		{ "index-pack", cmd_index_pack },

There is one other command with only the USE_PAGER flag turned on, whic=
h
also seems to have been broken by the change to remove the RUN_SETUP
flag: shortlog.  But that was done in March 2008 (abe549e1, "shortlog:
do not require to run from inside a git repository"), so it's no regres=
sion.

Ren=C3=A9
