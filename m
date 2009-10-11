From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Sun, 11 Oct 2009 12:39:14 +0200
Message-ID: <200910111239.15403.jnareb@gmail.com>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com> <200910102045.13374.jnareb@gmail.com> <76c5b8580910101845h43a607f0sd4184da302a19963@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 12:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwvsC-0004jP-QD
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 12:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760019AbZJKKi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 06:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759764AbZJKKiz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 06:38:55 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:55775 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbZJKKix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 06:38:53 -0400
Received: by fxm27 with SMTP id 27so7973951fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8avj11GeuacCtgMCF4FBE/YALofwto2FNXdr8yFVdzE=;
        b=FdE0P/2A4BphMMCZJmyNdivmtmO4nWVwaR5fssvmh3tyYpsusvDA9Z7JOAVSbxVVJH
         KTtZRstx/iSxgVt12QKrJxmLKPU+V4dzrFFh+sKAnshZu6wn3o4ovCFkosfL68Tt964E
         ajFNNMt9kRpHn0JlhlsD2Tqu4BnZ31/rN3HpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PXkFKtfqSd1XdFUD1BHEknU6ICpJK0x6LmDUqQvu/MlfN292txXbfPj3JbfvBCiL3q
         8H88DvF7kSSejWAXm9BK9TPKgAsoJ6JUfTPvvhJG9mrnoHZffEMsVoc25lHcF6zgSXyp
         XryZbbJ5t+LRCeCDZiHEP2X+Pzzs7W3CRDLes=
Received: by 10.103.78.38 with SMTP id f38mr1916843mul.72.1255257496889;
        Sun, 11 Oct 2009 03:38:16 -0700 (PDT)
Received: from ?192.168.1.13? (abwa37.neoplus.adsl.tpnet.pl [83.8.224.37])
        by mx.google.com with ESMTPS id y2sm6503553mug.49.2009.10.11.03.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 03:38:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <76c5b8580910101845h43a607f0sd4184da302a19963@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129914>

On Sun, 11 Oct 2009, Eugene Sajine wrote:
> >
> > The project description, project owner and (clone) url are used by
> > gitweb only, so I don't see why git-clone has to feature-creep to
> > set them.
> 
> Well my logic is simple. Gitweb is a part of git bundle. If you don't
> want to use gitweb you're free to use git clone as you want. I don't
> see  why not to provide some usability features to it. For me it is
> quite obvious that it will be more comfortable to setup gitweb if this
> would be in  place. Instead of putting info in few different places
> manually, why not to give people a possibilty to do that using one
> command?
> 
> This is usability feature, but i feel that for me as a person who will
> support big ceantral bare repo hosting server, this would save huge
> time and efforts...

And this would be best left for a custom script creating repositories
and their git hosting related configuration.  Such script of necessity
would have to be site-specific, or at least contain site-specific 
configuration, like:
 * whether to use gitweb.owner or filesystem uid + GECOS is enough
 * whether to use gitweb.description or description file
 * whether to use gitweb.url, cloneurl file, or let gitweb autogenerate
   clone / fetch URL from base URL
 * gitosis / gitlite configuration, if needed, or setup of public keys
   for SSH authentication
 * project README.html file, if used
etc. 

git-clone is not a dumping ground (also, code speak louder than words).

I even think it might be mistake to have default 'description' file in 
templates...

-- 
Jakub Narebski
Poland
