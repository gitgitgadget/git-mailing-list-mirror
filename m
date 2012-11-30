From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] fsck: warn about ".git" in trees
Date: Fri, 30 Nov 2012 20:50:41 +0100
Message-ID: <50B90E11.8090501@web.de>
References: <20121128213529.GA16518@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 20:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeWcK-0005YK-63
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 20:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab2K3TvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 14:51:03 -0500
Received: from mout.web.de ([212.227.15.4]:56941 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758017Ab2K3TvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 14:51:00 -0500
Received: from [192.168.209.22] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MbQbk-1TxHwi2J08-00Iw1f; Fri, 30 Nov 2012 20:50:40
 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121128213529.GA16518@sigill.intra.peff.net>
X-Provags-ID: V02:K0:hq4FkXv0nlwgcKpmTpGEtmKYJb0tjzJikVlLsCbDJ4v
 2x7WHO0N7S+xPG5aOElTos98Wsg3ol4mw1AGbIRgHH5pxBVnqP
 Cv0oitHoRtGcOIYKsHwkknnClgmBffMz8nN2mAqA1oS3G8We5A
 j8+bJDZaL1ofzWOKjWRwdOQ+PpLCouzRLlwp8cshuBNeoVIk4E
 eBXTDdrhi2DtnMPQ7Y6Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210942>

> Having a ".git" entry inside a tree can cause confusing
> results on checkout. At the top-level, you could not
> checkout such a tree, as it would complain about overwriting
> the real ".git" directory. In a subdirectory, you might
> check it out, but performing operations in the subdirectory
> would confusingly consider the in-tree ".git" directory as
> the repository.
[snip]
> +	int has_dotgit = 0;

Name like "." or ".." are handled as directories by the OS.

".git" could be a file or a directory, at least in theory,
and from the OS point of view,
but we want to have this as a reserved name.

Looking at bad directory names, which gives trouble when checking out:

Should we check for "/" or "../blabla" as well?
