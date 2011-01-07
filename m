From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Fri, 7 Jan 2011 22:28:40 +0530
Message-ID: <20110107165837.GA8062@kytes>
References: <4D25E818.5050909@gmail.com>
 <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com>
 <20110106180051.GC11346@burratino>
 <7vpqs9aiul.fsf@alter.siamese.dyndns.org>
 <20110106204605.GA15090@burratino>
 <7vpqs98qti.fsf@alter.siamese.dyndns.org>
 <20110107013159.GA23280@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 17:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbFdc-0001Rb-C7
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 17:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab1AGQ5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 11:57:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53131 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab1AGQ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 11:57:40 -0500
Received: by ywl5 with SMTP id 5so6821594ywl.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=71hEKv6qNBcKFi6VwtgV5/ToCCeAuhvnWg0udtZej1Q=;
        b=fOByQIsT3+QaGu4wBOB5IlUWoRktvskaujsqF0yOPTfyXwZYR5q51OJ/JdSK2FXw+D
         14tWsntxHft7xJT3JBwyWShXBYLEqM3tdEjX3ck4XaKdPVltzI0tDQn8xVLpKK3xb4xF
         iQs1p+GkCrMeFSXdBtsc3F02TNvwaHi4BWlI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=umFpPAipdV9p3hUV8ErSB0/7opKni2rDuDfV4SfHTp/pOI0WvMm3C6D0xtfgC+Pp+c
         b+9Xx58iLP8IiPpo34x2bjfqW+Wv/HUKoW/HexCGHb+ohEILKEPw7uEexyN6C2ce3La/
         f5zGSecZh7NoGsValCKfKKx34At6GUWs39X/g=
Received: by 10.100.96.10 with SMTP id t10mr965034anb.100.1294419459201;
        Fri, 07 Jan 2011 08:57:39 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 2sm33778770anw.38.2011.01.07.08.57.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 08:57:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107013159.GA23280@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164720>

Hi,

Jonathan Nieder writes:
> To do the same for t91* would be impossible.  If svn is broken or not
> installed, svn-fe will run fine, but "git svn" will not.  On the other
> hand, if svnadmin were broken but svn still worked, "git svn" would be
> fine but that would be quite strange and I do not think it is worth
> spending time to prepare for.

I don't think it's worth spending time preparing for every concievable
breakage. The patch A few more examples of possible breakages I've
encountered:
- APR compiled without threading support, SVN compiled with it, or
  viceversa.
- SVN is compiled against GNU iconv, but apr-iconv installed, or
  viceversa.
- Two different versions of a dependent library are installed, and SVN
  links to a different version in a different location.

One or many components of SVN may fail. So, I'm in favor of the
current approach: if SVN is installed, attempt to run all the t91*
tests. Any failure can either be interpreted as a real test failure or
malformed SVN installation.

-- Ram
