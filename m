From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Thu, 26 Jul 2012 09:22:13 -0400
Message-ID: <50114485.80309@windriver.com>
References: <20120725185343.GA6937@windriver.com> <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuO1J-00062h-T2
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2GZNWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:22:19 -0400
Received: from mail.windriver.com ([147.11.1.11]:54070 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab2GZNWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 09:22:18 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6QDMEB6026682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 26 Jul 2012 06:22:14 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Thu, 26 Jul 2012
 06:22:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202262>

On 12-07-25 05:52 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> Has anyone else noticed false positives coming from the
>> orphan check?
> 
> Thanks.  This should fix it.

Indeed it does.  Thanks for the fix (and git in general).

Paul.
--

> 
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6acca75..d812219 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -606,7 +606,7 @@ static int add_pending_uninteresting_ref(const char *refname,
>  					 const unsigned char *sha1,
>  					 int flags, void *cb_data)
>  {
> -	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
> +	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
>  	return 0;
>  }
>  
> 
