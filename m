From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: How to create patches for a merge?
Date: Thu, 18 Feb 2010 03:40:07 -0800
Message-ID: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 12:40:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4kG-0008Gl-N3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935Ab0BRLkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 06:40:13 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:50885 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab0BRLkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 06:40:08 -0500
Received: by pzk2 with SMTP id 2so2397943pzk.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Mu99zhTCTTy5iygUa2DSxC1Q+ENApENmw05hNsZ86xM=;
        b=LixCL2e8ZqVDM0kuj/oM5X0ebliklryXY+X/tnQvorgaRt44k9KkjwhhumlsZODOgQ
         5U+mupcr92TyLQ3K9kWpnDZVYXkHSLbnLI137y+zqlUL4DZdZcQbp+xROMDZZCbekQha
         M8raN7C+t9D60Uebje1J/otjqruMph4HrhBYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=J26j5qwl/QTV96q0g8JkXw/w8bmEfW9rcRwRHa/uR9rrv70FIuuOfDlESrTPx9OfWv
         70J45h9vfmV/j6EJS+Ar9F8uKWfnH0s6QDMPRZb9odRC+LfEz69gpxpryL4c07ju2sVp
         8FDdKjcwmuzvqCAPScyl5alR2WGUxZwoZW5n8=
Received: by 10.142.62.34 with SMTP id k34mr6252435wfa.282.1266493207222; Thu, 
	18 Feb 2010 03:40:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140321>

When I use=C2=A0"git format-patch", it doesn't seem to include merges. =
How
can I perform a merge and then e-mail it to someone as a set of
patches?

=46or example, let's say that I merge two branches and perform another
commit on top of the merge:

git init

echo "initial file" > test.txt
git add test.txt
git commit -m "Commit A"

git checkout -b foo master
echo "foo" > test.txt
git commit -a -m "Commit B"

git checkout -b bar master
echo "bar" > test.txt
git commit -a -m "Commit C"

git merge foo
echo "foobar" > test.txt
git commit -a -m "Commit M"

echo "2nd line" >> test.txt
git commit -a -m "Commit D"

This creates the following tree:

=C2=A0 =C2=A0 B
=C2=A0 / =C2=A0 \
A =C2=A0 =C2=A0 =C2=A0 M - D
=C2=A0 \ =C2=A0 /
=C2=A0 =C2=A0 C

Now I try to checkout the initial commit and replay the above changes:

git checkout -b replay master
git format-patch --stdout master..bar | git am -3

This produces a merge conflict. In this scenario,=C2=A0"git format-patc=
h
master..bar"=C2=A0only produces 3 patches, omitting "Commit M". How do =
I
deal with this?

-Geoffrey Lee
