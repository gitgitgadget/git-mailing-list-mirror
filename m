From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 14 Jan 2011 01:44:49 -0600
Message-ID: <20110114074449.GA11175@burratino>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino>
 <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com>
 <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 08:45:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdeLY-0000jY-LR
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 08:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab1ANHpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 02:45:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53474 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1ANHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 02:45:14 -0500
Received: by gxk9 with SMTP id 9so1023051gxk.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e71MGspXnPqwbH5S0c+Sf2YvO/05eT7NNXYTcaNoWCk=;
        b=kyMhb89NOY1pfrJ803uT2+6M61HIEh1Wet+uUBDHuzkmVP1IMCNP5TbOOhDSMicFBe
         /QrhIJH0yZWonbA/9Bs9O3Mmqv/ah/kn11UOR4etIBwedMteTdMNz9w98ryW89BjMLSm
         nm7TGXhUt5Xcsod06lbm7uuZyvpFe8pSjrjDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=muWlmWsFdtR5frjK/ql1zzuREuIgZ+V13yNhjR2mcHj0lPzmO5g2Z9L5FpoTv7yM8g
         31l3ZCnpbpNSisyemRCiw/s0k3oWFbnFVnaM80BrIxsnqdUW8d7UOUO6qJceTUAiOR+I
         pnSKi7Cmdm97H0jvjBO6vGKohdTa84F4efeTQ=
Received: by 10.151.108.17 with SMTP id k17mr821114ybm.246.1294991112317;
        Thu, 13 Jan 2011 23:45:12 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id u5sm135942yba.10.2011.01.13.23.45.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 23:45:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2FEF49.8070205@burntmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165076>

Guy Rouillier wrote:

> Martin, thanks for the reply.  Have you had a chance to read the
> entire thread?  The matching test was suggested by Emil.

To summarize, Emil originally (2008)[1] suggested only checking
~/.cvs/cvspass when ~/.cvspass fails to open.  There was no response
at the time, perhaps because nobody interested saw the message.

Guy, two years later[2], wrote:

| I do see one possible issue with the supplied modifications.  At work, 
| we upgraded from CVS to CVSNT.  So, my home directory has both
| .cvspass (from the original CVS) and .cvs/cvspass (after the conversion to 
| CVSNT.)  Sloppy housekeeping on my part, I admit, but probably not 
| uncommon.  The supplied patch would pick up the original CVS file and 
| would fail.  (BTW, this is true only of the git-cvsimport.perl script 

and recommended erroring out if both files exist to make this easier
to diagnose.

Emil's advice: if this is an important use case to you, maybe it would
be served better by looking at both files?

> This is my first patch submission.  What is the process for reaching
> consensus?

See Documentation/SubmittingPatches, "An ideal patch flow".

My take: you learn what you can from others' advice, but ultimately
the idea is to just make those changes that make the patch better
(where better can mean featureful or simpler and more maintainable ---
this is not meant to be an excuse for overengineering).  In most cases
apparent conflicts are not real conflicts at all but signs of distinct
design goals to be balanced or reconciled.

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/77109
[2] http://thread.gmane.org/gmane.comp.version-control.git/163979
