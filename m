From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Wed, 16 Mar 2016 08:58:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603160855390.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 08:58:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag6Lp-00042y-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 08:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933970AbcCPH6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 03:58:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:64475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933203AbcCPH6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 03:58:36 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M3i8r-1ZpEoO3LlZ-00rITe; Wed, 16 Mar 2016 08:58:29
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-2-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pd0UsDGu9rYFOb6v9DXunq5GTRWnoSbM+xk+mmmAfzw9aRbpTiT
 fgXa3Lt0rUHAEd6Ngzt4nzJGeVDUg7yjJxn/glreE7u1ONIXe3YBJNx977nHBIojVeDqBAh
 GPX+rBLcBXZbJzlCtSe03gWXxKFQxM8lz6tMnmD6Po3oarXU83N/h7q1IK3ri04YiF/l7Zs
 gHfto1pzmSKdf4TvspZRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:osxFbdsqitc=:/rGqhKrrTW0b7L8Ge66Q5V
 /02YfTVOfgjEZza9P4k7O4TJlRx6O8aMlhKBQjIVxBq6Nf7i3UEHgnE69gtiQ+0CJ4DpXnATK
 jqv1tQ2xxSPF+CPwrvoedmwZRZMNpiPsxhG/iQCzCRhZyF7Ra3Q2H4g80p3nKx1+qCi6KMvUQ
 97PUOsNaRz65JGd1ti8E3SeFMkGIsxJcLAYbGjp/6Hf5Uu5ABAPf2nRB+rzu9u/Pm+ADPrjoF
 HCAIYVMARlIjbcowchHcqxoCgUr1efM0iJC6XQGpwF6yqjmpVJxmC+id3CXfsHdqLkjT8+upa
 dLL65SbVSA+Ob7QmMQXSQq4yEarRO+4W/q8wSa4vIMpS15i/D229pun/HeqeaMh8/JlTDv0nw
 XzsoLc5SJj4pB0Qoz6axlGxbfP+oGSqba3EdZ0ASQ8udSnK1fVnb4A1btEVO3qnJ6/J+9l/F2
 /ZGpSeE3cqs7ZYuERrnYZZ/fNfbIqc1zEHeEiXWZC47L9Gzo9kCeuj1AzsDQGygw76li2OsiA
 ZpWxzDZLnUI/h1B63slHlRtfB5LC9i2KvlLDE4doardmSY5fDry8hVRumO2m56Uywez693G4h
 cNwp7Mqo8sWjLIQiAdXPQ39nnYQ7tJaU0qnOiHXeAprqNeT2bZnAOiGfqyylN1O4qq64s5ScY
 rYd1zf8VPDamUbAuOpUTCxynb+tsxSPHpQN9OFcGCGh/+EtZnKws8ybyimakfYMRMtCJKr0XZ
 1ETP0mrSdd+hCA6mQpZdsZW5eIlyMBDaQArZFgRalTrxM5GMCXVLzGM55ONPD0ngDsqA7iSR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288950>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
> new file mode 100755
> index 0000000..aaca105
> --- /dev/null
> +++ b/t/perf/p3404-rebase-interactive.sh
> @@ -0,0 +1,26 @@
>
> [...]
>
> +test_perf 'rebase -i --onto master^' '
> +	git checkout perf-topic-branch &&
> +	git reset --hard perf-topic-branch-initial &&
> +	GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
> +'

This measures the performance of checkout && reset && rebase -i. Maybe we
should only test rebase -i?

Also, I would strongly recommend an extra test_commit after reset;
Otherwise you would only test the logic that verifies that it can simply
fast-forward instead of cherry-picking.

Ciao,
Dscho
