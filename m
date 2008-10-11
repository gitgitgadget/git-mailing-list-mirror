From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Sat, 11 Oct 2008 20:33:10 +0400
Message-ID: <20081011163310.GZ21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com> <20081007032623.GX21650@dpotapov.dyndns.org> <48EAFF23.1020607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Juran <jjuran@gmail.com>,
	Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Oct 11 18:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KohQD-0002nz-DI
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 18:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYJKQdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYJKQdS
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 12:33:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:60271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbYJKQdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 12:33:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so670969fgg.17
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xZnvFrlkXFNkDHZbj9xCynIpVB6TQb4R68vu4jQDJus=;
        b=e2LwtKC3/HdvuIFf/Rtjhu2cRm/MzB8WBougyiRFpZKcFEzOjCFANtNsojrPw79QGf
         D00MgMy1x1E5AmLGiazUDAqoV4OCwgRZDb87PtyYwqIqpwLfhWpb8lPE92+Vl18qTDpa
         PQtd+cdbirn+7Yc2bg+cYFcuI68uikKyScxpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ClNquhBXe380ivoDU9t95O+HQFkVU90Yqkx1mO55HNRT8nqJ16roBkrDgm6QGQG9cM
         UCmPlmCK+wDRnstY1rfTFaWqwS+s9irxije9VgnAdu0GmWpIxcLCUG+RSw+FFPDMylq/
         PDlP76g2+EU6bci1GtZonn4iGvdqbA3ADvZQs=
Received: by 10.86.83.2 with SMTP id g2mr2993811fgb.54.1223742794841;
        Sat, 11 Oct 2008 09:33:14 -0700 (PDT)
Received: from localhost (ppp85-141-237-231.pppoe.mtu-net.ru [85.141.237.231])
        by mx.google.com with ESMTPS id e20sm4156228fga.1.2008.10.11.09.33.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 09:33:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48EAFF23.1020607@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97981>

On Tue, Oct 07, 2008 at 08:18:11AM +0200, Johannes Sixt wrote:
> Dmitry Potapov schrieb:
> > +#if defined(_WIN32) || defined(__CYGWIN__)
> 
> I think that for consistency you should use __MINGW32__ instead of _WIN32.

I like Alex's suggestion more to use FILESYSTEM_CASEINSENSITIVE.

> 
> > +	/* On Windows, file names are case-insensitive */
> > +	case 'G':
> > +		if ((rest[1]|0x20) != 'i')
> > +			break;
> > +		if ((rest[2]|0x20) != 't')
> > +			break;
> 
> We have tolower().

I am aware of that, but I am not sure what we gain by using it. It seems
it makes only code bigger and slow. As to readability, I don't see much
improvement... Isn't obvious what this code does, especially with the
above comment?

Dmitry
