From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 12/35] prepare_index(): declare return value to be
 (const char *)
Date: Tue, 16 Sep 2014 14:17:09 -0700
Message-ID: <20140916211709.GM29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU07h-0001Zm-FN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 23:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbaIPVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 17:17:13 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55888 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbaIPVRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 17:17:13 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq14so601318pab.39
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Oe4pDWD8vbo5h1CpD0nyYWaEpXNs9/n369LWYDEx5yU=;
        b=ALfatZveTeaDa8uTXR9bhLNKCoeAjDmX6uLdZ1kwRqnNVb5CU6/G+cVmH50gbn692H
         1g9zgcx1YIblhEfgp6mNLJyFiYsq83C6A2ydGZ8C4+ecsw4xOF2qMTANejv96mGnTHgn
         8HNm/fgIQnwqrw5OmWxiXy0agMuWajtD02oEJ51s6W2HmsxZbIMIiMhPgFCFRgFBtcVP
         enr+nDSdL1eXSIXdGS6H3BKeSrkDM/8LRl8n7iU9GDyVaC1gQl0VUuAK4nRLylkpbzeH
         dOR4PD4JShcirzTgp4jHntGztEoZSFN3cLYatEqrPMuYaYMo2Al8EUYiRwRI7lmkH1AN
         ZvPA==
X-Received: by 10.68.115.48 with SMTP id jl16mr51346282pbb.78.1410902232491;
        Tue, 16 Sep 2014 14:17:12 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id f12sm11005870pdl.94.2014.09.16.14.17.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 14:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-13-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257196>

Michael Haggerty wrote:

> Declare the return value to be const to make it clear that we aren't
> giving callers permission to write over the string that it points at.
> (The return value is the filename field of a struct lock_file, which
> can be used by a signal handler at any time and therefore shouldn't be
> tampered with.)
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I wonder if we should just bite the bullet and make lock_file an
opaque struct with accessors for int fd and const char *filename.
