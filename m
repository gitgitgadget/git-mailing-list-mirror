From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Mon, 9 Aug 2010 14:36:19 -0500
Message-ID: <AANLkTi=TeJvF+swpMWddDtA7jh4XWedQ+FjigEdRYkx_@mail.gmail.com>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 21:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiY9K-0000hK-SK
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0HITgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:36:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55622 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab0HITgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 15:36:40 -0400
Received: by yxg6 with SMTP id 6so3536457yxg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=BNJjqRNiNtC4jP2iI3dMkjm+34P9qleeg2haqRMJ6Os=;
        b=qn4GiK0ipDYwEBtLldLVN5wuXR8PSCMaknXy382zgmm1RCvq6b18SrNAYBNnyhfIl2
         afD4OVTotXnH6EqvAbZ7NDZSUMg85bnGmIRwKYet1XgckRaSGToECrrW3LgfjbikSHig
         0uqyVDcRQ8AvlfK+SrcHm6A6ZJ3j/PHRNE6bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=thYx7B/uU/GkpiWWTIdZEVF2ePGvV49f9F8PNmyqt8aib1hIGNgEld+Q646EKv0tYM
         waqrrukcipHscCqnR8Ab5SvPctdQqiVUNJzSWZFs8iHheJqSo5pJx+88mKNvweOP+PYM
         f2cyfrhxQEloXkC+V1HuhJHJkMRaL/mFTjedA=
Received: by 10.150.68.35 with SMTP id q35mr18237507yba.210.1281382599312; 
	Mon, 09 Aug 2010 12:36:39 -0700 (PDT)
Received: by 10.231.181.4 with HTTP; Mon, 9 Aug 2010 12:36:19 -0700 (PDT)
In-Reply-To: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153006>

On Thu, Jul 29, 2010 at 07:37, Adam Mercer <ramercer@gmail.com> wrote:

> I'm trying to use git filter-branch to move all contents of a repo
> into a subdirectory of the repo root. The git filter-branch man page
> has the following example:
>
> =A0 =A0 =A0 To move the whole tree into a subdirectory, or remove it =
from there:
>
> =A0 =A0 =A0 =A0 =A0 git filter-branch --index-filter \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 'git ls-files -s | sed "s-\t\"*-&=
newsubdir/-" |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_INDEX_FILE=3D=
$GIT_INDEX_FILE.new \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g=
it update-index --index-info &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mv $GIT_INDEX_FILE.new $GIT_IN=
DEX_FILE' HEAD

I'm trying to do this with another repo now and am getting a different
error message:

$ git filter-branch --index-filter \
    'git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
        GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
            git update-index --index-info &&
    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
Rewrite b3100fb24a7eb2f349801f3b87cf995dc3d14bba (1/44)mv:
/Users/ram/git/eah2/.git-rewrite/t/../index.new: No such file or
directory
index filter failed: git ls-files -s | gsed "s-\t\"*-&sftlib/-" |
GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new git update-index --index-info && m=
v
$GIT_INDEX_FILE.new $GIT_INDEX_FILE
$

Any ideas?

This is on Mac OS X 10.6.4, with git-1.7.2.1, and GNU sed 4.2.1

Cheers

Adam
