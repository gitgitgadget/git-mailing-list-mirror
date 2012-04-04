From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for regular Atom feed
Date: Wed, 4 Apr 2012 20:58:31 +0200
Message-ID: <201204042058.32549.jnareb@gmail.com>
References: <4F79D76D.80805@pipping.org> <1333542344-20421-1-git-send-email-jnareb@gmail.com> <7v62df9yo5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sebastian Pipping <sebastian@pipping.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFVPj-0005GL-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 20:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab2DDS6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 14:58:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48012 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab2DDS6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 14:58:34 -0400
Received: by wibhq7 with SMTP id hq7so586836wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=q4TlJ+sNmf/k7vd5hnYoxD9K0CpL7Zdma8zmzFt266U=;
        b=Hjds6V39uL/0a83xyQiw8aqdi3mgLvvjSi46dxbDQgevKlFzdDpLnDDQgZqPRN4+Xi
         3rUE7io0MsICQbPd/aa/6zHe9pzcAdY65T7j3RJ21m+BGTyDS6KxBPoBQqVJRYTIJKwk
         rMIR4k2BsRdwQXtNdrq1rp0dF+PCRP9sBeW8UFuWAWNGMqdy5RdLVG4e85vCwGBTOgGl
         ExIrJaJNAbA2ijSyEj9SSSpz4C2SJerRzosxnH/LsJN9nfEHhMcI3/eUWNEaRI7pfgEl
         7Ag3bOv9C8xGACvp4v52HVxoQtUgKPPMBs3vHcwmrcpxmReT2p517bFABnKS4JYFfJZu
         UiXA==
Received: by 10.180.97.4 with SMTP id dw4mr7792566wib.18.1333565913224;
        Wed, 04 Apr 2012 11:58:33 -0700 (PDT)
Received: from [192.168.1.13] (adgy104.neoplus.adsl.tpnet.pl. [79.184.154.104])
        by mx.google.com with ESMTPS id fz9sm6973596wib.3.2012.04.04.11.58.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 11:58:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62df9yo5.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194720>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Junio, the bug is very minor, so I don't know if it is worth fixing
> > for 1.7.10.
> 
> Does this exist in 1.7.9.x maintenance track?  If it is an old bug, I do
> not think it should go to 1.7.10 proper (perhaps 1.7.10.1) this late, and
> if it is a bug in a new feature added for 1.7.10, we may want to fix it
> before the final, as the impact of the patch seems very minor.

It is an old bug, from 05bb5a2 (gitweb: Include links to feeds in HTML
header only for '200 OK' response, 2010-12-18) which refactored feed link
generation into print_feed_meta().  It is in gitweb since v1.7.4 I think.

So 1.7.10.1 it is...

> >  gitweb/gitweb.perl |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index a8b5fad2..ca6f038 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3886,6 +3886,7 @@ sub print_feed_meta {
> >  				'-type' => "application/$type+xml"
> >  			);
> >  
> > +			$href_params{'extra_options'} = undef;
> >  			$href_params{'action'} = $type;
> >  			$link_attr{'-href'} = href(%href_params);
> >  			print "<link ".
> 

-- 
Jakub Narebski
Poland
