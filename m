From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 15:01:22 +0200
Message-ID: <87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 15:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXABX-000292-O7
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 15:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558Ab3D3NBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 09:01:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34299 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759848Ab3D3NBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 09:01:24 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 30 Apr
 2013 15:01:21 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 30 Apr 2013 15:01:22 +0200
In-Reply-To: <1367324685-22788-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 30 Apr 2013 17:54:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222934>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The rev spec forms @{}, .., ... fill in HEAD as the missing argument
> automatically.  Unfortunately, HEAD~<n> is a very common idiom and
> there is no way to make HEAD implicit here (due the shell expansion of
> ~<n>).
>
> However, there is an alternative solution to the issue: overload the
> character @ to mean HEAD.  Do this at the lowest possible layer of
> abstraction: in dwim_ref(), substitute @ with HEAD just before calling
> resolve_ref_unsafe().  The program will only reach this point after
> the other specs like ~, ^ and @{} have been resolved; therefore, it is
> safe to do it here.
>
> This patch has the exact same effect as:
>
>     $ git symbolic-ref @ HEAD

But then why don't you just 'git symbolic-ref H HEAD' for a sort of
"local alias"?

What annoys me more is that there's no way to say

  git symbolic-ref U @{u}

so that I can avoid that -- it's really clumsy to type on a Swiss German
keyboard.  We'd need some sort of ref-alias feature for that to work.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
