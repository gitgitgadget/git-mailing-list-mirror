From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 09/17] rebase-common: implement
 cache_has_unstaged_changes()
Date: Mon, 14 Mar 2016 21:54:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603142151230.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-10-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:54:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZVe-0003t2-VT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933489AbcCNUyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 16:54:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:57219 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbcCNUy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 16:54:27 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGS9o-1ab9e02PzM-00DEcT; Mon, 14 Mar 2016 21:54:20
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-10-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7ScrXDHlPl5ppKHDpVKYTA8kL2U48eEQtj6+NBYrinh6ulAe5F4
 lFZEwEjJyYxt2QV4v9okU8xlDFSwJ4nTuIOypHM6i6Y/WCi/WuAjwSHFnLJIaImxYokwYfo
 UDj60uisy01J6rt5o+XW9fuLNsa3QFqxKdNj/rJewj/leFK19yB4mP4Yb3aO2sNC4Ge+zTF
 o1zWAEkc+7Sr7f2DbNoQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I6JtdRe8l6k=:OGN2CkwcZObUe2EcvkTLv4
 IdIbLJGBXGD+jBR1PafIbOVsui0BbfT9buxeFf9b+QCGi4f2RsiW+wKgEUgh87YvvpeoGXkwK
 +nLQPecYD0akAha8mN5htZ+hMKjkKKkPQCT/1/kz90A+GKDnIRKJ/fVphgcD+y0iplyAM0HLl
 VUAkmr038GVf5fsgqcxOS92yr49p9ApIle+8L548SAbVRZEWd4ZcjKdoXcsuWyKo1nSycH8xn
 iAjyNy5q+7gQF7O1hSmMQvdHGAzXjpeCbtx69fIZhr99FxE2avEhe7FcjLSiaoNQ8VS9xZfto
 Jz2NmiwdRMRroMGuwUpq9CkF5HByPybJyybmi7PaBH3rj1UtwQkBKVTway4lYV8aIWdJNd00t
 3iC6NlnTvjyhCELsjkCNo12uhSo6jWDgHSuUkd4JoDbX/hxrjRQ7tXBL+/IB8NEflneo0SQR9
 ftfX2ZO11LgM+d4xdWwpFL247qzKpNXn+arlbwLcREj4hBz2vyXhmu+CGRgDgdWtJjPqfeNcU
 46mVUgZgwNoMcg9U8x4DsqBywUMOIqDaWAFOZvh5hTcixuzz0lAS6FB7jtWjmc8roC3Onpajq
 PRrQlxa0KPrL8dXgpMMk8FA7XyZ+kBntbu+C0qWz6nIBFjEOBOFNzLveFcuVRtiaEqDNZW9xd
 2TdPNUnIvZhoNakJohOuJhv3IbDO9W/wrY3TIOD97uZLw3TdqZhMqKZSRer53oq1oH1QwLorA
 bh/v8eHuulkt7gCUmKlCL3o0nK84fnqSBUiaS7N45O0/hTnOc/Xi8kl19Z0RYlHvk/wbVuUa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288810>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> In the upcoming git-rebase-to-C rewrite, it is a common operation to
> check if the worktree has unstaged changes, so that it can complain that
> the worktree is dirty.
> 
> builtin/pull.c already implements this function. Move it to
> rebase-common.c so that it can be shared between all rebase backends and
> git-pull.

This function is not specific to rebases, even if you only use it for
those purposes for the moment.

In my 'interactive-rebase' branch, I moved it to wt-status (which is a
more logical place, methinks).

Also, you might want to join my discussion with Junio about the sense or
nonsense of keeping the prefix parameter instead of silently removing it
while moving the functions.

Furthermore, it is not really the cache (which I thought we settled on
calling "index" these days) that has unstaged changes, but the working
directory.

For simplicity's sake, I therefore kept the has_unstaged_changes() name
(it is not like there is a lot of confusion *what* can have unstaged
changes).

Ciao,
Johannes
