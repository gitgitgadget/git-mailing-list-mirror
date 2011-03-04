From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: why is merging with unstaged changes allowed when rebasing is not?
Date: Fri, 4 Mar 2011 17:32:19 +0100
Message-ID: <AANLkTi=dnyaPTX0Y43nbAGp46NtscKT3a2idxEhkreMm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 17:32:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvXvq-0001H6-0n
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 17:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406Ab1CDQck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 11:32:40 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55246 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759238Ab1CDQck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 11:32:40 -0500
Received: by qwd7 with SMTP id 7so1796678qwd.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=T7Nltf6Sz1m9KfaUrRgUBewHq4q5GWT8J1htU0jFzIg=;
        b=MgWzpwIHQwFaKxTV0lnH5MbDOUoPLUX1PJCZcjLJvwvPnoApzuUtdSUDjNpCR43JSc
         mdQyWDqWHR+VV3hFVdLLV1PW1DemG8kCEt6Z4FAkhrGQ5pKMmCZmSHQskkBmCSHdbyAK
         icX4QL02x8I3oosGdeYvT6jWGn8sE9b3WICh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=pf8buVFlnZBaxXWSS2nPvVo9fz0lcFihhiMtfKMaaxYtQEltbzU7kH2zVxMpiEdl7a
         XHpX336JVQrivdQ02+oADDaoCjoBp37MBIEMfWgzTIWK/ZjWRvMYwPR+sYz8O3bB1ZNs
         iwYFLxkW0w54oSLm7XEOVDKi4EhIANioZ+n6g=
Received: by 10.229.42.133 with SMTP id s5mr618333qce.258.1299256359127; Fri,
 04 Mar 2011 08:32:39 -0800 (PST)
Received: by 10.229.83.197 with HTTP; Fri, 4 Mar 2011 08:32:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168446>

Isn't it inconsistent that I can merge with unstaged changes in my
work-tree but not rebase? I agree that both should fail if the
operation would have to touch the file which has unstaged changes. But
if not - why don't we allow the rebase? (Is it just because we
technically do a "git reset --hard" during the rebase which fails on
unstaged changes?). Here is how tried it out:

git init
touch a b
git add a b
git commit -m initial
echo "a-master" >> a
git commit -a -m "modified a on master"
git checkout -b side HEAD~1
touch c
git add c
git commit -m "added c on side"
echo "b-side" >> b
# git rebase master -> would fail complaining about unstaged changes
# git merge master ->  would not fail

Even a 'git checkout master; git cherry-pick side' works well (but
updates the wrong branch)

Ciao
=A0 Chris
