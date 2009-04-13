From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes  
  misreading
Date: Mon, 13 Apr 2009 15:56:27 +0200
Message-ID: <49E3448B.8010602@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <7vab6rkl5f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 15:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtMfy-00071M-RN
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 15:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZDMN4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 09:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZDMN4l
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 09:56:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:60237 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZDMN4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 09:56:41 -0400
Received: from [10.0.1.101] (p57B7FFE1.dip.t-dialin.net [87.183.255.225])
	by india601.server4you.de (Postfix) with ESMTPSA id 4DEC32F8056;
	Mon, 13 Apr 2009 15:56:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vab6rkl5f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116441>

Junio C Hamano schrieb:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
>> "git archive" is used to create archives from a tree (or commit), so
>> it should not consult any .gitattributes files on working directory.
>>
>> It currently does,...
>=20
> ...which _might_ be actively used as a _feature_ by people; I do not =
think
> it is a bad idea to have a mode of operation where it solely works wi=
th
> in-tree attributes ignoring the work tree ones, and I suspect we prob=
ably
> would want to make that the default, but "so it should not" is probab=
ly a
> bit too strong.
>=20
> For example, an older version may record $Id$ with keyword expansion =
set
> in its in-tree .gitattributes, and you later found it to be a mistake=
 and
> have removed it in the current version.  Re-exporting an older versio=
n
> with the current code wouldn't have $Id$ expanded, but with your patc=
h it
> will.
>=20
> A stronger example would be crlf conversion, I suppose, but the same =
"with
> the current code we can fix it up but after this patch we can't" worr=
y
> applies.
>=20
> So perhaps you may want to resurrect the current behaviour with a new
> option --fix-attributes, whose description would be "normally the com=
mand
> takes attributes settings from the tree being exported, but .gitattri=
butes
> files in it may record wrong attributes you may want to fix while
> exporting.  With this option, corresponding .gitattributes files in t=
he
> work tree will override the in-tree .gitattributes" or something like
> that.

Hmm, "fix" implies that something is broken without this option, which
is not necessarily the case.  A purely descriptive name like
--worktree-attributes fits better IMHO.

Also, the last sentence of the description may be taken to imply a
mixing of attributes from work tree and exported tree is done, which is
not the case with the patch from series 2 (and shouldn't be).  Perhaps:
"With this option, .gitattributes files are read from the work tree
instead of from the exported tree."

Ren=C3=A9
