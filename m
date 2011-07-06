From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] revert: Eliminate global "commit" variable
Date: Wed, 6 Jul 2011 03:55:19 -0500
Message-ID: <20110706085519.GC15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 10:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeNtJ-00065S-4y
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 10:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1GFIzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 04:55:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38581 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab1GFIzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 04:55:23 -0400
Received: by iwn6 with SMTP id 6so5903113iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bA89Lyi546EImmksnQRDR3x8XR9ks+kwyPv4TF3YGE4=;
        b=pBBj0JVPuhS1BppWB6z5QRKcOD84JjMOCedBWX55434w8yx7gW5XTQCOIr5rFexRl/
         DxEomfNg9qNTmZi9BjWm56j5zUVQfxjd0kRWMjbMAX0Oxnh2VDXKsJLOzdSuixB74A6z
         fX7i5OPPe5PT03a93D8bk4nVfOrQx33hyEMF8=
Received: by 10.43.132.8 with SMTP id hs8mr8470547icc.418.1309942523391;
        Wed, 06 Jul 2011 01:55:23 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id hw7sm8571455icc.3.2011.07.06.01.55.21
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 01:55:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176665>

Ramkumar Ramachandra wrote:

> Since we want to develop the functionality to either pick or revert
> individual commits atomically later in the series, make "commit" a
> variable to be passed around explicitly as an argument for clarity.
> This involves changing several functions to take an additional
> argument, but no functional changes.  Additionaly, this will permit
> more than one commit to be cherry-picked at once, should we choose to
> develop this functionality in future.

I don't understand the last sentence above --- doesn't "git cherry-pick
A B" work already?

The patch looks good, except for:

[...]
> -static void write_cherry_pick_head(void)
> +static void write_cherry_pick_head(struct commit *commit)
[...]
> -			write_cherry_pick_head();
> +			write_cherry_pick_head(sha1_to_hex(commit));

I don't see how this would even compile.
