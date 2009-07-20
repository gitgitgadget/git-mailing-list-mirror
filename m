From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: bug with .git file and aliases
Date: Mon, 20 Jul 2009 16:04:52 +0200
Message-ID: <adf1fd3d0907200704sb097a99h1ab8f118be5854f9@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jul 20 16:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MStUY-0002Uw-98
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 16:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZGTOEz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 10:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbZGTOEy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 10:04:54 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:44211 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZGTOEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 10:04:53 -0400
Received: by an-out-0708.google.com with SMTP id d40so3634462and.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 07:04:52 -0700 (PDT)
Received: by 10.100.32.13 with SMTP id f13mr6195720anf.36.1248098692225; Mon, 
	20 Jul 2009 07:04:52 -0700 (PDT)
In-Reply-To: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123602>

2009/7/20 Geoffrey Irving <irving@naml.us>:
> git 1.6.3.3 has a bug related to .git file support and aliases.
> Specifically, if you make an alias for status and call it from a
> subdirectory, git status chdirs into the true .git dir but then
> chdir's back to the wrong place in order to run the lstats for status=
=2E
> =A0The result is that git status thinks all files have disappeared.
>
> Here's a self-contained test script:
>
> =A0 =A0#!/bin/bash
> =A0 =A0set -x
>
> =A0 =A0# make a simple repository
> =A0 =A0mkdir repo
> =A0 =A0cd repo
> =A0 =A0git init
> =A0 =A0mkdir a
> =A0 =A0echo content > a/b
> =A0 =A0git add a/b
> =A0 =A0git commit -m "a commit"
>
> =A0 =A0# replace the gitdir with a gitfile
> =A0 =A0mv .git ../repo.git
> =A0 =A0echo gitdir: `pwd`.git > .git
>
> =A0 =A0# normal git status works
> =A0 =A0cd a
> =A0 =A0git status
>
> =A0 =A0# an alias for git status fails
> =A0 =A0git config alias.st status
> =A0 =A0git st

I suspect that the $GIR_DIR and .git file works equally in this
aspect, so you should specify where is the workdir in .git/config with
respect the repository:

git config core.workdir `pwd`

HTH,
Santi
