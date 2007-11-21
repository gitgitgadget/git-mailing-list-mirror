From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH] gitview: revamped to use string.join, stripped a function def
Date: Wed, 21 Nov 2007 13:19:30 +0800
Message-ID: <91b13c310711202119j4f9e20f0n2515babe5f9217ac@mail.gmail.com>
References: <1190922917-5044-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cr_quan@163.com,
	"Scott James Remnant" <scott@ubuntu.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 06:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iui06-0001yH-Kd
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 06:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbXKUFTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 00:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXKUFTd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 00:19:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:40106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbXKUFTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 00:19:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so29933ugc
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZxrE+iUHR9CQKVuHlkTOxFp2EHgToz+muS6JQ1Ct55w=;
        b=XmHliWw2/IGKE1BiBZwJYw2fKYRlUhp+NeFtNE95sBfUMhZSuDygkmQqZk3cKrvqL2xVsVFzEJmjHvh0HlGU6MtKLidJ6AEL9Jd+K6RMFBt0p+7FhcGJDhZaEmFhtu80TPXGjCoafQ1a8VIygoUcU1yV0/+AaB02BaSMkC6JSm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJyS/8NwNR145vdW5X0GQ/xk4yVevayaTzNgK8QXqy+LXl0X68jty845SN+r8LH/sE/5qZGZql2nxh48IXcLZZnhuU4hZ+aGUeRk75oCK4RhZMcLqSMXdSr9QkLSyhihnmWrxtwsZoLfssbeKTArvJQaY7Y1SMDT/1UjFofgnnY=
Received: by 10.78.188.10 with SMTP id l10mr7704970huf.1195622370385;
        Tue, 20 Nov 2007 21:19:30 -0800 (PST)
Received: by 10.78.157.4 with HTTP; Tue, 20 Nov 2007 21:19:30 -0800 (PST)
In-Reply-To: <1190922917-5044-1-git-send-email-crquan@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65593>

Please give some comments.

On Sep 28, 2007 3:55 AM, Denis Cheng <crquan@gmail.com> wrote:
> Signed-off-by: Denis Cheng <crquan@gmail.com>
> ---
>  contrib/gitview/gitview |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
> index 5931766..2eb72b1 100755
> --- a/contrib/gitview/gitview
> +++ b/contrib/gitview/gitview
> @@ -36,17 +36,6 @@ except ImportError:
>
>  re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
>
> -def list_to_string(args, skip):
> -       count = len(args)
> -       i = skip
> -       str_arg=" "
> -       while (i < count ):
> -               str_arg = str_arg + args[i]
> -               str_arg = str_arg + " "
> -               i = i+1
> -
> -       return str_arg
> -
>  def show_date(epoch, tz):
>         secs = float(epoch)
>         tzsecs = float(tz[1:3]) * 3600
> @@ -1115,7 +1104,7 @@ class GitView(object):
>
>         def set_branch(self, args):
>                 """Fill in different windows with info from the reposiroty"""
> -               fp = os.popen("git rev-parse --sq --default HEAD " + list_to_string(args, 1))
> +               fp = os.popen("git rev-parse --sq --default HEAD " + " ".join(args[1:]))
>                 git_rev_list_cmd = fp.read()
>                 fp.close()
>                 fp = os.popen("git rev-list  --header --topo-order --parents " + git_rev_list_cmd)
> --
> 1.5.3.2

-- 
Cheng
