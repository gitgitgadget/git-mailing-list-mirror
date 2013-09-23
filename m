From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 8/9] transport-helper: add support to delete branches
Date: Sun, 22 Sep 2013 21:34:20 -0500
Message-ID: <523fa8aca96e2_57ae47e74413df@nysa.mail>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
 <1377789808-2213-9-git-send-email-felipe.contreras@gmail.com>
 <523F9E79.8070602@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 04:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNw4K-0006kQ-HL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 04:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab3IWCkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 22:40:06 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49855 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3IWCkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 22:40:05 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so153760oag.33
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 19:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=ME1iaf8LTKuHS6hjGWgHqdkUHLMClmqQRYS6Rb2kAXY=;
        b=LkcWbC703UQkR/6RlCXylJFgTs0FO8B2ClzpBqytlvhozvqagIjcbLjTTd8OWJzUS4
         OHIeU3o0j0dcYHxU13H2oLxvsj/VvfW+yJ61DRx31CuZmpJi231BShc86oAD3AJJMdS0
         QVV+5Rn07Fpi9Dv2ptxgBYT3NhnyYYLZP86qQfRbL9iw2oW/i5U0JuH0FHYL0Zn1co03
         wR8wYruzofSxjGZS4r8/aJqHuec1zoveNBCOaMPPc1dJQXatkzxzmj78UkdCrpw0zRpH
         Hb3cVDJZBnni23uvDcWHuvY6Q9Flrpc2vfUiNm6iFuD/9xlZwi6jmKlLfusOVMJoczRO
         0nYg==
X-Received: by 10.182.50.130 with SMTP id c2mr489211obo.35.1379904004666;
        Sun, 22 Sep 2013 19:40:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm11747371obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 19:40:03 -0700 (PDT)
In-Reply-To: <523F9E79.8070602@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235180>

Richard Hansen wrote:
> On 2013-08-29 11:23, Felipe Contreras wrote:
> > For remote-helpers that use 'export' to push.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  t/t5801-remote-helpers.sh |  8 ++++++++
> >  transport-helper.c        | 11 ++++++-----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> [...]
> > diff --git a/transport-helper.c b/transport-helper.c
> > index c7135ef..5490796 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -844,18 +844,19 @@ static int push_refs_with_export(struct transport *transport,
> >  		}
> >  		free(private);
> >  
> > -		if (ref->deletion)
> > -			die("remote-helpers do not support ref deletion");
> > -
> 
> The above deleted lines actually appear twice in transport-helper.c due
> to an incorrect merge conflict resolution in
> 99d9ec090677c925c534001f01cbaf303a31cb82.  The other copy of those lines should
> also be deleted:
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index 859131f..bbf4e7c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -874,9 +874,6 @@ static int push_refs_with_export(struct transport *transport,
>  		char *private;
>  		unsigned char sha1[20];
> 
> -		if (ref->deletion)
> -			die("remote-helpers do not support ref deletion");
> -
>  		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
>  		if (private && !get_sha1(private, sha1)) {
>  			strbuf_addf(&buf, "^%s", private);

Right.

-- 
Felipe Contreras
