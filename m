From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] connect.c: Fix memory leak
Date: Mon, 09 Mar 2015 20:23:59 +0100
Message-ID: <54FDF34F.60608@web.de>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 20:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV3Hp-0000KL-8T
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 20:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbbCITYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 15:24:18 -0400
Received: from mout.web.de ([212.227.15.4]:57257 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbbCITYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 15:24:17 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MGRI8-1YHnk33fZg-00DGkq; Mon, 09 Mar 2015 20:24:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425920304-22360-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:iMRFP82KraV4CAsjxygQFFr8SOD83lOrjS6g7SjL4YM3sjtMEz6
 j3GdGdBSfUPN9fJcj7BLrqm61B1WsWnWUf/UGzRVIGuGisb92fiFeVlSFdOKosg/uU2dVjx
 Sbuy3xb1Q+fiTPutq9DqC54aJYn+cDEwPvn18mSkBppmH1a5RjSQUfalZ0KmBSa14bl06Qn
 YYGy10vh8czt6rPx9z3Ig==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265189>

On 2015-03-09 17.58, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  connect.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/connect.c b/connect.c
> index ce0e121..6090211 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -739,6 +739,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>  
>  				free(hostandport);
>  				free(path);
> +				free(conn);
>  				return NULL;
>  			} else {
>  				ssh = getenv("GIT_SSH_COMMAND");
> 
Nice catch, thanks.
(Even if it is not sooo serious today, the current implementation of Git just dies
when connection is NULL)
