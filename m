From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 18/26] refs: move transaction functions into common
 code
Date: Mon, 02 Nov 2015 17:19:36 -0500
Organization: Twitter
Message-ID: <1446502776.4131.30.camel@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
	 <1445998467-11511-19-git-send-email-dturner@twopensource.com>
	 <5635CA8A.2080505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNS7-0006Rd-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbbKBWTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:19:39 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35819 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbKBWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:19:38 -0500
Received: by qgbb65 with SMTP id b65so128187443qgb.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=Q9mqw19TeQZRI3MS+Dge5T17XMvABIsRkZ1WToheAjA=;
        b=CPSQ/vZ8HCcwM1ffqeObO8roh1O61qIMBZsQHBB32dZNGq2iXRBar45W3y3VOW73LV
         vuAeJ+nByuwR6wkJazGhfy4aIJ1Q9r1rZR0e33he7PKZ85sH96rsnjbJDA/3jxOFSd9F
         PaDr2eABZETY6L99n1SC18eXaR8yRS0Nat5g2DT/B5yrUNuea6gz0CD1JhMnI3dM4fX8
         jj/92HrbWkVUYN0fQA7rEUxTo1seNsJrsNnLMTfXX1RLytTGuLopmmdjM0PqJMGyM7Xe
         p9/Vszxv/lvX7NkD99UsCo0uOArZmhv/Ui8JmZe7EKknAo9MuvNsTyf0elObibQdP/pp
         8kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Q9mqw19TeQZRI3MS+Dge5T17XMvABIsRkZ1WToheAjA=;
        b=MKmXjZ3mfT26L8c2wOG246Mx/8yNs249vBtT87FkRxr0T3rWLn1pc5xZeu1y0Q0Nxp
         qFBz8KDbPWLkp+5rcviiCcuesWKv46KpjQ8Z9zHRHNN2tXS7TctqRUCFWDar+sAnO5S/
         gl1rMFFB/cLR17aHJoBYrYuUB7oEJize32vkTFxPu+8TQSJ/lYnITBkZXwydUGx8zflM
         Mkq8yyc+NkpyO44U4QGxZza4tcrsN1qLncwjU0rpNC5XvM5HyYgERPDzwGfb3IZrs1bS
         wYniX9hIblRkw/aL80jDhcP1wm7uBTegoPknIPD1Z+moEyO1kok97RSk9fEH64Wkgn3l
         hjag==
X-Gm-Message-State: ALoCoQn/IlvNSdRVBVIIpR7D5z1dgUuvS6/W6FkbFLl/MEVcjMWccUHq24neW3fdBB9KaaUkx9C2
X-Received: by 10.140.22.234 with SMTP id 97mr33133866qgn.55.1446502777455;
        Mon, 02 Nov 2015 14:19:37 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 44sm8684896qgh.11.2015.11.02.14.19.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 14:19:36 -0800 (PST)
In-Reply-To: <5635CA8A.2080505@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280731>

On Sun, 2015-11-01 at 09:17 +0100, Michael Haggerty wrote:
> On 10/28/2015 03:14 AM, David Turner wrote:
> > The common ref code will build up a ref transaction.  Backends will
> > then commit it.  So the transaction creation and update functions should
> > be in the common code.  We also need to move the ref structs into
> > the common code so that alternate backends can access them.
> > 
> > Later, we will modify struct ref_update to support alternate backends.
> 
> I would prefer that this and later patches *not* add declarations to the
> public API in refs.h for functions and data that are only meant to be
> used by other reference backends.
> 
> So I'm working on a modified version of your series that declares such
> functions in refs-internal.h [1] instead. I hope to submit it tomorrow.

OK, I will fix up your other two issues and then wait for that series.

> Actually, I have half a mind to move all of the refs-related files to a
> subdirectory, like
> 
>     refs.h
>     refs/refs.c
>     refs/refs-internal.h
>     refs/refs-be-files.c
>     refs/refs-be-lmdb.c       <- still to come
> 
> What would you think of that?

Since we're moving stuff around anyway, we might as well introduce a
little more hierarchy.  
