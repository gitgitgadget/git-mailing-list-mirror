From: Chris Down <chris@chrisdown.name>
Subject: http.proxy seems to not be propagated on `submodule update`
Date: Wed, 10 Dec 2014 17:05:46 +0000
Message-ID: <20141210170546.GA50294@chrisdown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyki3-0007lq-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbaLJRFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 12:05:51 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49281 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaLJRFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 12:05:50 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so5859205wid.11
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=mDjATmnAycCXMY7rxkJFWV1zLiLXCyCvqSq9HDd7tBw=;
        b=CNc4W9wzBPlBgw9Q57ocdouQvbMXnNWUcDit9lQvZ0NbQtzEUrCOWjCtn6ztGn+BrZ
         sXd+I+GrMnK8NszWWfMw3bbDftuA1B4fn/8waeIyS2xuOs4n1sAMYm1rTja3UojNlubs
         x5xNiFbrRmdA2SIDtNLyP6rh1lAGkRKEkJRPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=mDjATmnAycCXMY7rxkJFWV1zLiLXCyCvqSq9HDd7tBw=;
        b=VUmKztkm9aDLqlCqE1tjMSrXEBuaMCyWu/qxHGg7EWa5AEA5MaWUxoc2JXnLuEnIon
         8s5GUOJDn4G71L1uEX/dmJ9t8QcYwTIsobg3pHm+ZLiUaucCZoaNLWbbTgEmw+gUOhUa
         qCbucItwShZWe8fWPT4+BBSgk8qTiNckN4acVWCu1bqNJpt5WTKma5h4I6PLshtcbKND
         o+YoVn0s+2hjUTSF5DTB7kdJPYTkezv9hLQcFGiwRlR3yqu7Ui9ewHuTcBC1omJin5N5
         sprNSgHKiOPfWShlX1bomj30mDsRdGbgL4utW9n5inC97dkXdVpZjIE4srq0tuvGBSAP
         WqHg==
X-Gm-Message-State: ALoCoQnB7uXpLSTwRDF4lZsR9j2PkbdzjP5OtUadwKMvHommma5jzF9z04AP/8H6HoSQ32V+WVZL
X-Received: by 10.180.108.235 with SMTP id hn11mr7989304wib.14.1418231149014;
        Wed, 10 Dec 2014 09:05:49 -0800 (PST)
Received: from chrisdown.name ([195.89.19.114])
        by mx.google.com with ESMTPSA id ex8sm6584076wjd.41.2014.12.10.09.05.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 09:05:48 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261223>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to recursively update submodules in a repo on a server that=20
requires a proxy to access the internet.

I typically pass http.proxy with -c to tell git about the proxy, but=20
with `submodule update`, it seems the argument isn't propagated and thus=20
results in the process sitting doing nothing when it tries to connect.

Is this expected behaviour?

    cdown@dev023:dotfiles:linux$ GIT_TRACE=3D2 git -c http.proxy=3Dfwdproxy=
=2Eany:8080 submodule update --init --recursive
    trace: exec: 'git-submodule' 'update' '--init' '--recursive'
    trace: run_command: 'git-submodule' 'update' '--init' '--recursive'
    trace: built-in: git 'rev-parse' '--git-dir'
    trace: built-in: git 'rev-parse' '--show-cdup'
    trace: built-in: git 'rev-parse' '-q' '--git-dir'
    trace: built-in: git 'rev-parse' '--sq-quote' '--init'
    trace: built-in: git 'rev-parse' '--sq-quote' '--recursive'
    trace: built-in: git 'ls-files' '--error-unmatch' '--stage' '--'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/auto-save.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/auto-save.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/ctrlp.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/ctrlp.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/easymotion.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/easymotion.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/fugitive.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/fugitive.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/markdown.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/markdown.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/pathogen.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/pathogen.update'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/supertab.url'
    trace: built-in: git 'config' '-f' '.gitmodules' 'submodule..vim/bundle=
/supertab.update'
    trace: built-in: git 'ls-files' '--error-unmatch' '--stage' '--'
    trace: built-in: git 'config' '-f' '.gitmodules' '--get-regexp' '^submo=
dule\..*\.path$'
    trace: built-in: git 'config' 'submodule..vim/bundle/auto-save.url'
    trace: built-in: git 'config' 'submodule..vim/bundle/auto-save.update'
    trace: built-in: git 'rev-parse' '--git-dir'
    trace: built-in: git 'rev-parse' '--show-toplevel'
    trace: built-in: git 'rev-parse' '--show-toplevel'
    trace: built-in: git 'rev-parse' '--local-env-vars'
    trace: built-in: git 'config' 'core.worktree' '../../../../../.vim/bund=
le/auto-save'
    trace: built-in: git 'rev-parse' '--local-env-vars'
    trace: built-in: git 'fetch'
    trace: run_command: 'git-remote-https' 'origin' 'https://github.com/907=
th/vim-auto-save.git'
    ^C
    cdown@dev023:dotfiles:linux$ git --version
    git version 1.8.1

Thanks,

Chris

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.22 (Darwin)

iQJ8BAEBCgBmBQJUiH1qXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwODQ5MjlBQ0ZCQzIzQjBCMUEyNkE4NDFE
RjhEMjFCNjE2MTE4MDcwAAoJEN+NIbYWEYBwqJ4QAILHei6ILzP7vqzULcguaW8E
sSEdwvq2SeQbnJ6w5ek8I7/m4oqOGJObsbl34l3lHbloAHvvCpwR8rQq+X+2UaCd
wUzQQN/DK8XA1SeZGUm4IiHRBjFyeeAbJlQhdymULMPRi8D0Gs3XSGJ1R8yJy1y2
bp5zfSowYg6u97n/DwelFGYvG8xpMiVPHSzpIoIpXyuyOnwG+qSiq6ejRO4/VD8G
Zts81yLuhZ5ifz0D6CMbjZJHEOLeS1WAG8lM1Nt0Squ112vr3qV8g2cxAuMmh/Vl
UQ8Gr85W0h7Xksji9nKWxER+i42S0rcDwBvqzsBmgpuhpGNZmKx512Rr8CzZxlIC
1GVyITo8bhB0WPk1NqnKacuRbtKM+e6ewqsB292TW3qNsd+/ikAb3gzBBk/tfGZD
gfurJolHEDYrgswk8Uh6Bstx/TI8HJF2wblj0SWsDQtLNay4YI/xcTp5c+HUWAb5
p9VJzbnFamO95oCxEOhI+ZHem8GMqrifKGjPNHWrXM626XoBpVPrC/799n+d7gPY
k04b8WF9Ch7+LKUrbxMvoIOn2bPfxLngEfihYqGvJ+A8PzqKVagdjBhRtLLXYNjf
fJwvprJjgT4k4vTs3xGgTL/EFwMN/cNBfHH53ZlfTQtDEp8PoOAxTwfxKv/5UqwF
B5bWpn7EXqjwPwFMtecg
=5O6u
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
