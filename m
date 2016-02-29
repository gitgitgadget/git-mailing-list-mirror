From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 05/32] refs: add a backend method structure with
 transaction functions
Date: Mon, 29 Feb 2016 15:43:00 -0500
Organization: Twitter
Message-ID: <1456778580.18017.57.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <1456354744-8022-6-git-send-email-dturner@twopensource.com>
	 <20160227040643.GB10829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 21:43:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUer-00049v-Km
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 21:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbcB2UnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 15:43:05 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34034 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcB2UnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 15:43:03 -0500
Received: by mail-qg0-f41.google.com with SMTP id b67so125860439qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JRkcvcmTsiA6+1JH1LDIhEVyUaQzP13vR5eHouw+xEk=;
        b=z7qHOilI5K3LBTXWzErR5AVXNUqcVVIBKr5HumQq40vG+ucKjWHBbkpslCbVlR79mx
         j6gvdRdP1N7QRAfk+iWCAe8UroX0qsrjT8RMVnzYh2Lqhko23Kp42ig4E19G4hwhYcGc
         KH/in5TgneoTRIvvnZ5zRW3rH6j/JRnFFPFQ8hCiCgKvkHq1RkETiqqSyKqVb1ZlzeQ4
         aJD54rS/7b2fzlGVaG4QxUjHd+0rxdwmB6j70rG/CvSI/+qnODMZc7iQfOIk42Sd6AGO
         6ijSkFrxP9VIPL8S1MTYggqnQJPjQPE+/lFPmbhN8CZvNmtPOziwP2ucJpyhpfq7z2jT
         PzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JRkcvcmTsiA6+1JH1LDIhEVyUaQzP13vR5eHouw+xEk=;
        b=Vqbj6KNTIPn7AvVDxWMJ75Cb7I80ucXM7Q6NSG8KI2jxJESfzrBOKK5qxzS/lAiRgg
         fkZChzf4h1cETCP12rsn5CtD5Z6l/H9/LjKHABpCWw2hhz1Uj4TONdm/21WrZwViSy1f
         8TYYSlqx67tYdhd05wxeMI/qGUkDTKxMPqgkA9BAJtNxMKEuFCznDtNmKE+Yaws+GFtU
         9lRBO/w8RVg579ruGmG3XNYQNOrdMKzvu3Qd0OBge/Zx2PYKjPORLhSUtUPRPpivahO1
         pMOAKdJmuyn8uUGmcv+qg17WCc04+uGVU12l7XE2hi5C8qwyTRcIkBEvtnczVe0KO4Rx
         /+Mw==
X-Gm-Message-State: AD7BkJIyr+Ij8uOIVu34I/mhIIW8y9LsLxX2Kf0kdTNJeNeQvS8DdcgIk8OberZ1tEglDQ==
X-Received: by 10.140.239.66 with SMTP id k63mr23405726qhc.11.1456778582758;
        Mon, 29 Feb 2016 12:43:02 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a102sm11657722qgf.21.2016.02.29.12.43.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 12:43:01 -0800 (PST)
In-Reply-To: <20160227040643.GB10829@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287896>

On Fri, 2016-02-26 at 23:06 -0500, Jeff King wrote:
> On Wed, Feb 24, 2016 at 05:58:37PM -0500, David Turner wrote:
> 
> > +int set_ref_storage_backend(const char *name)
> > +{
> > +	struct ref_storage_be *be;
> > +
> > +	for (be = refs_backends; be; be = be->next)
> > +		if (!strcmp(be->name, name)) {
> > +			the_refs_backend = be;
> > +			return 0;
> > +		}
> > +	return 1;
> > +}
> 
> So we search through the list and assign the_refs_backend if we find
> something, returning 0 for success, and 1 if we found nothing. OK
> (though our usual convention is that if 0 is success, -1 is the error
> case).

Will fix.

> > +int ref_storage_backend_exists(const char *name)
> > +{
> > +	struct ref_storage_be *be;
> > +
> > +	for (be = refs_backends; be; be = be->next)
> > +		if (!strcmp(be->name, name)) {
> > +			the_refs_backend = be;
> > +			return 1;
> > +		}
> > +	return 0;
> > +}
> 
> Here we do the same thing, but we get "1" for exists, and "0"
> otherwise. That makes sense if this is about querying for existence.
> But
> why does the query function still set the_refs_backend?

Yeah, that's wrong.

> I'm guessing the assignment in the second one is just copy-pasta, but
> maybe the whole thing would be simpler if they could share the
> implementation, like:
> 
>   struct ref_storage_be *find_ref_storage_backend(const char *name)
>   {
> 	struct ref_storage *be;
> 	for (be = refs_backends; be; be = be->next)
> 		if (!strcmp(be->name, name))
> 			return be;
> 	return NULL;
>   }
> 
>   int set_ref_storage_backend(const char *name)
>   {
> 	struct ref_storage *be = find_ref_storage_backend(name);
> 	if (!be)
> 		return -1;
> 	the_refs_backend = be;
> 	return 0;
>   }
> 
> You don't really need an "exists", as you can check that "find"
> doesn't
> return NULL, but you could wrap it, of course.

I'd rather wrap it to keep the backends firmly inside the refs-internal
barrier.  

Thanks.
