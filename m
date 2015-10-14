From: Sven Helmberger <sven.helmberger@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Thu, 15 Oct 2015 01:36:32 +0200
Message-ID: <561EE700.3020002@gmx.de>
References: <561E6FBB.7060302@gmx.de>
 <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 01:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmVb9-0005dR-9n
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 01:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbJNXgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 19:36:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:56234 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbbJNXgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 19:36:38 -0400
Received: from [192.168.2.61] ([79.245.214.86]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LqylH-1aGuP42QXz-00ecoF; Thu, 15 Oct 2015 01:36:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:pn9u4qrdSOguXbEcaLaGJuH76n12Y5jxfZi2XL3giQfrtEz+Slp
 nPj4BGmHV73aDWDjO5F25ZHKgXaXa5O+9iVEaRQB7XqSbxcLg0jdHPVt1EH6/aSF4jUHK5R
 DbFesWVVRFBzzFx0XSavb4AXxp//6DvdF3LaC5HRjXJSPpnMqxPIDi/lWH/FnPmTx65mP8X
 hjdNXHMoUpqLm7VacsBoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gq5T4SeQWMc=:qgHSKJoRSWVTP3jcFPiHfU
 taBmoA4oI7OKdashZCs9Pdn7+KJz3T+rbpWurGFmR0MCx17BxQzI3DcP7j9nbQx/1qrNUkA23
 8oWgDR+9nSE9x6N0r3NlgtoPjIcbfPh8jR61hBstV/0KonIhD5DPGkMoG9xmobfdZoX07Mgxn
 syT3cEGoICFrpyZcFPu2Ig9j5QKc+rliDGZsk/lZdE30EQXg0KzvnIxjF0ezkQ64+YZ5ad0zO
 xQHTwHpZxI8MQDqWT/siuccneqCju7eJ5pJEbqsPkk43cVLuWpesep2PdVEyBIVXHqQp6RY6o
 YDmnyuvprLJu7DhSiqwtA/F/vsvRFTbA8HeKe2t1P9yFFdX3at2wSorAcvph8SoGwrwbqn2RL
 r2XQHYHmesqoIQ7QP2WjYfZw74uR59Ximi0Sm6PmlAxO/t66azm6DKttG/NXk44xhry2oSpw3
 yXlEWQqgWS/QYCNubAeDXUfjTByjfSnsB9kmbC8TVta7ClTy9AVHUSy4lxlbgDSh6DTUMbG3r
 AldeW2YsjspiODHnWko1iORzBaY0HNCMArYjpbxFpf3Mb8CZ495cDytnm8anx955fxGw7xPzh
 2L6lOmQ/FmCoJz/koIt7h1MV3gS9XamRwGgJL1NN/p+/wWhIvZFJjfzfpotknitdPkk07t6Ns
 KZgpOVTW+a3BkZ963W80vipE7fRT8wpZciSrPtkyGWmA6ppJeQmaMqFPeJnfPLTE7GgXNAMqC
 XXbISOUBbnamFzdxbkZ8axYkQRRUNGsf30NwtunlXro+rllEWXFdTRsSOYUrHawAut9gEj2E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279639>

Am 14.10.2015 um 19:50 schrieb Junio C Hamano:
> Sven Helmberger <sven.helmberger@gmx.de> writes:
> 
> As a quick-and-dirty change, you could invent a new variant of
> 's'plit that breaks a N-line hunk into N hunks with 1-line each, but
> obviously that would not be a pleasant-enough UI to be called usable
> when you have a hunk that adds 100 lines.  Perhaps "Split this hunk
> into two by ending the earlier one immediately before the line that
> has this substring" or something might be an idea?
> 

If we go by the style of interaction in git add --patch and git add
--interactive, I think the most canonical solution would be to implement
it like this.

If we know when we can't split the current patch any further ( the point
at which selecting s changes nothing anymore), why shouldn't add --patch
not work similar to add --interactive in that it prints the lines of the
diff prefixed with numbers and the user can define a numerical range to
"split off". Then they decide whether to add those lines or not and
return to the line-numbers until they're trough with the patch.

Regards,
Sven Helmberger
