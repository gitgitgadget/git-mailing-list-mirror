From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Wed, 5 Oct 2011 19:28:40 +1100
Message-ID: <CACsJy8DDcMPVFm2t3xTo1U3SthZEktOCQBBwwJwvSiQer9KuUg@mail.gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com> <vpqd3ebn9nc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 05 10:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBMqs-000374-AW
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 10:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1JEI3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 04:29:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab1JEI3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 04:29:11 -0400
Received: by bkbzt4 with SMTP id zt4so1807955bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=B0t/VtnJej5McFHs0i2L2020zC9WGXrh4XhJICMMIhE=;
        b=EOHMDwJNxBMya5/Hfz8rCugFbZiLyJGjD+n25hG3NqP0CbpcwYrnVRY8wgGnDsHGbS
         99GnqjgALU49UvtGZZABpyenei7Mxi41lgg38JjoqVABXdqNofAqn+P1z50bMXGPyPtu
         E2gqfIUHvuiLEvgJxvDVNiLH2uLFCZho4PMF4=
Received: by 10.204.141.134 with SMTP id m6mr1291451bku.199.1317803350153;
 Wed, 05 Oct 2011 01:29:10 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 01:28:40 -0700 (PDT)
In-Reply-To: <vpqd3ebn9nc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182837>

2011/10/5 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This series adds --exclude that uses .gitignore mechanism remove
>> commits whose changes that are _entirely_ excluded.
>
> I'd see this --exclude as the opposite of specifying files, i.e. in a
> repository containing directories A, B and C,
>
> git log --exclude=3DB
>
> would be the same as
>
> git log A C

I think I emphasized it too much. "git log --exclude=3DB/ A B C" should
be equivalent to "git log A C". If changes touch A or C, then no
matter they touch B, the commit will always be in. If changes only
touch B, neither A nor B, then the commit is removed, exactly the same
case with "git log A C".

>> Because it uses .gitignore mechanism, beware that these patterns do
>> not behave exactly like pathspecs

if you specify --exclude=3DB, then A/.../B, C/.../B are all removed. A
subtle difference between pathspec and .gitignore.

> and because "git log --stat A C" (or --patch) will show the diff only
> for A and C for commits touching all directories.

I'll take care of --patch and friends later. They both (--patch and
commit pruning) use the same diff mechanism, if we get it right for
for commit pruning, --patch will come nicely.
--=20
Duy
