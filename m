From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] checkout: tone down the "forked status" diagnostic messages
Date: Wed, 20 Feb 2008 21:56:41 -0500
Message-ID: <76718490802201856x54f160e7m7bb6ba10fada845e@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <20080209030046.GA10470@coredump.intra.peff.net>
	 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
	 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
	 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
	 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
	 <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
	 <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 03:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS1ce-0000Pg-Nm
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 03:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbYBUC4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 21:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYBUC4p
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 21:56:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:12735 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYBUC4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 21:56:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4288607wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XiqdYLBz0LB3uy+RVP60CdVsCVgBOlySJYH3kEk+pNc=;
        b=YgksgEztO8CrAZbd/vN9AC8L+ReBN8jkpxZLEaGx4VscB/15026sJ2KQ27dtXMRmydnupywnPb3m5CmUS46rPLpGpzb9RTKOmpTulAUfRGRWDGLdeX9PzP9DSEywi73KmNeIEAi9vDVCdqSVD2qYO48ekYRXIA1IfLZfE3bVKIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PePEVpLoCMhHs7iLEI01sSuNhBGY0Ibn8+kyN4c2aIt7BJuczxGCmf/9jup4+z7mWAAAdYf0KfQMJFOU3RATj2m8UKwd9Hg4FbLdoBuww4sJFoMAmx7Xh/u+kGivqBX1va5izCIpfIe9ZfXv9cYS/DtNTVb9xSS1v1oZLKu/n28=
Received: by 10.114.107.19 with SMTP id f19mr2197387wac.113.1203562601600;
        Wed, 20 Feb 2008 18:56:41 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 18:56:41 -0800 (PST)
In-Reply-To: <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74588>

On Wed, Feb 20, 2008 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wrote:

>  diff --git a/builtin-checkout.c b/builtin-checkout.c
>  index 5291f72..261f67f 100644
>  --- a/builtin-checkout.c
>  +++ b/builtin-checkout.c
>  @@ -301,64 +301,88 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
>         char *base;
>  +       base = branch->merge[0]->dst;
>         if (!resolve_ref(base, sha1, 1, NULL))
>                 return;

Apparently base can be null, which on OS X causes a Bus Error in resolve_ref
when it calls strcmp(ref, list->name)

j.
