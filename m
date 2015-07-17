From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix detection of uname failure
Date: Fri, 17 Jul 2015 15:06:57 +0200
Organization: gmx
Message-ID: <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
References: <1437135095-6244-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 15:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG5ME-00041A-R4
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 15:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbbGQNHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 09:07:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:65166 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbbGQNHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 09:07:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MdoR7-1Zb9uJ3oB3-00Paau; Fri, 17 Jul 2015 15:06:58
 +0200
In-Reply-To: <1437135095-6244-1-git-send-email-charles@hashpling.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:zgJbNRROY1TusyWxk2M2ThLQsEz+/HRYfH3tZCHcwnvmOlr/TnL
 5rLfPkeJMpuO2CuO5DgGDirbNj6Q9mh/PYiCtOP5kQbHeCEtnJdt/eLI5KFvz+B2c0iHgFs
 9tPr+GH7F8EsyeLMlpJtvZg3B4mSI+U9Bba2janVQyLCUrBsdXpv9uwBBecmA6jM8fFc/xy
 LKs4nMgalnmAHVixLkgzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLOaQBd3Yh0=:X6aLRt/W6YxJQuZeFARr4y
 9ydbt/vpSc7eLSG4yxVuh3VF+kLd28QVPTMpLATiA+FpbXvt0YMxmyAeltzVdTfosYTVKHPd7
 iz65P2YDkjrlJzOEYvyyY7yOZ/Ex/wRwDTCU9m64FX0+x6IZev+Lq/q6a5/pxGSN1/sBkFNPU
 mZpQqlPYeTy5V8vlNo/HPNYU6klZlii/p2WXbPgXwW2Lw/EQFYozF6l9Chuirh22qJlYwArAI
 LB2RCRfQ9m6fCKaVj8j27oDcNvSlv7pdUTszoPtEbfdDZm3slyBDlaX4IYChuJUilnFGxNvqT
 kcqtOG/IbKeyDnYgBIrU1Uo2ztrGurwrAf9dtOBixjoECyaaRZ7/NRptoBXhphXzU/Mgulwpx
 5Y+xXKa1oh/in92FYLUt7f1esm+wuFiWDGymBJ8nfayysWLWyty5NIB1AnFbrfEYWd8PJz+P1
 TYa7Ldo/1mZIBegVIIbLi7aI70+y5B8Ze0LNGRaS1H0vgLqBj6Tx4QV84KKwe/bBRjzCPBzbi
 mMDxPHYJEv0SN9oyP+9G245eeabGO/Qmdg6Hyl6nixQT1by7wEGxquqRLxMhgeiWqva8pG8Pn
 a3nQ7euC9IdH2JfnrR4maE51cPuZoQHviaIiHlyGUbpRZ6Z0mIwnjz7ln+VmEglCafsNeiwAM
 +lV09Zk+5cc1wwHSpD5Y8BPrPV25KGm8wamLj+Gx6Mz1/5sFd1eS3W8wAZLPlr0sB+OA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274070>

Hi Charles,

On 2015-07-17 14:11, Charles Bailey wrote:

> diff --git a/dir.c b/dir.c
> index 8209f8b..52dbfd0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1848,7 +1848,7 @@ static const char *get_ident_string(void)
>  
>  	if (sb.len)
>  		return sb.buf;
> -	if (uname(&uts))
> +	if (uname(&uts) == -1)

>From a quick `git grep '== -1'` and another quick `git grep '< 0'` it appears to me that we prefer the latter. Maybe you want to adjust it in the patch, too?

Ciao,
Johannes
