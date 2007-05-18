From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: autocrlf
Date: Fri, 18 May 2007 13:32:54 +0100
Message-ID: <200705181332.55228.andyparkins@gmail.com>
References: <200705181111.53823.andyparkins@gmail.com> <464D91E7.FB3F9B4@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1du-0008A1-FH
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbXERMdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbXERMdE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:33:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:40208 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbXERMdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:33:02 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1311141nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 05:33:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OAX0R2vyKLvNi2ThZtYkq+swwf8AACYyLb1wGfoy3BL9gr6xsFfbQ51j1YYoDO7kD6WUh1u/hn1QMfIDHdCzH7IDO6A5B1PwMxrFVIAAUnpMlSRbv2hH8nReFW8kNWKQeY8wKt0IzBS84o6x6+P6iGba4zZlYA8NRTn4JXX/8Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iQoRWoCA7E2wDPcdVTtLJzjR/I7QHRQzgPLup7olhbL9YoUo4Z07XCgQwyy3BqYKS9STZUuuXqTEkoefA0Ze3UH+q7kVJu/cFQns3y64QwCKgGZMbtwafELnX7ZNeuDutiYod0XdGzS/E3O5hVqNSR+uDPQv6ZApiXlC9Im0W1U=
Received: by 10.64.21.6 with SMTP id 6mr6263226qbu.1179491579731;
        Fri, 18 May 2007 05:32:59 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id d2sm3914265qbc.2007.05.18.05.32.58;
        Fri, 18 May 2007 05:32:58 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <464D91E7.FB3F9B4@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47600>

On Friday 2007 May 18, Johannes Sixt wrote:

> > What actually happens is that any file with the crlf attribute is being
> > checked out with LF expanded to CRLF (I'm running Linux of course), which
> > is completely not what I wanted.
>
> If I understand the documentation correctly
> (Documentation/gitattributes.txt) then you set core.autocrlf to true on
> Windows and false everywhere else, and things should start working like
> you imagined.

Presumably then it is defaulting to false for Linux as everything is working 
fine for me at present.  However, that is not the case when I set the crlf 
attribute.

Documentation/gitattributes.txt:

This attribute controls the line-ending convention.

Set::

    Setting the `crlf` attribute on a path is meant to mark
    the path as a "text" file.  'core.autocrlf' conversion
    takes place without guessing the content type by
    inspection.

I read that as meaning the automatic detection of file type is overridden by 
the crlf attribute.  What I'm actually seeing is that it has the same effect 
as enabling "autocrlf = true" for that file.  As you say "autocrlf = true" is 
for windows, the crlf attribute should not be forcing it on as that then 
applies to all platforms.

I think this is a bug.  The code agrees with the observed behaviour but not 
with the documentation.  Patch to follow.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
