From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH 8/8] git-p4: support clone --bare
Date: Tue, 8 Feb 2011 10:18:13 +0100
Message-ID: <AANLkTinmttwtgF+RdG7Sr9aMi=awKeWZnHVME+9Z_Np+@mail.gmail.com>
References: <20110205224848.GA30963@arf.padd.com>
	<20110205225247.GI30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 10:18:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmjiQ-0004aU-Cs
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 10:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1BHJSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 04:18:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40065 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1BHJSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 04:18:14 -0500
Received: by gxk9 with SMTP id 9so2119740gxk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ez29m2Pk4HTIlJZvoAJrfSF/7oIjUx/m1JVKBgOKb2s=;
        b=kgKEqTnmnZNe2vAmjDCwa6vfOGWRkN8N9CC2WToraAH8Oe1MxqnusuuuCO9PSVuB3Y
         U/oxHUJ4CjAIQpNh3VZAAtROPNkskdOzmPfDlDVBG4WIbgsHiTcCLdNTiHaunElNTlHA
         AAD+rdv2x8Wk5u6g7rk3ToUMXy8Chk1n82aVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IE482cFKAyJ0W1U6SPFyS4nMEP5RsOogPkbxvC3DM7B6r6dnna56Bg366QV06xgj2V
         Yr8cBfPj5ic/RVR3Gxd84gZupmz4XYK9+wmxMDG91escqlgyh9IsayRd2piaL0QOiWyU
         ezFf7h5U4x3MkFzWp0rBpJO7DNf9M0pWuI7nY=
Received: by 10.101.133.20 with SMTP id k20mr10348580ann.250.1297156693857;
 Tue, 08 Feb 2011 01:18:13 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Tue, 8 Feb 2011 01:18:13 -0800 (PST)
In-Reply-To: <20110205225247.GI30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166342>

On Sat, Feb 5, 2011 at 11:52 PM, Pete Wyckoff <pw@padd.com> wrote:
> Just like git clone --bare, build a .git directory but no
> checked out files.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-By: Tor Arvid Lund <torarvid@gmail.com>

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 17 +++++++++++++----
> =C2=A0t/t9800-git-p4.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 10=
 ++++++++++
> =C2=A02 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 5b08cd6..efc5dce 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1771,10 +1771,13 @@ class P4Clone(P4Sync):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D"where to leave=
 result of the clone"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optparse.make_option("-/", =
dest=3D"cloneExclude",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0action=3D"append", typ=
e=3D"string",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D"exclude depot path")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D"exclude depot path")=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optparse.make_option("--ba=
re", dest=3D"cloneBare",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D"store_true", defau=
lt=3DFalse),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cloneDestination =3D None
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.needsGit =3D False
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cloneBare =3D False
>
> =C2=A0 =C2=A0 # This is required for the "append" cloneExclude action
> =C2=A0 =C2=A0 def ensure_value(self, attr, value):
> @@ -1814,11 +1817,16 @@ class P4Clone(P4Sync):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cloneDestination =3D s=
elf.defaultDestination(args)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "Importing from %s into %s" % (', '=
=2Ejoin(depotPaths), self.cloneDestination)
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(self.cloneDestinati=
on):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(self.cloneDesti=
nation)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 chdir(self.cloneDestination)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git init")
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0self.gitdir =3D os.getcwd() + "/.git"
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0init_cmd =3D [ "git", "init" ]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.cloneBare:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_cmd.append("--bare")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0subprocess.check_call(init_cmd)
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not P4Sync.run(self, depotPaths):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.branch !=3D "master":
> @@ -1828,7 +1836,8 @@ class P4Clone(P4Sync):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 masterbranch =
=3D "refs/heads/p4/master"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if gitBranchExists(masterbr=
anch):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system("git b=
ranch master %s" % masterbranch)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system("git =
checkout -f")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.=
cloneBare:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
system("git checkout -f")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "Could =
not detect main branch. No checkout/master branch created."
>
> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 72c38af..1e7639b 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -87,6 +87,16 @@ test_expect_success 'wildcard files git-p4 clone' =
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf "$git" && mkdir "$git"
> =C2=A0'
>
> +test_expect_success 'clone bare' '
> + =C2=A0 =C2=A0 =C2=A0 "$GITP4" clone --dest=3D"$git" --bare //depot =
&&
> + =C2=A0 =C2=A0 =C2=A0 cd "$git" &&
> + =C2=A0 =C2=A0 =C2=A0 test ! -d .git &&
> + =C2=A0 =C2=A0 =C2=A0 bare=3D`git config --get core.bare` &&
> + =C2=A0 =C2=A0 =C2=A0 test "$bare" =3D true &&
> + =C2=A0 =C2=A0 =C2=A0 cd "$TRASH_DIRECTORY" &&
> + =C2=A0 =C2=A0 =C2=A0 rm -rf "$git" && mkdir "$git"
> +'
> +
> =C2=A0test_expect_success 'shutdown' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pid=3D`pgrep -f p4d` &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -n "$pid" &&
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
