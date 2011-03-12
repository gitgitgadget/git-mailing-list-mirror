From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: Cannot fetch whole history from Perforce
Date: Fri, 11 Mar 2011 22:45:40 -0800
Message-ID: <AANLkTiktQqzxFLn7R+EKm-WxWp95xZoGqKu7ijtRHASe@mail.gmail.com>
References: <AANLkTik6fxHUJbp6dWdAgV-wr=P=FxK1K-vGAGy8ruBd@mail.gmail.com>
	<AANLkTin6BBD+b2OYRk32GyAaEqFa-V7T1B7jEVujRkuL@mail.gmail.com>
	<AANLkTimaB3BU3YQgC7qgqUH=qYGrthPxnz63b-MLAbCR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Berg <merlin66b@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 07:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyIaE-0005kO-SD
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 07:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1CLGpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Mar 2011 01:45:44 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43385 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1CLGpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Mar 2011 01:45:43 -0500
Received: by bwz15 with SMTP id 15so3229104bwz.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 22:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fVFnNzJ2tcKGUXeL8aTE2Tg8/cj71vYhFl1ZVWHHFFQ=;
        b=aGMLHBdI5XHCqIagBPvseBw2VGE6HjHsWHICPHUCQKdBj7qiJiX5yLn4GagYPn+zNK
         NW/HKYqBmZZb6MeaP5bavmJ/iRZUTundKG6NwfKOHLTOQu+gdIOe7lPmSv7pf9bBo827
         iEI1lPOWyuDH7TiDOMqWdnk1eayOUwQ6O5XDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UfgLdwtNhAc73YyxEZDxfd7PGcL0nLXbWj2W3sTM8FwCLykyM20yq914o3QL+ks5vG
         +kdly7cpn+h2kT90VnrL0ed6B+q7VXHj0C1V4aZvBWJPOCxiSzY45p7Kx3q3BsNL2o7I
         mljxP6noOlMMgkS9jMhgkFl0WB9CAh3vOqviE=
Received: by 10.205.24.9 with SMTP id rc9mr8724751bkb.92.1299912341298; Fri,
 11 Mar 2011 22:45:41 -0800 (PST)
Received: by 10.204.23.71 with HTTP; Fri, 11 Mar 2011 22:45:40 -0800 (PST)
In-Reply-To: <AANLkTimaB3BU3YQgC7qgqUH=qYGrthPxnz63b-MLAbCR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168936>

Sorry for the slow response.

On Tue, Mar 8, 2011 at 2:33 PM, Tor Arvid Lund <torarvid@gmail.com> wro=
te:
> On Tue, Mar 8, 2011 at 9:36 PM, Thomas Berg <merlin66b@gmail.com> wro=
te:
>> Hi,
>>
>> On Tue, Mar 8, 2011 at 7:09 PM, Anatol Pomozov <anatol.pomozov@gmail=
=2Ecom> wrote:
>>> Hi, I am using HEAD version of the git and I have an issue with git=
-p4
>>> tool (p4 to git importer).
>>>
>>> git-p4 works fine when I import HEAD version of my project
>>>
>>> $ git p4 clone //depot/foo/bar --verbose
>>> But it fails with a cryptic error when I try to import @all revisio=
ns:
>> [...]
>>>
>>> $ git p4 clone //depot/foo/bar@all --verbose
>>> Importing from //depot/foo/bar@all into bar
>> [...]
>>>
>>> Can it be related to Pete's changes?
>>> http://permalink.gmane.org/gmane.comp.version-control.git/167281
>
> Whoops! The P4Clone class is a subclass of P4Sync, which means that
> this check (The one you mention from e32e00dc) will be done on every
> clone with @all. We can't have that :)
>
> It works for me if I patch it with this one-liner (but it's not
> exactly a beautiful looking line of code anymore):
>
> =C2=A0 =C2=A0-- Tor Arvid
> ---
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2df3bb2..7cb479c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1763,7 +1763,7 @@ class P4Sync(Command):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changes.sort(=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.=
p4BranchesInGit:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not isins=
tance(self, P4Clone) and not self.p4BranchesInGit:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 die("No remote p4 branches. =C2=A0Perhaps you never
> did \"git p4 clone\" in here.");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.verbo=
se:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 print "Getting p4 changes for %s...%s" % (',
> '.join(self.depotPaths),

Yep it fixes the problem for me. Do you have a plan to propose it for u=
pstream?
