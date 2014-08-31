From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] stash: prefer --quiet over shell redirection
Date: Sun, 31 Aug 2014 00:35:51 -0700
Message-ID: <20140831073550.GA66236@gmail.com>
References: <1409427029-65886-1-git-send-email-davvid@gmail.com>
 <1409427029-65886-2-git-send-email-davvid@gmail.com>
 <54023D01.6090504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:35:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNzfU-00085N-Tf
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 09:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaHaHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 03:34:57 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51544 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaHaHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 03:34:56 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so3589713pdj.32
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o9QIwxodlehynUTOVoB51yllW9ovq+g2YAWjXk1OYZo=;
        b=EGL6t19XAGs6PFiuGpF94iEvyBMtfB/Yp4Dda5TfwCWoPBPpObfxKUKrrb93beY1pY
         a0MeATYIQQfwE4h/EUfQfQ1d5+w/xLzEO7Op8eQrJimXx5vNxss+G3MW3jphxiYHyUXy
         JeuXyQ9M5fPZd05d12lQvFLPdLe9erP0In4eo3G0HJJnfPGu0Wux4tqtC4ylBFZ6ZnNq
         SWdEd0l9HcmmLvcycndPWcaaL0VO2g4pn6oPh2ZwiWBBmJksrNwlREbETpK5+e8QaC/E
         JsJ04a3D5uz//60LWfKBlGCzi5oiOlgVMbi4bFnCUVA0OO6uwZGaKdAwF+3VxxwQ8rQA
         dtVA==
X-Received: by 10.70.98.203 with SMTP id ek11mr29442658pdb.32.1409470496024;
        Sun, 31 Aug 2014 00:34:56 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id b9sm4538821pbu.91.2014.08.31.00.34.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 Aug 2014 00:34:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54023D01.6090504@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256281>

On Sat, Aug 30, 2014 at 11:07:13PM +0200, Johannes Sixt wrote:
> Am 30.08.2014 21:30, schrieb David Aguilar:
> > @@ -392,12 +392,12 @@ parse_flags_and_rev()
> >  		;;
> >  	esac
> >  
> > -	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
> > +	REV=$(git rev-parse --quiet --symbolic --verify "$1") || {
> >  		reference="$1"
> >  		die "$(eval_gettext "\$reference is not valid reference")"
> >  	}
> >  
> > -	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
> > +	i_commit=$(git rev-parse --quiet --verify "$REV^2") &&
> >  	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
> 
> I see another rev-parse that you did not modify. An omission?

The docs for --quiet say, "Only meaningful in --verify mode", so I didn't touch
the non-verify call-sites.

Thanks for the review. I'll address your notes and send a v2 shortly.
-- 
David
