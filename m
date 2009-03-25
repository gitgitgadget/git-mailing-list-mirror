From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 11:20:23 -0700
Message-ID: <8c9a060903251120j3e757e94o96b2b77669c16c61@mail.gmail.com>
References: <49CA7428.70400@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Mar 25 19:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXpV-0004pP-EC
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757AbZCYS01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbZCYS01
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:26:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:42282 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbZCYS00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 14:26:26 -0400
Received: by wf-out-1314.google.com with SMTP id 29so171259wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5ob9rrUzfwncPx6OSM8lO3Gg/6CXBCzQk7IsVdyIKng=;
        b=FdI+vO8pmXRPkrWi7UtkFbEY8w9qLeGlYuep06/AHCnsnyvDyqkfbGcCXOP6IXliSO
         MO7s7+HMutookP07mgQfmNgzSihNKuirHyNLjiodr4Xb4rF+KYa6JCmbdPI0ZVWPuDIA
         YZsC29TsA62rKZY7+VvzpvA929XLjKCaax+bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FsLjkZLXj1VDuOSFjy4/8M6PFtFJWV1ZuR7ep0B0CtwpqbQ1MijJiYTXXFiWMX98HX
         xxnblmPbkxu2UwcnUkUHQVhLWJZEf2h0JrA5B8eGFGKOodqSUDWERyMzGyuzpVm/t/Db
         KVkTpZPG9nWKuKammFmdi0D/WMqiIpbc5K6Kc=
In-Reply-To: <49CA7428.70400@obry.net>
Received: by 10.143.29.17 with SMTP id g17mr4037923wfj.109.1238005238244; Wed, 
	25 Mar 2009 11:20:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114638>

On Wed, Mar 25, 2009 at 11:12, Pascal Obry <pascal@obry.net> wrote:
>
> Starting a new project I create a new repo and added some files for t=
he
> initial revision of the project, something like:
>
> mkdir repo.git
> cd repo.git
> git init
> touch file
> git add file
> git ci -m "initial revision"
>
> Now one file was not meant to be committed, I wanted to revert this c=
ommit:
>
> git reset HEAD^
>
> fatal: ambiguous argument 'HEAD^': unknown revision or path not in th=
e
> working tree.
> Use '--' to separate paths from revisions
>
> I understand that HEAD^ does not exist, is there a way to do that?
>
> Thanks,
> Pascal.
>
> --
>
> --|------------------------------------------------------
> --| Pascal Obry =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Team-Ada Member
> --| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
> --|------------------------------------------------------
> --| =C2=A0 =C2=A0http://www.obry.net =C2=A0- =C2=A0http://v2p.fr.eu.o=
rg
> --| "The best way to travel is by means of imagination"
> --|
> --| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

You want "git filter-branch".  Probably something like:

git filter-branch --index-filter 'git rm --cached --ignore-unmatched
=46ILE_TO_REMOVE' -- --all

This will remove FILE_TO_REMOVE from all commits across all branches.

-Jacob
