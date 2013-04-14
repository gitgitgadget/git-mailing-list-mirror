From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Sun, 14 Apr 2013 21:07:30 +0200
Message-ID: <87li8lylql.fsf@hexa.v.cablecom.net>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSH8-0006Vr-AR
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab3DNTHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:07:38 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57039 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab3DNTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:07:37 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 14 Apr
 2013 21:07:33 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 14 Apr
 2013 21:07:34 +0200
In-Reply-To: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 13 Apr 2013 20:46:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221154>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's hard to see them among so much output otherwise.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/branch.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 00d17d2..a1cdc29 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -417,32 +417,45 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  	int ours, theirs;
>  	char *ref = NULL;
>  	struct branch *branch = branch_get(branch_name);
> +	char fancy[80];
>  
>  	if (!stat_tracking_info(branch, &ours, &theirs)) {
>  		if (branch && branch->merge && branch->merge[0]->dst &&
> -		    show_upstream_ref)
> -			strbuf_addf(stat, "[%s] ",
> -			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
> +		    show_upstream_ref) {
> +			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +			if (want_color(branch_use_color))
> +				strbuf_addf(stat, "[%s%s%s] ",
> +						GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);

AFAICS you are hardcoding the color?  The other bits of branch colors
are configurable through branch.color.*, so why not this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
