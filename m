From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 08/21] refs: add methods to init refs db
Date: Thu, 11 Feb 2016 16:15:36 -0500
Organization: Twitter
Message-ID: <1455225336.29013.11.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-9-git-send-email-dturner@twopensource.com>
	 <56BC4C3D.8040505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTyaV-00085Y-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbcBKVPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:15:40 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33157 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcBKVPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:15:39 -0500
Received: by mail-qg0-f50.google.com with SMTP id b35so48301633qge.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=o/TEfCYkLY8QvpfZNKeLoEgBzGP+vm/lZJOqFRvY8lA=;
        b=nqHa8njGb+c9O2rJVchI7UEPI1Y17tVPSflgbBfrWegZV31GQvFC5VLy8UjI3c3Ck5
         FzaAAVb6Jb9Fxpamk9M2p3jQwRDj9y0zni7iUsSn28LLB7nHQ19+L9nfDrIfMfxIdQTf
         6LTPHOeTh1pYTzJm/3lOxVrknbIZ4XWn0yRJ74KdR+JPvJDkvqsmaKEw1dsg4rztCgyx
         GnEISs4+PIWhiER5oefsDL57F23TfBZSZGoSyrJxzJXJF0+k/uSQTpotv7oauUS6JbQD
         2GpicIdfIVkM8ZFvGkVpi4EdnTOeprqSg/cf26dYvcAG1lYOQXG9bVSDF3O4rUjkVESq
         DWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=o/TEfCYkLY8QvpfZNKeLoEgBzGP+vm/lZJOqFRvY8lA=;
        b=a/987neGin2VGQclf2uNkkuKcOfs2eZFH+sfnqzcYtlOZk4h8gaYpTV495yZJl4rJ7
         iruITMgKOTUPUBH4NMO3NF3C3NVmPTQSpFaS5F00qF8iQuUZ3DpxMAUSjnzVrVWDVY7O
         iqw8gLhJnZuOZX6Mc6bFyjFTlyQV3bewLoQkHK5H8ctQAQkchYfxiybrV/qwjk2WoBTH
         ol+f/B8wWsx+7h1L06iibwvg3tPYGeDSYu8Pcz+tQjMy0JMW1ZwI3Uf09s84eoRVRtJu
         rrcxUErBhD577bUEg0uvQSIv44BAf9OmQ1XmxnaZnqqqtxWDmUxsMqot96slbVBSR2Sv
         hmwg==
X-Gm-Message-State: AG10YOTykTS/efNsquYGtwVa0V9+fQTz8eIcAseS/mQKQVGX3phW2upee4FmrDdzEROJ0A==
X-Received: by 10.140.99.53 with SMTP id p50mr57844591qge.97.1455225338783;
        Thu, 11 Feb 2016 13:15:38 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id f3sm4100661qge.44.2016.02.11.13.15.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 13:15:37 -0800 (PST)
In-Reply-To: <56BC4C3D.8040505@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286001>

On Thu, 2016-02-11 at 09:54 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Alternate refs backends might not need the refs/heads directory and
> > so
> > on, so we make ref db initialization part of the backend.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  builtin/init-db.c    | 20 ++++++++++----------
> >  refs.c               |  5 +++++
> >  refs.h               |  2 ++
> >  refs/files-backend.c | 16 ++++++++++++++++
> >  refs/refs-internal.h |  2 ++
> >  5 files changed, 35 insertions(+), 10 deletions(-)
> > 
> > [...]
> > diff --git a/refs.h b/refs.h
> > index 5bc3fbc..c5ecc52 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
> >  
> >  extern int is_branch(const char *refname);
> >  
> > +extern int refs_init_db(struct strbuf *err, int shared);
> 
> The convention elsewhere is for "struct strbuf *err" to be the *last*
> parameter.

Fixed, thanks.
