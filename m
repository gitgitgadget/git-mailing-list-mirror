From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Let users override name of per-directory ignore file
Date: Mon, 22 Oct 2007 13:18:14 +0200
Message-ID: <471C86F6.6010705@op5.se>
References: <20071021144542.8855A5BB85@nox.op5.se> <20071022105029.GB31862@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvIk-0003lL-B8
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbXJVLST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 07:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXJVLST
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:18:19 -0400
Received: from mail.op5.se ([193.201.96.20]:59407 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbXJVLSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:18:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 82A0A1730683;
	Mon, 22 Oct 2007 13:18:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.462
X-Spam-Level: 
X-Spam-Status: No, score=-2.462 tagged_above=-10 required=6.6
	tests=[AWL=0.037, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORwA7G8jbMjJ; Mon, 22 Oct 2007 13:18:15 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 88E7A173064F;
	Mon, 22 Oct 2007 13:18:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071022105029.GB31862@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61988>

Karl Hasselstr=F6m wrote:
> On 2007-10-15 14:09:32 +0200, Andreas Ericsson wrote:
>=20
>> When collaborating with projects managed by some other scm, it often
>> makes sense to have git read that other scm's ignore-files. This
>> patch lets git do just that, if the user only tells it the name of
>> the per-directory ignore file by specifying the newly introduced git
>> config option 'core.ignorefile'.
>=20
>> +	For example, setting core.ignorefile to .svnignore in
>> +	repos where one interacts with the upstream project repo
>> +	using gitlink:git-svn[1] will make a both SVN users and
>> +	your own repo ignore the same files.
>=20
>> +   The name of the `.gitignore` file can be changed by setting
>> +   the configuration variable 'core.ignorefile'. This is useful
>> +   when using git for projects where upstream is using some other
>> +   SCM. For example, setting 'core.ignorefile' to `.cvsignore`
>> +   will make git ignore the same files CVS would.
>=20
> I agree with what you're trying to do, but you're ignoring the fact
> that Subversion's ignore patterns (and possibly cvs's too -- I haven'=
t
> checked) are not recursive, while the patterns in .gitignore are
> recursive per default. So using ignore patterns directly from
> Subversion ignores more files under git than the same patterns did
> under Subversion.
>=20

Yes, I just got bitten by this. The top-level .cvsignore file ignores=20
Makefile (since it's generated from ./configure), but Makefile exists i=
n=20
several subdirectories where it's *not* generated, but adding !Makefile=
=20
to all those places doesn't sit too well with some of the project=20
maintainers, and cvs doesn't grok /Makefile to mean "toplevel Makefile"=
=20
(and it shouldn't since it has no notion of recursive ignores).

> One possible way to solve that would be to optionally have
> non-recursive per-directory ignore files. I haven't looked at how thi=
s
> is implemented, though, so I don't know if it's a good suggestion or
> not.
>=20

I'll have a look at it. Thanks for the review.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
