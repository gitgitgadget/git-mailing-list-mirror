From: Jonas Smedegaard <dr@jones.dk>
Subject: Re: [TopGit] Multiple concurrent sets of patches
Date: Tue, 3 Mar 2009 20:22:21 +0100
Message-ID: <20090303192221.GV12820@jones.dk>
References: <20090303113741.GO12820@jones.dk> <20090303130316.GA17702@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Cc: pasky@suse.cz, u.kleine-koenig@pengutronix.de,
	martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 20:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaEP-0004Dv-IO
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbZCCTWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757663AbZCCTWi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:22:38 -0500
Received: from 0x573b188a.cpe.ge-1-2-0-1101.hknqu1.customer.tele.dk ([87.59.24.138]:37633
	"EHLO xayide.jones.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbZCCTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:22:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by xayide.jones.dk (Postfix) with ESMTP id 42EBA11B961;
	Tue,  3 Mar 2009 20:22:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at jones.dk
Received: from xayide.jones.dk ([127.0.0.1])
	by localhost (xayide.jones.dk [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id KN-GRhBbiytC; Tue,  3 Mar 2009 20:22:31 +0100 (CET)
Received: from auryn.jones.dk (auryn.jones.dk [192.168.222.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by xayide.jones.dk (Postfix) with ESMTPS id 1054111B7F9;
	Tue,  3 Mar 2009 20:22:30 +0100 (CET)
Received: by auryn.jones.dk (Postfix, from userid 1000)
	id 735951B977A; Tue,  3 Mar 2009 20:22:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090303130316.GA17702@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Face: "yShHCQ6@h{]=Se"1&kVc#Yd%l<B\s%RAjk)T'F6yYw3/unDabXtVB2LIg(-J0zo^aE2 U[s (uhG@f$_ZpbxE53gCn:WZ_a.Gz8yI;ko-,iqW@*+8k<F$2G-nyl;^55>b=>9&
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112151>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, Mar 03, 2009 at 02:03:16PM +0100, martin f krafft wrote:
>also sprach Jonas Smedegaard <dr@jones.dk> [2009.03.03.1237 +0100]:
>> It seems to me that TopGit is incapable of handling this. That it can 
>> only handle patchset against a single branch, and if the need arise 
>> for restructuring an additional patchset for e.g. a stable or 
>> oldstable branch, then quilt needs to be used manually anyway.
>
>Let me try to understand you: you want TopGit to maintain a single
>feature branch against two different source branches? How should
>that work? Could you elaborate a bit so that your needs become a bit
>more obvious?

Not quite. I want TopGit to maintain multiple feature branches, 
preferrably related.

With "related" I mean that I would like to be able to "fork" a chain of 
interdependent feature branches.

TopGit easily support one chain of branches:

upstream + pristine-tar -> master -> build

I want TopGit to additionally support the following:

upstream + pristine-tar -> stable-master -> stable-build

upstream + pristine-tar -> oldstable-master -> oldstable-build


E.g. in addition to TopGit branches t/fix_01 and t/feature_01 I would 
want to fork those branches as t_stable/fix_01 and t_stable/feature_01.


I know that I can create all those TopGit branches one by one, but I 
would then need to explicitly declare a list of TopGit branches to apply 
each time I want to (re)generate a quilt patchlist.


Perhaps what I really am looking for here is something like "tg tag":

    git checkout t/fix_01
    tg tag t/fix_01 master
    git checkout -b t_stable/fix_01 t/fix_01
    tg tag -d master
    tg tag stable
    git checkout stable_build
    ./debian/rules tg-export tags=stable


...or perhaps this is not relevant upstream to TopGit at all but only to 
your packaging of a "tg-export" rule?


    - Jonas

- -- 
* Jonas Smedegaard - idealist og Internet-arkitekt
* Tlf.: +45 40843136  Website: http://dr.jones.dk/

    [x] quote me freely  [ ] ask before reusing  [ ] keep private
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtg20ACgkQn7DbMsAkQLhQGQCfQjtfJzzQUu6B0qywpkmxmdGp
66oAnjEtR2Dc/zJ+lMoP3TD3jy1pr1s9
=MwTs
-----END PGP SIGNATURE-----
