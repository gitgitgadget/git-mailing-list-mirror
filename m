From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Tue, 21 Aug 2012 11:47:25 +0200
Message-ID: <1894713.otuKr9xS8H@flomedio>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vehn1gocn.fsf@alter.siamese.dyndns.org> <7va9xpgngk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 11:47:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3l3k-0000ZA-2K
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 11:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab2HUJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 05:47:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33510 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2HUJrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 05:47:31 -0400
Received: by bkwj10 with SMTP id j10so2119505bkw.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=B8tQHYuRyKMtyGiS/vuPrGVQ6LkfoD4hhOnzow0ZifM=;
        b=NgbIFCQ3816mvSullssT58S+aEKAOsHhJVPC2+IWWxdLdpyvEbGa7Y7z2o7SgYB91t
         bOdGzBIelMYD35xWt2t5cuRKhLCKwX+4zcHVS7pQZYkL0Fk834r8fo6z5RNlypWZZbg/
         BoRlQ/HeWfQHa2Gz1OBahLnWb7YoUUjaPwUqpNAI0F0gJarj5Cs4f7fX+8miL8iiBeP1
         MKJudJNJEB5rLZIYaNghKsAeo6yu9Si8KJV7vPijqF0oieFtfZ3G2Zs75F4RszXqEv8O
         WJOta2wIkKaejpQn2FqB2q+h8UZeflM4DNm90eZoqLLFKZV9P4xhluohYNTQiJLyUQvV
         neDQ==
Received: by 10.204.157.18 with SMTP id z18mr5259931bkw.16.1345542450121;
        Tue, 21 Aug 2012 02:47:30 -0700 (PDT)
Received: from flomedio.localnet (91-115-84-27.adsl.highway.telekom.at. [91.115.84.27])
        by mx.google.com with ESMTPS id t23sm469359bks.4.2012.08.21.02.47.27
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 02:47:28 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-25-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7va9xpgngk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203960>

On Monday 20 August 2012 16:20:27 Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I think you meant something like:
> > 
> >       init_notes(NULL, notes_ref, NULL, 0);
> >
> >         marksfile = fopen(marksfilename, "r");
> >         if (!marksfile) {
> >               regenerate_marks(marksfilename);
> >                 marksfile = fopen(marksfilename, "r");

Btw, this is FILE* is nowhere closed in your fixuped version in fa/remote-svn.

> >                 if (!marksfile)
> >
> >                       die("cannot read marks file!");
> >       } else {
> >
> >               ...
