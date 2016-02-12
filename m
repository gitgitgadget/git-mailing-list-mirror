From: =?iso-8859-1?Q?V=EDt_Novotn=FD?= <witiko@gmail.com>
Subject: `.git` symlink makes `git submodule add` fail
Date: Fri, 12 Feb 2016 17:48:54 +0100
Message-ID: <20160212164853.GA6888@witiko>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 17:49:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUGu0-0000JU-RT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 17:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcBLQtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 11:49:00 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33573 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcBLQs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 11:48:58 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so70150850wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=40fVL6KCuR5Fsc3FC1Q9wlWFvJU9rmXI0m8mIQiKF2k=;
        b=eMBgnaEH3tHXOuw85VXItFWmVFk14R5s1qozISskHBMzqehBu7bBhQxf8X5uPK+YhG
         Ld11H1j1ER6LGThZXTLwSW9o08ndtXqd8SPh/P4tQEk+jYJITjCJjpKrAyPyN9Setcof
         LTZjGkm9Na1tr0wQudY0vXVXehep0h3CsZLrAS/As+M6oqjBkwoYaJ2FZNlJcEUj5mpY
         3iIxSJeJVSXUDGlPCh0d7Ym6k1tvie9ti7p1LzPa43ZzP/C2bKSeZ1fwc2LFo9dmWB7U
         bbKYVq7lUeJSkcpQRBXWlbla/yWv8bYAqTYH71PaW8Lj9XbXz7puBrNBDU3Ljgp5MqZx
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=40fVL6KCuR5Fsc3FC1Q9wlWFvJU9rmXI0m8mIQiKF2k=;
        b=kLodE2ShWfR+rFb/wQSG5MbmdDX2Y6UMvo6gk+cnrC2G39oK90kGj1W+slUex5Ooix
         GAQ/WutMAxhb/iSXy+M9AqfikLDky82eZ/xI/n7xymHqR5mxn5iQCpHGxWI+vbK7yIv5
         591rn3zrkWrSPXTbUuVkIleqaIa3qvDX/8K3qCU7zeUq1KbQaWg0q/r9IwKbVpV5YYQg
         XNrZ+rBX4bW6gCYIgBaBjuyG0vP5Ek3ztBXFT9NuYABpsTR4MQ2ExOEGnY9+LXl+Dz4U
         GeLfJqJAXGFrJTAgWCAUha6R9i3o+fhhq2zR/rZyf4aDEGmGQY7VX3HIlFNQfAMn3fyY
         AmRw==
X-Gm-Message-State: AG10YOSbv3Ti20/NHdPKzwG3tMF/6D3ai4NXwu3/8ur13oP4YtbrAGln3xtQn2+3j9j+VA==
X-Received: by 10.194.91.175 with SMTP id cf15mr2722615wjb.7.1455295737871;
        Fri, 12 Feb 2016 08:48:57 -0800 (PST)
Received: from witiko (dynamic-2a00-1028-8d1c-ac1a-021f-3cff-fe2d-27ad.ipv6.broadband.iol.cz. [2a00:1028:8d1c:ac1a:21f:3cff:fe2d:27ad])
        by smtp.gmail.com with ESMTPSA id c7sm3126252wmd.13.2016.02.12.08.48.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2016 08:48:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286057>

Hi,

	$ uname -a
	Linux witiko 4.3.0-1-amd64 #1 SMP Debian 4.3.5-1 (2016-02-06) x86_64 G=
NU/Linux
	$ git --version
	git version 2.7.0

I tend to make `.git` a symlink, when I need to maintain several Git
repositories inside a single directory. This was always transparent to =
Git, but
problems arose, when working with submodules:

	$ mkdir -p .repos/repoA
	$ ln -s .repos/repoA .git
	$ git init
	Initialized empty Git repository in /tmp/tmp.q3hkme6nm4/.repos/repoA/
	$ git submodule add https://github.com/witiko/git-parallel
	Cloning into 'git-parallel'...
	remote: Counting objects: 212, done.
	remote: Compressing objects: 100% (16/16), done.
	remote: Total 212 (delta 6), reused 1 (delta 1), pack-reused 195
	Receiving objects: 100% (212/212), 64.20 KiB | 0 bytes/s, done.
	Resolving deltas: 100% (120/120), done.
	Checking connectivity... done.
	fatal: Could not chdir to '../../../git-parallel': No such file or dir=
ectory
	Unable to checkout submodule 'git-parallel'

Is this a bug, or is the ability to symlink `.git` just a happy coincid=
ence?

Best Regards,
V=EDt
