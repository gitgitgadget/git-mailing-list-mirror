From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Wed, 24 Sep 2008 09:13:28 +0200
Message-ID: <48D9E898.1020305@op5.se>
References: <48D95836.6040200@op5.se>	<20080923162211.d4b15373.stephen@exigencecorp.com>	<48D95FE1.30200@op5.se> <20080924001027.GA19264@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 09:14:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiOaC-0003mo-AJ
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 09:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbYIXHNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 03:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYIXHNf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 03:13:35 -0400
Received: from mail.op5.se ([193.201.96.20]:43455 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbYIXHNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 03:13:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5A8ED24B0002;
	Wed, 24 Sep 2008 09:04:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.027
X-Spam-Level: 
X-Spam-Status: No, score=-4.027 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.372, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SXCm8FYpEMdg; Wed, 24 Sep 2008 09:04:05 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 460CC24B0004;
	Wed, 24 Sep 2008 09:04:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080924001027.GA19264@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96620>

SZEDER G=E1bor wrote:
> Hi Andreas,
>=20
> First of all, thanks for the work!
>=20
> On Tue, Sep 23, 2008 at 11:30:09PM +0200, Andreas Ericsson wrote:
>> It requires a bit of testing though. All the t/t34* tests pass with
>> all the patches applied, and some manual tries worked just fine too,
>> but if you wanna give it a twirl where you work, that'd be great.
> Unfortunately in my example workflow[1] posted earlier today your
> patch series does not work in the way I would like it to behave.
>=20
> The following DAG is created by the commands below:
>=20
>   -A---B      master
>     \
>      C---M    topic
>       \ /
>        D
>=20
>   git init
>   echo 1 >foo
>   git add foo
>   git commit -m 'first on master'       # A
>   echo 2 >>foo
>   git commit -m 'second on master' foo  # B
>   git checkout -b topic HEAD^
>   echo 1 >bar
>   git add bar
>   git commit -m 'first on topic'        # C
>   git checkout -b subtopic
>   echo 1 >baz
>   git add baz
>   git commit -m 'first on subtopic'     # D
>   git checkout topic
>   git merge --no-ff subtopic            # M
>=20
> If I now execute 'git rebase -p master topic', I get the following:
>=20
>   -A---B            master
>     \   \
>      \   C'---M'    topic
>       \      /
>        C----D
>=20
> But I would rather like to have the following:
>=20
>   -A---B            master
>         \
>          C'---M'    topic
>           \  /
>            D'
>=20
> Would such a behaviour possible at all?
>=20

See Johannes Sixt's reply (git sequencer).
What I provided was a hack to access existing functionality in a way
that was previously not possible. While that can be neat in itself,
the patch series doesn't alter how the merge-preserving rebase works
in the slightest.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
