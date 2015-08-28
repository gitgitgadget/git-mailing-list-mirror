From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: http.c (curl_easy_setopt and CURLAUTH_ANY)
Date: Fri, 28 Aug 2015 11:23:15 +0200
Organization: gmx
Message-ID: <e2b492394d92d8aecf45a53ee6af1875@www.dscho.org>
References: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Kazakoff <sh.kazakoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 11:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVFsa-0001wC-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 11:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbH1JXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 05:23:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:59389 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbH1JXR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 05:23:17 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeRKD-1YvLiA2KEP-00q7F0; Fri, 28 Aug 2015 11:23:15
 +0200
In-Reply-To: <CAF0pADEsO0y_6wcx-xNwRqjauJmMcQ8mUmbUbbWCBrK2gQ1quA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:HmVbQtDLT7loYLwn74TY5yRoigGm2e/EZ1JX+bEK7KkBjqRjMCh
 5CRL8kxvZ2702am/Ay+0Lx3mMnPuxK9GS8q1F3R2vf+YT4c+BRsIUOlC0Z++ExtDhmyZ6mZ
 VOxrtDO65M58OnIb77zgJDRZThiw1HDsbqucM5T/vIt2vsB9ohdCOEIR3ViKuTDLuFaKOpd
 8d2Q0gNZZZiNvg+PtNkDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TmTuAg17dII=:pMQbxuxIcLB+eNDVT2bNhM
 ORj9XjxazSsfPHoW0t9SkjqcA2TviRjX2fYyoq0hAImQs5QuTZ85sYhd2qXq14DRV3fAJHUlk
 n7sA/QL873cTGY7TroOUYhuh4XaEJg406fWRjzzDqI9WP50PwC3KrJEyasufzMYRFb4skUIhP
 fF0bHsM9paze7JKCJwGP7B6fLizJPYrh0PCJ2il9RZbxpA7Bgmf9BNyB1b4/KbOmiN3PhH7LS
 8UZ5GYbb8lfiJj4i0zTCUMS6a9tUJQhWST6z1f5dkHYRkvN4W7grpXkOsqbnVO0+MhAWUm5z7
 DuGtzhkA6W2Ab4U92bW5h7KmQKNxxozBbZH4pGAMZniNxvWfNe9sGSxKPcG9svnlJxZ7SmYju
 vPgcy/3y/v5ZUqOSg2xEWxZj4bwDl/X7J91ydekuzILuLXIjPYxRzkekOWUoFAWk8MhrwXVXw
 l0im2xZguY4V9WScdXAs+NdOQyrs/iwK/O0IltSohRLQHO2TIr8NGErnhh0lehdCpH7mO2O0N
 HUODF2Hu4icHyjEPTtktuVIDf+a1lCj5XbA60GWv3f9h5pZbY6HJdRv8Qsm1Da8xXCa2l+8x/
 NZ7Delj8cj1h8NC+fk+EWHyySplsPDxr+m5eUIJYWidZW1uMijAMOntltR17x2gHJbmsUkCA5
 0Nbry6k0glftmzZiITnsqZEuaOcWWVY7cHFhICLpclZ5DRE6LgZphXVGYIwSOi8CkRw7I2CpF
 V0r5XKeZ1XS0Jru8vQx7VpXtHCoNwq8CpywTsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276709>

Hi Stephen,

On 2015-08-28 08:07, Stephen Kazakoff wrote:

> When I'm behind a proxy (with BASIC authentication), I'm unable to
> perform a git clone.
> 
> I managed to fix this by editing http.c and recompiling. The change
> I'd like to propose is to line 452.
> 
> 
> From:
> 
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> 
> To:
> 
> curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC | CURLAUTH_NTLM);

But `CURLAUTH_ANY` should imply `_BASIC` and `_NTLM`. I remember that the `_ANY` was supposed to avoid hard-coding things.

According to

    https://github.com/bagder/curl/blob/ac7be02e695af95e93b3f5a40b80dcab782f5321/include/curl/curl.h#L651

it should actually imply even more. Maybe that is the problem? Could you debug further by setting the environment variable GIT_CURL_VERBOSE=1?

Ciao,
Johannes
