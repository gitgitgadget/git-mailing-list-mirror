From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:55:26 +0100
Message-ID: <200901280155.26399.jnareb@gmail.com>
References: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com> <200901280114.59388.jnareb@gmail.com> <cb7bb73a0901271643g7c3a8c42qff6025187ab3c081@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyjd-0002zM-1u
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbZA1Az2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZA1Az2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:55:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:26894 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZA1Az2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:55:28 -0500
Received: by fg-out-1718.google.com with SMTP id 13so346388fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=24+elepsphpJFNyoXU0t8kpAGZoCFkReCIulX9LiVjE=;
        b=kCiurTGsfLcX2gq3MWA2JONtagxnmgv8GrQiHZMUIBOZZj3QI7rC32VRNufRih1oTo
         2WI4YtYJpDJjyfe0f1X4kMZY2L4qSXHUmHknMvaNDGUYWYOAzMs/s1dLzx3/aX0Uz2bc
         p65QMYgrNiIqJT+FjL5vw4aMNj+jZ4qk5SQmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZRY6JLEEUZtmvBAZAGdOuKS4v5DWjc2qP/QBIeX62e7/C0B2GrnM9avRTC6NlMOy2x
         Ln9JlU62IG0r497M7arqdZvxoA06xFJBIwMDFrDvaeLUibaaQ5QpQzshuOOsCoBnjlu6
         JCNWNtFj53Dxb1ymsk4uXK3k4c8eUdU7k+EQs=
Received: by 10.86.80.17 with SMTP id d17mr380104fgb.55.1233104125929;
        Tue, 27 Jan 2009 16:55:25 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id d4sm1409124fga.51.2009.01.27.16.55.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 16:55:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901271643g7c3a8c42qff6025187ab3c081@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107437>

On Wed, 28 Jan 2009, Giuseppe Bilotta wrote:
> On Wed, Jan 28, 2009 at 1:14 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Tue, 27 Jan 2009, Giuseppe Bilotta wrote:

> > > Of course, last time I forgot that the BASE href is supposed to be
> > > absolute. While Opera apparently has no problem with it being relative,
> > > other browsers such as Firefox are stricter about it.
> >
> > Errrr... I think you are talking about _full_ vs. _absolute_, not
> > _absolute_ vs. _relative_, see below.
> 
> No, I actually mean absolute vs relative in the URI sense, not in the
> Perl/CGI sense.
> 
> http://www.example.com/ is absolute, / is relative

No, "/" is not relative, it is absolute, because it begins with '/'.
See RFC 1808 (Relative Uniform Resource Locators):

 2.2.  BNF for Relative URLs

 [...]

   URL         = ( absoluteURL | relativeURL ) [ "#" fragment ]

   absoluteURL = generic-RL | ( scheme ":" *( uchar | reserved ) )

   generic-RL  = scheme ":" relativeURL

   relativeURL = net_path | abs_path | rel_path

   net_path    = "//" net_loc [ abs_path ]
   abs_path    = "/"  rel_path
   rel_path    = [ path ] [ ";" params ] [ "?" query ]

(which means that CGI.pm -full is 'net_path', and -absolute is
'abs_path', and -relative is 'rel_path')

 [...]

 4.  Resolving Relative URLs

  [...]

     Step 4: If the embedded URL path is preceded by a slash "/", the
           path is not relative and we skip to Step 7.


-- 
Jakub Narebski
Poland
