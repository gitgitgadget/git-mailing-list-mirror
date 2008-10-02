From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: PATH_INFO support improvements
Date: Thu, 2 Oct 2008 10:19:26 +0200
Message-ID: <200810021019.27383.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 10:21:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJQi-0006ER-TP
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYJBITq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbYJBITp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:19:45 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:6558 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbYJBITo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:19:44 -0400
Received: by mu-out-0910.google.com with SMTP id g7so758114muf.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/3meHHz2zJjaHXPar8+X1ONEV0+ILCDwiDD7gUQhdQM=;
        b=rsO/uL5zW/3G6gA0Aej3gpPyh604946V37xGibYdErcD2uMtX2ZsF1vD5Q2w86MNyc
         gVNMn/F9/OJibBq4jFc0rXLHU2l1mYOFNH4eVTqrfGCZiEm8bblVHdkPB6xxgQfOb71h
         Gl97/VUpi+Xebl/72YxpnifidRG5tha4nzbSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RupWrhpspQnmB5v0S4RIIbbvfwBrji2lkHJmYhj3im8mYgzdsOrTEzwKBazHmzIe7C
         OMniemh2FOVhwiBoss3d48Y4Js1qFOR9fwPCi8DfDHM0eVfp1zvSc0ZbF9SwL7sPzW6L
         0gu5HmxYPBaBL5WPjAVZF4qA7FjuxatYluwUI=
Received: by 10.103.222.12 with SMTP id z12mr6614766muq.12.1222935580989;
        Thu, 02 Oct 2008 01:19:40 -0700 (PDT)
Received: from ?192.168.1.11? (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id s10sm1704055mue.15.2008.10.02.01.19.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 01:19:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97291>

Giuseppe Bilotta wrote:

> Fourth version of my gitweb PATH_INFO patchset, whose purpose is to
> reduce the use of CGI parameters by embedding as many parameters as
> possible in the URL path itself, provided the pathinfo feature is
> enabled.

A nit: when sending longer patch series you should use numbered
format in the form of [PATCH m/n] or [PATCH m/n vX] prefix.

> 
> The new typical gitweb URL is therefore in the form
> 
> $project/$action/$parent:$file..$hash:$file
> 
> (with useless parts stripped). Backwards compatibility for old-style
> $project/$hash URLs is kept, as long as $hash is not a refname whose
> name happens to match a git action.

Minor nit: there was also old-style $project/$hash_base:$file_name
path_info format.

>
> The main implementation is provided by paired patches (#1#3, #5#6)
> that implement parsing and generation of the new style URLs.
> 
> Patch #2 deals with a refactoring of the input parameters parsing and
> validation, so that the rest of gitweb can be agnostic wrt to the
> parameters' origin (CGI vs PATH_INFO vs possible other future inputs
> such as CLI).
> 
> Patch #4 is a minor improvement to the URL syntax that allows web
> documents to be properly browsable in raw mode.

Very nice summary of patchset and patch  coverage in this cover letter.

>
> Giuseppe Bilotta (6):
>   gitweb: parse project/action/hash_base:filename PATH_INFO
>   gitweb: refactor input parameters parse/validation
>   gitweb: generate project/action/hash URLs
>   gitweb: use_pathinfo filenames start with /
>   gitweb: parse parent..current syntax from pathinfo
>   gitweb: generate parent..current URLs

-- 
Jakub Narebski
Poland
