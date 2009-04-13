From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Mon, 13 Apr 2009 19:04:49 +0200
Message-ID: <18CF07A6-68CB-4A17-ACC9-89CD8545F58B@wincent.com>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071656.GE2924@coredump.intra.peff.net> <49DB089A.7080207@drmicha.warpmail.net> <20090409082350.GD17221@coredump.intra.peff.net> <adf1fd3d0904090315x10b8c481g311832c40c450c47@mail.gmail.com> <20090413083413.GB9846@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 19:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPcY-0005Ed-MN
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 19:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZDMRFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZDMRFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 13:05:25 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:59970 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbZDMRFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 13:05:24 -0400
Received: from cuzco.lan (125.pool85-53-29.dynamic.orange.es [85.53.29.125])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n3DH5DFc027484
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Apr 2009 13:05:15 -0400
In-Reply-To: <20090413083413.GB9846@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116454>

El 13/4/2009, a las 10:34, Jeff King escribi=F3:

> On Thu, Apr 09, 2009 at 12:15:08PM +0200, Santi B=E9jar wrote:
>
>> I've been thinking about this and both formats seems OK for me,
>> although using the +5 -6 format for just -v seems a good point.
>
> The trivial patch for this is below:
>
> ---
> diff --git a/builtin-branch.c b/builtin-branch.c
> index 3275821..c056a4d 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -317,14 +317,14 @@ static void fill_tracking_info(struct strbuf =20
> *stat, const char *branch_name,
>
> 	strbuf_addch(stat, '[');
> 	if (show_upstream_ref)
> -		strbuf_addf(stat, "%s: ",
> +		strbuf_addf(stat, "%s ",
> 			shorten_unambiguous_ref(branch->merge[0]->dst));
> 	if (!ours)
> -		strbuf_addf(stat, "behind %d] ", theirs);
> +		strbuf_addf(stat, "-%d] ", theirs);
> 	else if (!theirs)
> -		strbuf_addf(stat, "ahead %d] ", ours);
> +		strbuf_addf(stat, "+%d] ", ours);
> 	else
> -		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
> +		strbuf_addf(stat, "+%d -%d] ", ours, theirs);
> }
>
> static int matches_merge_filter(struct commit *commit)

I'm skeptical that people will know at a glance that "-" and "+" in =20
this context map onto "behind" and "ahead". I think that trading off =20
the clarity and obviousness of the words "behind" and "ahead" for the =20
brevity of the symbols "-" and "+" wouldn't be a very good idea.

Cheers,
Wincent
