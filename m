From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Thu, 20 Jan 2011 11:58:39 +0530
Message-ID: <20110120062837.GA27624@kytes>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
 <20110119214827.GA31733@burratino>
 <20110120045046.GB9493@kytes>
 <20110120054813.GB4770@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 07:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfnzr-0002Gm-Hl
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 07:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab1ATG1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 01:27:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46130 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab1ATG1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 01:27:45 -0500
Received: by gxk9 with SMTP id 9so68959gxk.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SnjybAHcxXEYhkwt/QC763Ge2T9L7QwyLgXQS5qvlo0=;
        b=pMkc+UrgsMPDwGVftQZyRfm5ANmyJCyR0nglu7R12HMK6KEHZoVeQQ63QYa4J6VFhJ
         FZLsvUG/AHRj0Cn2u5gW40sN2d5YElpaVP+Uy2wzdVnpqTtc80AtazBIRDMXY/qd19SD
         Ieb2K9w1szOR/xS9Ux1tZdXQnwN/WMbkeTSQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W1ulByNC77f+j9VTlNcTuKWYOiSzxcJREx3t2psI7NPvh9E+CLddQHVSDGHc6OfeAx
         KYVSrmZ9YpSM5LhctBZ8jJsHFPhGe0USgS3hG1KjJkPxTqJKDdMq5q6jro1aWlKDYB/d
         tLAxnvcRKSqkyd6sJcQu97Sb+xCnloDahtag0=
Received: by 10.150.196.10 with SMTP id t10mr2049480ybf.82.1295504864574;
        Wed, 19 Jan 2011 22:27:44 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v8sm4969779yba.2.2011.01.19.22.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 22:27:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110120054813.GB4770@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165306>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > The functionality to persist blobs that are refenced by
> > marks probably shouldn't be in svn-fe at all.
> 
> Do you mean svn-fi?

Yeah. Sorry about the typo. Just to make it clear:

svn-fi should only ever support inlined blobs. For older streams,
there's an extra overhead- it'll have to be chained along with a
helper program that transforms the stream to inline all the blobs.

> > This filter will need to persist every blob for the entire lifetime of
> > the program.
> 
> Depending on the interface, couldn't it be possible to rely on svn for
> the content of blobs that have already been exported?  If so, one
> would only need a place to stash (1) a mapping from mark numbers to
> (svn rev, path) pairs and (2) the full text of blobs that have not
> been exported as part of a rev yet.

Oh yes. We discussed this on IRC :) I'm just afraid that it won't be
fast enough- my idea is to essentially use `svnrdump dump` to replay
the blobs in a certain (path, revision); let me know if you think
there's a quicker way.

-- Ram
