From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] revert: Eliminate global "commit" variable
Date: Tue, 21 Jun 2011 11:52:34 -0500
Message-ID: <20110621165233.GK15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:52:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4Bx-0002x6-5u
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771Ab1FUQwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 12:52:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37162 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1FUQwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:52:38 -0400
Received: by iwn6 with SMTP id 6so2218226iwn.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wYfiIMK7abzPa5PEVMf6h/rdlQioUMVpr9NYnX5gi1Y=;
        b=toLBRyROpgRl/MdC9K37E/abZgCbrrzMScca/AsXSSRHAZa0IDdbIgTzl6PBGet1Tb
         uudNaJB+YJFs536eYptOumE+nqHv3hCAN3ICdIUOzXcVtIaA567ssT6jMzNCa04mE6+h
         liE6GG5wRBujfsRLa8S+7AL3l18cYZ18drUkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JHY+B8F2FbMyZf0tIBAcM8noeRC963LLanP1L1zg3O+GPnmCtsWkH4EU9IPlOYdFz8
         SPhclzIYseFXT62Y1rMVXh9BOsKonVk7OQ/1lJl4Cs8P2hlmw5J+vszuMmpBPeNsg7K1
         +XN8jZnP3Ievultb47FWYhBYi+0kd7JRar5sU=
Received: by 10.42.247.194 with SMTP id md2mr6831945icb.478.1308675158205;
        Tue, 21 Jun 2011 09:52:38 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id j2sm5486651icu.22.2011.06.21.09.52.36
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 09:52:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176170>

Hi,

Ramkumar Ramachandra wrote:

> Since we want to develop the functionality to either pick or revert
> individual commits atomically later in the series, make "commit" a
> local variable.  Doing this involves changing several functions to
> take an additional argument, but no other functional changes.

Okay, one more message review.  Suppose I asked you what this patch
does.  You'd say it makes "commit" no longer a static variable,
passing it around instead.  Next I ask you why.  The answer would
presumably be something like "because ... static variables are bad",
or "because passing it around explicitly makes it easier for a person
reading the code to see how the state evolves", or "because some day
we will want this to be thread-safe, meaning there could be more than
one commit being cherry-picked at the same time".  Right?
