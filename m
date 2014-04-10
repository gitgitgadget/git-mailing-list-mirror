From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 9/9] sha1_name: add support for @{publish} marks
Date: Thu, 10 Apr 2014 17:28:18 -0500
Message-ID: <53471b02305be_d696b12f099@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nU_Esy6QoQG-vv3nKE=P=gWDiFgRp4RKvq4DbxOntkaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 00:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYNbz-0007Eh-RT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 00:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965603AbaDJWiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 18:38:19 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:42615 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965535AbaDJWiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 18:38:17 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so5096818obc.7
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=W5VQ52IKecZ9H1R/1UD5oRaHmRNO8PEDv0TIuKhaHCA=;
        b=UEiWdKZ6cCqwFB+W5/ZpEQ+xArqFoa3dD61Z24U85GNtD1rVRMHUIS6AoSmSoB0+9A
         GFhbuwMebo/2C4pw4UjMQK9UHzPknQd+TUPnUG9TZBk3VCQSX3FpxNU7gJzwaD8ynekH
         HsaAbNut8OL958aO56u3WcgR9uWoGa1IuI0KyzXhrLjAkY+KO9Hi98oeBctiRMK8f1UZ
         67GSNJJVBFopR0cyXewmCCOcYm9HcceGLUIfs1WHxCBsOIEuviOv8TBQK4kUaprlzmkh
         +SLzrpfccfjk6WS3+SPAmOAzJPiQxi/tzyM6Le85N3Os7XTliWNYDV4LMSaAUysa9q8/
         juEQ==
X-Received: by 10.60.132.75 with SMTP id os11mr3204396oeb.70.1397169497246;
        Thu, 10 Apr 2014 15:38:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm9231077obc.0.2014.04.10.15.38.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 15:38:16 -0700 (PDT)
In-Reply-To: <CALkWK0nU_Esy6QoQG-vv3nKE=P=gWDiFgRp4RKvq4DbxOntkaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246062>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > diff --git a/sha1_name.c b/sha1_name.c
> > index aa3f3e0..a36852d 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -415,9 +415,9 @@ static int ambiguous_path(const char *path, int len)
> >         return slash;
> >  }
> >
> > -static inline int upstream_mark(const char *string, int len)
> > +static inline int tracking_mark(const char *string, int len)
> >  {
> > -       const char *suffix[] = { "upstream", "u" };
> > +       const char *suffix[] = { "upstream", "u", "publish", "p" };
> 
> Oh, another thing: on some threads, people decided that "@{push}"
> would be a more apt name (+ alias @{u} to @{pull} for symmetry).

@{push} is the name I originally suggested, but it's weird to talk about
"the push branch", so I decided on "the publish branch", which is more natural.

-- 
Felipe Contreras
