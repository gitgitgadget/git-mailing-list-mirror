From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Wed, 23 Feb 2011 18:22:49 -0600
Message-ID: <20110224002236.GB7433@elie>
References: <4D656F25.5090007@web.de>
 <4D656F4D.6080401@web.de>
 <7vipwa5phh.fsf@alter.siamese.dyndns.org>
 <4D659818.4070107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOz2-0007X2-BE
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1BXAW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:22:58 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41869 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab1BXAW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:22:57 -0500
Received: by vxi39 with SMTP id 39so3670vxi.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bR8y6r965LjFSpq4kxiT2GQXbymBFvqGb9jBv0/S6IE=;
        b=I4Sp3g7UpGDOPyhEQDynPecBloYTD7ROQsI0+oHjjeeWO8t9++CgbatfQuR/PZYjIc
         qRzfoCIwR99oqX3/jjh0pq+VraCfFfrJsSmU5Q9/MTBHPPN6cCXCnafxxATtMFfA8jv2
         Y8+GczFyOiEHTWgFLg/OwugTah3llCFld6bCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UZeN7srdho8AvS3MGHIuYhWHE2J1mkKNa7mH2D8XwhVd4S7yQio121cqbbcMtvOp9C
         9L0s2DCHBFwV8eQq/tbZcZrilrwmn0zgNAJejjlRe7XzSIM2OGFm0XVhXfwlgaS1LHez
         qLlj++IsoPGUe3sRQ5sCgk91JVRVNf8EG5qVM=
Received: by 10.52.162.66 with SMTP id xy2mr352029vdb.20.1298506976658;
        Wed, 23 Feb 2011 16:22:56 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id b5sm1338065vcx.28.2011.02.23.16.22.54
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 16:22:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D659818.4070107@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167754>

Jens Lehmann wrote:

> But maybe
> fetch_populated_submodules() should empty the string_list it just
> worked through?

No, I don't think so.  There might be cases where you want to fetch
and then check out the changed submodules some day.

What might be nice is for cmd_fetch to clear the list before it
returns.  That way, if this functionality ever gets lib-ified then
there will be that reminder about how to reset the state.  And
valgrind can be a little quieter. :)
