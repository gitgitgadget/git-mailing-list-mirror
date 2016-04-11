From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] index-helper: fix UNIX_PATH_MAX redefinition error on
 cygwin
Date: Mon, 11 Apr 2016 06:20:21 +0200
Message-ID: <570B2605.4040305@web.de>
References: <570ADAEE.20201@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 06:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apTLE-00052R-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 06:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbcDKEUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 00:20:41 -0400
Received: from mout.web.de ([212.227.15.3]:49495 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbcDKEUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 00:20:40 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lrrva-1bnaqN0rTK-013iJx; Mon, 11 Apr 2016 06:20:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <570ADAEE.20201@ramsayjones.plus.com>
X-Provags-ID: V03:K0:WMSba+IxaXJlfI19YmlISw2FbwUD58cA36cpr4gKpyztA8DTPLW
 znplhk1YsBMLYvqy9gF4QFMeT41v5sb3Pol0E9m7CZ5ZYFNtkNt+UCPP19c/j+rCpKZ6vvy
 98ch+Iyb4smnX1MnjD7I+FF0E5vnhzc1ylV4igoioahjlXktG+t+nt9KwuJhReltNaxx/vP
 EqJXa7SoKlvWZPHUJpWbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VFz4ubkqZ9A=:VeAnxriflCauEHwpbJf/LV
 H2RvpCgzzHprwX+qfYgdkEqVjBdE/FJIe3Ao50R3k+KyCHQ/mho+93wAGjUSaONrE1n5ofMvK
 smFBIdQkgCeI+jIukmwi95Q6F0O+terfcDmmSi+xTmU2Ch44EaJE8gVTx7kKzA2QkOOnmTbk9
 vukWASONBEyBOJTJVoJYGa/9uUmbtFkA3Ve/oqCDqqwD/xG56R8MAaLtLpc5pJTIw1Hu76VLA
 oUFm4Yz4Y3hv6Nxi3lTJMsTuCdeKRBOtgZQe+IGE4k7L57wgMmB96yYJ4EGJnP5AUZLlL1PZP
 LsV9/DCqbNcpjTGq0xxGBwALf+KNctxUoCQla6BHBB/JwyJs1mHBVPQUGLCwbvNVKxM03zObi
 J6A5fNCi+QaxASm64GCq29JvaoHfJknu5J/mCcatfw/IOyY1fszQdlM9EkkPkOW8OWfZrueJY
 jy7OnjP1Yinlo45Hk2/UFTApjWO1SobKTvaf8P8ZGxL3x2coelzyZDY8lGNMAePS4CBNUDmXV
 bjLCoOuTmEsjd2Ym/RlfTdZWlMrZSDMKKplnEAmA1kDykV+wmG7grvy7Nyg91g95Gd+6MEcow
 m4X2aHm7/X9swtgexXVkcDjcmsUWYbnetdsRoRLvZNK6SI02+gVMU+fKqDvdu7pX7dYS3Ie76
 voZX6bdjP7UwekxKyul6LBOX7aHQamMqlGNQDpmoA9sMXE/KGIfkt6Bh+4Q2sqP6i63gk0IIf
 q11YngweuOTzxzAffc39ZRBIBUOboDmbB/SnxLirgzoiY9D7qytWPKQVr+fr2yd7UVHSOELE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291204>

On 04/11/2016 12:59 AM, Ramsay Jones wrote:
The header mentions cygwin, but changes it for linux, BSD and Mac OS as 
well.
Is this intentional ?
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>   git-compat-util.h | 17 -----------------
>   index-helper.c    |  4 ++--
>   read-cache.c      |  2 +-
>   3 files changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0e35c13..c90c8c6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1043,21 +1043,4 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>   #define getc_unlocked(fh) getc(fh)
>   #endif
>   
> -#ifdef __linux__
> -#define UNIX_PATH_MAX 108
> -#elif defined(__APPLE__) || defined(BSD)
> -#define UNIX_PATH_MAX 104
> -#else
Can we use a #elif __CYGWIN__ here to fix the re-definition just for cygwi ?
