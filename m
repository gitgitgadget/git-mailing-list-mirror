From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Tue, 24 Jul 2012 06:59:10 -0400
Message-ID: <20120724105910.GA5478@padd.com>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stcpk-0003oC-3s
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 12:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab2GXK7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 06:59:14 -0400
Received: from honk.padd.com ([74.3.171.149]:34073 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab2GXK7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 06:59:14 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 3AD5C20E5;
	Tue, 24 Jul 2012 03:59:13 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D822931907; Tue, 24 Jul 2012 06:59:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202026>

worldhello.net@gmail.com wrote on Tue, 24 Jul 2012 16:00 +0800:
> Run command 'git rev-parse --git-dir' under subdir will return realpath
> of '.git' directory. Some test scripts compare this realpath against
> "$TRASH_DIRECTORY", they are not equal if current working directory is
> on a symlink.
> 
> In this fix, get realpath of "$TRASH_DIRECTORY", store it in
> "$TRASH_REALPATH" variable, and use it when necessary.

We have the same problem with p4.  I fixed it in t98* in
23bd0c9 (git p4 test: use real_path to resolve p4 client
symlinks, 2012-06-27), but maybe an exported
TRASH_DIRECTORY_REAL_PATH might be generally useful.

> +TRASH_REALPATH="$(cd "$TRASH_DIRECTORY"; pwd -P)"

There's a portable test helper that does this already:

    path=$(test-path-utils real_path "$path")

		-- Pete
