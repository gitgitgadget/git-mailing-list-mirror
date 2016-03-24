From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 14/33] refs: add methods to init refs db
Date: Thu, 24 Mar 2016 14:04:55 -0400
Organization: Twitter
Message-ID: <1458842695.28595.11.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-15-git-send-email-dturner@twopensource.com>
	 <56F3972C.7020901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 24 19:05:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9d1-0000x9-VS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcCXSE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:04:59 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33455 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcCXSE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:04:58 -0400
Received: by mail-qg0-f45.google.com with SMTP id j35so44777903qge.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qDHKt78cfvd4vUZVRewIQ1rpJXGtQZA2W1W6NpdioFk=;
        b=NdoiZHJXfkzdoFZE1Wx5b8AvQey02/WzNGcUf8FyT4dGC5tqqNlHaGMQcW9gdJAS9l
         dBgXOAnZ6PH9r1KN8Xjy7IUin/2aOETmEZLc7U5zuRgUMlV9GNqF729YJJexoSUMNkuf
         j7O/ge2P1dMLhtw2o7eQH2bZaWeU4B9HlnxH2arFdFZUU3QUBZdD4ZWkTeB4t04jowIp
         Y8PtoafqKm/rYC+7c0J2L/tg88VRFAebhZsCuH7F9Pwv1o7TQqWAZi2t1frmEAL3Rb54
         hnxzTqLe/gD7ZCsI8OALcUGwclVm93/MmXgLs0awiH2NNsnCTY3QQ6/pu5aHWlKq08Cf
         Ps4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qDHKt78cfvd4vUZVRewIQ1rpJXGtQZA2W1W6NpdioFk=;
        b=l4bT9uji4b7T13LTcpHNcq8wmaPWbtCZsDSNOCY0fttdsQK5buG54QRn+wkUGcSmus
         RDxuU93veoS/aAYgJ4ckOUuFLFIJCnpJjMky3UhhkiAMVN3ycC8pBXlAtfN+uCgRLkyR
         go8x+ahrrZKQBMOe+Gc586K83LBk6CjpEf5myrIqHzZmjZB2ld2b2HxXGnT0kvdAJHyl
         GKMj2f7Edn01tnISBnQCQ05Oiq6jg6fJxB8rBerPX9NLl8vsYUjnfCnZG7yewTH0sHZc
         Y7eD3rHWLbHuSfg1o0H+3jzZDzcaxE01biKUtegihMC3Fp6gZ+1/rfDYca5GAqbHRueG
         AxYw==
X-Gm-Message-State: AD7BkJLFDAPpNrPyWqxRPjylSOFwpBwS47MkqzZjgd0KxOh6E3ykIOHrGDyrGlYXn1UH4A==
X-Received: by 10.140.95.117 with SMTP id h108mr12162272qge.65.1458842697181;
        Thu, 24 Mar 2016 11:04:57 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f78sm3745920qge.8.2016.03.24.11.04.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 11:04:56 -0700 (PDT)
In-Reply-To: <56F3972C.7020901@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289778>

On Thu, 2016-03-24 at 08:28 +0100, Michael Haggerty wrote:
> >  	if (shared_repository) {
> >  		adjust_shared_perm(get_git_dir());
> > -		adjust_shared_perm(git_path_buf(&buf, "refs"));
> 
> Given that this function is creating the "refs" directory, it seems
> like
> adjust_shared_perm() should be called for it here, too (rather than
> in
> the backend-specific code).


Good point.
