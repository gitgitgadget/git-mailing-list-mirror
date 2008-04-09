From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Wed, 9 Apr 2008 02:34:58 -0400
Message-ID: <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
	 <47FBDA77.2050402@et.gatech.edu>
	 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjTuL-0006ar-HQ
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYDIGfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYDIGfB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:35:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:45637 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYDIGfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:35:00 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2215276fgb.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nPavUZrO9fzlJTwJJuXGPsqZJ8h6WkYuFqvoRx9x9kg=;
        b=w3/4lMLg4IGlemfC5ooLaP6Gc2QnyLgCgXtuv/lTRF0eUXyPPkbA/janxehpe8nFZ7t/WAMLO20xa/IkXqSqRYLxIJHkEFSVaghcXEnf32UEoP9cBcMlNCXYpXoEJ+4T4oaI8qwB/TeyrBJTlgHUAo8h42L/VuZOapwP1erZdTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lxzeHZJsO9xQqopCtng4iRlO6XF0sTELyZdLtPHAyGc2u6zUaXfsuctG79plFRd14kt+mFRcNA/IXJ4I2HLbIXJx5QS/6UCAnCujKVBRkIFSA8+5fTBTDCXlfRuZnvDSaXo0YNnwWjrYYkRYSixmRs9azMaFPKPIPKV7XuWUmRg=
Received: by 10.82.166.9 with SMTP id o9mr1229131bue.73.1207722898520;
        Tue, 08 Apr 2008 23:34:58 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 8 Apr 2008 23:34:58 -0700 (PDT)
In-Reply-To: <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79075>

On Wed, Apr 9, 2008 at 12:39 AM, Roman Shaposhnik <rvs@sun.com> wrote:
>  Agreed. But I guess I'd be less confused if "git submodule" didn't muck
>  with .git/config at all. Or are there any other consumers of the
> information
>  that it puts there (except itself)?

That I don't know.  If there aren't any others, then I agree, I'm not
sure what the whole .git/config messing is about.

> > In my own use case, I think having all the objects from the
> > supermodule *and* submodules all be in the same repo is what I want.
> > This kind of obviates the need for .gitmodules entirely, if
> > git-checkout and friends will do the right thing.  I think I'll submit
> > some patches eventually once I have this figured out properly.
>
>  Hm. But what about those who might want to pull from you? .git/config
>  doesn't propagate, which means that they'll be kind of stuck, don't
>  you think?

Not exactly.  The idea is that if the supermodule and submodules are
all lumped into a single repo (and your refs are set up correctly),
then cloning the supermodule will also clone all the submodules.  So
everyone will have all the necessary refs anyway; as long as
git-checkout checks them out, .gitmodules shouldn't have to exist at
all, becaues there's nothing "special" for git-submodule to do.

Have fun,

Avery
