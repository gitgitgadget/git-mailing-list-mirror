From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] am: let --signoff override --no-signoff
Date: Fri, 07 Aug 2015 11:29:13 +0200
Organization: gmx
Message-ID: <16ad6c2da8f85b9f5fc26ee6ebad944b@www.dscho.org>
References: <20150728164311.GA1948@yoshi.chippynet.com>
 <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
 <1438697331-29948-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 11:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNdxw-0004El-97
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 11:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbHGJ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 05:29:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:56924 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbbHGJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 05:29:21 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOSNd-1ZRCs22ml3-005n0l; Fri, 07 Aug 2015 11:29:15
 +0200
In-Reply-To: <1438697331-29948-4-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:odgunbdE+PoMr7yWgTiOAQUZt+ybtbd+KAgSaDVb0sZ3h+oNJ9C
 MVOnknsHubgXSwJ+TjYFA2rZ+Rfe6zcCTBzsWEeBmbuVnVLQnivAbgGBZqqNohgSjCbsmKl
 UEmkr9cg9GmdYOS2iwYrKYeSujSJsaZovkQiaRv1j1HJqXM7HvVWVSeIz81ldWPCwX4dFp2
 jqRFZSlJcwsr9X9R+BdcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J41zYS6FalA=:9EZanC0YQx/QK5PibfTLuE
 Aps5nymfXDFzI8ln7YFeW631RQ9YhwJs003EQk+UO174MBWORU2Z4gmnkU4DHbvkliq+ulBWR
 mXPiPuVRVwXlurHeE47Rv9ZEOO3XNLbDx+1oBZmCb54evdWENH35ROCTcFK5wVu7sraPS7c+r
 NTT2P6OoRve+RA38R3Oui0yYDMTifCV69UpnY4gMDOdsezTfX7VEAgM9VTpHX89yBfFqmc0g/
 8S3ZWELgvxDvTrizvDS21JCyl881co7aPa9vx6FYIUbN6dyHNehvB7OW9GzoY9huc2fn3jXFH
 m2uZ005/SuH/TlSVAP+d2edf9h6kqo4LIAOmWzggj/xOvdXeah3tXMbCbkEw40QGK+mFspLPe
 8h9tF1nSZgvOStdvoKKADehP3+J6H/5BRHD4vB1C0prFr+3JFnm6smmzlCjZSE1dpVBaisVHx
 Z4huNbY6eUV/YMAbEXiEy/X4K2NmyJq0DoD+ufO3g/MCCTamOsbfy+D7/jaV7Vr5In0ENlnMr
 VqS1xdZ4NlNm5tTWsnHeXXXLKVrlKmqOC38dnseoKBtaPW7Y+3mBTc3w2wSVTSMSjveoqHasX
 ry8uqhWc0Fl+m2gS00RlqOH/434hig9srzY1tzB7BUiNgFCznWjHn9+SMxx0gCqiMQ8jdTch8
 EE5cPdLaiLMygy4j9idYwofxAeruOkldo3+bmeggy+GqDkD279+QTgWN1zvDC1dhdLyI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275464>

Hi Paul,

On 2015-08-04 16:08, Paul Tan wrote:

> diff --git a/builtin/am.c b/builtin/am.c
> index 0961304..8c95aec 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2151,8 +2169,9 @@ int cmd_am(int argc, const char **argv, const
> [...]
> char *prefix)
>  		OPT_BOOL('3', "3way", &state.threeway,
>  			N_("allow fall back on 3way merging if needed")),
>  		OPT__QUIET(&state.quiet, N_("be quiet")),
> -		OPT_BOOL('s', "signoff", &state.signoff,
> -			N_("add a Signed-off-by line to the commit message")),
> +		OPT_SET_INT('s', "signoff", &state.signoff,
> +			N_("add a Signed-off-by line to the commit message"),
> +			SIGNOFF_EXPLICIT),
>  		OPT_BOOL('u', "utf8", &state.utf8,
>  			N_("recode into utf8 (default)")),
>  		OPT_SET_INT('k', "keep", &state.keep,
> @@ -2265,6 +2284,9 @@ int cmd_am(int argc, const char **argv, const
> char *prefix)
>  
>  		if (resume == RESUME_FALSE)
>  			resume = RESUME_APPLY;
> +
> +		if (state.signoff == SIGNOFF_EXPLICIT)
> +			am_append_signoff(&state);
>  	} else {

This is clever, but I suspect there is now a chance for a double-signoff if we passed `--signoff` to the initial `git am` call and it went through without having to resume.

Or am I missing something?

Ciao,
Dscho
