From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Turn git-rebase--*.sh to external helpers
Date: Wed, 17 Feb 2016 20:36:38 +0700
Message-ID: <1455716201-29784-1-git-send-email-pclouds@gmail.com>
References: <vpqio1nsk0q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu.Moy@grenoble-inp.fr, sbeller@google.com, peff@peff.net,
	christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 14:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2HY-0002LB-KT
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbcBQNgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 08:36:37 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34168 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422802AbcBQNgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:36:35 -0500
Received: by mail-pf0-f181.google.com with SMTP id x65so11707156pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HuvTKYde9kf+eiLdqoSw+denYYwuohJe4QVnOj1QK8Q=;
        b=xjRd73nWfiGAXlFYoZH/gd+W+tu3IBmUDUnNjIQDxTW5BTyZH1CWScGu3s3z9m/h7J
         /8BguLcUa6MN6i4e/EtD//+ni2fwoVad6s/F5/VysVfUN6rFTLCEPPPEgQ2QlI9aSil7
         rBaIb9ct5TksJ8lnHwyolQ/Z6BUEAjBJpCJCHq7G2wYFBuo+tiE8ooe65rwUm+dyZcok
         rTrJmv8HxL69sh04Q9JiNqqNyKPBStvXF72jbW2mQzj8Ku0dRe/EDQ9z3gxxe2lJ6QpX
         DXyKQHH0bZiays93dXCELyliaEkYrdUBHWQd+lfRkf4tqx/90N+lkKhLbZmCvcQhXqcf
         M3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HuvTKYde9kf+eiLdqoSw+denYYwuohJe4QVnOj1QK8Q=;
        b=dlasS40b1INYu9QXZPRHUPJWxAkWWtzvIpKWCpjiuvvIWTwLR7v3vuISA5Kyy8Z5lt
         XmUPn9EpBEWTF+hcBw63ni0UaHdT87kgg4CuxaGic5mTYsDL6zynXCuxJYYlx0j1NF+e
         3zRyPef7LfTEAww0b+Ug9oastv8MlYFsrDvxOxYEmyMjxeygxeVrK1YOvqYaplmfFChz
         605/JL9EfHwsppMetg3MburR6pM24K+hrKAces+ls+31Pzg6P1z8IynBl52KmTzActVG
         FnzQsPVtD5x+WTQTe13vNmZ9cQLpZtMuQKJxl3j+vl9lFO6T7yAtFCv2Y+xfrzrWedYW
         J7bA==
X-Gm-Message-State: AG10YOSJ9kSdDmVdWudOobT1ZiwsP5CbUPj3VAHDroOv03v6v8BiqXDJEgsHkqj7jbAgtA==
X-Received: by 10.98.68.193 with SMTP id m62mr2149922pfi.130.1455716195354;
        Wed, 17 Feb 2016 05:36:35 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id c24sm2957334pfj.41.2016.02.17.05.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 05:36:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Feb 2016 20:36:57 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <vpqio1nsk0q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286498>

On Wed, Feb 17, 2016 at 5:34 PM, Matthieu Moy <Matthieu.Moy@grenoble-in=
p.fr> wrote:
> There's a funny exercice there: the git-rebase--$type.sh scripts are =
not
> called as external helpers, but like this:
>
> run_specific_rebase () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ "$interactive_rebase" =3D implied ];=
 then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_EDITOR=3D=
:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export GIT_ED=
ITOR
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autosquash=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 . git-rebase--$type
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ...
>
> So, turning these scripts into builtins would first require turning t=
his
> ". git-rebase--$type" into an actual command call. But nothing
> unfeasible.

We do want to turn all these scripts to C in the end, regardless if
the conversion is part of any GSoC. So I dug up my code and prepared
this. Now we need people to convert any git-rebase*.sh to C :)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  rebase: move common functions to rebase--lib.sh
  rebase: move cleanup code to exit_rebase()
  rebase: turn git-rebase--*.sh into separate programs

 Makefile                             |   7 +--
 git-rebase--am.sh (mode +x)          |  23 ++++----
 git-rebase--interactive.sh (mode +x) |  15 ++++++
 git-rebase--lib.sh (new +x)          |  79 +++++++++++++++++++++++++++
 git-rebase--merge.sh (mode +x)       |  14 +++++
 git-rebase.sh                        | 100 ++++++---------------------=
--------
 6 files changed, 143 insertions(+), 95 deletions(-)
 mode change 100644 =3D> 100755 git-rebase--am.sh
 mode change 100644 =3D> 100755 git-rebase--interactive.sh
 create mode 100755 git-rebase--lib.sh
 mode change 100644 =3D> 100755 git-rebase--merge.sh

--=20
2.7.0.377.g4cd97dd
